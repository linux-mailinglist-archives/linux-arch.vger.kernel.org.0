Return-Path: <linux-arch+bounces-4577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E636A8D3663
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF95289183
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFDA181300;
	Wed, 29 May 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dsHjE0jo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BE180A99
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985756; cv=none; b=AAjGs99+fCeqz/YZb4xnIoxhjYJpRZpwjI/qKeGmUnNrDy1CPUUV6/o7Z0KwvVG99fKcvViMWORdrt7KJDBShuBqlnstmRzmmGNQzhNIZCBfHcbprYQ+3uwt3/nqPzNDR8tQlAGze4Fz4Nhy0k3SN5S2S84GdaD4HMQWaIfwJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985756; c=relaxed/simple;
	bh=idIfNjbOL1qD0ETg1hT6YfT88MOe7waFfNRjHCRqyJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHRiANyZg8oUD4J0hmzgnZOhPo0ys7nhhxI/OgsJBHrvourmBd0apIgA1c2NBSngo2Ag2jrkit+Tl6gyanqSQSb37sWDVJA9vmOxtcj4PvQiSQ7R2ewI/SdrNcBrAY3fPFN0jmYXe4GvxkXcXPpXrChwIbTxdqcbYg2kuJSNZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dsHjE0jo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57883b25b50so2284997a12.2
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716985754; x=1717590554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGOEscTDwTYqe9co9+vKadCnOa5+j3XpvvU3cG9r11k=;
        b=dsHjE0joBJ+pINsd1aEDha8rBVzEkpvitdyXLo7dwKlw2lgPXQ5uhB743UYcwCkCZZ
         h4P9LYTAM/Cev2OmYo0eeSucugyHn7x/XxHP8rn6EsHlIxBhKxdTzQKhK5ivwV66HPyN
         mT6kvcttDvRlVKRcMyAgqBhcQstk7TBAfy3O9zBXDZiK6tpQbdcbOpyCu/WK27aDbJkb
         noriGWhgky95jdcVtszZxReBt/gaN+xRcjdmjFhLGjWGfbIalKxVufzl8UFB3IQPMOLa
         WPWSnzcWBemAQ9dPfwLh2pABMvp+8tCmX8ZqGw8qNSnau0MFx/4g9uw5JuAXV5sR/LFs
         J9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985754; x=1717590554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGOEscTDwTYqe9co9+vKadCnOa5+j3XpvvU3cG9r11k=;
        b=IzfLDXoGOe0P+ra1ZNPHzD6MWUFQLg5zMNDs0QolSPZV8YdRLHy7Nv5Y7YhJMsFVvn
         iIduDLbWLUJxMroGZVppORHIeN5Vy48kblf6o2lmaeH7tCrTzLcdMqD1SbDX03vlg9s9
         QgQGih+88H7t26xe/7qZdQHwD0maeZ//OKo4dqSZmqEv8sG/p01uH66YqHob0t6xAiV0
         5cKnFJiZL/1mfnITBTTZu68Lps7DnnySpEB80D6aXGCcF4yarh1ICQn+i5RQf02EpF2a
         YgITwMDm6O+rw5so84eJwIQUZ7v92GKDnCdqPI1MHX7s6RY3p8i+haw/vCXBAkbtNZ/T
         wacw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvFkNsYFOKi6rhnk9COP5zygTPdFz0F5uJqpuN941ooeDpx7vNsar1R/z6A4suKiX6ph/SF4TPpWGumEgwSy8EHX/D3bqT3TeMA==
X-Gm-Message-State: AOJu0YyWZBuOafzn4GVSqcUnXAWIFEsE5FS4Cso1Wle+udvtZWLbqbuK
	PjI1jOKQHWbSlbMzBSwoNW9qNMbPHVetgWSKQ2Fec32fAzyR1eMQ/oLw8rXVPLHXipfB4h/XIDa
	iJxWxvqrqEIzSwv/9dJn9X7LeTEB+x9N38jNn1w==
X-Google-Smtp-Source: AGHT+IEQgikhsrsUYBnaJMpD1uGbxEZ77OxlR6yJ2c4VtevK8CwBEfxhj58UbW9AHXXHwN+zwIK7XfHdcV5UtsKrn0U=
X-Received: by 2002:a17:906:a455:b0:a5b:53e2:519e with SMTP id
 a640c23a62f3a-a62642ea4f9mr995846166b.26.1716985753806; Wed, 29 May 2024
 05:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com> <ZlZurXUUUfXHZJaX@andrea>
In-Reply-To: <ZlZurXUUUfXHZJaX@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:29:02 +0200
Message-ID: <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
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

On Wed, May 29, 2024 at 1:54=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > +zabha:                                                                =
       \
> > +     __asm__ __volatile__ (                                          \
> > +             prepend                                                 \
> > +             "       amocas" cas_sfx " %0, %z2, %1\n"                \
> > +             append                                                  \
> > +             : "+&r" (r), "+A" (*(p))                                \
> > +             : "rJ" (n)                                              \
> > +             : "memory");                                            \
>
> Couldn't a platform have Zabha but not have Zacas?  I don't see how this
> asm goto could work in such case, what am I missing?

Zabha amocas.[b|h] instructions are only implemented if Zacas is
present, as the specification states: "If Zacas [2] extension is also
implemented, Zabha further provides the AMOCAS.[B|H] instructions."

But the code you mention is only for 8 and 16bit operations, so I
think we are good anyway?

Thanks,

Alex

>
>   Andrea

