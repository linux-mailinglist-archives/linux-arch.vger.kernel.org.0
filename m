Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E431C8A42
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGMRD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 May 2020 08:17:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38686 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGMRB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 08:17:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200507121659euoutp0130134b196d36649fee372093381b253f~MviF4DxTt3103131031euoutp01p;
        Thu,  7 May 2020 12:16:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200507121659euoutp0130134b196d36649fee372093381b253f~MviF4DxTt3103131031euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588853819;
        bh=+0bSafdqNc6S4bL9vEty9BPH/rbVn5QLED7naWqmpz8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LXFU2Q9Lhx6b8gh4rlmMfRU7Wl/uygI1LFV8ej1938MBW4PXQBu1mm6OYGHSJOCyH
         CRip2q0s/ovbd/k6WdmcJkneHqwQob1RDdo0RPKut9fwHOSGljob338Ets2tYQnzXD
         qLFZScLDfymGjBJQtA0thhhPMGogM7bwVnAUFbxI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200507121659eucas1p26a10dcbc8fe175821e21df8ac520305c~MviFl1y090729007290eucas1p26;
        Thu,  7 May 2020 12:16:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 82.44.60698.B3CF3BE5; Thu,  7
        May 2020 13:16:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f~MviFLRGLh0728607286eucas1p2p;
        Thu,  7 May 2020 12:16:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200507121658eusmtrp18cffaa2b9f5206ccfc4335c60b0f241b~MviFKHTUk1203712037eusmtrp1o;
        Thu,  7 May 2020 12:16:58 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-61-5eb3fc3bb0ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.6A.08375.A3CF3BE5; Thu,  7
        May 2020 13:16:58 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200507121656eusmtip2fdff08fcfd2429469bb24f2c1d011a1e~MviDWmdYd2670726707eusmtip2d;
        Thu,  7 May 2020 12:16:56 +0000 (GMT)
Subject: Re: [PATCH v4 02/14] arm: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
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
        Mike Rapoport <rppt@linux.ibm.com>,
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
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
Date:   Thu, 7 May 2020 14:16:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414153455.21744-3-rppt@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tb0xTVxjGd+6/XojFQ5FxxsiWdNNkGnDGubyJC5lzS+62D8PEfdAFXKc3
        1YyC6W11arJ0/DGloRsUWLGt26zZFFMkFC2UUZVGQcdgwypBI+pQwjBAoU6nUGS9XMz49rzv
        ec7zO8+Hw9Oax1wmv6fIJBqLdIVaLpkJdD3ty94Ybyl486qTAU+Tj4M5R5cKmuubWAiWDzIw
        VVJOQ/SXSgTWUgqOPZ1h4fD3m+Co24FgLtTMQfzIFAXjsTUw/Vu3Cm6ETyK48+s3CXv7Iwb8
        9wZYiJa1cTBlnWQh0u7h4LZvngVPvJaGcF0Iwey/zxIozxUWzljCHNhcIxz4KyIc+C4eV8HF
        plYKBmstHITq7iLo9TckYH/eZuBsT5SGslsb4I4jRL27SvD94ENCZKCfFmZnHEgo/+4JJ0S+
        tVOCd8zCCNW92ULQNaQSjneMUULleBkr+E9VcII/5lAJfe4pRrhcP8sIVd4LSPjD76PzsrYn
        v7NLLNyzTzSuzf08ebe1YfneaPpXg41u2oJcqTaUxBP8FnH2WjkbSuY1+CQiZd5OWhn+QeRq
        /02kDA8RcVePqp5fsY2e52StwScQORb4VDFFEel/WE/LB2n4Q2JvucTIegXOI4GYnZFNNPbw
        pGb8+gIjDXspYp8vWYji8Dpim7AtaDXOJbPxUMLE8wx+nXS4UmSZjvOJc2Cr4kglV47cZ+R1
        Et5ALo0cktc0fpWUnnXTis4gN+//SMkkgoeTyO8jPy8kEvw+6fRqlC5p5EH3mcVeWaSnppJR
        /KWI/NXXqFKGSkQiJfVIcW0kt/pmODmIxm+Qpva1ynoTcUZbKSU/hQxOpCpvSCGOgHMRqybW
        w4vYVcTVfVpVhV5zLSnjWtLAtaSB63/WT4g5hTJEs2TQi9L6InF/jqQzSOYifc7OYoMfJX5D
        z7PuR23oXPyLMMI80i5Tw3RLgYbV7ZMOGMKI8LR2hXrZk+YCjXqX7sBB0Vi8w2guFKUwepln
        tBnq9d6xfA3W60zil6K4VzQ+P6X4pEwLulZT3GgZmauYvLB8i346b3J0S+yjQ84bKR+02U/n
        rv674m3j/sdgC4qRbQ2Zd6+lt2g+/qxj89DRmBGud0kdZr3JpA6vaQsMj5s3mya2Z+e/aGc6
        c155gS95EHJq8/mVK+uCL7G2+NCwvauqxvBJPHxvayiYtWP+YPXXje+1TtZqGWm3bt1q2ijp
        /gMIjfFfCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTZxSH895/vRjKrgXGG4Zxqc4FN+ouWDkYRbd98OI2XWL8sgms0Tsw
        Uup6WzNnslUBLVUmViBYUBGmmeZupLc6BO3ARlAkKkgkaAZsQeLcFCrLEKGAvQETvj3vOc/v
        PTnJYUldORPP7sy3idZ8U56eWUB1TN/oT1od8mV9MNaUCNX1MgNT7jYNeCvraWgs6qUgeKCI
        hJFzRxA4Cwg483KChoMVH8LJKjeCKb+XgdCJIAFPR9+D57duaOBB4GcEA1f2h/Wm/ylQBnto
        GCm8zEDQOUxDd1M1A/3yDA3VoTISAuV+BJMvpsOjqttpuOgIMODyDDGgFHczIF+v08D1+gYC
        esscDPjL/0RwWzkfHtbZT8GljhESCv8wwoDbT6xfJsinZCR093SRwuSEGwlFR8cZofvHEkKo
        feKghGO3k4RGT59GqLv6hBCOPC2kBeVCMSMoo26NcKcqSAk3KycpobS2BQl3FZn8POELwxqr
        xW4T3861SLa1+i95SDbwaWBIXplm4FNSM1cnG/Ur0tfsEPN27hGtK9K/MuQ6z7+xeyT2295f
        qkgH8ix0oQgWcyux63Ez40ILWB13FuH/hu/Ts40E3F7hmONoHOpxzUnPEC7yFiO1Ec1l4BJf
        K6VyDLcJt08MUapEcjUsHr35mFAf0VwNgRua20jV0nHZuLPgCqEyw/HY9Uz9NoLVcul4MuQP
        OyxLcUvxVU+UirFcJi7sSpw1FuL2E48otRzBGXHr0D61THKr8CnfX+QsL8YFl6rmOA4/fHSa
        KEXRnnlpz7yIZ17EMy9Sg6gLKEa0S+Ycs8QbJJNZsufnGLZbzAoKn+RvbS99l9E975YA4lik
        j9TCc1+WjjbtkfaaAwizpD5GGznuzdJpd5j2fidaLdlWe54oBZAxvNkxMj52uyV84Pm2bN7I
        p0Ian5qSmrIK9HFaJ3dtm47LMdnEXaK4W7S+zhFsRLwDvfVpX0COa9v1w6HGsYdRXWLL2p8S
        yzKCmpPjEHl2bNO1SpKOKu3c9827X7ta/x6W+/6Rgh8XD2ad21qXd9wd2PiAWv7Zhg7F5Eg/
        lH3H+Wtmx5KZmX8XN/x+unZg+v2SdXIL8c6yaWZzrH1QSWpOOHz8Td/U1PeLMsHwSV/JRxlH
        B2x6Sso18ctJq2R6BVeOmCioAwAA
X-CMS-MailID: 20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f
References: <20200414153455.21744-1-rppt@kernel.org>
        <20200414153455.21744-3-rppt@kernel.org>
        <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi

On 14.04.2020 17:34, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Today I've noticed that kexec is broken on ARM 32bit. Bisecting between 
current linux-next and v5.7-rc1 pointed to this commit. I've tested this 
on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:

# kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
memory_range[0]:0x40000000..0xbe9fffff
memory_range[0]:0x40000000..0xbe9fffff
# kexec -e
kexec_core: Starting new kernel
8<--- cut here ---
Unable to handle kernel paging request at virtual address c010f1f4
pgd = c6817793
[c010f1f4] *pgd=4000041e(bad)
Internal error: Oops: 80d [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1329 Comm: kexec Tainted: G        W 
5.7.0-rc3-00127-g6cba81ed0f62 #611
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at machine_kexec+0x40/0xfc
LR is at 0xffffffff
pc : [<c010f0b4>]    lr : [<ffffffff>]    psr: 60000013
sp : ebc13e60  ip : 40008000  fp : 00000001
r10: 00000058  r9 : fee1dead  r8 : 00000001
r7 : c121387c  r6 : 6c224000  r5 : ece40c00  r4 : ec222000
r3 : c010f1f4  r2 : c1100000  r1 : c1100000  r0 : 418d0000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6bc14059  DAC: 00000051
Process kexec (pid: 1329, stack limit = 0x366bb4dc)
Stack: (0xebc13e60 to 0xebc14000)
...
[<c010f0b4>] (machine_kexec) from [<c01c0d84>] (kernel_kexec+0x74/0x7c)
[<c01c0d84>] (kernel_kexec) from [<c014b1bc>] (__do_sys_reboot+0x1f8/0x210)
[<c014b1bc>] (__do_sys_reboot) from [<c0100060>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xebc13fa8 to 0xebc13ff0)
...
---[ end trace 3e8d6c81723c778d ]---
1329 Segmentation fault      ./kexec -e

> ---
>   arch/arm/include/asm/pgtable.h     |  1 -
>   arch/arm/lib/uaccess_with_memcpy.c |  7 +++++-
>   arch/arm/mach-sa1100/assabet.c     |  2 +-
>   arch/arm/mm/dump.c                 | 29 +++++++++++++++++-----
>   arch/arm/mm/fault-armv.c           |  7 +++++-
>   arch/arm/mm/fault.c                | 22 ++++++++++------
>   arch/arm/mm/idmap.c                |  3 ++-
>   arch/arm/mm/init.c                 |  2 +-
>   arch/arm/mm/ioremap.c              | 12 ++++++---
>   arch/arm/mm/mm.h                   |  2 +-
>   arch/arm/mm/mmu.c                  | 35 +++++++++++++++++++++-----
>   arch/arm/mm/pgd.c                  | 40 ++++++++++++++++++++++++------
>   12 files changed, 125 insertions(+), 37 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

