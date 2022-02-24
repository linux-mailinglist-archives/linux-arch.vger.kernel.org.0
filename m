Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0974C2646
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 09:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiBXIbL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 03:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBXIbE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 03:31:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE927DF0B;
        Thu, 24 Feb 2022 00:29:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so1425844pja.1;
        Thu, 24 Feb 2022 00:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jedIA9WEwtNh3KGbShSkittm5VM0EONlJ1A9vm17fT8=;
        b=lsND3RgsKjI5xyyy6shdTuvhvnmDZ9B3/Dh3m0i7wShsj12/jV4Y/JRElBrJPFhjqK
         3n+mwI+y9BN7eENez0m00GTC9rsBB7xksx6i4bRTfo3Fxqk/KntZCQEMekZsBSewXLyR
         JlR9K9NziSTBsYajWlcEYxwddlukxg2S7azUE2LrDJuasZpGuOT+EiYJINvfdAUzfHOG
         tuS/+R2RIcd67V/Ma4xL97pbvS+lvgo1KuPu+v8t6/J8BV2BUp/rSchpcTMa8wK3m5UB
         mUuTWu6rQNlgJTc/kQjyZaIyTDAKKPYjgGUWctSXnF48+KypHZ33yGh5w19EZuHOHycQ
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jedIA9WEwtNh3KGbShSkittm5VM0EONlJ1A9vm17fT8=;
        b=zRmMlsI0B1EqftqK+gIfMvHYDTzRhpItvt1AP/TWhpm4t+PPQhK46EBLwUD4TYdnf9
         j9Gf3b6LB5yVv7Fu6maEWIhLwZlMBC06nK3GVn+bQ5NoRMxec2+D1oIBnNJN3gxrloDb
         mWohcwSJ4zBOt5wGAQ2osskMQe2+xreo8NYwohp386YAlExQL3z4yfNlgWQ+GrNk9UTh
         NxNZdgyq6FA7M99I6CRuIKCExIIRMzbNugLuB1zHs1gWOqS6lNtN4l+O3E6LeieVUFzK
         T5TUd0eNpmAHQ1lldPY8nVTWAhEyUdSslzKJxQJrvOfI1WXLfriBQb9CozL6ie5errxe
         KhbA==
X-Gm-Message-State: AOAM533NaNJdMtoGfibAngm4+qMgspwOHeass3B4xPPfsISqs8LsnX1+
        bmbXgAHPXJ9ssSu5JRBV1Ws=
X-Google-Smtp-Source: ABdhPJzfJYZ3OGlEB7o1IETC2NwE70KCIwlHUyDhzjWmFqwoZ+PAmo3HYXXOEwyWz/POzBiBo3Y6cg==
X-Received: by 2002:a17:90b:3b4d:b0:1bc:a5a7:b389 with SMTP id ot13-20020a17090b3b4d00b001bca5a7b389mr1670354pjb.148.1645691384918;
        Thu, 24 Feb 2022 00:29:44 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090a7d1500b001b968e82819sm5179319pjl.10.2022.02.24.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:29:36 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:29:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, deller@gmx.de,
        mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org,
        davem@davemloft.net, richard@nod.at, x86@kernel.org,
        jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
Message-ID: <YhdB7tNDvtsYLUzr@antec>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 02:13:27PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are many different ways that access_ok() is defined across
> architectures, but in the end, they all just compare against the
> user_addr_max() value or they accept anything.
> 
> Provide one definition that works for most architectures, checking
> against TASK_SIZE_MAX for user processes or skipping the check inside
> of uaccess_kernel() sections.
> 
> For architectures without CONFIG_SET_FS(), this should be the fastest
> check, as it comes down to a single comparison of a pointer against a
> compile-time constant, while the architecture specific versions tend to
> do something more complex for historic reasons or get something wrong.
> 
> Type checking for __user annotations is handled inconsistently across
> architectures, but this is easily simplified as well by using an inline
> function that takes a 'const void __user *' argument. A handful of
> callers need an extra __user annotation for this.
> 
> Some architectures had trick to use 33-bit or 65-bit arithmetic on the
> addresses to calculate the overflow, however this simpler version uses
> fewer registers, which means it can produce better object code in the
> end despite needing a second (statically predicted) branch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64, asm-generic]
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  arch/openrisc/include/asm/uaccess.h   | 19 +--------
...
>  include/asm-generic/access_ok.h       | 59 +++++++++++++++++++++++++++
>  include/asm-generic/uaccess.h         | 21 +---------
>  include/linux/uaccess.h               |  7 ----
>  32 files changed, 109 insertions(+), 366 deletions(-)
> 
...
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index 120f5005461b..8f049ec99b3e 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -45,21 +45,7 @@
>  
>  #define uaccess_kernel()	(get_fs() == KERNEL_DS)
>  
> -/* Ensure that the range from addr to addr+size is all within the process'
> - * address space
> - */
> -static inline int __range_ok(unsigned long addr, unsigned long size)
> -{
> -	const mm_segment_t fs = get_fs();
> -
> -	return size <= fs && addr <= (fs - size);
> -}
> -
> -#define access_ok(addr, size)						\
> -({ 									\
> -	__chk_user_ptr(addr);						\
> -	__range_ok((unsigned long)(addr), (size));			\
> -})
> +#include <asm-generic/access_ok.h>

I was going to ask why we are missing __chk_user_ptr in the generic version.
But this is basically now a no-op so I think its OK.

>  /*
>   * These are the main single-value transfer routines.  They automatically
> @@ -268,9 +254,6 @@ clear_user(void __user *addr, unsigned long size)
>  	return size;
>  }
>  
> -#define user_addr_max() \
> -	(uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>  
>  extern __must_check long strnlen_user(const char __user *str, long n);

...
> diff --git a/include/asm-generic/access_ok.h b/include/asm-generic/access_ok.h
> new file mode 100644
> index 000000000000..1aad8964d2ed
> --- /dev/null
> +++ b/include/asm-generic/access_ok.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_ACCESS_OK_H__
> +#define __ASM_GENERIC_ACCESS_OK_H__
> +
> +/*
> + * Checking whether a pointer is valid for user space access.
> + * These definitions work on most architectures, but overrides can
> + * be used where necessary.
> + */
> +
> +/*
> + * architectures with compat tasks have a variable TASK_SIZE and should
> + * override this to a constant.
> + */
> +#ifndef TASK_SIZE_MAX
> +#define TASK_SIZE_MAX			TASK_SIZE
> +#endif
> +
> +#ifndef uaccess_kernel
> +#ifdef CONFIG_SET_FS
> +#define uaccess_kernel()		(get_fs().seg == KERNEL_DS.seg)
> +#else
> +#define uaccess_kernel()		(0)
> +#endif
> +#endif
> +
> +#ifndef user_addr_max
> +#define user_addr_max()			(uaccess_kernel() ? ~0UL : TASK_SIZE_MAX)
> +#endif
> +
> +#ifndef __access_ok
> +/*
> + * 'size' is a compile-time constant for most callers, so optimize for
> + * this case to turn the check into a single comparison against a constant
> + * limit and catch all possible overflows.
> + * On architectures with separate user address space (m68k, s390, parisc,
> + * sparc64) or those without an MMU, this should always return true.
> + *
> + * This version was originally contributed by Jonas Bonn for the
> + * OpenRISC architecture, and was found to be the most efficient
> + * for constant 'size' and 'limit' values.
> + */
> +static inline int __access_ok(const void __user *ptr, unsigned long size)
> +{
> +	unsigned long limit = user_addr_max();
> +	unsigned long addr = (unsigned long)ptr;
> +
> +	if (IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE))
> +		return true;
> +
> +	return (size <= limit) && (addr <= (limit - size));
> +}
> +#endif
> +
> +#ifndef access_ok
> +#define access_ok(addr, size) likely(__access_ok(addr, size))
> +#endif
> +
> +#endif
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 0870fa11a7c5..ebc685dc8d74 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -114,28 +114,9 @@ static inline void set_fs(mm_segment_t fs)
>  }
>  #endif
>  
> -#ifndef uaccess_kernel
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -#endif
> -
> -#ifndef user_addr_max
> -#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
> -#endif
> -
>  #endif /* CONFIG_SET_FS */
>  
> -#define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
> -
> -/*
> - * The architecture should really override this if possible, at least
> - * doing a check on the get_fs()
> - */
> -#ifndef __access_ok
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	return 1;
> -}
> -#endif
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67e9bc94dc40..2c31667e62e0 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -33,13 +33,6 @@ typedef struct {
>  	/* empty dummy */
>  } mm_segment_t;
>  
> -#ifndef TASK_SIZE_MAX
> -#define TASK_SIZE_MAX			TASK_SIZE
> -#endif
> -
> -#define uaccess_kernel()		(false)
> -#define user_addr_max()			(TASK_SIZE_MAX)
> -
>  static inline mm_segment_t force_uaccess_begin(void)
>  {
>  	return (mm_segment_t) { };


Acked-by: Stafford Horne <shorne@gmail.com> [openrisc, asm-generic]

Thanks!
