Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7975F3161
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJCNkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJCNkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 09:40:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520202936D;
        Mon,  3 Oct 2022 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664804417; x=1696340417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5qCpWO+BAGW3ExOyW3chioNW0LHy3lT3j4pg7MiQnQ=;
  b=OOOksX1axHfX1SVR+j4lORPLuVLsK7iwzxqWdv6ApHo38UIGUD5DsgI6
   DS2UKQPzmtIpOjKtBynm0y8ig/SQbmU7Voq4AYonpgFjt4o5A4RWs5vgw
   L20DqmmJTRMDC69VHNVL1L6pp0eJUcPEqJUD7grm0rc7fKw66j/lhfBew
   srJqETT1T9DSAIkxJg7jpDzfzvuPpRoTDvYGg1G5eH7xnwygVFNP+bXnB
   LPFi11WXwovj+EFuXoG9m466JpNm5HC44ySawY09MNBqcqHgCbNksPoCS
   u6vUxznHfEnbBGEESA+gwkhNmRlcKyyVFvkibI/JkpMmX7J2DoEzkYkyj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283003462"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="283003462"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 06:40:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="952343480"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="952343480"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 06:40:08 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7FA5C104CE4; Mon,  3 Oct 2022 16:40:06 +0300 (+03)
Date:   Mon, 3 Oct 2022 16:40:06 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Message-ID: <20221003134006.yoye7dvywuec6bco@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Hm. Shouldn't ARCH_HAS_SHADOW_STACK definition be in arch/Kconfig, not
under arch/x86?

Also, I think "def_bool n" has the same meaning as just "bool", no?

> +
> +config X86_SHADOW_STACK
> +	prompt "X86 Shadow Stack"
> +	def_bool n

Maybe just

	bool "X86 Shadow Stack"

?

> +	depends on ARCH_HAS_SHADOW_STACK
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
> -- 
> 2.17.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
