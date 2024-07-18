Return-Path: <linux-arch+bounces-5503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE0935089
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363D11F22282
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1613A3F6;
	Thu, 18 Jul 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wJZYrC7E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8A57333
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319630; cv=none; b=hrXJtnR4fE1O6/f11BicNY3cPFxMNIRhR39qza6GfOXKfXNaCMjR3tuAPHWRd6DU7hHkH/ALKeHcRNVMN02ub99pz8TIkz8dcqIhQicqmq0KV01G56OrhOBBWnIH/ZalFJumYU+ZKgXRsTuXFlWv2akuT0Bp2DQDIYD+wR/bogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319630; c=relaxed/simple;
	bh=hV/yjRqF09iUcs/e0H7EaoqxbBux+C8yA9yGsn7+gIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSp8WZM6tFHWlqetUPRkKzvgV0HVRNpsit0GcsgcU27/HYpSqHXJVxkft49PUi7dx05EuCc+SbJPgE0UGhNFNntE9f/ZNbFHfLe/rmS/DqeIssnMSpQWc4g5EL+t5Mj70R8c1z+lFgfnDdT0ytUIF74XEvmhYl5XUj+w2m+upq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wJZYrC7E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c25beae1so98064366b.2
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721319627; x=1721924427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7GxSN83wkZ2Gt6sREDponA0vNCLDJLytERV2W14H4I=;
        b=wJZYrC7Enhxehy4aiAW/B2Xal1dfj95xgrcz4wNxRE5mqudVuBuYTsCBibCuvKFgjJ
         1cggZdu66is6nSBVYj7yPhDnZSuFZFMthwdyVgDQbPUyM8TE/caj5YB6yUW9YwkU0Ife
         0ho9DbiAnzWvtzaF1gphAAr1bYCaUtAx18EjET12bWjsi8qKkhvHquyRmsSVq7kpfHN/
         K9Wo5xLTY+WIX+OfjBQNv+UQTdNfmlaEUUpZw0ovaU0ZaeY+s4guDoStImnPqIcXjKT6
         B5bpuGcyIfnoq3nfkiKCuD+MO/Jh23fd0O7jwjI9gQxKH+XC4VNFkcOBQToMgOa6SrAj
         DQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721319627; x=1721924427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7GxSN83wkZ2Gt6sREDponA0vNCLDJLytERV2W14H4I=;
        b=dQVA7DcfC2morwsyelX4j1AwEgOtZMMkwpiaB0ftfKHaWK/Etc8gklLmlOYwgLEq/7
         0l/2e9hQPtQm8a+DaXmkC4IqJtQPUMWZAXzQi9yI/yKK9DjpWvDcazAZw6gxKvlASBeQ
         5HfKHQp4gE+B7Kx2jzINjmquHBISbJTFSdbrmQTJOdLeHIbwHxtzl+ojGEREI7SXUUBD
         0Cw3CuZwaWTR7EJCDpMm59HFZUsZO68PNQ5uGrBQUl3Nq0CeejtUkLagN6Gq/meaNlo3
         fNmPkX5+fS/uBq4y7iHLD/uvJZPfzrp3TxlilQpQ3gzJW/LW+ixKHeyh9RYHfAsT+AHt
         NYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMjnj8JQrINxr64+dEP5VZ1GwycYckmJ/SBNlEYXYGJUZXOkpeK2KPucvvYEN9K1sayrSHe92nHECUQUyk/yNLPQsNMzLyvwmRag==
X-Gm-Message-State: AOJu0YzXk+lJgLKAxnYT0qNEmH4xuH+otsYBxMjSJBenYzGcS3fH1rfb
	1MnPEtF1/ejBR5lnFarqhHDlcHpXdzVd6FTqi1iLV6fOn/pBe+PowqY7zvgXM/zmvDrc9FL02ma
	KYMZc5A7R2eXpCuO3QCr26EP+lQ5Rq/f/cRkgmQ==
X-Google-Smtp-Source: AGHT+IFWxHKkplzJKRLqT5zU4jO3082AA0xXCpFalTdhVnKTUbtkr/nNZqNjYbQOPoY/7FuHv/90dOwfuXx6JMhiz28=
X-Received: by 2002:a17:906:6c4:b0:a77:d1ea:ab39 with SMTP id
 a640c23a62f3a-a7a0115bfe2mr329353566b.16.1721319627120; Thu, 18 Jul 2024
 09:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-4-alexghiti@rivosinc.com> <20240717-e7104dac172d9f2cbc25d9c6@orel>
 <fb03939b-502b-410a-85f5-2785b2bd0676@ghiti.fr> <20240718-d583846f09bc103b7eab6b4e@orel>
In-Reply-To: <20240718-d583846f09bc103b7eab6b4e@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 18 Jul 2024 18:20:15 +0200
Message-ID: <CAHVXubjQo9WaHu1FwEaJ496xpYtshrOkkw_HP9cP_3rWjnMxzw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] riscv: Implement cmpxchg8/16() using Zabha
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 6:06=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Jul 18, 2024 at 02:50:28PM GMT, Alexandre Ghiti wrote:
> ...
> > > > +                                                                 \
> > > > +         __asm__ __volatile__ (                                  \
> > > > +                 prepend                                         \
> > > > +                 "       amocas" cas_sfx " %0, %z2, %1\n"        \
> > > > +                 append                                          \
> > > > +                 : "+&r" (r), "+A" (*(p))                        \
> > > > +                 : "rJ" (n)                                      \
> > > > +                 : "memory");                                    \
> > > > +         goto end;                                               \
> > > > + }                                                               \
> > > > +                                                                 \
> > > > +no_zabha_zacas:;                                                 \
> > > unnecessary ;
> >
> >
> > Actually it is, it fixes a warning encountered on llvm:
> > https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-399=
0X/
>
> I'm not complaining about the 'end:' label. That one we need ';' because
> there's no following statement and labels must be followed by a statement=
.
> But no_zabha_zacas always has following statements.

My bad, that's another warning that is emitted by llvm and requires the ';'=
:

../include/linux/atomic/atomic-arch-fallback.h:2026:9: warning: label
followed by a declaration is a C23 extension [-Wc23-extensions]
 2026 |         return raw_cmpxchg(&v->counter, old, new);
      |                ^
../include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded
from macro 'raw_cmpxchg'
   55 | #define raw_cmpxchg arch_cmpxchg
      |                     ^
../arch/riscv/include/asm/cmpxchg.h:310:2: note: expanded from macro
'arch_cmpxchg'
  310 |         _arch_cmpxchg((ptr), (o), (n), ".rl", ".aqrl",
         \
      |         ^
../arch/riscv/include/asm/cmpxchg.h:269:3: note: expanded from macro
'_arch_cmpxchg'
  269 |                 __arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,
         \
      |                 ^
../arch/riscv/include/asm/cmpxchg.h:178:2: note: expanded from macro
'__arch_cmpxchg_masked'
  178 |         u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);
         \
      |         ^


>
> Thanks,
> drew

