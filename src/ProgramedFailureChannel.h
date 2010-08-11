// Copyright (C) 2009 Juan-Carlos Maureira
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
//

#ifndef PROGRAMEDFAILURECHANNEL_H_
#define PROGRAMEDFAILURECHANNEL_H_

#include <omnetpp.h>

#include "LinkFailureManager.h"

class ProgramedFailureChannel : public cDatarateChannel {
private:
	LinkFailureManager* lfm;
public:
	ProgramedFailureChannel(const char* name=NULL);
	ProgramedFailureChannel(const ProgramedFailureChannel& ch);

	virtual ~ProgramedFailureChannel();
#if OMNETPP_VERSION>0x0400
	virtual void processMessage(cMessage *msg, simtime_t t, result_t& result);
#else
    virtual bool deliver(cMessage *msg, simtime_t at);
#endif
	virtual bool initializeChannel(int stage);

	void setState(LinkState state);

};

#endif /* PROGRAMEDFAILURECHANNEL_H_ */
