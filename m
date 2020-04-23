Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A71B595F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDWKiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 06:38:52 -0400
Received: from foss.arm.com ([217.140.110.172]:36992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWKiw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 06:38:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1520531B;
        Thu, 23 Apr 2020 03:38:52 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54943F68F;
        Thu, 23 Apr 2020 03:38:50 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:38:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 10/23] arm64: mte: Handle synchronous and asynchronous
 tag check faults
Message-ID: <20200423103847.GC4963@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-11-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-11-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:25:50PM +0100, Catalin Marinas wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ddcde093c433..3650a0a77ed0 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -145,6 +145,31 @@ alternative_cb_end
>  #endif
>  	.endm
>  
> +	/* Check for MTE asynchronous tag check faults */
> +	.macro check_mte_async_tcf, flgs, tmp
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if_not ARM64_MTE
> +	b	1f
> +alternative_else_nop_endif
> +	mrs_s	\tmp, SYS_TFSRE0_EL1
> +	tbz	\tmp, #SYS_TFSR_EL1_TF0_SHIFT, 1f
> +	/* Asynchronous TCF occurred for TTBR0 access, set the TI flag */
> +	orr	\flgs, \flgs, #_TIF_MTE_ASYNC_FAULT
> +	str	\flgs, [tsk, #TSK_TI_FLAGS]
> +	msr_s	SYS_TFSRE0_EL1, xzr
> +1:
> +#endif
> +	.endm
> +
> +	/* Clear the MTE asynchronous tag check faults */
> +	.macro clear_mte_async_tcf
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if ARM64_MTE
> +	msr_s	SYS_TFSRE0_EL1, xzr
> +alternative_else_nop_endif

This needs a 'dsb ish' prior to the msr as an indirect write (async tag
check fault) to the TFSRE0_EL1 register is not ordered with a subsequent
direct write (msr) to this register.

The check_mte_async_tcf macro is fine as we execute it after taking an
exception with SCTLR_EL1.ITFSB bit set (which triggers such
synchronisation).

-- 
Catalin
