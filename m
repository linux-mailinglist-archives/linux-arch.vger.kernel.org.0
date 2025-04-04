Return-Path: <linux-arch+bounces-11280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC7A7BBA4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D00177DC1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171481DDC37;
	Fri,  4 Apr 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuFVzkfU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0010146588
	for <linux-arch@vger.kernel.org>; Fri,  4 Apr 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766564; cv=none; b=oOzYQAUoIHAPSp9OpBhOWYOpuPWuDMWdWzpsWJAt2+1iM+Wv6L0gbEtmMGtTlXcgXOaQZDk04VieX2Uh3Cdvss1YWINNFlglhyCWcek1HfiN5P9ICXjDIJIkM9JYbds76NOsiwp73wbMx+teZNz7mIWN+KRs+retgx9K6NTQBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766564; c=relaxed/simple;
	bh=VESalJP7ZL+nitnbDAWdGop/8vGDiwf3xv7DdkO+lzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2uEo2eqI3L1fhAAvgjp8lQDWQGmUSThF2dqXG8vhg1dec+JU+B9R17sKt9BqANlbTQjCafzJtU+rmlJMVa0j/7iR4cXRb3tby9rpZjfaqSgeMD3tCJvRDys7ISuyU2oZzdEVM09gQpPU3NggEEL+Qcl+GBd8OnHu9LbMxKQm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuFVzkfU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so170675ad.0
        for <linux-arch@vger.kernel.org>; Fri, 04 Apr 2025 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743766561; x=1744371361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eyajWB+7jjTPaaR8yZhZbdWh1p1RlxmUfHflZtAUUo=;
        b=FuFVzkfU6eCjMIEy36mpxT8o9gZKNIbRrU6B9ocGx6NWQ2kyiSkK6jvwe4Sighe3Pd
         6qRPtxhi4eMqttxm6KN4DpHKIVAfulME0zOHr8QpabRl+YAIzqBWFatOyXqoopuaBdZy
         3riJpo0eCscZzooxmGV+gUshQYnSTaEb6RWTdQ6D7rqpozNIlSAaIR8E6GIRvmp5czD4
         8grbupVpqsa8fInPzQwJUuN1BkeP5znju0zX82YyGFTDo2SVcn6N+T4KVav81ggMJrTz
         COHiLea5vl1ai7D3HkSvXFus/nMW6FxbXc/L3ptgc/0XwCOFn3S6gt0M5ExVBBBiE7cR
         BhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743766561; x=1744371361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eyajWB+7jjTPaaR8yZhZbdWh1p1RlxmUfHflZtAUUo=;
        b=PCRpnTJs6mbBCuSoyJlnuiQhEJ6GVUGTd3HkLpfbbOqzTpuKLWFl7PCx9LfSiEOWvM
         1UtU7iFI8gDb+9o3j+8ap+IfI5STpXrWELsKvDCeDqQdcZ9ct99gSjzlX/JatjOEvhpg
         wa0uJ30gzYU96p0MmI9QC3KDc6x75tNnHJMG/E53F+xGpaRexQBV23GY4hoD3eyyjIg+
         zb3+G89AgR54ayPUoyH/F0zxvCqiutx/F6BFD9qBMI8OmOOwxA/JY/BrWeNe2tYIkGyb
         pd3yetmlcOzl4RBI2mpCI0X+dNWFIpoUW0a8yKFP8JRjK4Nk0jYaviQCS1r1CRsjbReC
         HHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIh12wdJyIKdMWYBN8npseiB/nRUuTfHPZKpSs6e+jOg+GKOlX3wQJJZnOw6ZRPUTYqSAc07AIvOZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyejok/4Hr96fnAVooZM+YKIvNvK3WAC/nCIsz2vGhm4c5Q1TYT
	uLIhkImhaaZxuJ9r6oVS3Hwe4NcC1w6yHSvy1h3Z7W2iyOyOmJBzo9igKFb+aT5ZonQmAe4pdBb
	ISkqoL7LshwqkYmTmElp4NOLn0PbuICbEQFN0
X-Gm-Gg: ASbGncvnMsKF8PMTPl9/biujdJpbi/yLsr9vdnW76+x+8+K/U1Oz4E/RrRPRHwXa6cb
	urXkxQ2HnLx67n+WHrv/oTCDzp1UrJOmWR1GZM881OYEu/Igyt9pcEesNMWCLHf+ssodK4kUDd+
	me8l6otBB+KOOpnpC75tdwbJuLdjo=
X-Google-Smtp-Source: AGHT+IED3d7Nee0RkFeQ/TfMnvqofVxnmkzP6wrLXFrYkWR2UjtCec6EbIVzIf0i4xh5ml+5Sm4+57ZZZARaNgNjLIY=
X-Received: by 2002:a17:903:1cb:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-22a89eabbecmr2670415ad.10.1743766560729; Fri, 04 Apr 2025
 04:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com> <20250403165702.396388-4-irogers@google.com>
 <48a734d3-0920-402c-afab-f4f205cd6b0d@app.fastmail.com>
In-Reply-To: <48a734d3-0920-402c-afab-f4f205cd6b0d@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Apr 2025 04:35:49 -0700
X-Gm-Features: AQ5f1JpD8IxezKIMQJr341eabN5TwcT9DjE5US16IXc1hwT1GroRon_SXxjDvaQ
Message-ID: <CAP-5=fUB=UWcrX4JJg5skJ30_mQTy4TwWVU-=g99WSjTg67Eig@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] bitops: Silence a clang -Wshorten-64-to-32 warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Apr 3, 2025, at 18:57, Ian Rogers wrote:
> > The clang warning -Wshorten-64-to-32 can be useful to catch
> > inadvertent truncation. In some instances this truncation can lead to
> > changing the sign of a result, for example, truncation to return an
> > int to fit a sort routine. Silence the warning by making the implicit
> > truncation explicit.
>
> The fls64() function only seems to deal with unsigned values, so
> I don't see how it would change the sign.

You are right. I was trying to motivate in the message why building
with -Wshorten-64-to-32 is a good thing, and in this case we're making
an implicit cast explicit.

> > diff --git a/include/asm-generic/bitops/fls64.h
> > b/include/asm-generic/bitops/fls64.h
> > index 866f2b2304ff..9ad3ff12f454 100644
> > --- a/include/asm-generic/bitops/fls64.h
> > +++ b/include/asm-generic/bitops/fls64.h
> > @@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
> >       __u32 h =3D x >> 32;
> >       if (h)
> >               return fls(h) + 32;
> > -     return fls(x);
> > +     return fls((__u32)x);
> >  }
>
> Maybe this would be clearer with an explicit upper_32_bits()/
> lower_32_bits() instead of the cast and the shift?

It feels a little overkill to me, but if others prefer it then it is a
minor change.

Thanks,
Ian

>       Arnd

