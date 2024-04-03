Return-Path: <linux-arch+bounces-3394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B877897189
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5C92845B9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198571487F3;
	Wed,  3 Apr 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oy6vBAjo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMSZN9SO"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F51487E0;
	Wed,  3 Apr 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152136; cv=none; b=H2EU761yLj/E15F90edItcfk8gmMa7tAAilDkB7dFwbJ4r4Y6S73yw3qiSta2Y+xZuYAre2yMhsHTIc0TopWDnMscdDAW/vhxZOtBNR282v4/7npjsQJH9fw4Xle6y6khnbP7k+rblsJ//9axFBCtwtjVctRTZ6/nS0w3SdLCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152136; c=relaxed/simple;
	bh=qoTFFleE42BgrSkvKarf5pCVIY29rDDpqfsHaC7hnc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbG+SG7UMjorrLj/SqvSlsrs/E63jKC8d6+8Fhrf4fBux+52UYbEAX0lk/+n3EdQs+0HB7g2LFfSwesrpTB/jo7q6Tvh7n9mR2X0JgKh6VD/EKCllDtuhLvzPZIPsHqrGA3Ob9KlpWyVZRWkefDdCUUASPO7HPTkFAeEYbbjy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oy6vBAjo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMSZN9SO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712152132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7kLxvWk/5gRltzRCZSO2/VhtuBBFwcoV8m7fx6icxE=;
	b=oy6vBAjox1TNAs+TZf+sluJyIhyG+yUvn4oR5PmJNKXZgJRpLiUL8ueqPNp11qni1Sgji0
	C1dZpA4PrxvLDIjWNzybh4s97wN0RB7g6l5zSgoyzVTyn46APfr4Pdgfw5/q6iSR2pwNib
	EI4JoU2J2MbavCyfuLMtjcZO17ty2AWmnHGkBFtJbBLyrABDRnOF+V2Xrky0dDrBHc50F3
	0N2uehmxvltD/2eeiHwbSWrB87AL0y+jhgGKU/JqMhvAF0NL9QSwRWASew/93Yezpnms+l
	IOo6gGF+KgJnEjGVf61SG1xQLOx/bx0UxeTi1cIa8a8wsHeNgzXoK3TphkBDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712152132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7kLxvWk/5gRltzRCZSO2/VhtuBBFwcoV8m7fx6icxE=;
	b=dMSZN9SOEbyPVeTuY2xmvA7+bdIbzh65aIqcDnmKw45YoP7FeZHZuu6ZtEdkGIRAEoE+9C
	ebusyTmb9oxT05Aw==
To: =?utf-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
 =?utf-8?B?4KS+4KSwKQ==?= <maheshb@google.com>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org,
 sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com,
 palmer@sifive.com, keescook@chromium.org, legion@kernel.org,
 mark.rutland@arm.com, mszeredi@redhat.com, casey@schaufler-ca.com,
 reibax@gmail.com, davem@davemloft.net, brauner@kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
 <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
 <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx>
 <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
 <877chfcrx3.ffs@tglx>
 <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
Date: Wed, 03 Apr 2024 15:48:51 +0200
Message-ID: <871q7md0ak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:
> On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> The modification that you have proposed (in a couple of posts back)
> would work but it's still not ideal since the pre/post ts are not
> close enough as they are currently  (properly implemented!)
> gettimex64() would have. The only way to do that would be to have
> another ioctl as I have proposed which is a superset of current
> gettimex64 and pre-post collection is the closest possible.

Errm. What I posted as sketch _is_ using gettimex64() with the extra
twist of the flag vs. a clockid (which is an implementation detail) and
the difference that I carry the information in ptp_system_timestamp
instead of needing a new argument clockid to all existing callbacks
because the modification to ptp_read_prets() and postts() will just be
sufficient, no?

For the case where the driver does not provide gettimex64() then the
extension of the original offset ioctl is still providing a better
mechanism than the proposed syscall.

I also clearly said that all drivers should be converted over to
gettimex64().

> Having said that, the 'flag' modification proposal is a good backup
> for the drivers that don't have good implementation (close enough but
> not ideal). Also, you don't need a new ioctl-op. So if we really want
> precision, I believe, we need a new ioctl op (with supporting
> implementation similar to the mlx4 code above). but we want to save
> the new ioctl-op and have less precision then proposed modification
> would work fine.

I disagree. The existing gettimex64() is good enough if the driver
implements it correctly today. If not then those drivers need to be
fixed independent of this.

So assumed that a driver does:

gettimex64()
   ptp_prets(sts);
   read_clock();
   ptp_postts(sts);
=20=20=20
today then having:

static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
{
	if (sts) {
		if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
			ktime_get_raw_ts64(&sts->pre_ts);
		else
			ktime_get_real_ts64(&sts->pre_ts);
	}
}

static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
{
	if (sts) {
		if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
			ktime_get_raw_ts64(&sts->post_ts);
		else
			ktime_get_real_ts64(&sts->post_ts);
	}
}

or

static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
{
	if (sts) {
		switch (sts->clockid) {
                case CLOCK_MONOTONIC_RAW:
                	time_get_raw_ts64(&sts->pre_ts);
                        break;
                case CLOCK_REALTIME:
			ktime_get_real_ts64(&sts->pre_ts);
                        break;
                }=20=20=20=20=20=20=20=20
	}
}

static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
{
	if (sts) {
		switch (sts->clockid) {
                case CLOCK_MONOTONIC_RAW:
                	time_get_raw_ts64(&sts->post_ts);
                        break;
                case CLOCK_REALTIME:
			ktime_get_real_ts64(&sts->post_ts);
                        break;
                }=20=20=20=20=20=20=20=20
	}
}

is doing the exact same thing as your proposal but without touching any
driver which implements gettimex64() correctly at all.

While your proposal requires to touch every single driver for no reason,
no?

It is just an implementation detail whether you use a flag or a
clockid. You can carry the clockid for the clocks which actually can be
read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED:

struct ptp_sys_offset_extended {
	unsigned int	n_samples; /* Desired number of measurements. */
	clockid_t	clockid;
	unsigned int	rsv[2];    /* Reserved for future use. */
};

and in the IOCTL:

        if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
        	return -EINVAL;

	sts.clockid =3D extoff->clockid;

and it all just works, no?

I have no problem to decide that PTP_SYS_OFFSET will not get this
treatment and the drivers have to be converted over to
PTP_SYS_OFFSET_EXTENDED.

But adding yet another callback just to carry a clockid as argument is a
more than pointless exercise as I demonstrated.

Thanks,

        tglx

