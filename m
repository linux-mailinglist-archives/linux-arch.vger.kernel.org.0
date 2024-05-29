Return-Path: <linux-arch+bounces-4580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95CD8D36D6
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FCB286EE3
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB4E542;
	Wed, 29 May 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O4vT9H1X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB7D53E
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987372; cv=none; b=mowve9IDkfKHJ6LrP9XrlnmJTG/M+RVv3twJKfXino6EtKbob+uVM91wZaP/0R80CNCPQGuEKFZHRcKp7i+/W6Jdq1s+HbVZPsBadUMdJ9xDPwRlBijbDbiC2tuh9+LBoMaqhkV861MfE6xCjvWi0Lo8us3eT634V7yIpI0MF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987372; c=relaxed/simple;
	bh=ZswRo9CCBUa07cVg9bCL+lMt2x/W4xXLb1fAdy1GxqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufpJb6wT14QRekWmfODrPCZJEhDeK+sXA/Z8bbckABGYYR0AQfFsdEWROBcpBXfqzZwPWKfrBl/tjc23Zi7GxhusyUcUwidtDrqbVcv0qXqoUea2kdeMJvOZ0I3QDBmYFglgzBC3Rnr3d9K/sCfrkxUtWFMIXRizsI4AkwDzOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O4vT9H1X; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a632ba6c9dbso258594766b.2
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716987369; x=1717592169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km2JkQ5ctJj0MJYq+rdmwY806xDsfrDcZz255+ragDo=;
        b=O4vT9H1X/9QI2rjcgwoD/Ne6NQsG1Oo2fFf0jKWAkvIKmZulIPQBz4avzgaBeuKqdy
         phM0/nCcytGu7PbvxIhTwCvs55Z0cd/ym7m/1LCtFxwDHrW5HBqdvBFmyiPtFnRC7BfG
         gj9hg0ao5IyEET7jRl2FWhKDqpmwMafmHE7phc6kY++NEmMgiQd0he/w/o1VOYPJDw2T
         saGvytSH4ygLQJib8l0/rcP0dbWCjwLJcSWxCFfoH81jpYe7eYZ4hAQxcHfach1Mku27
         nMjdDFJY1hIrWxC0HXOJyPXkUPwxRs3kuuJGUl8foOpZK1ovmWN+qsg11SjulH+6XB2W
         F/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987369; x=1717592169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km2JkQ5ctJj0MJYq+rdmwY806xDsfrDcZz255+ragDo=;
        b=U61YIVD/KE0tUGynKbXrUFaePrduQzkvArCqJDrzd6od1arjj4KeA/13TRFiZ5AhBD
         Q6looaICQyrMWTlWfHQZz3JFENCs0FQRymIO1k/xE3RqN7Ke9e1Ov41digTHens5mP/v
         638J2933ghVgpHlxv4GtA4p6YJozTVZJROUnNtPeesCMpyDkd/LHNIc7kkLIpPwlVj/7
         eZnxVrr4479RomlJ4Z4RjFo7Shp3mWvYLIzgOgkuI+PYtlgI2ZXwS1cOhfw32ypbFou9
         /8dKdhdEWbDqiibPofdDOOxAqGuP8AmVL7FH2+5rJbBXmiWst4iDiosoiHyXohL4P25d
         hA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO8BLqXOWsAEPf5zVaCD6327r8f/m6FAlumbOszrSRFlcpR9BGBdcnp4un4wFDg8VrG6Xo3Ym9m31O+dG3dm/pHqCzUcobMdfcrQ==
X-Gm-Message-State: AOJu0YxAfcncVIjCrqLgVA0FV9nYBCYkcNI8agnOkOJdRWqoKNIIpFZ1
	FM+5NRwG9OhOe2x3GiVYfFoSfZKyPmWi+eKEdH5PnQHuI7x5f2xVEKrxZG1ztLNR8ucD8yz0b92
	+B4C8DdlHV1dGD7E6GGaVLNwk87f24R+Oz1gl9w==
X-Google-Smtp-Source: AGHT+IH0vOZfyMkMWjnkaaZK40pKjAqSY52a2HgHvxw27fqLFne63Zuz6Oyl4uIA4uXNRiyl5WY3rMhK7Cfm5L00l5U=
X-Received: by 2002:a17:907:25ca:b0:a59:c833:d272 with SMTP id
 a640c23a62f3a-a626417a32amr1191230666b.13.1716987368948; Wed, 29 May 2024
 05:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com> <ZlZurXUUUfXHZJaX@andrea> <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
In-Reply-To: <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:55:58 +0200
Message-ID: <CAHVXubgGQ1whBsAVbfZryqxzTu+uNaUQoAs_AUhM2ofN9h9BDA@mail.gmail.com>
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:29=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Wed, May 29, 2024 at 1:54=E2=80=AFAM Andrea Parri <parri.andrea@gmail.=
com> wrote:
> >
> > > +zabha:                                                              =
         \
> > > +     __asm__ __volatile__ (                                         =
 \
> > > +             prepend                                                =
 \
> > > +             "       amocas" cas_sfx " %0, %z2, %1\n"               =
 \
> > > +             append                                                 =
 \
> > > +             : "+&r" (r), "+A" (*(p))                               =
 \
> > > +             : "rJ" (n)                                             =
 \
> > > +             : "memory");                                           =
 \
> >
> > Couldn't a platform have Zabha but not have Zacas?  I don't see how thi=
s
> > asm goto could work in such case, what am I missing?
>
> Zabha amocas.[b|h] instructions are only implemented if Zacas is
> present, as the specification states: "If Zacas [2] extension is also
> implemented, Zabha further provides the AMOCAS.[B|H] instructions."
>
> But the code you mention is only for 8 and 16bit operations, so I
> think we are good anyway?

And I was wrong like Andrea noted privately. So I'll fix that too, thanks!

>
> Thanks,
>
> Alex
>
> >
> >   Andrea

