Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0722FD540
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbhATQQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 11:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391449AbhATQP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jan 2021 11:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611159270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lad1uHPnItt2h30i45RNcf50RD7bS69aVQ4eDKRX1L0=;
        b=DKK0LcTUuG0oTpouMCMj76Mmj7/nYlKdalEwmnbze5I/p0mR1qZwWi5NT6PmbQseRIopFx
        IA88Rs7+VaXlwMTICHbOOscrFkQNiQNDk5K+5g2en+bu/X3th7SLz5rO2QLuE2VBW+mh0M
        GkxEBXjTksZXaubDqMcgnAav9JjrRto=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-lABKtAL1N3uApPEFHp1New-1; Wed, 20 Jan 2021 11:14:28 -0500
X-MC-Unique: lABKtAL1N3uApPEFHp1New-1
Received: by mail-qv1-f70.google.com with SMTP id x19so23548776qvv.16
        for <linux-arch@vger.kernel.org>; Wed, 20 Jan 2021 08:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Lad1uHPnItt2h30i45RNcf50RD7bS69aVQ4eDKRX1L0=;
        b=DKhUPG35ZAobRuPAlURXBJZjT+B8770y546YlixVOLhC4CCnmhCil/D+BP5S0erLvy
         Nt/o+VPccIvbQI/tlp5tHLeKWveky+uCh/7iK0s+h/TkTF9M6qqr7sWnAnrDalW+duqw
         6GxJtVZ1/D3EpnQsnS8j1e3juDiKkqvZRZjr9eL0WTBdSU7m586y4svl+s/Y/Obir0l/
         TuexqtLH06CBxctY3IlpFLDSfp8D0kNAamv4cZipLmsvunzf8vylDO6f2ODQ9TCoI7n0
         1TB7ccHPxy/tog6k2vjeRuq7kozEpxnjdXbZIP3HbMZB7FtxLVDDQpNFu07f6edf2bUe
         Nvbw==
X-Gm-Message-State: AOAM532u5joGdM/Tagh6xDxbgfXhDs88wHGzIr+hQ9mWABkrMVOZDHbH
        EFKJzwuVhT0+IQYUhdodoF4S3mo1i8gTIlQTlRwV/Aow+rGEr4yJ562qWCq8iInByGF4bPHBvwY
        aQyU0FHs49nI6sEatQ3mrzQ==
X-Received: by 2002:a05:620a:16d5:: with SMTP id a21mr10366403qkn.188.1611159268329;
        Wed, 20 Jan 2021 08:14:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa1sWajSI1FTyvSZwFHP82ogRLpD8pcZQV6w7EVxGoRn+kZbogXRcXHCwbvc+otqYOVRd6Zg==
X-Received: by 2002:a05:620a:16d5:: with SMTP id a21mr10366381qkn.188.1611159268128;
        Wed, 20 Jan 2021 08:14:28 -0800 (PST)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id h1sm1436705qtr.1.2021.01.20.08.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:14:27 -0800 (PST)
Subject: Re: [PATCH v4 2/4] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     linux-arch@vger.kernel.org, len.brown@intel.com,
        tony.luck@intel.com, libc-alpha@sourceware.org,
        ravi.v.shankar@intel.com, jannh@google.com,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        dave.hansen@intel.com, linux-api@vger.kernel.org,
        Dave.Martin@arm.com
References: <20210115211038.2072-1-chang.seok.bae@intel.com>
 <20210115211038.2072-3-chang.seok.bae@intel.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <46031a4a-3e4e-3a1d-1188-ed9af2cf95d1@redhat.com>
Date:   Wed, 20 Jan 2021 11:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115211038.2072-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/15/21 4:10 PM, Chang S. Bae via Libc-alpha wrote:
> Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
> use by all architectures with sigaltstack(2). Over time, the hardware state
> size grew, but these constants did not evolve. Today, literal use of these
> constants on several architectures may result in signal stack overflow, and
> thus user data corruption.
> 
> A few years ago, the ARM team addressed this issue by establishing
> getauxval(AT_MINSIGSTKSZ), such that the kernel can supply at runtime value
> that is an appropriate replacement on the current and future hardware.
> 
> Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
> added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
> size to userspace via auxv").

The value of AT_MINSIGSTKSZ has been generic ABI for all architectures since
2018 when it was added to glibc's generic elf.h because of arm64.

Rather than define this just for x86 may we please put this into the generic
headers, since it has been there since 2018?

Any userspace code that might be inspecting for AT_MINSIGSTKSZ is going to
expect a value of 51.

No other architecture has a define for value 51. This way we avoid any accidents
with the value being different for architectures.
 
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch")
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: H.J. Lu <hjl.tools@gmail.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: x86@kernel.org
> Cc: libc-alpha@sourceware.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
> ---
>  arch/x86/include/asm/elf.h         | 4 ++++
>  arch/x86/include/uapi/asm/auxvec.h | 6 ++++--
>  arch/x86/kernel/signal.c           | 5 +++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index b9a5d488f1a5..044b024abea1 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -311,6 +311,7 @@ do {									\
>  		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
>  		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
>  	}								\
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
>  } while (0)
>  
>  /*
> @@ -327,6 +328,7 @@ extern unsigned long task_size_32bit(void);
>  extern unsigned long task_size_64bit(int full_addr_space);
>  extern unsigned long get_mmap_base(int is_legacy);
>  extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
> +extern unsigned long get_sigframe_size(void);
>  
>  #ifdef CONFIG_X86_32
>  
> @@ -348,6 +350,7 @@ do {									\
>  	if (vdso64_enabled)						\
>  		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
>  			    (unsigned long __force)current->mm->context.vdso); \
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
>  } while (0)
>  
>  /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
> @@ -356,6 +359,7 @@ do {									\
>  	if (vdso64_enabled)						\
>  		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
>  			    (unsigned long __force)current->mm->context.vdso); \
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
>  } while (0)
>  
>  #define AT_SYSINFO		32
> diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
> index 580e3c567046..edd7808060e6 100644
> --- a/arch/x86/include/uapi/asm/auxvec.h
> +++ b/arch/x86/include/uapi/asm/auxvec.h
> @@ -10,11 +10,13 @@
>  #endif
>  #define AT_SYSINFO_EHDR		33
>  
> +#define AT_MINSIGSTKSZ		51

This definition should go into the generic auxvec.h.

We could also remove the arm64 define, but that is orthogonal arch cleanup.

> +
>  /* entries in ARCH_DLINFO: */
>  #if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
> -# define AT_VECTOR_SIZE_ARCH 2
> +# define AT_VECTOR_SIZE_ARCH 3
>  #else /* else it's non-compat x86-64 */
> -# define AT_VECTOR_SIZE_ARCH 1
> +# define AT_VECTOR_SIZE_ARCH 2
>  #endif
>  
>  #endif /* _ASM_X86_AUXVEC_H */
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 138a9f5b78d8..761d856f8ef7 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -716,6 +716,11 @@ void __init init_sigframe_size(void)
>  	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
>  }
>  
> +unsigned long get_sigframe_size(void)
> +{
> +	return max_frame_size;
> +}
> +
>  static inline int is_ia32_compat_frame(struct ksignal *ksig)
>  {
>  	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
> 


-- 
Cheers,
Carlos.

