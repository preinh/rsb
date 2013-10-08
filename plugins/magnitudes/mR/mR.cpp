/***************************************************************************
 * Copyright (C) 2009 by gempa GmbH
 *
 * Author: Jan Becker
 * Email: jabe@gempa.de
 *
 * Modifications 2010 - 2011 by Stefan Heimers <heimers@sed.ethz.ch>
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 ***************************************************************************/

#define SEISCOMP_COMPONENT MR

#include "mR.h"
#include <seiscomp3/processing/magnitudes/mb.h>
#include <seiscomp3/seismology/magnitudes.h>


//#include <seiscomp3/logging/log.h>
//#include <seiscomp3/core/strings.h>
//#include <seiscomp3/processing/amplitudes/mb.h>
//#include <seiscomp3/processing/magnitudeprocessor.h>
//#include <seiscomp3/seismology/magnitudes.h>
//#include <seiscomp3/math/filter/seismometers.h>
//#include <seiscomp3/math/geo.h>

//#include <iostream>
//
//#include <boost/bind.hpp>
//#include <unistd.h>

//// Only valid within 5-105 degrees
//#define DELTA_MIN 5.
//#define DELTA_MAX 105.

//// Only valid for depths up to 80 km
//#define DEPTH_MAX 80

#define MAG_TYPE "mR"

//using namespace std;
//
using namespace std;

using namespace Seiscomp;
using namespace Seiscomp::Processing;

ADD_SC_PLUGIN(
	"mR R- Brazilian Regional Magnitude Processor",
	"RSB, based on 'mb' amplitude. Modified by Stephane/ Marlon",
	0, 0, 7
)

namespace {


	class SC_SYSTEM_CLIENT_API MagnitudeProcessor_mR : public MagnitudeProcessor {
		DECLARE_SC_CLASS(MagnitudeProcessor_mR);

		public:
			MagnitudeProcessor_mR();

			Status computeMagnitude(
				double amplitude, // in micrometers per second
				double period,    // in seconds
				double delta,     // in degrees
				double depth,     // in kilometers
				double &value);
	};

	IMPLEMENT_SC_CLASS_DERIVED(MagnitudeProcessor_mR, MagnitudeProcessor, "MagnitudeProcessor_mR");
	REGISTER_MAGNITUDEPROCESSOR(MagnitudeProcessor_mR, MAG_TYPE);

}


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MagnitudeProcessor_mR::MagnitudeProcessor_mR()
 : MagnitudeProcessor("mR") {}
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MagnitudeProcessor::Status MagnitudeProcessor_mR::computeMagnitude(
	double amplitude, // in micrometers per second
	double period,      // in seconds
	double delta,     // in degrees
	double depth,     // in kilometers
	double &value)
{
	// Clip depth to 0
	if ( depth < 0 ) depth = 0;

	// maximum allowed period is 3 s according to IASPEI standard (pers. comm. Peter Bormann)
	if ( period < 0.4 || period > 3.0 )
		return PeriodOutOfRange;

	// amplitude is nanometers, whereas compute_mb wants micrometers
	bool valid = Magnitudes::compute_mb(amplitude*1.E-3, period, delta, depth+1, &value);
	value = correctMagnitude(value);
	return valid ? OK : Error;
}


