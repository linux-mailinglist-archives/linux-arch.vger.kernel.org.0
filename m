Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A62706FA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRUY5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRUY5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:24:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF7C0613CE;
        Fri, 18 Sep 2020 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=yAMhSupJBbZkPaKwYOyhZeq16yiQVbhqGBu9I9QwZJ8=; b=RQptF1yKQdaMfvH2IgafRgkWxV
        mb4GAZQaANOjCgO0bQShHHOeqS2Fcp47TLzLJDI7JZziWojmB1dMU84PNmdHFX1i32Gzma+r59q3u
        GMwDCEfkbwLX9j/GqqUmQGvVQeEDoFXotxbPGssyVoNds3EbNvzI9g1X7+bPPyGT6enQhQZMr+C3F
        pt6pAhDnei4+UsHrvmwbIz77O0NrQp9r+A7ma4dnzItBuSqCjJrl+U2ojV0opWzF1X+dzvOk87QG3
        UTXBWdFVyKRX+mCkCmNvb96C24bp866cQi972lyvXFgg4J0TsaCmL5ee5aYdFV/ivgsIGiYfQFz2H
        9i++2+3g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJMve-0005x8-EQ; Fri, 18 Sep 2020 20:24:22 +0000
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
Date:   Fri, 18 Sep 2020 13:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918192312.25978-2-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

If you do another version of this:

On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.
> 
> Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> oriented programming attacks.  It is active when the kernel has this
> feature enabled, and the processor and the application support it.
> When this feature is enabled, legacy non-IBT applications continue to
> work, but without IBT protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
> v10:
> - Change build-time CET check to config depends on.
> 
>  arch/x86/Kconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6b6dad011763..b047e0a8d1c2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
>  
>  	  If unsure, say y.
>  
> +config X86_INTEL_BRANCH_TRACKING_USER
> +	prompt "Intel Indirect Branch Tracking for user-mode"
> +	def_bool n
> +	depends on CPU_SUP_INTEL && X86_64
> +	depends on $(cc-option,-fcf-protection)
> +	select X86_INTEL_CET
> +	help
> +	  Indirect Branch Tracking (IBT) provides protection against
> +	  CALL-/JMP-oriented programming attacks.  It is active when
> +	  the kernel has this feature enabled, and the processor and
> +	  the application support it.  When this feature is enabled,
> +	  legacy non-IBT applications continue to work, but without
> +	  IBT protection.
> +
> +	  If unsure, say y

	  If unsure, say y.

> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> 


-- 
~Randy

