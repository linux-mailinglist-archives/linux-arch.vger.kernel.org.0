Return-Path: <linux-arch+bounces-1289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE382646F
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jan 2024 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A594F1F21593
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jan 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59602134B3;
	Sun,  7 Jan 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGpcLuBm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5A134A4;
	Sun,  7 Jan 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f3da7ba2bfso9208117b3.3;
        Sun, 07 Jan 2024 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704636358; x=1705241158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At4cppVUZPK/oi+d0/WXlrlbXmfl3AdgViIm5bbQigc=;
        b=jGpcLuBmfTRUoDV2bgeNh7eJwF5tig2ZRkIqb1zwoHF+mdU2Xe/jkVwFKPttw/xX+9
         9ITWoNtkMrZpp2xC03uOnSF/r7pBXPCHAh91HLuhTKLeRpUmuPOhmHZHZ/K5QLbj/EEM
         6AhtSYJ43cMZ9BDqmVR4hY0W0DKUkOqHUO0e8IEyG2gBj0px+Yt8pdeZiPadW9HNRiPv
         6vlCG/Pjr3k+rwYB5iB2adIss0AkfjASRVLGOrQ7ksxeB/jwdsvTU2KxT9xwjO7bdil6
         aspzIgEkyUpdAUM/KRS3Q6MMQQ6uxADgz2SX5Cedg9NZul5uSR8XSGBz2mE5z0Lkbur1
         yKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704636358; x=1705241158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At4cppVUZPK/oi+d0/WXlrlbXmfl3AdgViIm5bbQigc=;
        b=OHloTgHGrElxX87fr4gzPQ85D1850havrc8zgSGMiYSSX/gPG/RkPzjt6lhzwnWg3W
         2wnK/azNtQyFCaQfEt3LC+PIJbn8ZS60t48guj88RpGgmtMXZLLQTSl/w5f9Zq1Xdea7
         jIr6jjY0Av+svyKx30F4I+1mjBeUkoSmKKAQ4cscD8pn+bEth3bWYI+VLTgDaE2cmeGs
         nuJRwuZHX27BqgCkJvQt+kD0ZeW6SAaUw1bsKhOYGAZlXZZ9rS7qtbC9Sk+uYJFlzh2l
         t1VMzzPGI1MoxHT6YN4S2PFHDBIUgDOFLl+5+g5wSPT3FWOU1X2I6J6Vx/OU0QUUVH7w
         jQNw==
X-Gm-Message-State: AOJu0YzINCwhUWBJpwOvkboEG856bAM3RgLStf8qjqhjjNeerQ3a9YTd
	EAhwAq4oBfK3QMuPV54T9KtOvISjo3fUTZWFocY=
X-Google-Smtp-Source: AGHT+IHHU9hNBXjpC0cTM3U5+wNHBJNsvalMHS1eOBVG8i/atRPxH3yByQ9QrY9bFvkGCWgT49AAnMDYHWqyZ1cQd4s=
X-Received: by 2002:a81:82c6:0:b0:5ed:7d36:7963 with SMTP id
 s189-20020a8182c6000000b005ed7d367963mr2115024ywf.6.1704636357761; Sun, 07
 Jan 2024 06:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228122411.3189-1-maimon.sagi@gmail.com> <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com> <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>
In-Reply-To: <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 7 Jan 2024 16:05:46 +0200
Message-ID: <CAMuE1bFQzc4u0X_z7sXyeAn2c4vLPHHJ8aeqC8uYmo2nJpC0wQ@mail.gmail.com>
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Cochran <richardcochran@gmail.com>, Andy Lutomirski <luto@kernel.org>, datglx@linutronix.de, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Kees Cook <keescook@chromium.org>, 
	Alexey Gladkov <legion@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 1:30=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Dec 31, 2023, at 17:00, Sagi Maimon wrote:
> > On Fri, Dec 29, 2023 at 5:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>
> >> > +struct __ptp_multi_clock_get {
> >> > +     unsigned int n_clocks; /* Desired number of clocks. */
> >> > +     unsigned int n_samples; /* Desired number of measurements per =
clock. */
> >> > +     clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock ID=
s */
> >> > +     /*
> >> > +      * Array of list of n_clocks clocks time samples n_samples tim=
es.
> >> > +      */
> >> > +     struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_=
MAX_CLOCKS];
> >> > +};
> >>
> >> The fixed size arrays here seem to be an unnecessary limitation,
> >> both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are small
> >> enough that one can come up with scenarios where you would want
> >> a higher number, but at the same time the structure is already
> >> 808 bytes long, which is more than you'd normally want to put
> >> on the kernel stack, and which may take a significant time to
> >> copy to and from userspace.
> >>
> >> Since n_clocks and n_samples are always inputs to the syscall,
> >> you can just pass them as register arguments and use a dynamically
> >> sized array instead.
> >>
> > Both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are enough of any
> > usage we can think of,
> > But I think you are right, it is better to use a dynamically sized
> > array for future use, plus to use less stack memory.
> > On patch v4 a dynamically sized array will be used .
> > I leaving both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS but
> > increasing their values, since there should be some limitation.
>
> I think having an implementation specific limit in the kernel is
> fine, but it would be nice to hardcode that limit in the API.
>
> If both clkidarr[] and ts[] are passed as pointer arguments
> in registers, they can be arbitrarily long in the API and
> still have a documented maximum that we can extend in the
> future without changing the interface.
>
> >> It's not clear to me what you gain from having the n_samples
> >> argument over just calling the syscall repeatedly. Does
> >> this offer a benefit for accuracy or is this just meant to
> >> avoid syscall overhead.
> > It is mainly to avoid syscall overhead which also slightly
> > improve the accuracy.
>
> This is not a big deal as far as I'm concerned, but it
> would be nice to back this up with some numbers if you
> think it's worthwhile, as my impression is that the effect
> is barely measurable: my guess would be that the syscall
> overhead is always much less than the cost for the hardware
> access.
>
> >> On the other hand, this will still give less accuracy than the
> >> getcrosststamp() callback with ioctl(PTP_SYS_OFFSET_PRECISE),
> >> so either the last bit of accuracy isn't all that important,
> >> or you need to refine the interface to actually be an
> >> improvement over the chardev.
> >>
> > I don't understand this comment, please explain.
> > The ioctl(PTP_SYS_OFFSET_PRECISE) is one specific case that can be
> > done by multi_clock_gettime syscall (which cover many more cases)
> > Plus the ioctl(PTP_SYS_OFFSET_PRECISE) works only on drivers that
> > support this feature.
>
> My point here is that on drivers that do support
> PTP_SYS_OFFSET_PRECISE, the extra accuracy should be maintained
> by the new interface, ideally in a way that does not have any
> other downsides.
>
> I think Andy's suggestion of exposing time offsets instead
> of absolute times would actually achieve that: If the
> interface is changed to return the offset against
> CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW or CLOCK_BOOTTIME
> (not sure what is best here), then the new syscall can use
> getcrosststamp() where supported for the best results or
> fall back to gettimex64() or gettime64() otherwise to
> provide a consistent user interface.
>
> Returning an offset would also allow easily calculating an
> average over multiple calls in the kernel, instead of
> returning a two-dimensional array.
>
PTP_SYS_OFFSET_PRECISE returns the systime and PHC time and not offset.
But you are right , in the next patch I will use this IOCTL .

>     Arnd

