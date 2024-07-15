Return-Path: <linux-arch+bounces-5395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82D931537
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6BE1C21506
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B718C349;
	Mon, 15 Jul 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QexLbJ93"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE318C19B
	for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048208; cv=none; b=C6JwClC3pmaORILmNvUCm7/kPXozfHzvpmn2f2tI5wIi+usCFzPdm28LOW2GWfEhtyB/kiIHhGOiN90DjvrmmQimZThB8CmS1Tgd2NSJhFunAT5ElurPItGkYKPCEHnDoIQrpy1m9/eAjB3T024ybVKwJRAdIANSR2yAYPX8LFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048208; c=relaxed/simple;
	bh=FXxvxDNMjpNVzwzqZhWBa1tOHGY8zYU9VrOR2o556sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGK0uuxUdm0KuMS2xlz+ZrFtFniiTqQj9p/jwXJXgzBH7RObYkcfIneP8/LCgyKi7tpNp6+cCNQpesL2Qd4wtWVD1owfAjFuHeWoQI2PQUX+/+MBoqGnqRRQfpcYfP6BvjsO0rl+NB/FnbzIJHp+UxF7P5NA0bwq6yEUETlC7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QexLbJ93; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e2f51496so512591466b.0
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721048205; x=1721653005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfNNMp1rG3SXkek7cMYvB8iok7DNluaUVkXIU0Xf14=;
        b=QexLbJ93JEyxZvu628I2UWvMqo8uXieaqS/fpZhsOWLWPD7aNNjLthPyQ+49lhkSOc
         qBjx9AIiFwKY/lNLixLAfIQz2hzT5G7i6k5CwSz9v7RP7JSMJ9+s20TdV0yoeKMbvnZT
         WOLcvr9D9LEDKan+HDj9esjlMQw+nFMmFFev9OreNwxHm1MiohItvszOBqAuUqUKDwD7
         dea37r/x4Z3bbgHq3VXaYPO7JatHogAuW+EY01pM2U9RW4x5BtaP25v8zs105zzVVCC1
         a/pXz1USpbpACQ4j4UzbXoybrK7WwMrDj2A7pqPyeZ4DBneAcs+eknHi0Vrj2wyeivK3
         4sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048205; x=1721653005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfNNMp1rG3SXkek7cMYvB8iok7DNluaUVkXIU0Xf14=;
        b=DSzVC6aBToIhjC3EwrB1D47XEJmSIokjPbhJ0f5PC7uy4qVyk+6jL+VXcTPwoVbwBj
         spoJB8A+eccMCzWgEiEWwXXyZKuRnv3uNJSC2pqIm2g6vwZxfiMRml1j7sQZVVtfguD/
         X2aFy5kPIp8wW/E3vJSHieG8XOJaMU46F8es2jpG8TQPidFPlncHM74CDnsbpnD/TuUl
         xN8U1VzVm3FT4DH8+ko7SucNmMlEzoO+ehoawuHdki6IdWvQ5vEHFJlTdK773e78pPtU
         scH3oQFYOMU/nEj3x0toSuqETcCSvOdZiDcajchEtdAW4zUwvmOUTgbEiZFs2ijQ6mOr
         qyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1fayTBNTdTGRBBDxe79hqvf7HKr/HpaPMrv4uCfKy3zuEnIDTilnjUOb69zlFBBm0dofbFhwr8s0REk2g+2qXs0jpiZsO2abk6Q==
X-Gm-Message-State: AOJu0Yz0z4+XRjj7hyj2i/Fdt057nh4mXOCoCbbs1fnUhNLUiucc6KRF
	ZLgqd7eMH6CJFdoqTPIWjrTJZVyfWgJjMAQJaANNiKqrM7LyYE6fSEbzapLlWoj95RdtIm5pqAx
	OgkvSJxfE4Tf6aHibXf6Du9XLJIS1A0yW8saooQ==
X-Google-Smtp-Source: AGHT+IEQxCwmk3v9bZId3rguAE4ZhEMOX7OQcvnvy46JJ2wjs4mq+MuCAlAfeu4173n5ppDi6qdRzxNLjJYPZQTWSyo=
X-Received: by 2002:a17:906:fa08:b0:a72:b811:4d43 with SMTP id
 a640c23a62f3a-a780b883462mr1101581166b.59.1721048205077; Mon, 15 Jul 2024
 05:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-4-alexghiti@rivosinc.com> <Zn1StcN3H0r/eHjh@andrea>
 <1cd452af-58cd-468c-9bb6-90f67711d0b0@ghiti.fr> <Zo3NBHUEMMec/6uD@andrea>
In-Reply-To: <Zo3NBHUEMMec/6uD@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 14:56:34 +0200
Message-ID: <CAHVXubjCdse-3z3hKR81VpdvjxVaxPUZdmTwc4fvHordcfHVng@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Wed, Jul 10, 2024 at 1:51=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > > I admit that I found this all quite difficult to read; IIUC, this is
> > > missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.
> >
> > I'm not sure we need the zacas check here, since we could use a toolcha=
in
> > that supports zabha but not zacas, run this on a zabha/zacas platform a=
nd it
> > would work.
>
> One specific set-up I was concerned about is as follows:
>
>   1) hardware implements both zabha and zacas
>   2) toolchain supports both zabha and zacas
>   3) CONFIG_RISCV_ISA_ZABHA=3Dy and CONFIG_RISCV_ISA_ZACAS=3Dn
>
> Since CONFIG_RISCV_ISA_ZABHA=3Dy, the first asm goto will get executed
> and, since the hardware implements zacas, that will result in a nop.
> Then the second asm goto will get executed and, since the hardware
> implements zabha, it will result in the j zabha.  In conclusion, the
> amocas instruction following the zabha: label will get executed, thus
> violating (the semantics of) CONFIG_RISCV_ISA_ZACAS=3Dn.  IIUC, the diff
> I've posted previously in this thread shared a similar limitation/bug.

So you mean that when disabling Zacas, we should actually disable
*all* the CAS instructions, even the Zabha ones. It makes sense and
allows for a single way to disable the CAS instructions but keeping
the other atomic operations.

I'll fix that and add a comment.

Thanks,

Alex

>
>   Andrea

