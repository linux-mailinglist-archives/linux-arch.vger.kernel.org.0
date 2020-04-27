Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BA1BAA87
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgD0Q5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 12:57:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0Q5l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 12:57:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0028131B;
        Mon, 27 Apr 2020 09:57:40 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AF013F68F;
        Mon, 27 Apr 2020 09:57:39 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:57:37 +0100
From:   Dave Martin <dave.martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 01/23] arm64: alternative: Allow alternative_insn to
 always issue the first instruction
Message-ID: <20200427165737.GD15808@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-2-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-2-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:25:41PM +0100, Catalin Marinas wrote:
> There are situations where we do not want to disable the whole block
> based on a config option, only the alternative part while keeping the
> first instruction. Improve the alternative_insn assembler macro to take
> a 'first_insn' argument, default 0, to preserve the current behaviour.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/alternative.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 5e5dc05d63a0..67d7cc608336 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -111,7 +111,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>  	.byte \alt_len
>  .endm
>  
> -.macro alternative_insn insn1, insn2, cap, enable = 1
> +/*
> + * Disable the whole block if enable == 0, unless first_insn == 1 in which
> + * case insn1 will always be issued but without an alternative insn2.
> + */
> +.macro alternative_insn insn1, insn2, cap, enable = 1, first_insn = 0
>  	.if \enable
>  661:	\insn1
>  662:	.pushsection .altinstructions, "a"
> @@ -122,6 +126,8 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>  664:	.popsection
>  	.org	. - (664b-663b) + (662b-661b)
>  	.org	. - (662b-661b) + (664b-663b)
> +	.elseif \first_insn
> +	\insn1

This becomes quite unreadable at the invocation site, especially when
invoked as "alternative_insn ..., 1".  "... first_insn=1" is not much
better either).

I'm struggling to find non-trivial users of this that actually want the
whole block to be deleted dependent on the config.

Can we instead just always behave as if first_insn=1 instead?  This this
works intuitively as an alternative, not the current weird 3-way choice
between insn1, insn2 and nothing at all.  The only time that makes sense
is when one of the insns is a branch that skips the block, but that's
handled via the alternative_if macros instead.

Behaving always like first_insn=1 provides an if-else that is statically
optimised if the relevant feature is configured out, which I think is
the only thing people are ever going to want.

Maybe something depends on the current behaviour, but I can't see it so
far...

[...]

Cheers
---Dave
