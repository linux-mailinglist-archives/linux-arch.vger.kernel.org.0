Return-Path: <linux-arch+bounces-1239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A9822DE7
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FC31C225A9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061319461;
	Wed,  3 Jan 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRN0qJR0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5D1944F;
	Wed,  3 Jan 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e734d6cbe4so81648257b3.3;
        Wed, 03 Jan 2024 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286805; x=1704891605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7i+8MOEKjuPGnNZAwLyrfk1/htpJtDKIJboRJ8BNRw=;
        b=JRN0qJR0+he2iO4E+cmj2irMEFVUzfJE+ux7EcxfrlRZCKGfQT71A+uEONYui22I7/
         tlMjZNWG2+VLDPOnPQTHokhyT4mURZ9aZsA0UXj6KKhz5e2b3klYF0g3nRRDgWoIFjIy
         8wCl21rMEGZ9KXkQcbDuid+u0lt+vRvka6bqIVtxIBCYbnqwBa58ZvHzGlStHvy5606c
         LFLLqk2xqFjbZNkrLKAliK3m3XkJTtAk29eg4jr8VuvnC+GTQTWqKP8XEoQjMn2Euh1g
         ovtyjOVNPR5oCpQwBC/v+UR9sFq0LBHO6NIvPPiDvlXJsUHdKxGeZqWMuOWz6jgzoc4D
         iSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286805; x=1704891605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7i+8MOEKjuPGnNZAwLyrfk1/htpJtDKIJboRJ8BNRw=;
        b=Pq09Fxv09Qntl8yyZMc9LE/mGlXz5wqvRfQpXU+bpS/1dRLREi7jxb065f4Zu906Vn
         GIfgK5vyjs1k6c1X9NshVLQrv2I8zS2rO8lsagt0ZrfgZ42FdA5yafvjvLlc1RHQlQJS
         4A4+m5jLfR2I3DMPYa08NxhBaagj//OqhrG6uBkNEEKMZNrr7oT//PZQrejaX2XIXqf4
         9UrcNGuh49GuctnEZpV4gCzahjK1Awui+wNQbe9QaraHxRn98mIpu2grx+y1hqcejIZT
         pDbV2EkebWYlpbUeG9k6YawpAehHuEdi3qyA0yuNL+kZfKUPpUicELja3J+IhMOYH07i
         hEKA==
X-Gm-Message-State: AOJu0YwHyKKDsOvgXyTKHuZSuLXUsM6MewgL4Aob2gExmo1HBXwN+0n4
	OzVi4p6p02LWKFDtx/DRYOvO/F2+UII46IIvKdk=
X-Google-Smtp-Source: AGHT+IGJmHL5mhcQjzvp8qz99imIe8rGleTfl85avDtM7nLrtho2mwL2xBJcVqPaQr7D9agYfqaHXi7cXkm96p1JIxo=
X-Received: by 2002:a81:84ce:0:b0:5de:a99e:17af with SMTP id
 u197-20020a8184ce000000b005dea99e17afmr11538761ywf.3.1704286804769; Wed, 03
 Jan 2024 05:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102091855.70418-1-maimon.sagi@gmail.com> <86fcb951-67e0-4f1d-a441-f3b4bcce8210@app.fastmail.com>
In-Reply-To: <86fcb951-67e0-4f1d-a441-f3b4bcce8210@app.fastmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 3 Jan 2024 14:59:53 +0200
Message-ID: <CAMuE1bEN61aFL7dMDqF-v1Htt0K37w7OVwmYNQuPt5QSWUphXQ@mail.gmail.com>
Subject: Re: [PATCH v5] posix-timers: add multi_clock_gettime system call
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

On Tue, Jan 2, 2024 at 12:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Jan 2, 2024, at 10:18, Sagi Maimon wrote:
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
> > ---
> >  Changes since version 4:
> >  - fix error  : 'struct __ptp_multi_clock_get' declared inside paramete=
r list
> >    will not be visible outside of this definition or declaration
>
> I usually put all the changes for previous versions in a
> list here, it helps reviewers.
>
Will be done on patch V6.
> The changes you made for previous versions all look good
> to me, but I think there is still a few things worth
> considering. I'll also follow up on the earlier threads.
>
> > +#define MULTI_PTP_MAX_CLOCKS 32 /* Max number of clocks */
> > +#define MULTI_PTP_MAX_SAMPLES 32 /* Max allowed offset measurement sam=
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
> Since you now access each member individually, I think it
> makes more sense here to just pass these as four
> register arguments. It helps with argument introspection,
> avoids a couple of get_user(), and lets you remove the fixed
> array dimensions.
>
I prefer the use of  get_user(), I will use it to remove  the fixed
array dimensions.
which will be done on patch V6.
> > +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get
> > __user *, ptp_multi_clk_get)
> > +{
> > +     const struct k_clock *kc;
> > +     struct timespec64 *kernel_tp;
> > +     struct timespec64 *kernel_tp_base;
> > +     unsigned int n_clocks; /* Desired number of clocks. */
> > +     unsigned int n_samples; /* Desired number of measurements per clo=
ck.
> > */
> > +     unsigned int i, j;
> > +     clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs *=
/
> > +     int error =3D 0;
> > +
> > +     if (copy_from_user(&n_clocks, &ptp_multi_clk_get->n_clocks,
> > sizeof(n_clocks)))
> > +             return -EFAULT;
> > +     if (copy_from_user(&n_samples, &ptp_multi_clk_get->n_samples,
> > sizeof(n_samples)))
>
> If these remain as struct members rather than register arguments,
> you should use get_user() instead of copy_from_user().
>
Will be done on patch V6
> > +     kernel_tp_base =3D kmalloc_array(n_clocks * n_samples,
> > +                                    sizeof(struct timespec64), GFP_KER=
NEL);
> > +     if (!kernel_tp_base)
> > +             return -ENOMEM;
>
> To be on the safe side regarding possible data leak, maybe use
> kcalloc() instead of kmalloc_array() here.
>
Will be done on patch V6.
> > +     kernel_tp =3D kernel_tp_base;
> > +     for (j =3D 0; j < n_samples; j++) {
> > +             for (i =3D 0; i < n_clocks; i++) {
> > +                     if (put_timespec64(kernel_tp++, (struct __kernel_=
timespec __user *)
> > +                                     &ptp_multi_clk_get->ts[j][i])) {
>
> I think the typecast here can be removed.
>
You are right, will be fixed on patch V6.
>       Arnd
Thanks for your Notes.

