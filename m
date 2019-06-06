Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8237F5E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFFVRo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 17:17:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbfFFVRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 17:17:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56L7KgM039981
        for <linux-arch@vger.kernel.org>; Thu, 6 Jun 2019 17:17:42 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy8xbcmb9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 17:17:42 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jun 2019 22:17:41 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 22:17:38 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56LHbXc27066732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 21:17:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A6B5B2064;
        Thu,  6 Jun 2019 21:17:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B183B2065;
        Thu,  6 Jun 2019 21:17:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.216.200])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 21:17:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D275D16C362C; Thu,  6 Jun 2019 14:17:36 -0700 (PDT)
Date:   Thu, 6 Jun 2019 14:17:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
 <CAMuHMdW-8Jt80mSyHTYmj6354-3f1=Vp_8dY-Nite1ERpUCFew@mail.gmail.com>
 <20190606094340.GD28207@linux.ibm.com>
 <8d1666df180d4d01aaebb5d41370b338@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1666df180d4d01aaebb5d41370b338@AcuMS.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060621-2213-0000-0000-0000039B2E67
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011224; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214223; UDB=6.00638248; IPR=6.00995302;
 MB=3.00027212; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-06 21:17:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060621-2214-0000-0000-00005EBF501D
Message-Id: <20190606211736.GW28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060143
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 04:34:52PM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 06 June 2019 10:44
> ...
> > But m68k is !SMP-only, correct?  If so, the only issues would be
> > interactions with interrupt handlers and the like, and doesn't current
> > m68k hardware use exact interrupts?  Or is it still possible to interrupt
> > an m68k in the middle of an instruction like it was in the bad old days?
> 
> Hardware interrupts were always on instruction boundaries, the
> mid-instruction interrupts would only happen for page faults (etc).

OK, !SMP should be fine, then.

> There were SMP m68k systems (but I can't remember one).
> It was important to continue from a mid-instruction trap on the
> same cpu - unless you could guarantee that all the cpus had
> exactly the same version of the microcode.

Yuck!  ;-)

> In any case you could probably use the 'cmp2' instruction
> for an atomic 64bit write.
> OTOH setting that up was such a PITA it was always easier
> to disable interrupts.

Unless I am forgetting something, given that m68k is a 32-bit system,
we should be OK without an atomic 64-bit write.

							Thanx, Paul

