Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9373A1915
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhFIPTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 11:19:33 -0400
Received: from foss.arm.com ([217.140.110.172]:34250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239576AbhFIPTY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 11:19:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9DF0D6E;
        Wed,  9 Jun 2021 08:17:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76C653F73D;
        Wed,  9 Jun 2021 08:17:25 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:16:25 +0100
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
Subject: Re: [PATCH v2 1/3] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <20210609151622.GK4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604112450.13344-2-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:24:48PM +0100, Mark Brown wrote:
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
> flag as with arch_elf_adjust_prot() and calling it for both the main
> executable and any intepreter.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I haven't got my head around whether we must move some of the arm64
logic from arch_elf_adjust_proc() to arch_parse_elf_properties(), but
either way, it would make sense to explain the direction of travel here.

(This may just be me failing to keep track of what's changing -- the
affected logic is retained for bisectability here and then dropped later
on in the series...)

It's a little annoying that we add has_interp all over the place only to
remove it again later, but I guess that may be the simplest way to keep
things bisectable while moving logic around.  If so, I don't have a
strong opinion on it.

[...]

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 187b3f2b9202..253ca9969345 100644
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
> @@ -963,12 +968,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
> @@ -979,10 +983,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
> +				      interpreter, false, &arch_state);

Nit: interpreter != NULL?

(I guess it works as-is, but from the way this is written it looks a
little like we intend parse_elf_properties() to examine / modify
*interpreter, which is not the case.

>  	if (retval)
>  		goto out_free_dentry;
>  

[...]

Cheers
---Dave
