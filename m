Return-Path: <linux-arch+bounces-3395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0489744D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1B4B25965
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25914A4D6;
	Wed,  3 Apr 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbqRo29e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itiwUlxd"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E914A4CA;
	Wed,  3 Apr 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158931; cv=none; b=J1p2L4pdEutScCl8TtrUYwGyH3vCnf4TgSCHM4w3PkSHSlMOgnoxpI7xb0c1fCBUvoNT/A/58EdAQF5wMkrzuxl/uWt1vr0ebSTMIc878R/opRQ6v8xHbYkccfbrl6BoBzGFg9FRLqoI5lIzInnedsTwbFE+6pJe/G7UT3egZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158931; c=relaxed/simple;
	bh=xVqTrV2EOxUSSZan1ZZw8dKzYogFsYUkgkdBUwZAxcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFsDcp7ZHypIroATLTky5v/HtmigxBG07WMg08Y9TgsS/v5qol7ESVlCekRJAMayUFV024g8n9WGrrisVoR61bRbEpDabqf6iD0Zbd65nhsQAC9s5p/4uQibTT7lDUxUCG0s9jNGkJeJRiYoxMVzpP3OzGO7bu9qehmE/17NkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbqRo29e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itiwUlxd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712158928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOt0dOO+AFCPf2GAEgYOVi3ktaLl36Jl9BRCEYzmAVA=;
	b=LbqRo29eSLs0gajWgIU45I87whjhwxMoBUqXlru9Mtkvw9BX5lOHSqHADP+/+gb69QI/GT
	cutVljl5VhvqxSqWqHBdVX+jNU8V4s3DRcvbjwwMLQk2+QAwsniLFGUfdrct2RNC7y/VU7
	EHwOg8z++x3Q/zC5+lHmheUWXDHHbgsFuRNNSRsN0dIS7aWZMjydPYuMTgrTSRzeaASBiS
	F00+XFrToDJ6MbT8BjjR1XJI0Bg5Xkmt8/8+hMNYlwoLA8t16XIToYUJiq5+w923T3pwyG
	1fNpip141RD/a6XX7kjxaYH5QC+zUveNtPMugEgKf7qKdEW7P2N1UOpizzE45Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712158928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOt0dOO+AFCPf2GAEgYOVi3ktaLl36Jl9BRCEYzmAVA=;
	b=itiwUlxdZ9cob1BWZQhY7cl1ZtIot+bgRrFVL003XoxCbPQJyDIJj2augiiFd1SCyTT6+f
	zkXCWVmYe1WNbTBw==
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
In-Reply-To: <871q7md0ak.ffs@tglx>
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
 <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
 <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx>
 <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
 <877chfcrx3.ffs@tglx>
 <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
 <871q7md0ak.ffs@tglx>
Date: Wed, 03 Apr 2024 17:42:07 +0200
Message-ID: <87v84ybghc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2024 at 15:48, Thomas Gleixner wrote:
> On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=
=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=
=B0) wrote:
> It is just an implementation detail whether you use a flag or a
> clockid. You can carry the clockid for the clocks which actually can be
> read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED:
>
> struct ptp_sys_offset_extended {
> 	unsigned int	n_samples; /* Desired number of measurements. */
> 	clockid_t	clockid;
> 	unsigned int	rsv[2];    /* Reserved for future use. */
> };
>
> and in the IOCTL:
>
>         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
>         	return -EINVAL;

That should obviously be:

          switch (extoff->clockid) {
          case CLOCK_REALTIME:
          case CLOCK_MONOTONIC_RAW:
          	break;
          default:
                return -EINVAL;
          }
=20=20=20=20=20=20=20=20=20=20
...

> 	sts.clockid =3D extoff->clockid;
>
> and it all just works, no?
>
> I have no problem to decide that PTP_SYS_OFFSET will not get this
> treatment and the drivers have to be converted over to
> PTP_SYS_OFFSET_EXTENDED.
>
> But adding yet another callback just to carry a clockid as argument is a
> more than pointless exercise as I demonstrated.
>
> Thanks,
>
>         tglx

