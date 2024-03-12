Return-Path: <linux-arch+bounces-2937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86308793FF
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9828542B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650AC7B3C5;
	Tue, 12 Mar 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOeyputJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E47A707;
	Tue, 12 Mar 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245771; cv=none; b=GOu/9y47vPmSeZ/xSj/Uk0ENsnlb7DQsgS7RCOojGQZU9nvFvb4i8JmEGR7+CYN6bzauZmxB+jn4ryfGjcsMSeyn+BWr9dg6JWpuvPhGdntiYiitnYS2aaChZ6XU2dGSycUQBVStSlJMEfsuVQmdQrxTHavq2FNfkVHz3YwsIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245771; c=relaxed/simple;
	bh=Od215/XrPMqF4+aWXTeN/DubjcXHAzjLof05GAiv7mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gghpa8ILHsW7naHeUJqirfSvhBlEUH9tspX6P2AkYlLdL3Cc5bvsAll0/s6jEKOTD8PkB+PFSNwIoLjZyV/ObboI8Vubo8iXjkMTAau0Zewp5FSBa/Z0VrUxyuEldtGnZo+Qqvzd2PjYERzGsv6NF5hlkvKSUe9e5fsXxhk04Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOeyputJ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso5001060276.1;
        Tue, 12 Mar 2024 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710245768; x=1710850568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyFCwjdYDVIsztUBry/f8bsBjuN4jiZlFF7Qs0any0A=;
        b=VOeyputJx4gB+FKpzjuGz/mJQOfFyhRO+LkMvQEl9ZH0JRUTBcCoMSuXONZbnHoqEq
         75cJtEYRP4jauCzuJpqThyhz016lY3Yef0bu7ATe5bmU+E9nF2MAieHoFXHG965ryGY/
         KzdSdjZtF5vAqetOnDGNT2AotDOAoRzjMhkpq0gw+huzEi08bzLG/KROpmgcEzVX/mi8
         LNlcWfo9Z3p8zOajfhV7Jd6f6YagxUMiqSAlmKAfyBQt2HafTOPVasM9iH5Sm1fDXnd5
         EDOCn51nh7S86Dwk+uaMzd3dOrdoklB20h3rfHoiAQaKmOOY6wToOlBOkatsHhE0YddK
         rwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245768; x=1710850568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyFCwjdYDVIsztUBry/f8bsBjuN4jiZlFF7Qs0any0A=;
        b=acJP4WN3ti81tKV1rVhg2OCj1Q7nXdFS5dp1ajT36fdJXjl6pCUAsqGOeMVZHx9edI
         Qoe1xwCBr0gSHX8tuRY9OlOaaa0e/6tbFtjaChSjPgYEVRtLKhqGwvI1bYWo2e+qUCPK
         woShZKKpTeAOBtso7NMOiuirUkkkdbsnxLrt5VT1ItoK+6rIMf+iyXCkqsQh+hXCCXu9
         XrXtQ7cVvsJrtY69I0/fskOK/ib1YnfMzN1/089MZkTCqbqD0Na6vQeFGeJ9bD/0CO9U
         nCmUL55hCv8E6RJAdkuEGv8xQ8KUQP4jnnxig6B7zBlq6VtYhUwZU6nEgbBBD4e9uo+A
         0n5w==
X-Forwarded-Encrypted: i=1; AJvYcCUJU0ASCsaf1j31I2vx01HsS/CpUnNtl7o2IC/B9pfSKQi6lyOarnrddfbqEv76RL+00xADqNdTJBkJDmcnqPJ9UXfOelt7AQXqehBX2BtaQ1/3fSqFr2UGy/JtrQNM6yiU7YFOEGIdeTR7jPVLTTgdOL+fODDEKWiPAuysNFz4Z9vST30+7Xyx6tn3QUfy8PXbCzNVO7m9j9T5eQ==
X-Gm-Message-State: AOJu0Yz4wmzeByUnpdC1oCpKQDxVrsjpCVjMxeWLUcjVp5/59mmFy+hu
	KVJki0jpr1/FBp5+6aqqMtD1L2eg4U8aiyWJOXxSb46QNfVxwl3sKx0s8tFeZRbtjsFZ7jKmcLa
	gnC89DXOx8sSsGU75kymIA7oyY3k=
X-Google-Smtp-Source: AGHT+IGsSqgV1J0+s8AAEp+Hw6N2iqJsbKQk1JL5Q7CLDKpFxVnD6clDIdy/25mD+Q8JAgZGZR7sLNILrtt3WOl8e/0=
X-Received: by 2002:a25:c846:0:b0:dd0:129f:16 with SMTP id y67-20020a25c846000000b00dd0129f0016mr1385426ybf.11.1710245768623;
 Tue, 12 Mar 2024 05:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312095005.8909-1-maimon.sagi@gmail.com> <7bf7d444-4a08-4df4-9aa1-9cd28609d166@app.fastmail.com>
In-Reply-To: <7bf7d444-4a08-4df4-9aa1-9cd28609d166@app.fastmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 12 Mar 2024 14:15:57 +0200
Message-ID: <CAMuE1bGkZ=ifyofCUfm4JVS__dgYG41kecS4TxBaHJvyJ607PQ@mail.gmail.com>
Subject: Re: [PATCH v6] posix-timers: add clock_compare system call
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Cochran <richardcochran@gmail.com>, Andy Lutomirski <luto@kernel.org>, datglx@linutronix.de, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Kees Cook <keescook@chromium.org>, 
	Alexey Gladkov <legion@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, reibax@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd
Thanks for you comments.

On Tue, Mar 12, 2024 at 1:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Mar 12, 2024, at 10:50, Sagi Maimon wrote:
> > Some user space applications need to read a couple of different clocks.
> > Each read requires moving from user space to kernel space.
> > Reading each clock separately (syscall) introduces extra
> > unpredictable/unmeasurable delay. Minimizing this delay contributes to =
user
> > space actions on these clocks (e.g. synchronization etc).
> >
> > Introduce a new system call clock_compare, which can be used to measure
> > the offset between two clocks, from variety of types: PHC, virtual PHC
> > and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> > The system call returns the clocks timestamps.
> >
> > When possible, use crosstimespec to sync read values.
> > Else, read clock A twice (before, and after reading clock B) and averag=
e these
> > times =E2=80=93 to be as close as possible to the time we read clock B.
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>
> I like this a lot better than the previous versions I looked at,
> so just a few ideas here how this might be improved further.
>
> > +/**
> > + * clock_compare - Get couple of clocks time stamps
> > + * @clock_a: clock a ID
> > + * @clock_b: clock b ID
> > + * @tp_a:            Pointer to a user space timespec64 for clock a st=
orage
> > + * @tp_b:            Pointer to a user space timespec64 for clock b st=
orage
> > + *
> > + * clock_compare gets time sample of two clocks.
> > + * Supported clocks IDs: PHC, virtual PHC and various system clocks.
> > + *
> > + * In case of PHC that supports crosstimespec and the other clock is
> > Monotonic raw
> > + * or system time, crosstimespec will be used to synchronously capture
> > + * system/device time stamp.
> > + *
> > + * In other cases: Read clock_a twice (before, and after reading
> > clock_b) and
> > + * average these times =E2=80=93 to be as close as possible to the tim=
e we
> > read clock_b.
> > + *
> > + * Returns:
> > + *   0               Success. @tp_a and @tp_b contains the time stamps
> > + *   -EINVAL         @clock a or b ID is not a valid clock ID
> > + *   -EFAULT         Copying the time stamp to @tp_a or @tp_b faulted
> > + *   -EOPNOTSUPP     Dynamic POSIX clock does not support crosstimespe=
c()
> > + **/
> > +SYSCALL_DEFINE5(clock_compare, const clockid_t, clock_a, const
> > clockid_t, clock_b,
> > +             struct __kernel_timespec __user *, tp_a, struct __kernel_=
timespec
> > __user *,
> > +             tp_b, int64_t __user *, offs_err)
>
> The system call is well-formed in the way that the ABI is the
> same across all supported architectures, good.
>
> A minor issue is the use of int64_t, which in user interfaces
> can cause namespace problems. Please change that to the kernel
> side __s64 type.
>
you are right - it will be fixed on the next patch
> > +     kc_a =3D clockid_to_kclock(clock_a);
> > +     if (!kc_a) {
> > +             error =3D -EINVAL;
> > +             return error;
> > +     }
> > +
> > +     kc_b =3D clockid_to_kclock(clock_b);
> > +     if (!kc_b) {
> > +             error =3D -EINVAL;
> > +             return error;
> > +     }
>
> I'm not sure if we really need to have it generic enough to
> support any combination of clocks here. It complicates the
> implementation a bit but it also generalizes the user space
> side of it.
>
> Can you think of cases where you want to compare against
> something other than CLOCK_MONOTONIC_RAW or CLOCK_REALTIME,
> or are these going to be the ones that you expect to
> be used anyway?
>
sure, one example is syncing two different PHCs (which was originally
why we needed this syscall)
I hope that I have understand your note and that answers your question.
> > +     if (crosstime_support_a) {
> > +             ktime_a1 =3D xtstamp_a1.device;
> > +             ktime_a2 =3D xtstamp_a2.device;
> > +     } else {
> > +             ktime_a1 =3D timespec64_to_ktime(ts_a1);
> > +             ktime_a2 =3D timespec64_to_ktime(ts_a2);
> > +     }
> > +
> > +     ktime_a =3D ktime_add(ktime_a1, ktime_a2);
> > +
> > +     ts_offs =3D ktime_divns(ktime_a, 2);
> > +
> > +     ts_a1 =3D ns_to_timespec64(ts_offs);
>
> Converting nanoseconds to timespec64 is rather expensive,
> so I wonder if this could be changed to something cheaper,
> either by returning nanoseconds in the end and consistently
> working on those, or by doing the calculation on the
> timespec64 itself.
>
I prefer returning timespec64, so this system call aligns with other
system calls like clock_gettime for example.
As far as doing the calculation on timespec64 itself, that looks more
expansive to me, but I might be wrong.
Sagi
>      Arnd

