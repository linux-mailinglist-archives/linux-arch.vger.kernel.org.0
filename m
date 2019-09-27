Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE350C03C7
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfI0LA0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 07:00:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51144 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfI0LAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 07:00:25 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8RAxKHL024144;
        Fri, 27 Sep 2019 05:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=t4yOQo0VlJX6JufnHlZIny/cmaBng/L1TfNmP/2VMGU=;
 b=lTrXqdfpDsdRtLbwZQcpO+qpqMdi93ncS5Dz9Cdnlcb5zl2eNC5iNv7R9BUqkcfzVQV7
 F44mcqofdU1HXuSEj0cRS9Hb6VCrOzUBz9YE/KqSkiiGoGgcWJr6jW3VZNmuCoYM1Gey
 NdNiCa8RXQwaKJMSugeU6oWrQOhe7IDUCoCY0k/Sljhe+EQ8PuuGpUS6h1FGrfYJoYE/
 Bl7XRlHGXS3AVvVWG9L6xgB2ynH4oWkRnLyNBGgA/4L6Zk8S4k5wI2Gyn2ovq8eI7ybo
 w6OMLdaVUlVjO73j3vxGEOeFMXidTgG40wJnGgpjfGz2Tja26L5V90ba2AJALfgvYA4c Mg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2v5h92ckbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Sep 2019 05:59:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 27 Sep
 2019 11:59:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 27 Sep 2019 11:59:42 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B7692C3;
        Fri, 27 Sep 2019 10:59:42 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:59:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <rmk+kernel@arm.linux.org.uk>, Will Deacon <will@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20190927105942.GS10204@ediswmail.ad.cirrus.com>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909270103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 27, 2019 at 12:43:33PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2019-08-30 at 12:43 +0900, Masahiro Yamada wrote:
> > Commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > this option. A couple of build errors were reported by randconfig,
> > but all of them have been ironed out.
> > 
> > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > (and it will simplify the 'inline' macro in compiler_types.h),
> > this commit changes it to always-on option. Going forward, the
> > compiler will always be allowed to not inline functions marked
> > 'inline'.
> > 
> > This is not a problem for x86 since it has been long used by
> > arch/x86/configs/{x86_64,i386}_defconfig.
> > 
> > I am keeping the config option just in case any problem crops up for
> > other architectures.
> > 
> > The code clean-up will be done after confirming this is solid.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> [ Adding some ARM people as they might be able to help ]
> 
> This was found to cause a regression on a Raspberry Pi 2 B built with
> bcm2835_defconfig which among other things has no SMP support.
> 
> The relevant logs (edited to remove the noise) are:
> 
> [    5.827333] Run /init as init process
> Loading, please wait...
> Failed to set SO_PASSCRED: Bad address
> Failed to bind netlink socket: Bad address
> Failed to create manager: Bad address
> Failed to set SO_PASSCRED: Bad address
> [    9.021623] systemd[1]: SO_PASSCRED failed: Bad address
> [!!!!!!] Failed to start up manager.
> [    9.079148] systemd[1]: Freezing execution.
> 
> I looked into it, it turns out that the call to get_user() in sock_setsockopt()
> is returning -EFAULT. Down the assembly rabbit hole that get_user() is I
> found-out that it's the macro 'check_uaccess' who's triggering the error.
> 
> I'm clueless at this point, so I hope you can give me some hints on what's
> going bad here.
> 

Not sure I can add much in terms of a solution, but I can at
least confirm I am seeing exactly the same issue, on my Zynq
based ARM system.

Thanks,
Charles
