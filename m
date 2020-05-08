Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9161E1CB637
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEHRoN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 13:44:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEHRoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2020 13:44:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HZWAC120545;
        Fri, 8 May 2020 13:42:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtveutta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:42:43 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048HaDP7122403;
        Fri, 8 May 2020 13:42:42 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtveutsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:42:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048HeoYq020104;
        Fri, 8 May 2020 17:42:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5wvbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 17:42:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048HgbZm43712600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 17:42:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBCB542041;
        Fri,  8 May 2020 17:42:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EED54203F;
        Fri,  8 May 2020 17:42:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 May 2020 17:42:34 +0000 (GMT)
Date:   Fri, 8 May 2020 20:42:32 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
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
Message-ID: <20200508174232.GA759899@linux.ibm.com>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-3-rppt@kernel.org>
 <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
 <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
 <20200507161155.GE683243@linux.ibm.com>
 <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=1 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080144
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 08:53:27AM +0200, Marek Szyprowski wrote:
> Hi Mike,
> 
> On 07.05.2020 18:11, Mike Rapoport wrote:
> > On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
> >> On 14.04.2020 17:34, Mike Rapoport wrote:
> >>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>
> >>> Implement primitives necessary for the 4th level folding, add walks of p4d
> >>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
> >>>
> >>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> Today I've noticed that kexec is broken on ARM 32bit. Bisecting between
> >> current linux-next and v5.7-rc1 pointed to this commit. I've tested this
> >> on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:
> >>
> >> # kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
> >> memory_range[0]:0x40000000..0xbe9fffff
> >> memory_range[0]:0x40000000..0xbe9fffff
> >> # kexec -e
> >> kexec_core: Starting new kernel
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address c010f1f4
> >> pgd = c6817793
> >> [c010f1f4] *pgd=4000041e(bad)
> >> Internal error: Oops: 80d [#1] PREEMPT ARM
> >> Modules linked in:
> >> CPU: 0 PID: 1329 Comm: kexec Tainted: G        W
> >> 5.7.0-rc3-00127-g6cba81ed0f62 #611
> >> Hardware name: Samsung Exynos (Flattened Device Tree)
> >> PC is at machine_kexec+0x40/0xfc
> > Any chance you have the debug info in this kernel?
> > scripts/faddr2line would come handy here.
> 
> # ./scripts/faddr2line --list vmlinux machine_kexec+0x40
> machine_kexec+0x40/0xf8:
> 
> machine_kexec at arch/arm/kernel/machine_kexec.c:182
>   177            reboot_code_buffer = 
> page_address(image->control_code_page);
>   178
>   179            /* Prepare parameters for reboot_code_buffer*/
>   180            set_kernel_text_rw();
>   181            kexec_start_address = image->start;
>  >182<           kexec_indirection_page = page_list;
>   183            kexec_mach_type = machine_arch_type;
>   184            kexec_boot_atags = image->arch.kernel_r2;
>   185
>   186            /* copy our kernel relocation code to the control code 
> page */
>   187            reboot_entry = fncpy(reboot_code_buffer,

Can you please try the patch below:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 963b5284d284..f86b3d17928e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -571,7 +571,7 @@ static inline void section_update(unsigned long addr, pmdval_t mask,
 {
 	pmd_t *pmd;
 
-	pmd = pmd_off_k(addr);
+	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), addr), addr);
 
 #ifdef CONFIG_ARM_LPAE
 	pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);

>  > ...
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
Sincerely yours,
Mike.
