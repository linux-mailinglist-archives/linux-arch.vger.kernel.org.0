Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501D61CDCDF
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgEKOQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 10:16:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730158AbgEKOQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 10:16:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDXD0a161500;
        Mon, 11 May 2020 10:15:47 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvrxy12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 10:15:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BEB2Gc003182;
        Mon, 11 May 2020 14:15:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30wm55mhcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 14:15:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04BEFg6J62193780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 14:15:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49024204B;
        Mon, 11 May 2020 14:15:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C160C42045;
        Mon, 11 May 2020 14:15:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.187])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 May 2020 14:15:38 +0000 (GMT)
Date:   Mon, 11 May 2020 17:15:36 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>,
        linux-arch@vger.kernel.org, Brian Cain <bcain@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 02/14] arm: add support for folded p4d page tables
Message-ID: <20200511141536.GB983798@linux.ibm.com>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-3-rppt@kernel.org>
 <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
 <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
 <20200507161155.GE683243@linux.ibm.com>
 <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
 <20200508174232.GA759899@linux.ibm.com>
 <665dade8-727a-3318-6779-3998080da18f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665dade8-727a-3318-6779-3998080da18f@samsung.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marek,

On Mon, May 11, 2020 at 08:36:41AM +0200, Marek Szyprowski wrote:
> Hi Mike,
> 
> On 08.05.2020 19:42, Mike Rapoport wrote:
> > On Fri, May 08, 2020 at 08:53:27AM +0200, Marek Szyprowski wrote:
> >> On 07.05.2020 18:11, Mike Rapoport wrote:
> >>> On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
> >>>> On 14.04.2020 17:34, Mike Rapoport wrote:
> >>>>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>>>
> >>>>> Implement primitives necessary for the 4th level folding, add walks of p4d
> >>>>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
> >>>>>
> >>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Can you please try the patch below:
> >
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index 963b5284d284..f86b3d17928e 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -571,7 +571,7 @@ static inline void section_update(unsigned long addr, pmdval_t mask,
> >   {
> >   	pmd_t *pmd;
> >   
> > -	pmd = pmd_off_k(addr);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), addr), addr);
> >   
> >   #ifdef CONFIG_ARM_LPAE
> >   	pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);
> This fixes kexec issue! Thanks!
> 
> 
> Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 218f1c390557 ("arm: add support for folded p4d page tables")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing!

The patch is still in mmotm tree, so I don't think "Fixes" apply.

Andrew, would you like me to send the fix as a formal patch or will pick
it up as a fixup?

> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
Sincerely yours,
Mike.
