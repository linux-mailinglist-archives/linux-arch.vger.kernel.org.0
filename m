Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA12643D2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIJKXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 06:23:51 -0400
Received: from foss.arm.com ([217.140.110.172]:60372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgIJKXp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 06:23:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B941063;
        Thu, 10 Sep 2020 03:23:44 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4693F68F;
        Thu, 10 Sep 2020 03:23:43 -0700 (PDT)
Subject: Re: [PATCH v9 09/29] arm64: mte: Clear the tags when a page is mapped
 in user-space with PROT_MTE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-10-catalin.marinas@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5c2ebe16-2ac9-6cff-3456-6d8ac96b5fb7@arm.com>
Date:   Thu, 10 Sep 2020 11:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904103029.32083-10-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/09/2020 11:30, Catalin Marinas wrote:
> Pages allocated by the kernel are not guaranteed to have the tags
> zeroed, especially as the kernel does not (yet) use MTE itself. To
> ensure the user can still access such pages when mapped into its address
> space, clear the tags via set_pte_at(). A new page flag - PG_mte_tagged
> (PG_arch_2) - is used to track pages with valid allocation tags.
> 
> Since the zero page is mapped as pte_special(), it won't be covered by
> the above set_pte_at() mechanism. Clear its tags during early MTE
> initialisation.
> 
> Co-developed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
[...]
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> new file mode 100644
> index 000000000000..a36705640086
> --- /dev/null
> +++ b/arch/arm64/lib/mte.S
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +#include <linux/linkage.h>
> +
> +#include <asm/assembler.h>
> +#include <asm/sysreg.h>
> +
> +	.arch	armv8.5-a+memtag
> +
> +/*
> + * multitag_transfer_size - set \reg to the block size that is accessed by the
> + * LDGM/STGM instructions.
> + */
> +	.macro	multitag_transfer_size, reg, tmp
> +	mrs_s	\reg, SYS_GMID_EL1
> +	ubfx	\reg, \reg, #SYS_GMID_EL1_BS_SHIFT, #SYS_GMID_EL1_BS_SIZE
> +	mov	\tmp, #4
> +	lsl	\reg, \tmp, \reg
> +	.endm
> +
> +/*
> + * Clear the tags in a page
> + *   x0 - address of the page to be cleared
> + */
> +SYM_FUNC_START(mte_clear_page_tags)
> +	multitag_transfer_size x1, x2
> +1:	stgm	xzr, [x0]
> +	add	x0, x0, x1
> +	tst	x0, #(PAGE_SIZE - 1)
> +	b.ne	1b
> +	ret
> +SYM_FUNC_END(mte_clear_page_tags)
> 

Could the value of SYS_GMID_EL1 vary between CPUs and do we therefore 
need a preempt_disable() around mte_clear_page_tags() (and other 
functions in later patches)?

Steve
