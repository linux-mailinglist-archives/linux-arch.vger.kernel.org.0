Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F667AD17
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfG3P7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 11:59:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728825AbfG3P7b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 11:59:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UFvctd054436;
        Tue, 30 Jul 2019 11:59:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2q8mdfh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 11:59:14 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6UFvxeT055565;
        Tue, 30 Jul 2019 11:59:05 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2q8mdf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 11:59:05 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6UFtFgj004690;
        Tue, 30 Jul 2019 15:58:48 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2u0e86qs7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 15:58:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UFwlNw36503878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 15:58:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7357AB2065;
        Tue, 30 Jul 2019 15:58:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5089BB2064;
        Tue, 30 Jul 2019 15:58:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.181.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 15:58:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E976416C13A3; Tue, 30 Jul 2019 08:58:47 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:58:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Use term cumul-fence instead of fence in ->prop ordering
 example
Message-ID: <20190730155847.GW14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190729123605.150423-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907291641220.760-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1907291641220.760-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 04:41:34PM -0400, Alan Stern wrote:
> On Mon, 29 Jul 2019, Joel Fernandes (Google) wrote:
> 
> > To reduce ambiguity in the more exotic ->prop ordering example, let us
> > use the term cumul-fence instead fence for the 2 fences, so that the
> > implict ->rfe on loads/stores to Y are covered by the description.
> > 
> > Link: https://lore.kernel.org/lkml/20190729121745.GA140682@google.com
> > 
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  tools/memory-model/Documentation/explanation.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > index 68caa9a976d0..634dc6db26c4 100644
> > --- a/tools/memory-model/Documentation/explanation.txt
> > +++ b/tools/memory-model/Documentation/explanation.txt
> > @@ -1302,7 +1302,7 @@ followed by an arbitrary number of cumul-fence links, ending with an
> >  rfe link.  You can concoct more exotic examples, containing more than
> >  one fence, although this quickly leads to diminishing returns in terms
> >  of complexity.  For instance, here's an example containing a coe link
> > -followed by two fences and an rfe link, utilizing the fact that
> > +followed by two cumul-fences and an rfe link, utilizing the fact that
> >  release fences are A-cumulative:
> >  
> >  	int x, y, z;
> > @@ -1334,10 +1334,10 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
> >  link from P0's store to its load.  This is because P0's store gets
> >  overwritten by P1's store since x = 2 at the end (a coe link), the
> >  smp_wmb() ensures that P1's store to x propagates to P2 before the
> > -store to y does (the first fence), the store to y propagates to P2
> > +store to y does (the first cumul-fence), the store to y propagates to P2
> >  before P2's load and store execute, P2's smp_store_release()
> >  guarantees that the stores to x and y both propagate to P0 before the
> > -store to z does (the second fence), and P0's load executes after the
> > +store to z does (the second cumul-fence), and P0's load executes after the
> >  store to z has propagated to P0 (an rfe link).
> >  
> >  In summary, the fact that the hb relation links memory access events
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Queued with Alan's ack, thank you both!

							Thanx, Paul
