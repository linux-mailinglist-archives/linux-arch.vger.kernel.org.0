Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3901C7CE3A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfGaUZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Jul 2019 16:25:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730341AbfGaUZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 16:25:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VKNn3n029449
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2019 16:25:22 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3hybr4qs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2019 16:25:22 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Jul 2019 21:25:21 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 21:25:16 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VKPFVW52756816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 20:25:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BFA1B2064;
        Wed, 31 Jul 2019 20:25:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CEB2B205F;
        Wed, 31 Jul 2019 20:25:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Jul 2019 20:25:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9874316C99FD; Wed, 31 Jul 2019 13:25:17 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:25:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
 <cb9785b7-ed43-b91a-7392-e50216bd5771@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb9785b7-ed43-b91a-7392-e50216bd5771@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19073120-0052-0000-0000-000003E70E3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011530; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240217; UDB=6.00653980; IPR=6.01021637;
 MB=3.00027984; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-31 20:25:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073120-0053-0000-0000-000061EAB294
Message-Id: <20190731202517.GF5913@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310203
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 01, 2019 at 12:19:25AM +0900, Akira Yokosawa wrote:
> On Wed, 31 Jul 2019 09:52:05 -0400, Alan Stern wrote:
> > On Tue, 30 Jul 2019, Mauro Carvalho Chehab wrote:
> > 
> >> Em Tue, 30 Jul 2019 18:17:01 -0400
> >> Joel Fernandes <joel@joelfernandes.org> escreveu:
> > 
> >>>>> (4) I would argue that every occurence of
> >>>>> A ->(some dependency) B should be replaced with fixed size font in the HTML
> >>>>> results.  
> >>>>
> >>>> Just place those with ``A -> (some dependency)``. This will make them use
> >>>> a fixed size font.  
> >>>
> >>> Ok, understood all these. I guess my point was all of these will need to be
> >>> done to make this document useful from a ReST conversion standpoint. Until
> >>> then it is probably just better off being plain text - since there are so
> >>> many of those ``A -> (dep) B`` things.
> > 
> >> On a very quick look, it seems that, if we replace:
> >>
> >> 	(\S+\s->\S*\s\w+)
> >>
> >> by:
> >> 	``\1``
> >>
> >>
> >> On an editor that would allow to manually replace the regex (like kate),
> >> most of those can be get.
> >>
> >> See patch enclosed.
> > 
> > Some time ago I considered the problem of converting this file to ReST 
> > format.  But I gave up on the idea, because the necessary changes were 
> > so widespread and the resulting text file would not be easily readable.
> > 
> > Replacing things of the form "A ->dep B" just scratches the surface.  
> > That document teems with variable names, formulas, code extracts, and
> > other things which would all need to be rendered in a different font
> > style.  The density of the markup required to do this would be
> > phenomenally high.
> > 
> > In my opinion it simply was not worthwhile.
> 
> +1 on keeping this and the other .txt files of LKMM intact.

Looks like a pretty clear consensus thus far.  Any objections to keeping
these .txt for the time being?

							Thanx, Paul

