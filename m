Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5B31703B
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhBJTe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhBJTeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 14:34:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619CC0613D6
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:33:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x136so1951367pfc.2
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5bTpxzmhyqMaSkCM7ds9uXFXoaDcIa78EBDnlUPl2tM=;
        b=VWbs0iMTi2vxgqSwLGR1NXJdtgPJJ6t4i0fxXfJCU5WzFFtliBM/eTDIg5VfwrHuVh
         oH1P/5nO3zxEOnMd9vQFOtU3haSm17GRulcWBQzjEjFXR4fgrpUzh5+QedWYnWjBhM3t
         iJxFNTw5/lOdvOHNgy3tzs1MED1SyuOioaqak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5bTpxzmhyqMaSkCM7ds9uXFXoaDcIa78EBDnlUPl2tM=;
        b=L05HYf/2jNHeYRP0SJf8CsN7sVi1Y+ISUC/njG9lrKdZb/d6zjh+TFh7fJxCCCwEml
         BhcOBOMcqIfG21Mebz5OO3XmcnOyZfR5ecWpNRzzyAAzzlcr+5uIe3zsiQkiIxk/PeCK
         J5NIaxJAXRCOerCyl0bqA2S6HPxPufuhlq2/eMM4fAgh4wtfyazDvfmoU7rniDhpJ2zF
         UnH4aoIXTRx1Xa8OdIOQA+/a5+Z6Ci0K4yKvc3yLMWtP/9z41IQaOcoMcN8r7uiaoSIr
         nn4C0nwrUekn3HJzqr/+lySYMQs+unSo9RWQBnmeWLUFjb+L3oBMp5QfM4siUy+xBVCD
         vcqQ==
X-Gm-Message-State: AOAM5303u1TcQcLRlK7KeSOXBGT4MHaqGoCZg2byUcxvT5M18lEX844x
        NkgahlmQ/LxGv0mF/PwvdjGlng==
X-Google-Smtp-Source: ABdhPJyb9Yi+7DfO6DoJ8QQltqWHPhVAwYYQxHwDF6BnEPn/Zzx5qk5FkuYTK7JIoitwMok0JH75Tw==
X-Received: by 2002:a63:5459:: with SMTP id e25mr4520747pgm.403.1612985612828;
        Wed, 10 Feb 2021 11:33:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o185sm2139133pfb.196.2021.02.10.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:33:32 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:33:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
Subject: Re: [PATCH v20 02/25] x86/cet/shstk: Add Kconfig option for
 user-mode control-flow protection
Message-ID: <202102101133.3C94A64@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-3-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:40AM -0800, Yu-cheng Yu wrote:
> Shadow Stack provides protection against function return address
> corruption.  It is active when the processor supports it, the kernel has
> CONFIG_X86_CET enabled, and the application is built for the feature.
> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
> non-Shadow Stack applications continue to work, but without protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig           | 23 +++++++++++++++++++++++
>  arch/x86/Kconfig.assembler |  5 +++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..1138b5fa9b4f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -28,6 +28,7 @@ config X86_64
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_HAS_SHADOW_STACK
>  	select HAVE_ARCH_SOFT_DIRTY
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE
> @@ -1951,6 +1952,28 @@ config X86_SGX
>  
>  	  If unsure, say N.
>  
> +config ARCH_HAS_SHADOW_STACK
> +	def_bool n
> +
> +config X86_CET
> +	prompt "Intel Control-flow protection for user-mode"
> +	def_bool n
> +	depends on X86_64

This depends isn't needed any more. With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

> +	depends on AS_WRUSS
> +	depends on ARCH_HAS_SHADOW_STACK
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	help
> +	  Control-flow protection is a set of hardware features which place
> +	  additional restrictions on indirect branches.  These help
> +	  mitigate ROP attacks.  Applications must be enabled to use it,
> +	  and old userspace does not get protection "for free".
> +	  Support for this feature is present on Tiger Lake family of
> +	  processors released in 2020 or later.  Enabling this feature
> +	  increases kernel text size by 3.7 KB.
> +	  See Documentation/x86/intel_cet.rst for more information.
> +
> +	  If unsure, say N.
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> index 26b8c08e2fc4..00c79dd93651 100644
> --- a/arch/x86/Kconfig.assembler
> +++ b/arch/x86/Kconfig.assembler
> @@ -19,3 +19,8 @@ config AS_TPAUSE
>  	def_bool $(as-instr,tpause %ecx)
>  	help
>  	  Supported by binutils >= 2.31.1 and LLVM integrated assembler >= V7
> +
> +config AS_WRUSS
> +	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
> +	help
> +	  Supported by binutils >= 2.31 and LLVM integrated assembler
> -- 
> 2.21.0
> 

-- 
Kees Cook
