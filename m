Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50405F3471
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJCRZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJCRZl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:25:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715D23145
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 10:25:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a23so2519545pgi.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Eh36TVWrbcXNFU55d3swU5YqNSMVT4Ta89oIyEc6Y9o=;
        b=N7a4hDzZn46LbJVuATRGzyfB6RwBF1mOFM0mklRAl7TOVEUSyocBhaLpJnm051gBwo
         fle2M9WiGXJs4C0aMaeXdJVPGYdhaA0bN+SEtbeksodSvWRca7Hc6Jm5fvUYvibggxIm
         F1xjrOQoSSvpcfL5mAvzxnJFDl+JRTHNY+Tvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Eh36TVWrbcXNFU55d3swU5YqNSMVT4Ta89oIyEc6Y9o=;
        b=h4LqvROceL4d0KLxRKuz5G6qBI3HYQhZ5zFsUP7V3ca9mP3HNmivzxGlv6DVrwcF2G
         VkoV3NQXFWq/f6XlIldcb8U1moCqqXSweH7pvwNHe5L4xzAZBZ4qLxRjn5sO6kmlUtiz
         ec+iTsd+PZ1T6s9hMktvwe841/iaOmG5rn//fPGp+u9P2lnaqh+xr4EWan90bK6UKP3D
         XMJXlvRnEflypIdq1T5xv/VU3Ah2uj++/Oe/3A7DnBsDrp9PpBNJEilOB1peq8kgU1b3
         hu2R+5OAWULM89VP3dWIhdBy79D1Zqgy0okE+chhnxmMUPIEn5g/Ps9kcBz25m+dt7kc
         9zcA==
X-Gm-Message-State: ACrzQf3Zy27A2OD7/RBVSNlQ352eve52kIZvFNdJbb69zuH5teDC8hbc
        R11uGqzKtP8Mq7EpU1UZTKjnhQ==
X-Google-Smtp-Source: AMsMyM7i2rD0qIEnUie8bKeDsdhqownDwDDyMyGPDS32Fdy80LrPI3HEbwUHGAjdWNZFLZFsk60kDw==
X-Received: by 2002:a63:2a81:0:b0:43c:5fa6:1546 with SMTP id q123-20020a632a81000000b0043c5fa61546mr19683775pgq.43.1664817930407;
        Mon, 03 Oct 2022 10:25:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0055f1db26b3csm5611281pfc.37.2022.10.03.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:25:29 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:25:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Message-ID: <202210031020.0E93C75F9@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:28:59PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow Stack provides protection against function return address
> corruption. It is active when the processor supports it, the kernel has
> CONFIG_X86_SHADOW_STACK enabled, and the application is built for the
> feature. This is only implemented for the 64-bit kernel. When it is
> enabled, legacy non-Shadow Stack applications continue to work, but without
> protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Remove already wrong kernel size increase info (tlgx)
>  - Change prompt to remove "Intel" (tglx)
>  - Update line about what CPUs are supported (Dave)
> 
> Yu-cheng v25:
>  - Remove X86_CET and use X86_SHADOW_STACK directly.
> 
> Yu-cheng v24:
>  - Update for the splitting X86_CET to X86_SHADOW_STACK and X86_IBT.
> 
>  arch/x86/Kconfig           | 18 ++++++++++++++++++
>  arch/x86/Kconfig.assembler |  5 +++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..b68eb75887b8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_SHADOW_STACK
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select HAVE_ARCH_SOFT_DIRTY
> @@ -1936,6 +1937,23 @@ config X86_SGX
>  
>  	  If unsure, say N.
>  
> +config ARCH_HAS_SHADOW_STACK
> +	def_bool n
> +
> +config X86_SHADOW_STACK
> +	prompt "X86 Shadow Stack"
> +	def_bool n

I hope we can switch this to "default y" soon, given it's a hardware
feature that is disabled at runtime when not available.

> +	depends on ARCH_HAS_SHADOW_STACK

Doesn't this depend on AS_WRUSS too?

> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	help
> +	  Shadow Stack protection is a hardware feature that detects function
> +	  return address corruption. Today the kernel's support is limited to
> +	  virtualizing it in KVM guests.
> +
> +	  CPUs supporting shadow stacks were first released in 2020.
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

Otherwise, I don't see anything else using OCNFIG_AS_WRUSS:

$ git grep AS_WRUSS
arch/x86/Kconfig.assembler:config AS_WRUSS

-Kees

-- 
Kees Cook
