Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71574C77F8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 19:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiB1SiX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 13:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiB1Shw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 13:37:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249389A98A
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 10:24:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2E171042;
        Mon, 28 Feb 2022 10:24:11 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.196.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E23C3F70D;
        Mon, 28 Feb 2022 10:24:09 -0800 (PST)
Date:   Mon, 28 Feb 2022 18:24:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v10 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <Yh0TR3l6kWpsg0uu@arm.com>
References: <20220228130606.1070960-1-broonie@kernel.org>
 <20220228130606.1070960-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228130606.1070960-3-broonie@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 01:06:06PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79..82aaf361fa17 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -701,23 +701,49 @@ core_initcall(tagged_addr_init);
>  #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
>  
>  #ifdef CONFIG_BINFMT_ELF
> +static unsigned int bti_main;
> +
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
>  			 bool has_interp, bool is_interp)
>  {
> -	/*
> -	 * For dynamically linked executables the interpreter is
> -	 * responsible for setting PROT_BTI on everything except
> -	 * itself.
> -	 */
> -	if (is_interp != has_interp)
> -		return prot;
> -
> -	if (!(state->flags & ARM64_ELF_BTI))
> -		return prot;
> -
> -	if (prot & PROT_EXEC)
> +	if ((prot & PROT_EXEC) &&
> +	    (is_interp || !has_interp || bti_main) &&
> +	    (state->flags & arm64_elf_bti_flag(is_interp)))
>  		prot |= PROT_BTI;
>  
>  	return prot;
>  }

TBH, I liked the other series more as we were getting rid of
'has_interp' in patches 3 and 4. Now we keep it around only for the
bti_main case on dynamic executables (i.e. we need to distinguish them
from static). We could still get rid of has_interp if bti_main was
default on and it affected static binaries as well (for consistency, it
wouldn't be a bad idea).

I think the risk of ABI breaking is negligible in a glibc distro since
currently the dynamic loader sets PROT_BTI on the main exe anyway, just
as the kernel does after this series.

Anyway, from a correctness perspective, this patch looks fine to me,
just a preference for the other series:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
