Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD630D73
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEaLpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 07:45:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbfEaLpm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 May 2019 07:45:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VBS0sj141225
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 07:45:41 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2su17cdh94-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 07:45:41 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 31 May 2019 12:45:40 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 12:45:36 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VBiKap41353694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 11:44:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA546B2065;
        Fri, 31 May 2019 11:44:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DD40B2064;
        Fri, 31 May 2019 11:44:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 11:44:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 98B2B16C5D81; Fri, 31 May 2019 04:44:21 -0700 (PDT)
Date:   Fri, 31 May 2019 04:44:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Vineet Gupta'" <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053111-0040-0000-0000-000004F6FBE0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011190; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211199; UDB=6.00636407; IPR=6.00992235;
 MB=3.00027130; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 11:45:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053111-0041-0000-0000-0000090316D9
Message-Id: <20190531114421.GJ28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310076
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 31, 2019 at 09:41:17AM +0000, David Laight wrote:
> From: Vineet Gupta
> > Sent: 30 May 2019 19:23
> ...
> > While it seems reasonable form hardware pov to not implement such atomicity by
> > default it seems there's an additional burden on application writers. They could
> > be happily using a lockless algorithm with just a shared flag between 2 threads
> > w/o need for any explicit synchronization. But upgrade to a new compiler which
> > aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> > causing the code to suddenly stop working. Is the onus on them to declare such
> > memory as c11 atomic or some such.
> 
> A 'new' compiler can't suddenly change the alignment rules for structure elements.
> The alignment rules will be part of the ABI.
> 
> More likely is that the structure itself is unexpectedly allocated on
> an 8n+4 boundary due to code changes elsewhere.
> 
> It is also worth noting that for complete portability only writes to
> 'full words' can be assumed atomic.
> Some old Alpha's did RMW cycles for byte writes.
> (Although I suspect Linux doesn't support those any more.)

Any C11 or later compiler needs to generate the atomic RMW cycles if
needed in cases like this.  To see this, consider the following code:

	spinlock_t l1;
	spinlock_t l2;
	struct foo {
		char c1; // Protected by l1
		char c2; // Protected by l2
	}

	...

	spin_lock(&l1);
	fp->c1 = 42;
	do_somthing_protected_by_l1();
	spin_unlock(&l1);

	...

	spin_lock(&l2);
	fp->c2 = 206;
	do_somthing_protected_by_l2();
	spin_unlock(&l2);

A compiler that failed to generate atomic RMW code sequences for those
stores to ->c1 and ->c2 would be generating a data race in the object
code when there was no such race in the source code.  Kudos to Hans Boehm
for having browbeat compiler writers into accepting this restriction,
which was not particularly popular -- they wanted to be able to use
vector units and such.  ;-)

> Even x86 can catch you out.
> The bit operations will do wider RMW cycles than you expect.

But does the compiler automatically generate these?

							Thanx, Paul

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

