Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548738950D
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhESSLl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 14:11:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhESSLi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 14:11:38 -0400
Received: from zn.tnic (p200300ec2f0c020044d5f4cdafdb3fab.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:200:44d5:f4cd:afdb:3fab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BE581EC04DE;
        Wed, 19 May 2021 20:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621447816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kmnk3HRb3cmXxIvZwaL4Yb+pBm6cxLnt2meHDxXrqsM=;
        b=TwMVUgsb6IXeVBZzA6d5aIhwEuci3CpWN6/cdOkZQyGtLUAzYw4RKdPvGNXcuIU6QknbQE
        blXQ5U8G76V6aHPP8i0Lk7VoyusBNhIFKA7FWrMplro0XkfH2rUpKn1fzY2R/5xB7GG1gy
        yLMfKTZuUJSPwmUwo+E1+IYdMLiMf/4=
Date:   Wed, 19 May 2021 20:10:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
Message-ID: <YKVUgzJ0MVNBgjDd@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-27-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:11PM -0700, Yu-cheng Yu wrote:
> @@ -1951,6 +1951,8 @@ config X86_SHADOW_STACK
>  	depends on AS_WRUSS
>  	depends on ARCH_HAS_SHADOW_STACK
>  	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_USE_GNU_PROPERTY
> +	select ARCH_BINFMT_ELF_STATE
		^^^^^^^^

What's that for? Isn't ARCH_USE_GNU_PROPERTY enough?

> +int arch_setup_elf_property(struct arch_elf_state *state)
> +{
> +	int r = 0;
> +
> +	if (!IS_ENABLED(CONFIG_X86_SHADOW_STACK))
> +		return r;
> +
> +	memset(&current->thread.cet, 0, sizeof(struct cet_status));
> +
> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {

	cpu_feature_enabled

> +		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			r = shstk_setup();
> +	}
> +
> +	return r;
> +}
> +#endif

...

> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 30f68b42eeb5..24ba55ba8278 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -455,4 +455,13 @@ typedef struct elf64_note {
>  /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>  #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
>  
> +/* .note.gnu.property types for x86: */
> +#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002

Why not 0xc0000001? ARM64 is 0xc0000000...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
