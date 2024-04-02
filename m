Return-Path: <linux-arch+bounces-3356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C18954CB
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CE9289BDE
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D424133293;
	Tue,  2 Apr 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0EBIbrR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D9134CEF
	for <linux-arch@vger.kernel.org>; Tue,  2 Apr 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063283; cv=none; b=mJRzj5TcrehJ6msnBI3p59al5zVoJsvGm30w3NDhaWL7GCOnbrR85LweW5Ckck7sHzNPnJR3D4QCjeXq3k/s5s8bSa6vdywzBovTpXZKrmaMNG27x7kDaZqvR+lcvfxKuQThAM+f3Rwv7tHuOWKptBeleoKgKFgcE/TeH7h7y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063283; c=relaxed/simple;
	bh=vgP+36VWKafj4cVC7SyOoL9SCfau5bABFyH+Csakpn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9rq1kGQUsDUknpXNxjxiTNe8jkpjk6cqkD3uCxyxyyf3nGzFiCIIY/o+75NU8qyASmMyhq+PlbYwNmSa9zDRXokpXXZ3p2cuBZDaFXDyBNYTeqoq1QKB+ECPmlkADIMvtYlqY3t1Q/XVTL0bxzH2cmafoPmWvFxBsAfq69/ZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0EBIbrR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e695470280so2946197a34.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2024 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712063280; x=1712668080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lwz+te3v25y+UIyojEIFe5So3l8Pl+raR0jXQRZwL4g=;
        b=m0EBIbrRo2aNG3nZVIb2tMspivbN+KZS3njoFjN1mf343kOEkVlYfc4JUGFuRcYUWm
         jwpHFyOPJ5LxYONiIWZxr92uUbAPqMXpn0N2Vo7YRj8XDTeiS5RIWyaDDO9Zns3s0sh+
         zleHL5NXKjRmX2MBcsLga2nXl6RDH4EpD8Bwn3nElV7t+6Cjc3gedndiSXNKegEfIkdd
         s6+UB95VAdRVZzStBT/AokHkIhiKQWIl6QAXzeoT/J7GqIXg7wCoCdzl6GvDwZGgaiqF
         6g6XQz6WToQiGl1FVZQnWXpcaIxSfmh+doj97Jv9gtbE3XcFskjd29IcgjL+QifaJajM
         nOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063280; x=1712668080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwz+te3v25y+UIyojEIFe5So3l8Pl+raR0jXQRZwL4g=;
        b=Qrvf3KUVNT0jxRjCS3APsfKA6QgS+ZcrIiIBdsjMIdpNUJ+BTh2nLbd5nasCEqL6aR
         J0sjuK5aGKA4BAhDvcSijw9bWHxx3yaKk3t23sK1f0dIn8aQwnRar9QIdkZD+rdnBvZv
         Ad3QsXli7Au7sOQ5LHLTzxcNwr5wLMysW+7Xs98rGXE/tQpiHnzdFyuWOPPsPwVHly8E
         Rc/WPXt9qhA3PQwfZXP3Oc45BVqV19vO2JP0r5imrNN373jY8g16fJ4hTMzzmr0Gb8DE
         /pPMxoh8l5z5irB9rwe9jNwBJ8910ryiVfMaPMJpXrI5KF0TSbs5zw5MEwDmSF/BkoDr
         VlxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJO0z1dKsaXNrJecQrlkbtEHZhghwLQ/daDZJX/v4MQoIuQA3hoOXUt5fDuNxyfdMJBLd6mGMP+N8j0SJtxlpZziX0kAyyJfYMWg==
X-Gm-Message-State: AOJu0Yws/gYuAxj3QExkscmo0PGUgVAMgRlyb1m01zn9AYQeDh+0oXRD
	dkdkn+4ay6S+9z0ygBl0K5RycceSOaaTDAn394GPrARLiu3GSid0tg/dYBsotRzYURk9ZYN5xpJ
	gkVOKpwuJPVQS9CZoDW/+GFIeYtwkgJWVUANk
X-Google-Smtp-Source: AGHT+IFfjHomY9Q1pqJvyjMwrOtxO9qwBxdriDeV+1TZPmKhKqftTRLWP/h8EQ6LJ6NPd7qWAALGTCn/qXfM/KNFjPs=
X-Received: by 2002:a05:6808:1707:b0:3c4:f08d:544d with SMTP id
 bc7-20020a056808170700b003c4f08d544dmr4327794oib.17.1712063280344; Tue, 02
 Apr 2024 06:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop> <20240401213950.3910531-1-paulmck@kernel.org>
In-Reply-To: <20240401213950.3910531-1-paulmck@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 2 Apr 2024 15:07:22 +0200
Message-ID: <CANpmjNNSCWSndpf-N7=ifSUFhLWjYJibRf58hETjHeW25RzWYg@mail.gmail.com>
Subject: Re: [PATCH RFC cmpxchg 1/8] lib: Add one-byte and two-byte cmpxchg()
 emulation functions
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Douglas Anderson <dianders@chromium.org>, 
	Petr Mladek <pmladek@suse.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 23:39, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Architectures are required to provide four-byte cmpxchg() and 64-bit
> architectures are additionally required to provide eight-byte cmpxchg().
> However, there are cases where one-byte and two-byte cmpxchg()
> would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
> cmpxchg_emu_u16() that emulate one-byte and two-byte cmpxchg() in terms
> of four-byte cmpxchg().
>
> Note that these emulations are fully ordered, and can (for example)
> cause one-byte cmpxchg_relaxed() to incur the overhead of full ordering.
> If this causes problems for a given architecture, that architecture is
> free to provide its own lighter-weight primitives.
>
> [ paulmck: Apply Marco Elver feedback. ]
> [ paulmck: Apply kernel test robot feedback. ]
>
> Link: https://lore.kernel.org/all/0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop/
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: <linux-arch@vger.kernel.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/Kconfig                |  3 ++
>  include/linux/cmpxchg-emu.h | 16 ++++++++
>  lib/Makefile                |  1 +
>  lib/cmpxchg-emu.c           | 74 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 94 insertions(+)
>  create mode 100644 include/linux/cmpxchg-emu.h
>  create mode 100644 lib/cmpxchg-emu.c
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ae4a4f37bbf08..01093c60952a5 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1609,4 +1609,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>         # strict alignment always, even with -falign-functions.
>         def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
>
> +config ARCH_NEED_CMPXCHG_1_2_EMU
> +       bool
> +
>  endmenu
> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> new file mode 100644
> index 0000000000000..fee8171fa05eb
> --- /dev/null
> +++ b/include/linux/cmpxchg-emu.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> + * lacking direct support for these sizes.  These are implemented in terms
> + * of 4-byte cmpxchg operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#ifndef __LINUX_CMPXCHG_EMU_H
> +#define __LINUX_CMPXCHG_EMU_H
> +
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
> +
> +#endif /* __LINUX_CMPXCHG_EMU_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index ffc6b2341b45a..1d93b61a7ecbe 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -236,6 +236,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
>
>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  #ensure exported functions have prototypes
> diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> new file mode 100644
> index 0000000000000..a88c4f3c88430
> --- /dev/null
> +++ b/lib/cmpxchg-emu.c
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> + * lacking direct support for these sizes.  These are implemented in terms
> + * of 4-byte cmpxchg operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/instrumented.h>
> +#include <linux/atomic.h>
> +#include <linux/panic.h>
> +#include <linux/bug.h>
> +#include <asm-generic/rwonce.h>
> +#include <linux/cmpxchg-emu.h>
> +
> +union u8_32 {
> +       u8 b[4];
> +       u32 w;
> +};
> +
> +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> +{
> +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> +       int i = ((uintptr_t)p) & 0x3;
> +       union u8_32 old32;
> +       union u8_32 new32;
> +       u32 ret;
> +
> +       ret = READ_ONCE(*p32);
> +       do {
> +               old32.w = ret;
> +               if (old32.b[i] != old)
> +                       return old32.b[i];
> +               new32.w = old32.w;
> +               new32.b[i] = new;
> +               instrument_atomic_read_write(p, 1);
> +               ret = data_race(cmpxchg(p32, old32.w, new32.w));
> +       } while (ret != old32.w);
> +       return old;
> +}
> +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> +
> +union u16_32 {
> +       u16 h[2];
> +       u32 w;
> +};
> +
> +/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> +{
> +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> +       int i = (((uintptr_t)p) & 0x2) / 2;
> +       union u16_32 old32;
> +       union u16_32 new32;
> +       u32 ret;
> +
> +       WARN_ON_ONCE(((uintptr_t)p) & 0x1);
> +       ret = READ_ONCE(*p32);
> +       do {
> +               old32.w = ret;
> +               if (old32.h[i] != old)
> +                       return old32.h[i];
> +               new32.w = old32.w;
> +               new32.h[i] = new;
> +               instrument_atomic_read_write(p, 2);
> +               ret = data_race(cmpxchg(p32, old32.w, new32.w));
> +       } while (ret != old32.w);
> +       return old;
> +}
> +EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
> --
> 2.40.1
>

