Return-Path: <linux-arch+bounces-11146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7EA720B6
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C373BB51E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CC25EFAE;
	Wed, 26 Mar 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpNCyLAu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC723AE79
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024116; cv=none; b=YXjqU0/dfTYy8kU3KCisHe4Gj+/ZlZlJGJmDKh56SKyvvZFh5YqPKj9s23SraVo4lsHNAf/b1qmnluQl7m5FKGoA93aYi8LDz7HwkaaB3+4/1h6bbBBmUKSSYTOEIOw8d95P33IvFwV/VUGNRDr8sGZ0YlxXWLFkwKMbpx4YgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024116; c=relaxed/simple;
	bh=P6V9ol/irj61zvGkj49jPh2uWIAWA/KyBPVCWmTBZC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpzux2oFFsSR4iaiPfmegxwq+gydjQ0c6BiNRywVqE3NJJhSQgZUre4zkRWgxzJNgEkOA+n4T3DtwBWYWX04Nw0uCnq3fMJn3niNJ9lBd32DUGxvXXq07CTYs8gZ+GR/4jfMFLPgMLonHlvfqRZZogSIfJtV2j9UAI+FmnL3c4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpNCyLAu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so1277a12.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743024113; x=1743628913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMIaxzdKd25j5BobKFtyp9BpbbkbtzKIEHTHbqVE8I=;
        b=KpNCyLAuF95VLGzdkKDKEvlMDsW6LLf21KmfH2CCLO4EFh9TgXapMF78JmSgjWR3wm
         CxR9tQ0/DfytuDN+3Am5WmjySI1DbNuDQ6iYxQaLbbtVSBS+hgYLM3nEjle2so4JBTMP
         HoGBKrf8riD5vKJafwMZzxm/HN2kCtBX2zjypMdtbN77PGuyFJG8cQ+TAGOXWw2IxrKE
         qmIX7N7MKQWP7c5HiV566cdSZ8p2LrJCrUS0VCuWlW7zW5vV+4nq25/cKZWDcb15NDjz
         T66HbOHZhwyEJx3azG6DIakjZd3+kb70rJLMc3Z7Eq9PHBykbJkZRPFckqtWNfWzuHX5
         PcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743024113; x=1743628913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMIaxzdKd25j5BobKFtyp9BpbbkbtzKIEHTHbqVE8I=;
        b=UaITgfeT8bZ8BF9B46BzpMJfOTele5HZXo1lvvmld6cQmWxJXLPqIJvhIOf3Bv3+JY
         sJH8pMuPQ9ZwaDygRskuyugPENuAr0bBqS+9AYkwTNUsT1o9Yk8i2FdD0oo6qFGlCVyw
         FVCboz82CboaAdgGNgYpu9QcCFrRMJdxeNDUg3Q7cE2OE/WhGzeChYDMR+WTeOO3uwsN
         Sp9PthruG/R2uxV/H861Lxd1J1CYIUmkWHE5vC1Dpg2mAE+mg5Waf3zKFZ6WEeMza41U
         V8iGFR1C/EAIKHTIsskNOvdej+tUD8mA//dhhelWH3q/7kBgGePOml4m/HThrkoNfZvj
         nctw==
X-Forwarded-Encrypted: i=1; AJvYcCVDRpxZvXKAxSm4xRV5lsO7NkQ4HzbEL15jVJcyjRZOlO0C9V9tvcx2lojCZUsvTEe+vuHXeS/xhwki@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+z2GCXFrX2JA7bGDgAsVlXvxzfN2dS23CXvAwoOR1j9398/k
	S1ByZtjDC5Iyc4E6Auln80NXgaxSN0/ORO9V+A7aUGCJM68m1xKsVX+uRw+afsP1Thk0lgce0xb
	LcewGs30eKmuav/2BXSk3r9DlDbk9FsAcg4FK
X-Gm-Gg: ASbGnctTNJNWBPq4APBCs7WafhIrsGBSl3TVOhISfS79Nl1+jLFV9vMGHWWZqbySlFu
	35hT9h7UDDgqi8p+HRhpp/SFKzTXwZB7IxVavRAM6iMKkYkD6kQijT6yX9vSK2/kH7keUIisu/s
	UzjYQW3wTTorUAUwNnmembYC/wXujFg6jErMQECfKG06RHxpxGP6eifuU=
X-Google-Smtp-Source: AGHT+IE8kzG9HOPQV9zW2XiAapRcWyf13sKtcWkvsQE8PgKGtGYn8uvp97F8cRQncQNiapCuYJZbMoC+j+wiotiTmdU=
X-Received: by 2002:aa7:d688:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5edaa299a33mr12983a12.2.1743024112866; Wed, 26 Mar 2025
 14:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
 <20250326203926.GA10484@ax162> <CAG48ez05PsJ3-JUBUMrM=zd5aMJ_ZQT4mhavgnCbXTYvxFPOhQ@mail.gmail.com>
In-Reply-To: <CAG48ez05PsJ3-JUBUMrM=zd5aMJ_ZQT4mhavgnCbXTYvxFPOhQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 22:21:16 +0100
X-Gm-Features: AQ5f1JquhTVerEmqgNAhgQCsPngLTzI4uGjqymw9DsbgV3pWRPJXXIrAKOz8bcU
Message-ID: <CAG48ez3uh48VZCVO3JD3uv9k5kZBHahr3dAita4hkHsLqyyA9w@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:44=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Wed, Mar 26, 2025 at 9:39=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> > On Tue, Mar 25, 2025 at 05:01:34PM +0100, Jann Horn wrote:
> > > Also, since this read can be racy by design, we should technically do
> > > READ_ONCE(), so add that.
> > >
> > > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrast=
ructure")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > ...
> > > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonc=
e.h
> > > index 8d0a6280e982..e9f2b84d2338 100644
> > > --- a/include/asm-generic/rwonce.h
> > > +++ b/include/asm-generic/rwonce.h
> > > @@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void=
 *addr)
> > >       (typeof(x))__read_once_word_nocheck(&(x));                     =
 \
> > >  })
> > >
> > > -static __no_kasan_or_inline
> > > +static __no_sanitize_or_inline
> > >  unsigned long read_word_at_a_time(const void *addr)
> > >  {
> > > +     /* open-coded instrument_read(addr, 1) */
> > >       kasan_check_read(addr, 1);
> > > -     return *(unsigned long *)addr;
> > > +     kcsan_check_read(addr, 1);
> > > +
> > > +     return READ_ONCE(*(unsigned long *)addr);
> >
> > I bisected a boot hang that I see on arm64 with LTO enabled to this
> > change as commit ece69af2ede1 ("rwonce: handle KCSAN like KASAN in
> > read_word_at_a_time()") in -next. With LTO, READ_ONCE() gets upgraded t=
o
> > ldar / ldapr, which requires an aligned address to access, but
> > read_word_at_a_time() can be called with an unaligned address. I
> > confirmed this should be the root cause by removing the READ_ONCE()
> > added above or removing the selects of DCACHE_WORD_ACCESS and
> > HAVE_EFFICIENT_UNALIGNED_ACCESS in arch/arm64/Kconfig, which avoids
> > the crash.
>
> Oh, bleeeh. Thanks for figuring that out. I guess that means we should
> remove that READ_ONCE() again to un-break the build. I'll send a patch
> in a bit...

I sent a patch at
<https://lore.kernel.org/all/20250326-rwaat-fix-v1-1-600f411eaf23@google.co=
m/>.

