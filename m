Return-Path: <linux-arch+bounces-1221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCED821352
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jan 2024 09:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257D9B220DD
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jan 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660F15C0;
	Mon,  1 Jan 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P13B6y0L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A76107;
	Mon,  1 Jan 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f911e9ac4so71978356d6.3;
        Mon, 01 Jan 2024 00:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704098706; x=1704703506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMd3337IrmQ0bZURCWuZgY7ObmtziyKnBbbsdShesQA=;
        b=P13B6y0L/VLM+WrzGnbvTTHsbtYiNQbkOZp9Qmd50bvisyBta/mdpID43uJL60f7O1
         UwsKhBl30I5DkPE3Z4liNcbHYLKeEYB5jdun3naPYQPi0e9lUOKGGWM1RLbUITJ7j/6G
         X5uyf6yEA9JFqfWSdr/OU5B6Ck2COtkska5RVd/nYyNY5oaDCVwdWcqWsb5bivJ/rUlH
         4slAIRo47yNLUy1mpu1JmCs6YeNON0N3yncLoNI7MK2W+kG9rlWIxaWAabJwUHVrNjB3
         +elCjSxp0wVaDEHkAlaWOVzPACnon22dATDrh7tcV6ReGHB+bESRzheo+zSzsdnrFMgi
         t8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704098706; x=1704703506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMd3337IrmQ0bZURCWuZgY7ObmtziyKnBbbsdShesQA=;
        b=OBu5zuLNfVN9LnAzHkqPC2dbm61GAmjRPWn/P9R4hnwFIuBn/y9fSKaRN61w3fVzwN
         ilEbyarkrLqV7qDQgGZI+wCJLt2q2zBcmlZhXn2rLgkeqn8LYzS4RqEizPJcwWYuIfYS
         JBllE2yD7VkunfhVomZr4YvazZtIUoUN+A+/F5QPQ9jutqd3VvXrAqyj5ry9scK0GoHn
         rQz6JOUowo9PmIGZnMA0/lCQmEGDZOTM6UPgSb/b2hiofn3uom/JvL7DddmjZkQ2ivvI
         /H7+YSc58LB9N1pMdpGtpRZNtrb+cnKdLtMYLPnC4JFwfpTH9PZzQvfnNoNJzHgFa8YB
         P6Yw==
X-Gm-Message-State: AOJu0Yyx3e9nhxIn/A8NTOuS2mqgb+MgwP5vTOvZvvTAUvMSDg+kxePM
	cgw2jp3qyQpr7ff2f97aA2BHRd4VPF2JzZelMg0=
X-Google-Smtp-Source: AGHT+IFuLXt2pu/sD00gZE5db/2DT8ryB8RwTB2TigDIieI5XuP6+gGgYA8QO8yQM+kQAlpRCRFRxvoEP+MVvlSKc5s=
X-Received: by 2002:a0c:ec05:0:b0:67f:b9a4:80e4 with SMTP id
 y5-20020a0cec05000000b0067fb9a480e4mr16658116qvo.39.1704098706637; Mon, 01
 Jan 2024 00:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231170721.3381-1-maimon.sagi@gmail.com> <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
In-Reply-To: <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 1 Jan 2024 10:44:55 +0200
Message-ID: <CAMuE1bEuou1Bx-6c3es3+FuTguOCb+iqU=hickK5hP7wT=M6Pw@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: add multi_clock_gettime system call
To: Andy Lutomirski <luto@kernel.org>
Cc: richardcochran@gmail.com, datglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org, 
	sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com, 
	palmer@sifive.com, keescook@chromium.org, legion@kernel.org, 
	mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 11:10=E2=80=AFPM Andy Lutomirski <luto@kernel.org> =
wrote:
>
> On Sun, Dec 31, 2023 at 9:07=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.co=
m> wrote:
> >
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
Andy Thank you for your notes.
>
> Knowing this offset sounds quite nice, but...
>
> >
> > New system call allows the reading of a list of clocks - up to PTP_MAX_=
CLOCKS.
> > Supported clocks IDs: PHC, virtual PHC and various system clocks.
> > Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> > The system call returns n_clocks timestamps for each measurement:
> > - clock 0 timestamp
> > - ...
> > - clock n timestamp
>
> Could this instead be arranged to read the actual, exact offset?
>
It can be done, but I prefer to leave it generic and consistent with
other time system calls.
In most cases the offset calculation is done in user space application
> > +       kernel_tp =3D kernel_tp_base;
> > +       for (j =3D 0; j < n_samples; j++) {
> > +               for (i =3D 0; i < n_clocks; i++) {
> > +                       if (put_timespec64(kernel_tp++, (struct __kerne=
l_timespec __user *)
> > +                                       &ptp_multi_clk_get->ts[j][i])) =
{
> > +                               error =3D -EFAULT;
> > +                               goto out;
> > +                       }
> > +               }
> > +       }
>
> There are several pairs of clocks that tick at precisely same rate
> (and use the same underlying hardware clock), and the offset could be
> computed exactly instead of doing this noisy loop that is merely
> somewhat less bad than what user code could do all by itself.
You are correct, there are some PHCs on the same NIC (each per port)
that share the same HW counter/clock.
In that case it is slightly better to do the offset calculation in the
NIC driver code,
but that requires changes in each NIC driver's code.
The main thing is that the multi_clock_gettime system call is a
generic solution,
it covers that case among other cases, for example sync between two
PHCs on different NICs.

