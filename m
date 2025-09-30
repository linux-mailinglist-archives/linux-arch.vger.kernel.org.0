Return-Path: <linux-arch+bounces-13805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD0BABDDD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3791882512
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75B220F34;
	Tue, 30 Sep 2025 07:41:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AABF4F1
	for <linux-arch@vger.kernel.org>; Tue, 30 Sep 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218102; cv=none; b=fbQLjQ4/S5eH4lfRKtmKcgEo3xbbs454HVL4RAfpuL3gsfhfaFldDTmGIUPViswUZh5I/RVlZQCkYL/aVdwPhitcNQ4qjyofkVh1Lgdi6Y1ZN942IiB8AnmUX56RCwY9vvTnIy2/mZf1NfqNXZtYgbMhezMAwuHpqPHx5tT9tTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218102; c=relaxed/simple;
	bh=fTwHavaF1SCVZfuafGtVN+0vomY8dJ9l2Z2f28ZmrAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO9yOLxkRueHGiSyBilG+oPSjP/TGpQBYb3FZ6ZZCUbo0YombhlRSSXyU1fH087TG4nNpt4WpOXgnv9fXgnys0bvZ/o/Eh4UpMkK1giE8MvC6UsrUcXMs/p5Di/90S1IuJjtFX7mK7JeYutqfVcXUrqjEEgNX2SnwqtZLMb3dOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso3637126241.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Sep 2025 00:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218099; x=1759822899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+5g3R4BFoKeU12X4z++S/cR17tgT9XO68T2ERc1SG0=;
        b=F44s1ZoP1JAmEMQN3Kn1UH2ZnuiGnpQQo5/iA0UNEQSM/GUwwqJq/bV+EV0/hg3Mwz
         HVfLPPifOWjmQ31GU2T4rMPLiEIbUR9VQt7XomjXWUUzwuR0Cv4q9Ebz0h+w9ykKkibp
         ldhtTFmBP3Gv6msPnAoslo4sP00ws7MrwRsBOs/kTXpegVP67JCC0OqtpdqEZDZolfNj
         ppY5nR3+z6ioZs3Pt/nRx5CfL66Lcs++FPS+XPrT9sWU6fSMfZSXlJpTrFuCBQ+WwhNU
         sXq1o6qSoBhRvI8aYRoGoQUBPwtxLiSlEaEnnSyL3qq1A1qLedtNAcKKhLy0pysch/lO
         VuOA==
X-Forwarded-Encrypted: i=1; AJvYcCWDnKAW0nzrFUfgYvieUx7x/CiNvMq0Ow0kJCPua97dKXZ+erLZtqKpobevRwt6HgEPKdtJC19ZuMny@vger.kernel.org
X-Gm-Message-State: AOJu0YxEraNFhUJrFqMjAwU3sLcpilNKAWdxgvEZDWceL6Rkx/++OigV
	21RrID2W+oVhX3O47G+uRnn7M10wIJfyZ+r912zP9G/pAdR8TS41X2TnH9IjnX8p
X-Gm-Gg: ASbGncuitlHR+yyvhK5GVNr2o5NZZcaIomq0JsTO+bBywo6zl+kx38IiUt6ALdXni+X
	K6R19IYUmhJrdAIemHVhB5dVsd27/bUyjsKz2QfZa3j1Ydz9UMk2qj8M+LiBQTXV3B/LpiNSroq
	BiNbyX6pBLkyY1if6iN0tXBGmDMktKTLe0qvWA1wEWCHrmesY70pXw8DaNCDqjThd7i5s3bqPMm
	e4bm6nRcvYIlI1GjH3rsupkiZBkACRV7n4RnbTpX5i/PYnPHVi6rB7eTres7ON+ffUS1gxCtFs3
	NAcd5zbdMGcmKrVkCEl97PJk3s8RAFctzZOfcoO1nfrCxAr59sHPmrot1tFJ/w/GNfw6Ip/4aYS
	9CxG8HuGZftPn9UtLXZrtAQmcSWlivQcj1ulkmbKCf1/FBB6Oqik3FCpWAPVeIUp+hedJ0L0BqP
	pNarONZt9j
X-Google-Smtp-Source: AGHT+IEMEM09/S/MsLVW89ozaMU//1XgsSflVXKUFtBYbb0q2qFdSn7t1HXWYBs4dC7gEnMt6SgeAg==
X-Received: by 2002:a05:6102:41a3:b0:519:534a:6c50 with SMTP id ada2fe7eead31-5acd4350499mr8641171137.34.1759218098922;
        Tue, 30 Sep 2025 00:41:38 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3b700a82sm4174118137.17.2025.09.30.00.41.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:41:38 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso6292642137.2
        for <linux-arch@vger.kernel.org>; Tue, 30 Sep 2025 00:41:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2CzMpXgcZRqu1NWaS/BFKSwF2FB1Wad2XiqeSwMyMzYyegJ45T7dCTDxN+yb4pVWghzRJV6FD5lHt@vger.kernel.org
X-Received: by 2002:a05:6102:50a0:b0:59c:93df:4fe with SMTP id
 ada2fe7eead31-5acc8e96fdfmr7499750137.9.1759218097979; Tue, 30 Sep 2025
 00:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org> <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
In-Reply-To: <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 09:41:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
X-Gm-Features: AS18NWAfx6HdJiP6HG3pvvDkgqXmfVsm3y8cTCSy1KPMOu0E9WrRTl3w7eUQ96A
Message-ID: <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 30 Sept 2025 at 04:18, Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 23 Sep 2025, I wrote:
> > ... there's still some kmem cache or other allocator somewhere that has
> > produced some misaligned path and dentry structures. So we get
> > misaligned atomics somewhere in the VFS and TTY layers. I was unable to
> > find those allocations.
>
> It turned out that the problem wasn't dynamic allocations, it was a local
> variable in the core locking code (kernel/locking/rwsem.c): a misaligned
> long used with an atomic operation (cmpxchg). To get natural alignment for
> 64-bit quantities, I had to align other local variables as well, such as
> the one in ktime_get_real_ts64_mg() that's used with
> atomic64_try_cmpxchg(). The atomic_t branch in my github repo has the
> patches I wrote for that.

So cmpxchg() and friends should not take a volatile void *, but (new)
properly-aligned types, using the new _Generic()?

> To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit
> atomic operations, for my small m68k .config, it was also necesary to
> increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a

Probably ARCH_SLAB_MINALIGN should be 4 on m68k.  Somehow I thought
that was already the case, but it is __alignof__(unsigned long long) = 2.

> ARCH_SLAB_MINALIGN increase, as that wastes memory. I think it might be
> more useful to limit the alignment test for CONFIG_DEBUG_ATOMIC, as
> follows.

Did you check what would be the actual impact of increasing it to 4 or 8?

> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -68,7 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
>  {
>         kasan_check_read(v, size);
>         kcsan_check_atomic_read(v, size);
> -       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
> +       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));

I'd make that an arch-overridable define instead of hardcoded 3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

