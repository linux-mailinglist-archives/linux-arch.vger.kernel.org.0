Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4DF4D0C5E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 01:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiCHABP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 19:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiCHABO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 19:01:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735433A3A
        for <linux-arch@vger.kernel.org>; Mon,  7 Mar 2022 16:00:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a5so4251040pfv.2
        for <linux-arch@vger.kernel.org>; Mon, 07 Mar 2022 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSChNH+lUdAbaPTUG1zJh3zIL8Yt/GuhG02ImIJkwsA=;
        b=hJ6HSu1DtgxnnOolcgDpDd+f9cHxxGgMPxupO96VRQXTbydy7fPYwJM6r0kvkLQrVS
         6i0415EqzFGhhyo7ZtUfXJQ3xEVwvjVMBh1QVWE2gZ/vFwbrYKQ8JglhynXwiotCnJWn
         7Rgv09FEOcqiw1iH3AUiPwsC9K9T+Q4Vc1DYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSChNH+lUdAbaPTUG1zJh3zIL8Yt/GuhG02ImIJkwsA=;
        b=R14PSBHN4v/EEPw5dQ1qhKIXomGYEu0n/H9tPmcE66oIJ7C1dtKE5scTUMguniiHo1
         NQASK1mzzVl5cgB4kufjc860AMUXqx7YqUFoKsp4cSv2Dgx/28FkRTn16rZ8Sa+RkieG
         OL7Dieyz8US/N9qevmczofErZqp5PO2kTOe8/XWKtirhrR08bgz5Qf+lM0EdeuFXrBKT
         iPVmKsJjQDKWQOSvSNyWDmAFJF8FDXOHFDD8nP4yPojD9o1VpkuPYz0c8Uk37EzSuAXD
         f09jCS7VOLYFeY6XMVFIfICEeruu74bSek3CyGXJIzf/n99Pui/h2nt94bTQLmdJt0yk
         Z07A==
X-Gm-Message-State: AOAM531VbD0oYStSYU9DuTUc+87JVT0ZdBWiM/TNnlGKlovIBMAknmA0
        dgk8dyFZNwz33AlKU8puAJT4Vg==
X-Google-Smtp-Source: ABdhPJxDSuiVE8cbbycz0Ergwkg83bRoKMz9OjxmT3mGTQV67u5NSLYDiOHNckRjeKg+omngneNRog==
X-Received: by 2002:a65:610e:0:b0:378:d43b:9703 with SMTP id z14-20020a65610e000000b00378d43b9703mr11685997pgu.229.1646697616613;
        Mon, 07 Mar 2022 16:00:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00159200b004f708ecd48esm4742514pfk.149.2022.03.07.16.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:00:16 -0800 (PST)
Date:   Mon, 7 Mar 2022 16:00:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v10 1/2] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <202203071551.DBABE01@keescook>
References: <20220228130606.1070960-1-broonie@kernel.org>
 <20220228130606.1070960-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228130606.1070960-2-broonie@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 01:06:05PM +0000, Mark Brown wrote:
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
> main executable, adjusting arch_parse_elf_properties() to have a new
> flag is_interp flag as with arch_elf_adjust_prot() and calling it for
> both the main executable and any intepreter.
> 
> The user of this code, arm64, is adapted to ensure that there is no
> functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/elf.h |  3 ++-
>  fs/binfmt_elf.c              | 32 +++++++++++++++++++++++---------
>  include/linux/elf.h          |  4 +++-
>  3 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 97932fbf973d..5cc002376abe 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -259,6 +259,7 @@ struct arch_elf_state {
>  
>  static inline int arch_parse_elf_property(u32 type, const void *data,
>  					  size_t datasz, bool compat,
> +					  bool has_interp, bool is_interp,
>  					  struct arch_elf_state *arch)

Adding more and more args to a functions like this gives me the sense
that some kind of argument structure is needed.

Once I get enough unit testing written in here, I'm hoping to refactor
a bunch of this. To the future! :)

> @@ -828,6 +832,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
>  	struct elf_phdr *elf_property_phdata = NULL;
> +	struct elf_phdr *interp_elf_property_phdata = NULL;
>  	unsigned long elf_bss, elf_brk;
>  	int bss_prot = 0;
>  	int retval, i;
> @@ -865,6 +870,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
>  		char *elf_interpreter;
>  
> +		if (interpreter && elf_property_phdata)
> +			break;
> +

This is not okay. This introduces a memory resource leak for malicious
ELF files with multiple INTERP headers.

>  		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
>  			elf_property_phdata = elf_ppnt;
>  			continue;
> @@ -919,7 +927,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		if (retval < 0)
>  			goto out_free_dentry;
>  
> -		break;
> +		continue;

Because of this.

As a fix, I'd expect the PT_INTERP test to be updated:

                if (interpreter || elf_ppnt->p_type != PT_INTERP)
                        continue;


>  
>  out_free_interp:
>  		kfree(elf_interpreter);
> @@ -963,12 +971,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
> @@ -979,10 +986,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
> 2.30.2
> 

-- 
Kees Cook
