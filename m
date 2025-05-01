Return-Path: <linux-arch+bounces-11776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B6AA64BA
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 22:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266DB1BC69B6
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8E2522B4;
	Thu,  1 May 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OizFYNpc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E125333F;
	Thu,  1 May 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131225; cv=none; b=W6R2N+eSC7s6X4fXJ+PnImmA9dXspZE8tmmbbZt9q7vaRPIHmFCTGwxBEQgEYKJe2kV5a6grVzGrif21cHr/w5GhytIp9/0RrV7I7xbx4MnPfu3cy+SpK5Ghs18KL64UV5MMpiJOt7AYCBQbjBEbScIUoMDfV2fds87jGLxqer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131225; c=relaxed/simple;
	bh=FEXgAKcUyWT3zZFKIlQ3nL1UROMICgPG8FXVV9tUtjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4OZzbG7DZB1ff54hc+ep/9Jj8E2HMN+AmIctPyDd1wH16+2usvgcmPqzaoIMggMRG+/HZuhd+wqUmbBHYxa6fEnFuDiZfQvVrcCdNcd4UvkZPVVYBBrjVhDbajR1gEjTrBZHq9zWcLQLgoA4W/OAGpAU6qSWgvePXb4s+lbxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OizFYNpc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so12431835e9.3;
        Thu, 01 May 2025 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746131222; x=1746736022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCrT5RI9tPJ7D5C6rFSfJ9DKzSb1blmXIucsA95UFGk=;
        b=OizFYNpcjc32u/eiphnpLL886QPQGhVeCFBBqM+BTVCNv5U5WOleATMrGt4OEcLEUD
         AtlQ8pmKygQ9uVoh2kyef8tvsjp8hf7dFkXi6yWigpsTHybk5i46iMk0WYAArJfYosKy
         znLM5RQS9WTMYdUu33vi+kyl65sTBo8XYQDmlg2wJ2GF7K3VwPl1bSv8z9kicT1Coxaq
         bkibPD28BpdzgoY9n+8+zOCioMrsNusRr5fTnhSAo5gqXi0mpPLlWgvAF8K425wACMYc
         3F5Ue6cEowpPWlPbeQR1KO01YgTwGJ/FwbCbFgI4yyppaHnYUbuXtIy1jttCELK/0EiX
         tJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746131222; x=1746736022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCrT5RI9tPJ7D5C6rFSfJ9DKzSb1blmXIucsA95UFGk=;
        b=xISiYEq0NJqaPMUsrJnu0dTm8ODoazxDbUo7CZaTFGsLYedwwUxGtQRcyrfFqq2fDQ
         7+lGIR9wW/3vf52Px24l0lrRWDuFjj4gaRb/NGmq06JMLJZ/tuYqsO/UykHRMPZclZ9Q
         3HwxBBM1ivk3RDAuAL5a65YsKIa+y4mEiyH/F39be94YFFvGyk+XYK9IjHMNLGKm/4L8
         Fzx0broxZBQWX1BS0K6WB8/5ueqRfLgdHJJXOZDe9pAiBjxscP8sSE5X/QGWtRF3BqtA
         cvKdU+F4PmJNaJRg+QVkPKt549YVdZ3sZvuCCEPBBbZHiSZczlfwBy25JDhD/jgsM4dy
         dT7A==
X-Forwarded-Encrypted: i=1; AJvYcCVv2pTfCxDu3v3dt7IPuYjA4HZ+VppjpFgm+dQc62yWAz7kjyXrL9JM+S9CB0cAqcbn371iIHB4p+PNLQLL@vger.kernel.org, AJvYcCXs1gHp79zHNWM2Vwp/ttgCTH/b7OeQRIzwMeNs1Ff9u94xC7YWYMXVimQnqGxb2Ry+/js6FvMdirvp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eZ8n2dOwCEZbWyIrtKqEOKOGDEsa9l+y+vPbxiZbXkXzld/u
	D2Cd7YI+Jpbmlwlr/UBFCL9ULdDhvcWidiqrJHkaTB0QzfYozcu2
X-Gm-Gg: ASbGncviBAie2/B4b7KpUoeADhGDb5Nlg8FGomjJjXC4f34zjpKatSOYqzgbk5ov/8a
	0IPpz7CMIB3dtghE1xhte/MRRB4dxvO0lPhtdYcw7gi7ywPBZF+5HB6gLZxoqWD35m057sBubU3
	9ZZBZnCZbgDXjgTdhu7aFEg4soVKzMjimn/S1zJrdhAZedcItJ1DJcLulHnyLGdfrInWEI8ypnY
	vzgsWS+DGE4e8AE8qpv0AvwGvLjXcS63Gkp1hMDwdx0kiWxO9ERPpH4rV594Ys8u2HZ01yjIAwv
	pqwCIy+sOPe6fFlLwUb2bSH9NbFTRXHpTShRqA52R7iR/aqbIyH+5pnQ5omZ1F1HpJw3jI407ZN
	CkgsLjxIf9r3QYw==
X-Google-Smtp-Source: AGHT+IGoa75VeZa+WW/kanqD/QRdyRUMMOLSIlVjP6GebpoI9LguQrk9ih0fyLoC410P2DbStT3aSA==
X-Received: by 2002:a05:6000:178e:b0:391:20ef:6300 with SMTP id ffacd0b85a97d-3a099ae9afcmr173037f8f.37.1746131221750;
        Thu, 01 May 2025 13:27:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20a70sm69068995e9.31.2025.05.01.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:27:01 -0700 (PDT)
Date: Thu, 1 May 2025 21:26:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan
 <leo.yan@arm.com>
Subject: Re: [PATCH v2 4/5] math64: Silence a clang -Wshorten-64-to-32
 warning
Message-ID: <20250501212659.7e642411@pumpkin>
In-Reply-To: <CAP-5=fXrhsZYJwjJzqb-zMg+UoC-bKoYCjstq8yD9wHNCfbS5g@mail.gmail.com>
References: <20250430171534.132774-1-irogers@google.com>
	<20250430171534.132774-5-irogers@google.com>
	<20250501210729.60558b33@pumpkin>
	<CAP-5=fXrhsZYJwjJzqb-zMg+UoC-bKoYCjstq8yD9wHNCfbS5g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 13:15:30 -0700
Ian Rogers <irogers@google.com> wrote:

> On Thu, May 1, 2025 at 1:07=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 30 Apr 2025 10:15:33 -0700
> > Ian Rogers <irogers@google.com> wrote:
> > =20
> > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > inadvertent truncation. In some instances this truncation can lead to
> > > changing the sign of a result, for example, truncation to return an
> > > int to fit a sort routine. Silence the warning by making the implicit
> > > truncation explicit. This isn't to say the code is currently incorrect
> > > but without silencing the warning it is hard to spot the erroneous
> > > cases. =20
> >
> > Except that the extra casts make the reader think something 'extra'
> > is going on.
> > For readability you want as few casts as possible. =20
>=20
> Agreed except when not having the cast can introduce bugs which is why
> the cast is always required in other languages. Consider in Java:
> ```
> class a {
>   public static void main(String args[]) {
>      long x =3D args.length;
>      int y =3D x;
>  }
> }
> $ javac a.java
> a.java:4: error: incompatible types: possible lossy conversion from long =
to int
>      int y =3D x;
>              ^
> 1 error

I'm not a java expert, but I suspect it has 'softer' type conversions
for integers than C casts.
I've been badly bitten by C casts that make code compile when it really
shouldn't, or incorrectly mask off high bits.
There are actually loads of them in the Linux kernel.
As well as all the dubious min_t(u16,...) there are the (__force ...)
where the compiler shouldn't see a cast at all (it is for sparse).

> ```
> Having -Wshorten-64-to-32 enabled for building with clang would allow
> possible mistakes to be spotted, but that's not currently possible
> without wading through warnings that this series cleans up.
>=20
> I also don't really think anyone will be confused about the purpose of
> the cast in something like:
> ```
> al =3D (u32)a;

And no one is confused by what the code is doing without the cast.

We live with the 'integer to pointer of differ size' warning,
but even that was only really useful 30 years ago and is well
past its 'best before' date.

	David

> ```
>=20
> Thanks,
> Ian
>=20
> >         David
> >
> > =20
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  include/linux/math64.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/math64.h b/include/linux/math64.h
> > > index 6aaccc1626ab..f32fcb2a2331 100644
> > > --- a/include/linux/math64.h
> > > +++ b/include/linux/math64.h
> > > @@ -179,7 +179,7 @@ static __always_inline u64 mul_u64_u64_shr(u64 a,=
 u64 mul, unsigned int shift)
> > >  #ifndef mul_u64_u32_shr
> > >  static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned =
int shift)
> > >  {
> > > -     u32 ah =3D a >> 32, al =3D a;
> > > +     u32 ah =3D a >> 32, al =3D (u32)a;
> > >       u64 ret;
> > >
> > >       ret =3D mul_u32_u32(al, mul) >> shift; =20
> > =20


