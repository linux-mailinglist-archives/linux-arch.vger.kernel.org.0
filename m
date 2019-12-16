Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215101205D4
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLPMdo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 07:33:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727241AbfLPMdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Dec 2019 07:33:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGCWRT7129841;
        Mon, 16 Dec 2019 07:32:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdxy8vnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 07:32:31 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBGCWS60129905;
        Mon, 16 Dec 2019 07:32:30 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdxy8vkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 07:32:30 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBGCU6e7014099;
        Mon, 16 Dec 2019 12:32:33 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2wvqc5ty6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 12:32:33 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGCWSZL46793166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 12:32:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1BB7124053;
        Mon, 16 Dec 2019 12:32:27 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB3E124052;
        Mon, 16 Dec 2019 12:32:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.36.91])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Dec 2019 12:32:21 +0000 (GMT)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename HAVE_RCU_TABLE_NO_INVALIDATE
In-Reply-To: <20191211122955.940455408@infradead.org>
References: <20191211120713.360281197@infradead.org> <20191211122955.940455408@infradead.org>
Date:   Mon, 16 Dec 2019 18:01:58 +0530
Message-ID: <87woawzc1t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_04:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 suspectscore=2 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160113
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Towards a more consistent naming scheme.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig              |    3 ++-
>  arch/powerpc/Kconfig      |    2 +-
>  arch/sparc/Kconfig        |    2 +-
>  include/asm-generic/tlb.h |    2 +-
>  mm/mmu_gather.c           |    2 +-
>  5 files changed, 6 insertions(+), 5 deletions(-)
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
>  config MMU_GATHER_RCU_TABLE_FREE
>  	bool
>  
> -config HAVE_RCU_TABLE_NO_INVALIDATE
> +config MMU_GATHER_NO_TABLE_INVALIDATE
>  	bool
> +	depends on MMU_GATHER_RCU_TABLE_FREE


Can we drop this Kernel config option instead use
MMU_GATHER_RCU_TABLE_FREE? IMHO reducing the kernel config related to
mmu_gather can reduce the complexity. 

>  
>  config HAVE_MMU_GATHER_PAGE_SIZE
>  	bool
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -223,7 +223,7 @@ config PPC
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select MMU_GATHER_RCU_TABLE_FREE		if SMP
> -	select HAVE_RCU_TABLE_NO_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
> +	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MMU_GATHER_PAGE_SIZE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -65,7 +65,7 @@ config SPARC64
>  	select HAVE_KRETPROBES
>  	select HAVE_KPROBES
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP
> -	select HAVE_RCU_TABLE_NO_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
> +	select MMU_GATHER_NO_TABLE_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select HAVE_DYNAMIC_FTRACE
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -137,7 +137,7 @@
>   *  When used, an architecture is expected to provide __tlb_remove_table()
>   *  which does the actual freeing of these pages.
>   *
> - *  HAVE_RCU_TABLE_NO_INVALIDATE
> + *  MMU_GATHER_NO_TABLE_INVALIDATE
>   *
>   *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
>   *  freeing the page-table pages. This can be avoided if you use
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -102,7 +102,7 @@ bool __tlb_remove_page_size(struct mmu_g
>   */
>  static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>  {
> -#ifndef CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE
> +#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
>  	/*
>  	 * Invalidate page-table caches used by hardware walkers. Then we still
>  	 * need to RCU-sched wait while freeing the pages because software
