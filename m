Return-Path: <linux-arch+bounces-11143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB24A7201A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493F5169F29
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1601F8901;
	Wed, 26 Mar 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d260P5wQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E21EA7F3
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021931; cv=none; b=EMq0y2GvnF915upx3He71pA08e45tpum1cM2elmyfUrd2IMQyLNq30/dlI73bPiGLGB5wSiHctpRS8rAzIkMhs4agvM3KWMeqimXCGMNtxRNO/DH6fz3aC4gR1LZB5TYTjZDCIXsqUSQPEInL42jzeb5TbvUfv0rITTZc+BFGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021931; c=relaxed/simple;
	bh=bpCz5P/IGbW1PJcmJdHsh0Ct4MpaP9/+sfxMG+ksfRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6bqL7B4fxtW28Dz1Nvan7bKffbz6j3U+TzU9q5TTtcJHUyjseGMIg22CDo+aCbS9u8G2llH0L5GPCwzcgzQbVa4/1rF4myOQpTBP4sCeK7BZZgZGAHh+wO/7CQ1pwOwjY0VQ0fxyroaH0+eMhyI8Aquh6I+xhyCEAL/OjXHEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d260P5wQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so959a12.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743021928; x=1743626728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ktHXesu2kfcG5Dhn1yOjglQsPkU7kg2rXgHib344o=;
        b=d260P5wQHa/fWoX2/Be/iIY26P6GR057Kcg30KMVLYimA1hO/x3R6+Hj+qQUzk9zMX
         pW0WmUCp+AbAT9E1/4urY+RdJ+Ioyt+QQmTFu89IdPvkIlkS43XmbJU1ogNI3YMmHjiO
         ClaYwxCLeRVczjyU60Yxay65rIDTgngXgFxSakI/Xz8CZTwvI0Reu4gLXwKe5bh3BhNI
         6oh6Xcm1cp8vqOxh+xPtzJ9trtgNWtS+Wx1Abm7o8MfB9QwH5KEcDG7yFfjXe010u6vw
         nCAg9ZrK4mru/A8eR7OIyTpFqw1DKhK7laJKv8RUqGqTA06aMWR50uWljALxTMKM35Sj
         bH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021928; x=1743626728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7ktHXesu2kfcG5Dhn1yOjglQsPkU7kg2rXgHib344o=;
        b=M5WQYuKQ7owvJal7hKm47iStAj7O7pc4oc0D212iemgR099xaxNRonPBV2gLQ4pzcu
         EocyAlrql7X3TvFG9LZxmKJ7kcOfbwcYchDwjFRpgR24tbcarXFzSJNHU1Lj7iPKPT0J
         vWI5n+v27/ZlevDe00+Ly0rxN2YgG3GJkmprYFMCKRETDr2+Ns3XJU6SA2JrdUeLibBA
         XBT8IHySsS2LWhWBQjQcJ5szeOE2e7r0Di/0y7dZfV5+TlcV9yyhmahDXRnJzSJa9/Qy
         jWjRTHkzKs5l11Sf6Bs06OoUe+lSxtbGC7ZyUE3F7Dqa+NEdyQw3+F8zAIZEFlretnw/
         dVVg==
X-Forwarded-Encrypted: i=1; AJvYcCVBCF31PEwDOAs5T1cq0DpRpRRFO1/fd7O98L0ZY2rTNClcbhfIKWXTn5X0wnKDg6ZeC32FX9+MnDnQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQj/RJw/z3OMx77DaA/qcFCIlcbvH9rfau1jFd0CvtH6zpGtd
	bNl9Gic9ocR4x8JucwCFW//S2urBpbvudREIVOhLyqMd/TqjEwLhSUQoCoAM+xw0yydOt7fHUID
	m1aa2btsd5x1KUZhnLNvaYmeqKXlaIAsmdQkV
X-Gm-Gg: ASbGncu5lhx4YXVec6GUupQFDVhlG6VmrbM6wMN5LsZWBHldKWlBttX3KhB7m1BjPCu
	iDdKsCPVQ3lJUzOGzFnaTr9jMhixO/pcY/QcQ2rmapw64rKOXiD99yBr8QkOrBGyyKIAepHCMof
	TvOUe2UE/VT+6dZXekiBgu9BhfLcalQZfnaxbGbyBydslUdOaB0ZOu1KE=
X-Google-Smtp-Source: AGHT+IHwrjgZpcRulsDKiR6zDY29alu/eb5flZ9dkCDaZWzF1ZfCyNNDZdRtJ2/5IMq9El6tbI6vFM9Cu7fmz6kLVF4=
X-Received: by 2002:aa7:db89:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5edaad0f6d7mr5611a12.4.1743021927533; Wed, 26 Mar 2025 13:45:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com> <20250326203926.GA10484@ax162>
In-Reply-To: <20250326203926.GA10484@ax162>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 21:44:50 +0100
X-Gm-Features: AQ5f1JrP1Q2mctLjPTyd7EAIrLTDiLFwqKWpzfLsUtx5LAsqHO0kWByN0mYn4cM
Message-ID: <CAG48ez05PsJ3-JUBUMrM=zd5aMJ_ZQT4mhavgnCbXTYvxFPOhQ@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:39=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Tue, Mar 25, 2025 at 05:01:34PM +0100, Jann Horn wrote:
> > Also, since this read can be racy by design, we should technically do
> > READ_ONCE(), so add that.
> >
> > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastru=
cture")
> > Signed-off-by: Jann Horn <jannh@google.com>
> ...
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.=
h
> > index 8d0a6280e982..e9f2b84d2338 100644
> > --- a/include/asm-generic/rwonce.h
> > +++ b/include/asm-generic/rwonce.h
> > @@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void *=
addr)
> >       (typeof(x))__read_once_word_nocheck(&(x));                      \
> >  })
> >
> > -static __no_kasan_or_inline
> > +static __no_sanitize_or_inline
> >  unsigned long read_word_at_a_time(const void *addr)
> >  {
> > +     /* open-coded instrument_read(addr, 1) */
> >       kasan_check_read(addr, 1);
> > -     return *(unsigned long *)addr;
> > +     kcsan_check_read(addr, 1);
> > +
> > +     return READ_ONCE(*(unsigned long *)addr);
>
> I bisected a boot hang that I see on arm64 with LTO enabled to this
> change as commit ece69af2ede1 ("rwonce: handle KCSAN like KASAN in
> read_word_at_a_time()") in -next. With LTO, READ_ONCE() gets upgraded to
> ldar / ldapr, which requires an aligned address to access, but
> read_word_at_a_time() can be called with an unaligned address. I
> confirmed this should be the root cause by removing the READ_ONCE()
> added above or removing the selects of DCACHE_WORD_ACCESS and
> HAVE_EFFICIENT_UNALIGNED_ACCESS in arch/arm64/Kconfig, which avoids
> the crash.

Oh, bleeeh. Thanks for figuring that out. I guess that means we should
remove that READ_ONCE() again to un-break the build. I'll send a patch
in a bit...

