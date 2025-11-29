Return-Path: <linux-arch+bounces-15107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5473C948AF
	for <lists+linux-arch@lfdr.de>; Sun, 30 Nov 2025 00:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8CDA346264
	for <lists+linux-arch@lfdr.de>; Sat, 29 Nov 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04E226165;
	Sat, 29 Nov 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7ayhB0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48072623
	for <linux-arch@vger.kernel.org>; Sat, 29 Nov 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764457248; cv=none; b=bMyyHWsg1GDPR79EJ0NnhESlX7ruGGvE1jgJ0+wvQg2mdmciLcnxHu0QkXP8Ly7Vxi1ZkUmx8oGJNNb6qYSA40Ce79x23YAdaIfz9+JntGvk8YpOJKnOIqpRt0z5dZo785/kcH+mTAHGx15MfimVjwVyOxYdY41oUKvwBsOQqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764457248; c=relaxed/simple;
	bh=ahbrlVHUyjKynsmUn0eg1wukhIGIxV/YCSxXPxWxPkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQ7klfFrUCRcOZeZW+60SrVAemA4socw+XyglLNq2Shg1PPjUb5oWT1ru2DNXWeiFhO4Bo+Rxx9xsDBP5GDgw6uFZKumuyW83MrEVZC9JLJR5JU/DF3WnsLE8YEDhrGLcv7SNIwYkbTT5TwJsbfykJilnkfkEcGEi9/DFuHhXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7ayhB0a; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so4692511a12.2
        for <linux-arch@vger.kernel.org>; Sat, 29 Nov 2025 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764457245; x=1765062045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7abD6XH4eHcxEiWpbo/4uwSFXjdFhqX7mjZwLL/Fl0=;
        b=a7ayhB0a8mVesvDqyRPRfbj1qe5w2GyPPN0KTnT0F08k6+kCSI2gBADzePtfn/h//m
         EbiyixkVPtyiLEjuxSW2SrgTzw1DsjZbsU9Kff0xrpWmR06aaslxioPuT7Gqn9mqgSVE
         mzE2+ZQCFFUh4/vORTyqyTJ4SpwAG66swkMrIHXbo1U9lCx5oSkvw+7HPscncaVevLvz
         DNFi6eXZmzLa+2wGh63XhZNuSvGvfg6Ma3eg9uTKZtmZLIloEfUiAYy3Hx3a/stjxfl7
         VPTYzWDYkFPqKS7iOZm8mV4u9bsxfK/5cq0/LTDdBhDtICz32Ek6NlTMzpCq4qCefmQt
         shzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764457245; x=1765062045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7abD6XH4eHcxEiWpbo/4uwSFXjdFhqX7mjZwLL/Fl0=;
        b=sWupaqPaBrt9RGYh4kmcM1xKTORQp237HT2CuLO75A0teM0d1ek1H27JeqmSb6GTgg
         JpCar7feRy/CUbcxrvRH3sUlrkuJo1SLMdkPo+KhK3fxVrRdE1/3nGJP1wGrvTsNLOcs
         Fn2UEuLF7b3qvK052/dGO6aDsgvCXVkRJeU2D61AssmbcnTLt7R37RNIYxl8UvnTJ3jj
         XJs7Pg3uzVl9SgPz7rKKOrSiDi3OZbZp3eE079btUke2YSoDd9dy+2f5LECgS8808T3T
         +hgQmJhaU8eOA3aK2X5aey0U/gXkyngosssrKGNHvQdwCxeXFWMwGWVgA87PIrhCiq7U
         mdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh3/eYZt2kJtc3NkjuJwIRbuGyddHZTzhtBb3cp8o/spOeAya93DRKfPGuhgw3gDI+EdwaLntoSBHl@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHYMhNufh21XT52/LoG8v5JhDR7QRgQSGIFNxtMmzhKywMvxA
	aHGV+w0BbeFI7CZWR/b8mH6tfpXFJ4x8eLw/PqMTpVPXqljA9ztT8ZfthhX0dp14oAMfDhRUM5H
	S98Bvvj+KIksHyQ9VsaZHMMpH7GPnPjA=
X-Gm-Gg: ASbGncuZygHQaHrLtuvcihlfT0Nd1wfDGwXn4KgkTJtn7uSy3BvQ0WXFy0rrGcwBGhJ
	uyvlh8enK1yGkA9lG1hzrKWpfz7a8YdloNm4B2CMYBgx803wzM1Y7a85PAhzh8GaEXN5AY4Cn1T
	1Ci2oPptHEJCldm8Uk/SaVmMC+OElnmZZhDFwh8apFUH0NhoqGqH1wIubf7H46lYPZksLwQEA3c
	niYUyMN69Fuw+CzYmmWrl3B2E3+VUJxh8orwHFmM6FzWEMvWqN9qhcwTzXDwPTetbb5vHaG
X-Google-Smtp-Source: AGHT+IFraZxIxArC6ZRLXa5g7OneQiuIwggV1ggNXIteOyfynnk9uYcAtUhHJonNAod2bu5yo5u0XI1eptsrAOVctRM=
X-Received: by 2002:a05:6402:50d2:b0:633:d0b7:d6d2 with SMTP id
 4fb4d7f45d1cf-645eb2a9007mr18043484a12.18.1764457245181; Sat, 29 Nov 2025
 15:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121100044.282684-1-thuth@redhat.com> <20251121100044.282684-2-thuth@redhat.com>
In-Reply-To: <20251121100044.282684-2-thuth@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 30 Nov 2025 00:00:33 +0100
X-Gm-Features: AWmQ_bkDTkRArCOJtRA_LXcLs7nIqPHlR48Siu-A5cxKCr76Y6aVmGcQU7u8Tko
Message-ID: <CA+=Fv5SPuYyZ2ASzz3oVMCRQNP-G+0pbW58o32ryXrm_RBfqSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] alpha: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 the alpha headers
To: Thomas Huth <thuth@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:10=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> From: Thomas Huth <thuth@redhat.com>
>
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize now
> on the __ASSEMBLER__ macro that is provided by the compilers.
>
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/alpha/include/asm/console.h     | 4 ++--
>  arch/alpha/include/asm/page.h        | 4 ++--
>  arch/alpha/include/asm/pal.h         | 4 ++--
>  arch/alpha/include/asm/thread_info.h | 8 ++++----
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/alpha/include/asm/console.h b/arch/alpha/include/asm/co=
nsole.h
> index 088b7b9eb15ae..1cabdb6064bbe 100644
> --- a/arch/alpha/include/asm/console.h
> +++ b/arch/alpha/include/asm/console.h
> @@ -4,7 +4,7 @@
>
>  #include <uapi/asm/console.h>
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern long callback_puts(long unit, const char *s, long length);
>  extern long callback_getc(long unit);
>  extern long callback_open_console(void);
> @@ -26,5 +26,5 @@ struct crb_struct;
>  struct hwrpb_struct;
>  extern int callback_init_done;
>  extern void * callback_init(void *);
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __AXP_CONSOLE_H */
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.=
h
> index 5ec4c77e432e0..d2c6667d73e9e 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -6,7 +6,7 @@
>  #include <asm/pal.h>
>  #include <vdso/page.h>
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>
>  #define STRICT_MM_TYPECHECKS
>
> @@ -74,7 +74,7 @@ typedef struct page *pgtable_t;
>  #define PAGE_OFFSET            0xfffffc0000000000
>  #endif
>
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>
>  #define __pa(x)                        ((unsigned long) (x) - PAGE_OFFSE=
T)
>  #define __va(x)                        ((void *)((unsigned long) (x) + P=
AGE_OFFSET))
> diff --git a/arch/alpha/include/asm/pal.h b/arch/alpha/include/asm/pal.h
> index db2b3b18b34c7..799a64c051984 100644
> --- a/arch/alpha/include/asm/pal.h
> +++ b/arch/alpha/include/asm/pal.h
> @@ -4,7 +4,7 @@
>
>  #include <uapi/asm/pal.h>
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>
>  extern void halt(void) __attribute__((noreturn));
>  #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_=
halt))
> @@ -183,5 +183,5 @@ qemu_get_vmtime(void)
>         return v0;
>  }
>
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>  #endif /* __ALPHA_PAL_H */
> diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/as=
m/thread_info.h
> index 4a4d00b37986e..98ccbca64984c 100644
> --- a/arch/alpha/include/asm/thread_info.h
> +++ b/arch/alpha/include/asm/thread_info.h
> @@ -4,14 +4,14 @@
>
>  #ifdef __KERNEL__
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/processor.h>
>  #include <asm/types.h>
>  #include <asm/hwrpb.h>
>  #include <asm/sysinfo.h>
>  #endif
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct thread_info {
>         struct pcb_struct       pcb;            /* palcode state */
>
> @@ -44,7 +44,7 @@ register struct thread_info *__current_thread_info __as=
m__("$8");
>
>  register unsigned long *current_stack_pointer __asm__ ("$30");
>
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>
>  /* Thread information allocation.  */
>  #define THREAD_SIZE_ORDER 1
> @@ -110,7 +110,7 @@ register unsigned long *current_stack_pointer __asm__=
 ("$30");
>         put_user(res, (int __user *)(value));                           \
>         })
>
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern void __save_fpu(void);
>
>  static inline void save_fpu(void)
> --
> 2.51.1
>

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

