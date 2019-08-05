Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9920882773
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfHEWRq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Aug 2019 18:17:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727928AbfHEWRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 18:17:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75MGdLQ103742;
        Mon, 5 Aug 2019 18:17:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6v9t9qwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 18:17:27 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x75MHRjt105700;
        Mon, 5 Aug 2019 18:17:27 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6v9t9qvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 18:17:27 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x75MAsq3013181;
        Mon, 5 Aug 2019 22:17:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2u51w6bcyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 22:17:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75MHQq844957956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 22:17:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28E03B20A4;
        Mon,  5 Aug 2019 22:17:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3DCB209D;
        Mon,  5 Aug 2019 22:17:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 22:17:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9958416C9A3A; Mon,  5 Aug 2019 15:17:29 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:17:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Message-ID: <20190805221729.GM28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
 <20190805151545.GA1615@aparri>
 <1565018618.3341.6.camel@HansenPartnership.com>
 <20190805174355.GJ28441@linux.ibm.com>
 <1565028568.15050.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565028568.15050.7.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050224
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 05, 2019 at 11:09:28AM -0700, James Bottomley wrote:
> On Mon, 2019-08-05 at 10:43 -0700, Paul E. McKenney wrote:
> > On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> > > On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > > > Why don't you also add an entry in .mailmap as Will did in
> > > > > commit
> > > > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > > > @kernel.org")?
> > > > 
> > > > I considered it but could not understand its purpose...  Maybe
> > > > you can explain it to me?  ;-) (can resend with this change if
> > > > needed/desired).
> > > 
> > > man git-shortlog gives you the gory detail, but its use is to
> > > "coalesce together commits by the same person in the shortlog,
> > > where their name and/or email address was spelled
> > > differently."  The usual way this happens is that people have the
> > > name that appears in the From field with and without initials.
> > 
> > New one on me, thank you!  So I should have a line in .mailmap like
> > this?
> > 
> > Paul E. McKenney <paulmck@linux.vnet.ibm.com> <paul.mckenney@linaro.o
> > rg> <paulmck@linux.ibm.com>
> 
> Well, you could, but there's no need.  As long as your email has 'Paul
> E. McKenney' as the text prefix, git-shortlog will do the correct
> aggregation without any need for a .mailmap entry.  However, if, say,
> your linaro email had been
> 
> Paul McKenney <paul.mckenney@linaro.com>
> 
> Then you would need one because git-shortlog would think 'Paul
> McKenney' and 'Paul E. McKenney' were two different people.

Thank you for the explication!

							Thanx, Paul
