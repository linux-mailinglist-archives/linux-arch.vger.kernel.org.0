Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E293CD18A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhGSJ0E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 05:26:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235309AbhGSJ0E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 05:26:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F42E6D;
        Mon, 19 Jul 2021 03:06:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0803F73D;
        Mon, 19 Jul 2021 03:06:43 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:05:26 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v4 4/4] elf: Remove has_interp property from
 arch_parse_elf_property()
Message-ID: <20210719100526.GW4187@arm.com>
References: <20210712115259.29547-1-broonie@kernel.org>
 <20210712115259.29547-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712115259.29547-5-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 12:52:59PM +0100, Mark Brown wrote:
> Since all current users of arch_parse_elf_property() are able to treat the
> interpreter and main executable orthogonaly the has_interp argument is now
> redundant so remove it.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 2 +-
>  fs/binfmt_elf.c              | 2 +-
>  include/linux/elf.h          | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 9f86dbce2680..a6e9032b951a 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -262,7 +262,7 @@ struct arch_elf_state {
>  
>  static inline int arch_parse_elf_property(u32 type, const void *data,
>  					  size_t datasz, bool compat,
> -					  bool has_interp, bool is_interp,
> +					  bool is_interp,
>  					  struct arch_elf_state *arch)
>  {
>  	/* No known properties for AArch32 yet */
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index ae8094d42480..f0b3c24215f6 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -753,7 +753,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
>  
>  	ret = arch_parse_elf_property(pr->pr_type, data + o,
>  				      pr->pr_datasz, ELF_COMPAT,
> -				      has_interp, is_interp, arch);
> +				      is_interp, arch);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index d8392531899d..cdb080d4b34a 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -88,14 +88,14 @@ struct arch_elf_state;
>  #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
>  static inline int arch_parse_elf_property(u32 type, const void *data,
>  					  size_t datasz, bool compat,
> -					  bool has_interp, bool is_interp,
> +					  bool is_interp,
>  					  struct arch_elf_state *arch)
>  {
>  	return 0;
>  }
>  #else
>  extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> -				   bool compat, bool has_interp, bool is_interp,
> +				   bool compat, bool is_interp,
>  				   struct arch_elf_state *arch);
>  #endif
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
