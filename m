Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004BF3CD187
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhGSJZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 05:25:35 -0400
Received: from foss.arm.com ([217.140.110.172]:54412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235709AbhGSJZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 05:25:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B15B76D;
        Mon, 19 Jul 2021 03:06:14 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF4F3F73D;
        Mon, 19 Jul 2021 03:06:13 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:04:39 +0100
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
Subject: Re: [PATCH v4 1/4] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <20210719100427.GT4187@arm.com>
References: <20210712115259.29547-1-broonie@kernel.org>
 <20210712115259.29547-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712115259.29547-2-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 12:52:56PM +0100, Mark Brown wrote:
> Currently the ELF code only attempts to parse properties on the image
> that will start execution, either the interpreter or for statically linked
> executables the main executable. The expectation is that any property
> handling for the main executable will be done by the interpreter. This is
> a bit inconsistent since we do map the executable and is causing problems
> for the arm64 BTI support when used in conjunction with systemd's use of
> seccomp to implement MemoryDenyWriteExecute which stops the dynamic linker
> adjusting the permissions of executable segments.
> 
> Allow architectures to handle properties for both the dynamic linker and
> main executable, adjusting arch_parse_elf_properties() to have an is_interp

Nit: to have has_interp and is_interp flags

> flag as with arch_elf_adjust_prot() and calling it for both the main
> executable and any intepreter.

It would be helpful to note that the user of this code (arm64) is
adapted to ensure that there is no functional change; otherwise the
arm64 changes look a little non-obvious.

This is not a big deal though, and the code looks fine.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>

So, with or without the commit message tweaks:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/elf.h |  3 ++-
>  fs/binfmt_elf.c              | 31 +++++++++++++++++++++++--------
>  include/linux/elf.h          |  4 +++-
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 8d1c8dcb87fd..a488a1329b16 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -261,6 +261,7 @@ struct arch_elf_state {
>  
>  static inline int arch_parse_elf_property(u32 type, const void *data,
>  					  size_t datasz, bool compat,
> +					  bool has_interp, bool is_interp,
>  					  struct arch_elf_state *arch)
>  {
>  	/* No known properties for AArch32 yet */
> @@ -273,7 +274,7 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>  		if (datasz != sizeof(*p))
>  			return -ENOEXEC;
>  
> -		if (system_supports_bti() &&
> +		if (system_supports_bti() && has_interp == is_interp &&
>  		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
>  			arch->flags |= ARM64_ELF_BTI;
>  	}
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 439ed81e755a..81e151a57df2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -716,8 +716,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   */
>  
>  static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> -			      struct arch_elf_state *arch,
> -			      bool have_prev_type, u32 *prev_type)
> +			      struct arch_elf_state *arch, bool has_interp,
> +			      bool is_interp, bool have_prev_type,
> +			      u32 *prev_type)
>  {
>  	size_t o, step;
>  	const struct gnu_property *pr;
> @@ -751,7 +752,8 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
>  	*prev_type = pr->pr_type;
>  
>  	ret = arch_parse_elf_property(pr->pr_type, data + o,
> -				      pr->pr_datasz, ELF_COMPAT, arch);
> +				      pr->pr_datasz, ELF_COMPAT,
> +				      has_interp, is_interp, arch);
>  	if (ret)
>  		return ret;
>  
> @@ -764,6 +766,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
>  #define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
>  
>  static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
> +				bool has_interp, bool is_interp,
>  				struct arch_elf_state *arch)
>  {
>  	union {
> @@ -813,7 +816,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>  	have_prev_type = false;
>  	do {
>  		ret = parse_elf_property(note.data, &off, datasz, arch,
> -					 have_prev_type, &prev_type);
> +					 has_interp, is_interp, have_prev_type,
> +					 &prev_type);
>  		have_prev_type = true;
>  	} while (!ret);
>  
> @@ -828,6 +832,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
>  	struct elf_phdr *elf_property_phdata = NULL;
> +	struct elf_phdr *interp_elf_property_phdata = NULL;
>  	unsigned long elf_bss, elf_brk;
>  	int bss_prot = 0;
>  	int retval, i;
> @@ -936,6 +941,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  				executable_stack = EXSTACK_DISABLE_X;
>  			break;
>  
> +		case PT_GNU_PROPERTY:
> +			elf_property_phdata = elf_ppnt;
> +			break;
> +
>  		case PT_LOPROC ... PT_HIPROC:
>  			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
>  						  bprm->file, false,
> @@ -963,12 +972,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			goto out_free_dentry;
>  
>  		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
> -		elf_property_phdata = NULL;
>  		elf_ppnt = interp_elf_phdata;
>  		for (i = 0; i < interp_elf_ex->e_phnum; i++, elf_ppnt++)
>  			switch (elf_ppnt->p_type) {
>  			case PT_GNU_PROPERTY:
> -				elf_property_phdata = elf_ppnt;
> +				interp_elf_property_phdata = elf_ppnt;
>  				break;
>  
>  			case PT_LOPROC ... PT_HIPROC:
> @@ -979,10 +987,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  					goto out_free_dentry;
>  				break;
>  			}
> +
> +		retval = parse_elf_properties(interpreter,
> +					      interp_elf_property_phdata,
> +					      true, true, &arch_state);
> +		if (retval)
> +			goto out_free_dentry;
> +
>  	}
>  
> -	retval = parse_elf_properties(interpreter ?: bprm->file,
> -				      elf_property_phdata, &arch_state);
> +	retval = parse_elf_properties(bprm->file, elf_property_phdata,
> +				      interpreter != NULL, false, &arch_state);
>  	if (retval)
>  		goto out_free_dentry;
>  
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index c9a46c4e183b..1c45ecf29147 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -88,13 +88,15 @@ struct arch_elf_state;
>  #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
>  static inline int arch_parse_elf_property(u32 type, const void *data,
>  					  size_t datasz, bool compat,
> +					  bool has_interp, bool is_interp,
>  					  struct arch_elf_state *arch)
>  {
>  	return 0;
>  }
>  #else
>  extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> -				   bool compat, struct arch_elf_state *arch);
> +				   bool compat, bool has_interp, bool is_interp,
> +				   struct arch_elf_state *arch);
>  #endif
>  
>  #ifdef CONFIG_ARCH_HAVE_ELF_PROT
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
