Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011D95C512
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGAVkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 17:40:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbfGAVj7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 17:39:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Lb484124845
        for <linux-arch@vger.kernel.org>; Mon, 1 Jul 2019 17:39:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tft458dq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 01 Jul 2019 17:39:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 22:39:57 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 22:39:54 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61LdrWK13566520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 21:39:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D99AB2065;
        Mon,  1 Jul 2019 21:39:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15994B205F;
        Mon,  1 Jul 2019 21:39:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 21:39:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4713A16C2BD7; Mon,  1 Jul 2019 14:39:56 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:39:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] tools/memory-model: Update the informal documentation
Reply-To: paulmck@linux.ibm.com
References: <1561842644-5354-1-git-send-email-andrea.parri@amarulasolutions.com>
 <Pine.LNX.4.44L0.1907011012230.1536-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1907011012230.1536-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070121-0072-0000-0000-0000044331C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011362; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226073; UDB=6.00645444; IPR=6.01007285;
 MB=3.00027543; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 21:39:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070121-0073-0000-0000-00004CB368EC
Message-Id: <20190701213956.GU26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010250
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 01, 2019 at 10:12:45AM -0400, Alan Stern wrote:
> On Sat, 29 Jun 2019, Andrea Parri wrote:
> 
> > The formal memory consistency model has added support for plain accesses
> > (and data races).  While updating the informal documentation to describe
> > this addition to the model is highly desirable and important future work,
> > update the informal documentation to at least acknowledge such addition.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > ---
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Applied, thank you both!

							Thanx, Paul

> >  tools/memory-model/Documentation/explanation.txt | 47 +++++++++++-------------
> >  tools/memory-model/README                        | 18 ++++-----
> >  2 files changed, 30 insertions(+), 35 deletions(-)
> > 
> > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > index 68caa9a976d0c..b42f7cd718242 100644
> > --- a/tools/memory-model/Documentation/explanation.txt
> > +++ b/tools/memory-model/Documentation/explanation.txt
> > @@ -42,7 +42,8 @@ linux-kernel.bell and linux-kernel.cat files that make up the formal
> >  version of the model; they are extremely terse and their meanings are
> >  far from clear.
> >  
> > -This document describes the ideas underlying the LKMM.  It is meant
> > +This document describes the ideas underlying the LKMM, but excluding
> > +the modeling of bare C (or plain) shared memory accesses.  It is meant
> >  for people who want to understand how the model was designed.  It does
> >  not go into the details of the code in the .bell and .cat files;
> >  rather, it explains in English what the code expresses symbolically.
> > @@ -354,31 +355,25 @@ be extremely complex.
> >  Optimizing compilers have great freedom in the way they translate
> >  source code to object code.  They are allowed to apply transformations
> >  that add memory accesses, eliminate accesses, combine them, split them
> > -into pieces, or move them around.  Faced with all these possibilities,
> > -the LKMM basically gives up.  It insists that the code it analyzes
> > -must contain no ordinary accesses to shared memory; all accesses must
> > -be performed using READ_ONCE(), WRITE_ONCE(), or one of the other
> > -atomic or synchronization primitives.  These primitives prevent a
> > -large number of compiler optimizations.  In particular, it is
> > -guaranteed that the compiler will not remove such accesses from the
> > -generated code (unless it can prove the accesses will never be
> > -executed), it will not change the order in which they occur in the
> > -code (within limits imposed by the C standard), and it will not
> > -introduce extraneous accesses.
> > -
> > -This explains why the MP and SB examples above used READ_ONCE() and
> > -WRITE_ONCE() rather than ordinary memory accesses.  Thanks to this
> > -usage, we can be certain that in the MP example, P0's write event to
> > -buf really is po-before its write event to flag, and similarly for the
> > -other shared memory accesses in the examples.
> > -
> > -Private variables are not subject to this restriction.  Since they are
> > -not shared between CPUs, they can be accessed normally without
> > -READ_ONCE() or WRITE_ONCE(), and there will be no ill effects.  In
> > -fact, they need not even be stored in normal memory at all -- in
> > -principle a private variable could be stored in a CPU register (hence
> > -the convention that these variables have names starting with the
> > -letter 'r').
> > +into pieces, or move them around.  The use of READ_ONCE(), WRITE_ONCE(),
> > +or one of the other atomic or synchronization primitives prevents a
> > +large number of compiler optimizations.  In particular, it is guaranteed
> > +that the compiler will not remove such accesses from the generated code
> > +(unless it can prove the accesses will never be executed), it will not
> > +change the order in which they occur in the code (within limits imposed
> > +by the C standard), and it will not introduce extraneous accesses.
> > +
> > +The MP and SB examples above used READ_ONCE() and WRITE_ONCE() rather
> > +than ordinary memory accesses.  Thanks to this usage, we can be certain
> > +that in the MP example, the compiler won't reorder P0's write event to
> > +buf and P0's write event to flag, and similarly for the other shared
> > +memory accesses in the examples.
> > +
> > +Since private variables are not shared between CPUs, they can be
> > +accessed normally without READ_ONCE() or WRITE_ONCE().  In fact, they
> > +need not even be stored in normal memory at all -- in principle a
> > +private variable could be stored in a CPU register (hence the convention
> > +that these variables have names starting with the letter 'r').
> >  
> >  
> >  A WARNING
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 2b87f3971548c..fc07b52f20286 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -167,15 +167,15 @@ scripts	Various scripts, see scripts/README.
> >  LIMITATIONS
> >  ===========
> >  
> > -The Linux-kernel memory model has the following limitations:
> > -
> > -1.	Compiler optimizations are not modeled.  Of course, the use
> > -	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
> > -	to optimize, but there is Linux-kernel code that uses bare C
> > -	memory accesses.  Handling this code is on the to-do list.
> > -	For more information, see Documentation/explanation.txt (in
> > -	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
> > -	and "A WARNING" sections).
> > +The Linux-kernel memory model (LKMM) has the following limitations:
> > +
> > +1.	Compiler optimizations are not accurately modeled.  Of course,
> > +	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
> > +	ability to optimize, but under some circumstances it is possible
> > +	for the compiler to undermine the memory model.  For more
> > +	information, see Documentation/explanation.txt (in particular,
> > +	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
> > +	sections).
> >  
> >  	Note that this limitation in turn limits LKMM's ability to
> >  	accurately model address, control, and data dependencies.
> > 
> 

