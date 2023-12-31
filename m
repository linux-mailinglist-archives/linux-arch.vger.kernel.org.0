Return-Path: <linux-arch+bounces-1216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA3820BE7
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 17:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05FF281E37
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68063CF;
	Sun, 31 Dec 2023 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hznt+wRj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC263A7;
	Sun, 31 Dec 2023 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5cece20f006so71244567b3.3;
        Sun, 31 Dec 2023 08:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704038429; x=1704643229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMuvwD7eiLNXximEfDtwAGnJl1cUQtARzSFBpIb6hOQ=;
        b=hznt+wRjBln7J+3oHZQSnqGMT2uRFyFQN4TSIXvY53aYIu9HEbNz2DnclJ4BOT9eIL
         V6tGbjLMc5cgfiVAnxLGEfeW+u5wUaAnTV6MqNr0Epr5zYjkQvAeDdrd57ef9IB6Fy7U
         dGkeKGE7DI8J3mJekdZHTxvQZyreXmCfbf46cZvy6WkZIal8jXoHdKwcdhPbU9MbeZJt
         eO7DulzAJmcIIOCb5naH2KVvkS4uvBlaXU3eClvM7ruM0QyZYl8kYDuXmZeac2RbByY9
         7GcvTsUscPUhnxUKlBKlVgAwkcsstaey7yTrsTsQeW4w8L90B5FMhUWPT1YWzb6VUX92
         DZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704038429; x=1704643229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMuvwD7eiLNXximEfDtwAGnJl1cUQtARzSFBpIb6hOQ=;
        b=cLi8f4ZCJ3dQNMGRyP5+8StZjmk5S+KM+0O18wCSk0hYmic72uE5OBWFs1/MKAcVci
         bfikOIIPScqH/QazzmA2Ho1gDHkv40qhHFmDz8xmzIIV1MTijtUz36QCSxxt6WtS9Tdu
         YtyE1DjCVEge7J4tZJGcDnMsE8AvYytIDsvQnYUZpptSOMm+GzkhF9wo7Y59d/TdF/5X
         XVmhjC44ipUYZmkd2rdkXmmD8Dl+hd6ISXbzy/fPPQ32L4F5jHnJNHXUpDehHd8s+UyR
         xKgWhmyMg45QHcrpfTKZwDlM33t3JLRUSxwVsR9jJNgDjJLfNhUte/x7un7tDHEMe10s
         1Pvw==
X-Gm-Message-State: AOJu0Yx/BgM1QN1OJZyL+2Myo+ETxV3xtEIFF+1/mtIfFZ6cCg9BrHl8
	ut4Y3H594bME3kS1bbA21vYBop3bMNdZRZL4A04=
X-Google-Smtp-Source: AGHT+IFrWbbm+rynYKZoZFWyxavZmC2e3w8maDU/mRrBHbbvn+UloqCC/B9NjquC2jk1wcJVYqVoGau8iy9SdEyBBug=
X-Received: by 2002:a0d:d5ca:0:b0:5e8:4e1d:2f03 with SMTP id
 x193-20020a0dd5ca000000b005e84e1d2f03mr9051612ywd.52.1704038428946; Sun, 31
 Dec 2023 08:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228122411.3189-1-maimon.sagi@gmail.com> <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
In-Reply-To: <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 31 Dec 2023 18:00:17 +0200
Message-ID: <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
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

On Fri, Dec 29, 2023 at 5:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Dec 28, 2023, at 13:24, Sagi Maimon wrote:
> > Some user space applications need to read some clocks.
> > Each read requires moving from user space to kernel space.
> > The syscall overhead causes unpredictable delay between N clocks reads
> > Removing this delay causes better synchronization between N clocks.
> >
> > Introduce a new system call multi_clock_gettime, which can be used to m=
easure
> > the offset between multiple clocks, from variety of types: PHC, virtual=
 PHC
> > and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> > The offset includes the total time that the driver needs to read the cl=
ock
> > timestamp.
> >
> > New system call allows the reading of a list of clocks - up to PTP_MAX_=
CLOCKS.
> > Supported clocks IDs: PHC, virtual PHC and various system clocks.
> > Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> > The system call returns n_clocks timestamps for each measurement:
> > - clock 0 timestamp
> > - ...
> > - clock n timestamp
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>
> Hi Sagi,
>
> Exposing an interface to read multiple clocks makes sense to me,
> but I wonder if the interface you use is too inflexible.
>
Arnd - thanks alot for your notes.
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
> >  __SYSCALL(__NR_futex_wait, sys_futex_wait)
> >  #define __NR_futex_requeue 456
> >  __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
> > +#define __NR_multi_clock_gettime 457
> > +__SYSCALL(__NR_multi_clock_gettime, sys_multi_clock_gettime)
> >
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 457
> > +#define __NR_syscalls 458
>
> Site note: hooking it up only here is sufficient for the
> code review but not for inclusion: once we have an agreement
> on the API, this should be added to all architectures at once.
>
> > +#define MULTI_PTP_MAX_CLOCKS 5 /* Max number of clocks */
> > +#define MULTI_PTP_MAX_SAMPLES 10 /* Max allowed offset measurement sam=
ples. */
> > +
> > +struct __ptp_multi_clock_get {
> > +     unsigned int n_clocks; /* Desired number of clocks. */
> > +     unsigned int n_samples; /* Desired number of measurements per clo=
ck. */
> > +     clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs *=
/
> > +     /*
> > +      * Array of list of n_clocks clocks time samples n_samples times.
> > +      */
> > +     struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX=
_CLOCKS];
> > +};
>
> The fixed size arrays here seem to be an unnecessary limitation,
> both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are small
> enough that one can come up with scenarios where you would want
> a higher number, but at the same time the structure is already
> 808 bytes long, which is more than you'd normally want to put
> on the kernel stack, and which may take a significant time to
> copy to and from userspace.
>
> Since n_clocks and n_samples are always inputs to the syscall,
> you can just pass them as register arguments and use a dynamically
> sized array instead.
>
Both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are enough of any
usage we can think of,
But I think you are right, it is better to use a dynamically sized
array for future use, plus to use less stack memory.
On patch v4 a dynamically sized array will be used .
I leaving both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS but
increasing their values, since there should be some limitation.
> It's not clear to me what you gain from having the n_samples
> argument over just calling the syscall repeatedly. Does
> this offer a benefit for accuracy or is this just meant to
> avoid syscall overhead.
It is mainly to avoid syscall overhead which also slightly improve the accu=
racy.
> > +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get
> > __user *, ptp_multi_clk_get)
> > +{
> > +     const struct k_clock *kc;
> > +     struct timespec64 kernel_tp;
> > +     struct __ptp_multi_clock_get multi_clk_get;
> > +     unsigned int i, j;
> > +     int error;
> > +
> > +     if (copy_from_user(&multi_clk_get, ptp_multi_clk_get,
> > sizeof(multi_clk_get)))
> > +             return -EFAULT;
>
> Here you copy the entire structure from userspace, but
> I don't actually see the .ts[] array on the stack being
> accessed later as you just copy to the user pointer
> directly.
>
you are right, will be fixed on patch v4.
> > +             for (i =3D 0; i < multi_clk_get.n_clocks; i++) {
> > +                     kc =3D clockid_to_kclock(multi_clk_get.clkid_arr[=
i]);
> > +                     if (!kc)
> > +                             return -EINVAL;
> > +                     error =3D kc->clock_get_timespec(multi_clk_get.cl=
kid_arr[i],
> > &kernel_tp);
> > +                     if (!error && put_timespec64(&kernel_tp, (struct =
__kernel_timespec
> > __user *)
> > +                                                  &ptp_multi_clk_get->=
ts[j][i]))
> > +                             error =3D -EFAULT;
> > +             }
>
> The put_timespec64() and possibly the clockid_to_kclock() have
> some overhead that may introduce jitter, so it may be better to
> pull that out of the loop and have a fixed-size array
> of timespec64 values on the stack and then copy them
> at the end.
>
This overhead may introduce marginal jitter in my opinion,
still I like your idea since it is better to remove any overhead.
This will be fixed in patch v4.
I don't intend to use "a fixed-size array of timespec64 values on the
stack" since it will cause stack memory overflow,
Instead I will use a dynamically sized array (according to your
previews advice).
> On the other hand, this will still give less accuracy than the
> getcrosststamp() callback with ioctl(PTP_SYS_OFFSET_PRECISE),
> so either the last bit of accuracy isn't all that important,
> or you need to refine the interface to actually be an
> improvement over the chardev.
>
I don't understand this comment, please explain.
The ioctl(PTP_SYS_OFFSET_PRECISE) is one specific case that can be
done by multi_clock_gettime syscall (which cover many more cases)
Plus the ioctl(PTP_SYS_OFFSET_PRECISE) works only on drivers that
support this feature.
>       Arnd

