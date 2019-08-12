Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A78A558
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHLSHF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 14:07:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfHLSHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 14:07:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CI3Laq068929;
        Mon, 12 Aug 2019 14:06:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubcqvruqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 14:06:51 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7CI3Y8d070436;
        Mon, 12 Aug 2019 14:06:50 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubcqvruna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 14:06:49 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7CI18q1032240;
        Mon, 12 Aug 2019 18:06:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2u9nj620nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 18:06:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CI6kis13828738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 18:06:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11115B2068;
        Mon, 12 Aug 2019 18:06:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7182B205F;
        Mon, 12 Aug 2019 18:06:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 18:06:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BDB9716C19DD; Mon, 12 Aug 2019 11:06:49 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:06:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH RFC memory-model 27/31] tools/memory-model: Add data-race
 capabilities to judgelitmus.sh
Message-ID: <20190812180649.GM28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120194
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 12, 2019 at 11:32:35PM +0900, Akira Yokosawa wrote:
> Hi Paul,
> (CC: using Andrea's gmail address, adding Daniel)

Good point, I did forget to update at my end.  Fixed, thank you!

> Sorry for slow response, but please find inline comments below.
> 
> On Thu, 1 Aug 2019 15:20:52 -0700, Paul E. McKenney wrote:
> > This commit adds functionality to judgelitmus.sh to allow it to handle
> > both the "DATARACE" markers in the "Result:" comments in litmus tests
> > and the "Flag data-race" markers in LKMM output.  For C-language tests,
> > if either marker is present, the other must also be as well, at least for
> > litmus tests having a "Result:" comment.  If the LKMM output indicates
> > a data race, then failures of the Always/Sometimes/Never portion of the
> > "Result:" prediction are forgiven.
> 
> I'd like to see the reason _why_ they can be forgiven. Also, updating
> the header comment of judgelitimus.sh to mention these expansions would
> be of much help.
> 
> My guess is any data-race would moot the Always/Sometimes/Never
> prediction.

Exactly.  And good point, I will update the commit log to make this
explicit.

> This reminds me that update of LKMM documentation regarding plain
> accesses (data races) is yet to come.

Yes, this one is still on the to-do list.  Timely reminder, though!  ;-)

							Thanx, Paul

>         Thanks, Akira
> 
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
> > index ca9a19829d79..eaa2cc7d3b36 100755
> > --- a/tools/memory-model/scripts/judgelitmus.sh
> > +++ b/tools/memory-model/scripts/judgelitmus.sh
> > @@ -47,9 +47,27 @@ else
> >  	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
> >  	exit 255
> >  fi
> > +if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
> > +then
> > +	datarace_modeled=1
> > +fi
> >  if grep -q '^ \* Result: ' $litmus
> >  then
> >  	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
> > +	if grep -m1 '^ \* Result: .* DATARACE' $litmus
> > +	then
> > +		datarace_predicted=1
> > +	fi
> > +	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
> > +	then
> > +		echo '!!! Predicted data race not modeled' $litmus
> > +		exit 252
> > +	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
> > +	then
> > +		# Note that hardware models currently don't model data races
> > +		echo '!!! Unexpected data race modeled' $litmus
> > +		exit 253
> > +	fi
> >  elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
> >  then
> >  	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
> > @@ -114,7 +132,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
> >  then
> >  	ret=0
> >  else
> > -	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
> > +	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
> >  	then
> >  		flag="--- Forgiven"
> >  		ret=0
> > 
> 
