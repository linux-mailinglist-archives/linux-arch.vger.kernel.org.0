Return-Path: <linux-arch+bounces-2991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB8387B913
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 09:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90706281210
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 08:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02165D47E;
	Thu, 14 Mar 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9zTQjYV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CB3209;
	Thu, 14 Mar 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403518; cv=none; b=XUMAmUGIoFBjZuQhexSpF/LUqlqo6kiz9USzo5SMmls9nIjuohdny8rN8mWt5H59EOdD9xqtWRoQudy6hDqSls6naE7aA3qyWWj0nuEHm5atj+KYIwL0nvJ0X/db6UCSsY3jRYxS9pmSmOgXKBMgr8zDISM5eqO5njJ9jcCtYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403518; c=relaxed/simple;
	bh=VPLJfp9NdqW4M/VBucjQthlRIBFwdvxs0T0ZFaIybcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbnLEiOi88ZMR2SQDWSm7NsvIqqFzYsp90Q5juba7qKZEbi9fNU1EZPhoU6G8VEP7i4J3BlF+eTDVtQ4agstIGso6k0DFLjEbB3LDhTtFPl4YPCd2jR02isggDts48aQVyNqtnz7z+v7nOYEuM6vKoYhX1fnQO+nmMkHz/oLv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9zTQjYV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1306752276.1;
        Thu, 14 Mar 2024 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710403516; x=1711008316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HOd1NEFGrNPODCnQ0+xTI3Lih5dD4kxPSCpnwjc89U=;
        b=Z9zTQjYVbeDIhI3XBbJrU9X5mAYmfU1nGHZOhvSb8pSsAHFb06ShFuSZS7XKaXdFVT
         R+zmr7m/RqAdgPSDa3tptv8wVnl5J1CDmonRz81+cawCaYnkCG1Jlle3yC8Ot61E4GKa
         N0FN6D4nYsqzAwR3mBakVY6V4+PQ6+t7vDofimlPENaF/ewAtIao4k03lm5+GbnP2GSR
         BSnwSi/tV+6rjg9fNHzJ+F5zk9Wr2t18AyDTX+gL2b3UmDlBWTkOTVgZo0bHB5oMW/hG
         0HxeK8kNfH14H+bDEp6anjg5vYX6gmv/Y62VxG12k62Nn8Mjm6igl5FRY/kh4hYuTjNj
         rAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403516; x=1711008316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HOd1NEFGrNPODCnQ0+xTI3Lih5dD4kxPSCpnwjc89U=;
        b=ZjMvoKzB/Wo9o/Tj1C7RbiwGKtVO72zYUJTJ/yLiU+D0eh+39oqsILRtGo3RH9byYF
         BcT0cXoMP5uNWDtLI6MY5E57zxajVJUNJdBj3yqxcfVeI0hM+or1epFAIxWl0zwpFjAG
         mf7vWuNVaJOM3yfWXlApartwfkFPPdPlvT7u2MDFsqTyftlZkAIA4IvLvxtTgxSCRlqG
         R6WHiAW+KTsg6Apl+ut567bK/H2ZEz20K1DJ4Q6Lh45v6TqZ/AKQHtfYiumnLePVamJB
         kJmP7gcBTFUuOzswxwPr+ahx+ai0Kwncbp0MVgf1rsnkWMZ8/mwGco0ZuIczzpoc/LnJ
         8Rjg==
X-Forwarded-Encrypted: i=1; AJvYcCUspT3NBNtlTwt0sX9Hk3DfziFNzO6xCYl09T7GgoDqulnbOhMM+NTIvfLc9jjpasaHggg7lkDPYswh5sqqhZLPVswNtXCblby6qZDupVgvbu+c70+Fcq1X1CtlTDi+5enxg7Jys6ZDlU9qDl2B+UOuFch49q/MYsgnsNM1zizXjqgQ6DHgt+W94mTLPTkqLXMVB1WYo+0llYaHmw==
X-Gm-Message-State: AOJu0Yyf8phbOHDhsX+ISYuYSO6ro68ZBgr6OClOv2FFRsrIH+lA/apa
	sVdWJd1iKnDTwT2v8PFjuGG/tOEj7lgotT8nqIJ7fSQUW2Wv28NXLy4TuLm8GYQrRjMzB34U9T0
	Sxv6rKTnRLBHu5bCXE1iuu3kVAF4=
X-Google-Smtp-Source: AGHT+IHG7p1zVnVvA03Krk82xIr/ktb/SzmN4GOEef1FDRq7kQUCQbzOJ2eB2dFJWSa/KvrIuTgvQHqR+yHVnY00tOQ=
X-Received: by 2002:a25:df89:0:b0:dc7:46fd:4998 with SMTP id
 w131-20020a25df89000000b00dc746fd4998mr635712ybg.13.1710403515840; Thu, 14
 Mar 2024 01:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312095005.8909-1-maimon.sagi@gmail.com> <7bf7d444-4a08-4df4-9aa1-9cd28609d166@app.fastmail.com>
 <CAMuE1bGkZ=ifyofCUfm4JVS__dgYG41kecS4TxBaHJvyJ607PQ@mail.gmail.com> <0a4e4505-cf04-4481-955c-1e35cf97ff8d@app.fastmail.com>
In-Reply-To: <0a4e4505-cf04-4481-955c-1e35cf97ff8d@app.fastmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 14 Mar 2024 10:05:04 +0200
Message-ID: <CAMuE1bEGcPPQUHdZ-sodCZyMragvSRtKfENOZ4wphQggr1fJWg@mail.gmail.com>
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

On Tue, Mar 12, 2024 at 3:47=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Mar 12, 2024, at 13:15, Sagi Maimon wrote:
> > On Tue, Mar 12, 2024 at 1:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Tue, Mar 12, 2024, at 10:50, Sagi Maimon wrote:
> >> > +     kc_a =3D clockid_to_kclock(clock_a);
> >> > +     if (!kc_a) {
> >> > +             error =3D -EINVAL;
> >> > +             return error;
> >> > +     }
> >> > +
> >> > +     kc_b =3D clockid_to_kclock(clock_b);
> >> > +     if (!kc_b) {
> >> > +             error =3D -EINVAL;
> >> > +             return error;
> >> > +     }
> >>
> >> I'm not sure if we really need to have it generic enough to
> >> support any combination of clocks here. It complicates the
> >> implementation a bit but it also generalizes the user space
> >> side of it.
> >>
> >> Can you think of cases where you want to compare against
> >> something other than CLOCK_MONOTONIC_RAW or CLOCK_REALTIME,
> >> or are these going to be the ones that you expect to
> >> be used anyway?
> >>
> > sure, one example is syncing two different PHCs (which was originally
> > why we needed this syscall)
> > I hope that I have understand your note and that answers your question.
>
> Right, that is clearly a sensible use case.
>
> I'm still trying to understand the implementation for the case
> where you have two different PHCs and both implement
> clock_get_crosstimespec(). Rather than averaging between
> two snapshots here, I would expect this to result in
> something like
>
>       ktime_a1 +=3D xtstamp_b.sys_monoraw - xtstamp_a1.sys_monoraw;
>
> in order get two device timestamps ktime_a1 and ktime_b
> that reflect the snapshots as if they were taken
> simulatenously. Am I missing some finer detail here,
> or is this something you should do?
>
Since the raw monotonic clock and the PHC are not synthesized, that
won't be accurate at all and depends on the frequency delta between
them.

> >> > +     if (crosstime_support_a) {
> >> > +             ktime_a1 =3D xtstamp_a1.device;
> >> > +             ktime_a2 =3D xtstamp_a2.device;
> >> > +     } else {
> >> > +             ktime_a1 =3D timespec64_to_ktime(ts_a1);
> >> > +             ktime_a2 =3D timespec64_to_ktime(ts_a2);
> >> > +     }
> >> > +
> >> > +     ktime_a =3D ktime_add(ktime_a1, ktime_a2);
> >> > +
> >> > +     ts_offs =3D ktime_divns(ktime_a, 2);
> >> > +
> >> > +     ts_a1 =3D ns_to_timespec64(ts_offs);
> >>
> >> Converting nanoseconds to timespec64 is rather expensive,
> >> so I wonder if this could be changed to something cheaper,
> >> either by returning nanoseconds in the end and consistently
> >> working on those, or by doing the calculation on the
> >> timespec64 itself.
> >>
> > I prefer returning timespec64, so this system call aligns with other
> > system calls like clock_gettime for example.
> > As far as doing the calculation on timespec64 itself, that looks more
> > expansive to me, but I might be wrong.
>
> In the general case, dividing a 64-bit variable by some other
> variable is really expensive and will take hundreds of cycles.
> This one is a bit cheaper because the division is done using
> a constant divider of NS_PER_SEC, which can get optimized fairly
> well on many systems by turning it into an equivalent 128-bit
> multiplication plus shift.
>
> For the case where you start out with a timespec64, I would
> expect it to be cheaper to calculate the nanosecond difference
> between ts_a1 and ts_a2 to add half of that to the timespec
> than to average two large 64-bit values and convert that back
> to a timespec afterwards. This should be fairly easy to try
> out if you can test a 32-bit kernel. We could decide that
> there is no need to care about anything bug 64-bit kernels
> here, in which case your current version should be just as
> good for both the crosstime_support_a and !crosstime_support_a
> cases.
>
sounds good, it will be done on the next patch.
>      Arnd

