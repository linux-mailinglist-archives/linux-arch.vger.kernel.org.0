Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3348316EFC0
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgBYUHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:07:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35080 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgBYUHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:07:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so202304pjc.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+pmf0q/yQobAoH/07ZbYSuskhk1jR7zZpMRJsChqv5g=;
        b=DWyaKOrnA08bBBHiKbZV/oqpfDg5UAsqlM4nMGy5LWYLGlIhGwPIeKPvvUgnp2P33d
         dHeMtxvgTcqqMvW5CAqjji0CUw0/KKZOWJA6mkJaDIrODjVQ0uQh7xr84QPagG9oyfRs
         cCjOIB8MTl0+UKHUtGEaEJutf29gnAQLCtmKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pmf0q/yQobAoH/07ZbYSuskhk1jR7zZpMRJsChqv5g=;
        b=FLVxaXjine96Huvjho3i7DSJiOGMNbZv4Oc6OZuKSGjQ5jAqT7arpMx9uvz1rSMxvL
         Naxf2+20UIYv8h2bYwnuG5oo+EqI+IWwgPt6/dQABpNx5byRmtWJgdoaonDcCF2jhcS7
         9g6S5aaQnGYKuoGkuhYJcA2aQuYvXkrG9k31EOlX0Tpr3Bh5lSixJ7D4/6FynwBeEwUn
         RQBNAGmQE4pc998gKj9a4G0IaSJwGzf/ysrnJTLZG74bGOhuYJAlDgHNWwkQJ5AbmBcG
         VeIrKSFJ6PTmk84KQLS9Sj8zv6hvved4ZzMdhAWoQH6M/rxidlfV+hZz6LkSHeBhMuAg
         G2Sg==
X-Gm-Message-State: APjAAAUJvH9T1bMyMjeR++T6FY5YD6NYjamyxFlIeJx5jxL4wHvgy2oV
        X/nU4j4POmsB9WFmYVOMcpQBRQ==
X-Google-Smtp-Source: APXvYqzV6yOnHzJJS7dWA6X7DLMTlWnLxeeW9VltW3s8J6I8isgdPuY9CDPTyNDsFLw7CDHlyUyHRA==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr218843plq.7.1582661229878;
        Tue, 25 Feb 2020 12:07:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm17972057pfn.2.2020.02.25.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:07:09 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:07:07 -0800
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Message-ID: <202002251206.43C6B6DA@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-6-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:13AM -0800, Yu-cheng Yu wrote:
> Introduce Kconfig option: X86_INTEL_SHADOW_STACK_USER.
> 
> Shadow Stack (SHSTK) provides protection against function return address
> corruption.  It is active when the kernel has this feature enabled, and
> both the processor and the application support it.  When this feature is
> enabled, legacy non-SHSTK applications continue to work, but without SHSTK
> protection.
> 
> The user-mode SHSTK protection is only implemented for the 64-bit kernel.
> IA32 applications are supported under the compatibility mode.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig  | 22 ++++++++++++++++++++++
>  arch/x86/Makefile |  7 +++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..6c34b701c588 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1974,6 +1974,28 @@ config X86_INTEL_TSX_MODE_AUTO
>  	  side channel attacks- equals the tsx=auto command line parameter.
>  endchoice
>  
> +config X86_INTEL_CET
> +	def_bool n
> +
> +config ARCH_HAS_SHSTK
> +	def_bool n
> +
> +config X86_INTEL_SHADOW_STACK_USER
> +	prompt "Intel Shadow Stack for user-mode"
> +	def_bool n
> +	depends on CPU_SUP_INTEL && X86_64
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select X86_INTEL_CET
> +	select ARCH_HAS_SHSTK
> +	---help---
> +	  Shadow Stack (SHSTK) provides protection against program
> +	  stack corruption.  It is active when the kernel has this
> +	  feature enabled, and the processor and the application
> +	  support it.  When this feature is enabled, legacy non-SHSTK
> +	  applications continue to work, but without SHSTK protection.
> +
> +	  If unsure, say y.
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 94df0868804b..c34f5befa4c8 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -149,6 +149,13 @@ ifdef CONFIG_X86_X32
>  endif
>  export CONFIG_X86_X32_ABI
>  
> +# Check assembler Shadow Stack suppot
> +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +  ifeq ($(call as-instr, saveprevssp, y),)

This test needs to happen in the Kconfig rather than the Makefile; the
CONFIG should be unavailable if AS doesn't support the feature.

-Kees

> +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> +  endif
> +endif
> +
>  #
>  # If the function graph tracer is used with mcount instead of fentry,
>  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> -- 
> 2.21.0
> 

-- 
Kees Cook
