Return-Path: <linux-arch+bounces-4323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9118C2FE8
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 08:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C31C210A6
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B904ECF;
	Sat, 11 May 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/laxnxh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00CA55;
	Sat, 11 May 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409751; cv=none; b=AmdcY6NFKY4pLUpW/x5wvh/ayUO3qCY6wHVpU83dO8mBLjrmiROmj3IEVAgwHoV0gAbtl9Yl1aO/+/TrkYQ8CPjZr5GHyKvx860xSSZDdtevZFDbWJeeF7Bwnteup87kcWkNidBygL3Iqd4oUK2to7GBSZGZv9n+K67/sMCiorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409751; c=relaxed/simple;
	bh=Bbk0MO4IQHx0Mq4jWRtOutLf8k7zDUzhGEHWx1oJTEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZi3G1gcq5BnvBIKJRpl+j/0zO3w8QJ4dWTE+ZixtrjcmQS1YCS/pFyNIYDesuxs9C20xuOtFd7+fL6ImZP489pAuoJN/D7HifSBTlKOM8cGRG9R3MbLdWOV40RxuRM8aVtoVFDqWpuCIqq5Hu+2Af+x02sYaTnIu7ND5GRf1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/laxnxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBBAC2BD10;
	Sat, 11 May 2024 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715409751;
	bh=Bbk0MO4IQHx0Mq4jWRtOutLf8k7zDUzhGEHWx1oJTEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q/laxnxhX4hVWz1A7lEXCoI5z5pTZW6ssvLDeH/WFj9Xqlyfarsh53vjDUjT60n0S
	 SEjzxfcWMJRBOUs1l30dj1o2caIvGD4dq6n94plsd2kBppWByjcSAez/Cz9B1F7qKJ
	 YD8xVIYY1gibvnt/h1hVz/+BdTLDm3hTHiGaqGuGnLeKNfIpE0Y9JKVAr+T6ARtrmj
	 P3NmAcAGsmMrejPyOb5dBGNSk1AlMq7jo4QiahaOAJ+nt61EFt7Jn1llh5xt4pHRVA
	 KAZI/8DiAnbxo8ElnsWa64RTbWcLB3rX39gW+ZMB/LNScUsEbG5Cd77+hr17W2jUaR
	 oU6HKnMulY3Cw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e44d32a480so43306441fa.0;
        Fri, 10 May 2024 23:42:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfjwmiXZpoiqYApTw+A0wOE0msQDypZH/FmBJa2VhdRMR64SK8/qncrvqzTHU6RgA9lSPugOcaFDsk8Qngd28hXaSsswjOKc0a30ym2trJSMQRWQlYlDpl0/8WKOpa5EkYLxjqM3J9tw==
X-Gm-Message-State: AOJu0Yxa0S10wpqsrJu+4BLl0fDPUB5t5oIjRK13fLNz3qHwH4BUWwmA
	dLfilmpbmBd9btrS+9FNqdz3BQxI28C3yvBJ00YtP+kAPf7XpgbP4psmOW6/ZUx7cg04JIx80VL
	jCHCHVNksZuYNA11IwaflAUHLw4k=
X-Google-Smtp-Source: AGHT+IERM7qQjT9YJWZw+5E7S/UqSr34zrWEE+BgSAtY6nslHgZnNp5h1mVpEXM+pQpr7/8EEfeQljbZzn7pYGnd+rQ=
X-Received: by 2002:a05:6512:48d7:b0:51c:c63c:c2af with SMTP id
 2adb3069b0e04-5220fb74b85mr2551238e87.28.1715409749331; Fri, 10 May 2024
 23:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop> <20240501230130.1111603-11-paulmck@kernel.org>
In-Reply-To: <20240501230130.1111603-11-paulmck@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 11 May 2024 14:42:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQb1qW_GUiQBWiogBLX2geNGMFhOJK55ZKWJYyFqu-SSQ@mail.gmail.com>
Message-ID: <CAJF2gTQb1qW_GUiQBWiogBLX2geNGMFhOJK55ZKWJYyFqu-SSQ@mail.gmail.com>
Subject: Re: [PATCH v2 cmpxchg 11/13] csky: Emulate one-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, arnd@arndb.de, 
	torvalds@linux-foundation.org, kernel-team@meta.com, 
	Yujie Liu <yujie.liu@intel.com>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 7:01=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on csky.
>
> [ paulmck: Apply kernel test robot feedback. ]
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
>
> Co-developed-by: Yujie Liu <yujie.liu@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Yujie Liu <yujie.liu@intel.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-csky@vger.kernel.org>
> ---
>  arch/csky/Kconfig               |  1 +
>  arch/csky/include/asm/cmpxchg.h | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index d3ac36751ad1f..5479707eb5d10 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -37,6 +37,7 @@ config CSKY
>         select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
>         select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
>         select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
> +       select ARCH_NEED_CMPXCHG_1_EMU
>         select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mba=
cktrace)
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>         select COMMON_CLK
> diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpx=
chg.h
> index 916043b845f14..db6dda47184e4 100644
> --- a/arch/csky/include/asm/cmpxchg.h
> +++ b/arch/csky/include/asm/cmpxchg.h
> @@ -6,6 +6,7 @@
>  #ifdef CONFIG_SMP
>  #include <linux/bug.h>
>  #include <asm/barrier.h>
> +#include <linux/cmpxchg-emu.h>
>
>  #define __xchg_relaxed(new, ptr, size)                         \
>  ({                                                             \
> @@ -61,6 +62,9 @@
>         __typeof__(old) __old =3D (old);                          \
>         __typeof__(*(ptr)) __ret;                               \
>         switch (size) {                                         \
> +       case 1:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
>                 "1:     ldex.w          %0, (%3) \n"            \
> @@ -91,6 +95,9 @@
>         __typeof__(old) __old =3D (old);                          \
>         __typeof__(*(ptr)) __ret;                               \
>         switch (size) {                                         \
> +       case 1:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
>                 "1:     ldex.w          %0, (%3) \n"            \
> @@ -122,6 +129,9 @@
>         __typeof__(old) __old =3D (old);                          \
>         __typeof__(*(ptr)) __ret;                               \
>         switch (size) {                                         \
> +       case 1:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
>                 RELEASE_FENCE                                   \
> --
> 2.40.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

I will optimize it after ARCH_NEED_CMPXCHG_1_EMU is merged.

--=20
Best Regards
 Guo Ren

