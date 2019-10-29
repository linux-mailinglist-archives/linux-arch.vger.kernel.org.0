Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75343E934C
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 00:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfJ2XIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 19:08:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46941 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ2XH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 19:07:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id f19so108598pgn.13
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EK/iR04QppfFL6hJjq1Qp4tKuC0yyvj8XT1kmd57Vc8=;
        b=dtLNUoC1eHJFg8kN8Jl92Mm/KMo4Rv2P/Ke5YttA0vm9EMCZXYT1ihVW7e044UMAr3
         8dejWZTNu6tNpmE10toXS+HsMsUY8loN8/tZsFYReKVrgSDC4FCwihhKTmwwbvMDYxB7
         eH9kvuBXcG/bcdeVX7kFXgcslFNyRSVP5CdWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EK/iR04QppfFL6hJjq1Qp4tKuC0yyvj8XT1kmd57Vc8=;
        b=dh4HlrfDO7L5um7yxbdjKAwwcYFXxLQsla8PQ9+yiZJghVWoH+QgztiM0g3HQ+CVZf
         Guk7oX7XXVDF51FD16pZTN8alYfpRhu6L8rvvGuFcVpepO3uehZSOmT2cgAFNSWSQaua
         KyAbtak556KbilDWZJY/HApfJznTI3nFSVJOwzkWLNCpu2ght2L3d2SQxzomo6WxbAKL
         oNp9sm9BneK617eU2v74eYwKMz53JBeThk/dqoTWHNHMq5Eja5/i0giR+HDl8ajlxPH7
         K6gD8KOcDQaj04Vhkne3ASIgd7zlwM3Z8TL+KMesWeviSg4KX18x+FlLUmTHjKcJwVLq
         yg7w==
X-Gm-Message-State: APjAAAVIC99vVhOqu1h0bPchaFoH3IRP4ipRjXZitnvDHRK/eeQb6UO8
        8nM5y261dDIv5NMPqpCVMvmbjA==
X-Google-Smtp-Source: APXvYqxlpD8afJVfeJRJZqXRk4DC19b4p18OjNSVX2/RdrFGCqjrqXaMMfLfYxGsFkhlHHEsGanvkA==
X-Received: by 2002:a63:8f5e:: with SMTP id r30mr21918430pgn.146.1572390479068;
        Tue, 29 Oct 2019 16:07:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17sm175911pfh.121.2019.10.29.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:07:58 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:07:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/12] ELF: UAPI and Kconfig additions for ELF program
 properties
Message-ID: <201910291607.F5DA2EE@keescook>
References: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
 <1571419545-20401-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571419545-20401-2-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 06:25:34PM +0100, Dave Martin wrote:
> Pull the basic ELF definitions relating to the
> NT_GNU_PROPERTY_TYPE_0 note from Yu-Cheng Yu's earlier x86 shstk
> series.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  fs/Kconfig.binfmt        | 3 +++
>  include/linux/elf.h      | 8 ++++++++
>  include/uapi/linux/elf.h | 1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 62dc4f5..d2cfe07 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
>  config ARCH_BINFMT_ELF_STATE
>  	bool
>  
> +config ARCH_USE_GNU_PROPERTY
> +	bool
> +
>  config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y if !BINFMT_ELF
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index e3649b3..459cddc 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_ELF_H
>  #define _LINUX_ELF_H
>  
> +#include <linux/types.h>
>  #include <asm/elf.h>
>  #include <uapi/linux/elf.h>
>  
> @@ -56,4 +57,11 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
>  extern int elf_coredump_extra_notes_size(void);
>  extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
>  #endif
> +
> +/* NT_GNU_PROPERTY_TYPE_0 header */
> +struct gnu_property {
> +	u32 pr_type;
> +	u32 pr_datasz;
> +};
> +
>  #endif /* _LINUX_ELF_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 34c02e4..c377314 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
>  #define PT_LOPROC  0x70000000
>  #define PT_HIPROC  0x7fffffff
>  #define PT_GNU_EH_FRAME		0x6474e550
> +#define PT_GNU_PROPERTY		0x6474e553
>  
>  #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
>  
> -- 
> 2.1.4
> 

-- 
Kees Cook
