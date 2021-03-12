Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2833986A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 21:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhCLU2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 15:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhCLU2n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 15:28:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8FA564F43;
        Fri, 12 Mar 2021 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615580923;
        bh=GH0ez+6thAFHA0R/g6PB84gv2i0cqvUAgDElmnsXr8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VGaCV2AXrylOg6TdRiZrMPJOv7ON0cVJ59Gm/JCIHVTjgpVpTXKgz19cVR/N9d/2R
         cl8ZNHLB7lA+97wDIrdUBRH+gftY/6UzlNfMGAyOC6BpTsXGtUAu1R+U90pCvEG3Vw
         GvHnMVdIM9yzHj2XprFdXcYVlSCjbOvkGxNZSh7aMdxyS3TJrkPsPX+YQSLkOxk9cF
         BWJRoAwI38Kq7gXjQHHwTTqKRz9l/F5fsktD6Um9w6f2FjlvZgqxJtXzBXMx9bBFJM
         RNj5qICdALYiFE+JjspVs9n36AooGGZHEw7x216w0g65NhdOzwtSYiqO/sGbbaer2q
         SpgY62ZqJZ5Hw==
Date:   Fri, 12 Mar 2021 14:28:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] cfi: add __cficanonical
Message-ID: <20210312202841.GA2286570@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:04PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces a function address taken
> in C code with the address of a local jump table entry, which passes
> runtime indirect call checks. However, the compiler won't replace
> addresses taken in assembly code, which will result in a CFI failure
> if we later jump to such an address in instrumented C code. The code
> generated for the non-canonical jump table looks this:
> 
>   <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
> 	jmp noncanonical
>   ...
>   <noncanonical>:        /* function body */
> 	...
> 
> This change adds the __cficanonical attribute, which tells the
> compiler to use a canonical jump table for the function instead. This
> means the compiler will rename the actual function to <function>.cfi
> and points the original symbol to the jump table entry instead:
> 
>   <canonical>:           /* jump table entry */
> 	jmp canonical.cfi
>   ...
>   <canonical.cfi>:       /* function body */
> 	...
> 
> As a result, the address taken in assembly, or other non-instrumented
> code always points to the jump table and therefore, can be used for
> indirect calls in instrumented code without tripping CFI checks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

If you need it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci.h

> ---
>  include/linux/compiler-clang.h | 1 +
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 4 ++--
>  include/linux/pci.h            | 4 ++--
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 1ff22bdad992..c275f23ce023 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -57,3 +57,4 @@
>  #endif
>  
>  #define __nocfi		__attribute__((__no_sanitize__("cfi")))
> +#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 796935a37e37..d29bda7f6ebd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -246,6 +246,10 @@ struct ftrace_likely_data {
>  # define __nocfi
>  #endif
>  
> +#ifndef __cficanonical
> +# define __cficanonical
> +#endif
> +
>  #ifndef asm_volatile_goto
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index b3ea15348fbd..045ad1650ed1 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -220,8 +220,8 @@ extern bool initcall_debug;
>  	__initcall_name(initstub, __iid, id)
>  
>  #define __define_initcall_stub(__stub, fn)			\
> -	int __init __stub(void);				\
> -	int __init __stub(void)					\
> +	int __init __cficanonical __stub(void);			\
> +	int __init __cficanonical __stub(void)			\
>  	{ 							\
>  		return fn();					\
>  	}							\
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..39684b72db91 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
>  #ifdef CONFIG_LTO_CLANG
>  #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
>  				  class_shift, hook, stub)		\
> -	void stub(struct pci_dev *dev);					\
> -	void stub(struct pci_dev *dev)					\
> +	void __cficanonical stub(struct pci_dev *dev);			\
> +	void __cficanonical stub(struct pci_dev *dev)			\
>  	{ 								\
>  		hook(dev); 						\
>  	}								\
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
