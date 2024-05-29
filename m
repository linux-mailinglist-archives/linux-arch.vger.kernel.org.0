Return-Path: <linux-arch+bounces-4574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF88D3067
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EC828E1C0
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C7168C24;
	Wed, 29 May 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gDaCxHnY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE6168C18
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969869; cv=none; b=ZF/I6QusAfjb4MpZsqU1HvfIWz+GSU/gB70z7Q3m5btEXoDgngcOL6H+1u/5XVPnM9ojDEzK4CIYnWkNDvXasj3i3pDv5EzmHweQjdmPgEh+BNX/caJU3HT3tchHEsQHzSh7AsORxBGD9/WD+mdvFv+7PUw9gijqLimRLHW7/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969869; c=relaxed/simple;
	bh=pft0aWV0nsM4NfbvHg75f+OMYeiKUeGHKGBBrvtxlgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjLp0JWUZfF59ng5gF3JqgNyZZjvwQqX97HsKoAfu+JxJUNidy/dIJSaiFz/xfJjGYXXUX2rFfZg8HC2YMFy2oBg0iIk77AMwvdY5pTszooSHTjJL0LwDUP3N27hIGc1X5uHCowCu+8PFbnU8+ukVGQoybqZpk4j8jHmiR0k6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gDaCxHnY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso114936866b.0
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716969866; x=1717574666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iugICvJDzmJo7xGBPHogMYo6Gg3CJ7ooLOOivaduvyI=;
        b=gDaCxHnYmZS0tm8Ol8dqXsV9KxY5zbTD/Y2jCSfQ7lMLjC94uBPmMMa6rVKfwn53iD
         Cgs4wuotuXpq6DfuEljDV94CsuMBHsmP76PXqu+iPnHhN/Nbw6yEsfeLCt+ibrouGb/0
         pbRFNeTTD+gJ6NpChHHUhYX5JlTkOKKOe/p83Dl9xlKBYTTf2/BVZY1q8ZTRBSBDeXUP
         EOtUHt3o8uyiWWuX3cYv+DCKOK6dxZFidarv1f9RNa5HsUJXKPxlbyX/nR140bkcOhgm
         XArzyOY7YFwN67BfjMo+kXzwmzmZzsIID8PVhWug278JWScwQn0IhjuqWWNKdQTPhfIe
         9HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969866; x=1717574666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iugICvJDzmJo7xGBPHogMYo6Gg3CJ7ooLOOivaduvyI=;
        b=AOhKWs7qprQmrp2Q0XK99s4HB8CJL/MEUMWRqGzcCCPw0iXrHaXeWl5hirRYf5Riz2
         haBiQ2hmKIDBpy9uyau7iB+PRyDseGT5OlfNmwRHXx7N3trp16I0h6DuyAt2pPcPyClD
         kAhB1xEsab46eEuQLRSkhnP5L/sL5a+WPT8tzytgYPyIhCBqHOzpjfkqLrpt9ExY9lb6
         e27OP1G3n/Ojgk4eNAWBvyn3hloIK5leAsMLulg0ot/j4Edu/2T3M4GS9g3bplQ8uHHb
         fHbrK/uVdyJNAQmZRpMXt/gFCcm1M2CZqhFVoNLyUosvTP0E2iLTZ0B5tZds1vg3HjVQ
         qxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDC0bINpVNTkN/Ph3DgK5EBD/lv6HC7ivgBtcainO/mkB7BBFwsHjXK0vC7foPBnEUrvD3HhMMZlRw2Z+x7FfxVwszyQ7nSr2v2Q==
X-Gm-Message-State: AOJu0YwswW+FaHJue6ztEDR/7RwJrfimx37wyQq/HE5ZJg6UvFpAqxmO
	u1riyOOOEB8utVQiTdAvuLuizNDsZM7MSxfuz0YHOdYuvBWCgcFIOceht/05JmbUw1mcKoac3P8
	gF4o+wjKJXrcR57GwXvI6GY9VhqYblCOKVuse9w==
X-Google-Smtp-Source: AGHT+IG6iwinAXXk+z85s+DZ7rCxbual1zF0BnW9/urFx8Jq0vjUfxC8W1lP9e0VTumF0FrEVCZkoP1D8o+mWg7nLg0=
X-Received: by 2002:a17:906:3e4f:b0:a5c:d4b2:6a44 with SMTP id
 a640c23a62f3a-a642d3846f7mr95336266b.16.1716969865779; Wed, 29 May 2024
 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-5-alexghiti@rivosinc.com> <ZlYbupL5XgzgA0MX@andrea>
In-Reply-To: <ZlYbupL5XgzgA0MX@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 10:04:14 +0200
Message-ID: <CAHVXubgBDxyow3-CFwBrkJ7xoAXCv8Tq7nNTAcvbzbA=TAaf5A@mail.gmail.com>
Subject: Re: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
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

Hi Andrea,

On Tue, May 28, 2024 at 8:00=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > -#define __arch_xchg_masked(prepend, append, r, p, n)                 \
> > +#define __arch_xchg_masked(swap_sfx, prepend, append, r, p, n)        =
       \
>
> This actually indicates a problem in the current (aka, no Zabha)
> implementation: without your series, xchg16() gets mapped to
>
>   lr.w     a2,(a3)
>   and      a1,a2,a5
>   or       a1,a1,a4
>   sc.w     a1,a1,(a3)
>   bnez     a1,43c <.L0^B1>
>
> which is clearly wrong... (other "fully-ordered LR/SC sequences"
> instead follow the mapping
>
>   lr.w     a2,(a3)
>   and      a1,a2,a5
>   or       a1,a1,a4
>   sc.w.rl  a1,a1,(a3)
>   bnez     a1,43c <.L0^B1>
>   fence    rw,rw  )
>
> A similar consideration for xchg8().

Ok, I will fix that separately and make it merged in -rc2.

Thanks,

Akex

>
>   Andrea

