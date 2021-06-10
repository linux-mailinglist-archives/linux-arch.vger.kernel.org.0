Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75EA3A28DF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJKBz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 06:01:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJKBz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 06:01:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA0ED6E;
        Thu, 10 Jun 2021 02:59:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0BA63F694;
        Thu, 10 Jun 2021 02:59:57 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:58:57 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <20210610095853.GN4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org>
 <20210609151724.GM4187@arm.com>
 <6e0b1dbd-688c-aba6-e376-91ce9440d741@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0b1dbd-688c-aba6-e376-91ce9440d741@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 09, 2021 at 09:55:36AM -0700, Yu, Yu-cheng wrote:
> On 6/9/2021 8:17 AM, Dave Martin wrote:
> >On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:
> >>Since we have added an is_interp flag to arch_parse_elf_property() we can
> >>drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> >>the arm64 code which no longer needs it and any future users will be able
> >>to use arch_parse_elf_properties() to determine if an interpreter is in
> >>use.
> >
> >So far so good, but can we also drop the has_interp argument from
> >arch_parse_elf_properties()?
> >
> >Cross-check with Yu-Cheng Yu's series, but I don't see this being used
> >any more (except for passthrough in binfmt_elf.c).
> >
> >Since we are treating the interpreter and main executable orthogonally
> >to each other now, I don't think we should need a has_interp argument to
> >pass knowledge between the interpreter and executable handling phases
> >here.
> >
> 
> For CET, arch_parse_elf_property() needs to know has_interp and is_interp.
> Like the following, on top of your patches:
> 
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 607b782afe2c..9e6f142b5cef 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -837,8 +837,15 @@ unsigned long KSTK_ESP(struct task_struct *task)
>  }
> 
>  int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> -			    bool compat, struct arch_elf_state *state)
> +			    bool compat, bool has_interp, bool is_interp,
> +			    struct arch_elf_state *state)
>  {
> +	/*
> +	 * Parse static-linked executable or the loader.
> +	 */
> +	if (has_interp != is_interp)
> +		return 0;
> +

[...]

Ah, sorry, I did attempt to check this with your series, but I didn't
attempt to build it.  I must have missed this somehow.

But: does x86 actually need to do this?

For arm64, we've discovered that it is better to treat the ELF
interpreter and main executable independently when applying the ELF
properties.

So, can x86 actually port away from this?  arch_parse_elf_properties()
and arch_adjust_elf_prot() would still know whether the interpreter is
being considered or not, via the is_interp argument to both functions.
This allows interpreter and main executable info to be stashed
independently in the arch_elf_state.

If x86 really needs to carry on following the existing model then that's
fine, but we should try to keep x86 and arm64 aligned if at all possible.

Cheers
---Dave
