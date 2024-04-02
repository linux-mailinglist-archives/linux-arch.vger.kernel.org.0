Return-Path: <linux-arch+bounces-3359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC15895FA6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 00:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A481C22320
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDA21340;
	Tue,  2 Apr 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8gs3/kN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/S3kigRc"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22F1D6AE;
	Tue,  2 Apr 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097452; cv=none; b=W10TqsaPvy5VnnlmThzMZBeFgxDZOjLBb3GGNNh17bIpp2lcCYgQVV/Ny27yjt1URfxO0PVhgRDAa3lW1Rzk3RPUEvLnRmFCrP+NWTS/GlnUozRTu7bf0MwzlT9Q8uDI0/CULHYDoe0RGFSy6GEw5PqJgZ4ULQXqg6M/1BFhu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097452; c=relaxed/simple;
	bh=RTJ4TUWlWWd2tTYwH9K2+rCPELvAiNcHn8N7wtsQdE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGv4B2I9IO7Vu7D2acS2jIBX/gxlkKM4ATuqG+QfjxQjmx/2Pht0zs2TkEkZUIX/lnkI30+++eVc1mZD0VJ0Gk7auouuAUcs6wVE3Iqfs0OPjkwcKfr+msubxKZqnG2ro6pMSSxTJm048CRtQer5Ay8E8FlJeUQnwMF8Kbte+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8gs3/kN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/S3kigRc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712097449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clN786LC8NAM+WdiMM9dgE3xxt8pA/vNnE2Z1vIrTT0=;
	b=y8gs3/kNhqVMDT69laurybXNrUUQLXSrWBlCfk7pYoQcD7sK8QMi2tcLxZzkUPDz1X8GFu
	rDsIpWZ0dnEQluAc24xXlL4OxvWeX0lwaDKuqO838hTIEmqov7noMajRVkE4KsmiJRAFsQ
	3vsSR5JyyO2QIU4l+hPyGZvLBGQ96v5jvXV9Sh2ifVY5GBGOQaIHT3bmPElkDDpBp7Nr3v
	ou/q6j9YcqJz8Gz30kQRCGPebZaTDn7VkUNbbI+KO5BTEDOOP2q3L7BLEWF1I1ZZ1YOXaG
	C79sLoWN91aYOfwqYOMJ0rCrI198o5Dd+BP7sBJx9J4T5MaI6XiMi2qXJC8CcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712097449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clN786LC8NAM+WdiMM9dgE3xxt8pA/vNnE2Z1vIrTT0=;
	b=/S3kigRc0yKHbucTfmxketx4NbcQwgEjHo9AEoMAW71rZkqIq1rlQldWDmbV8LlyBHHCAK
	2c+UPz+ei3Kc93DA==
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
In-Reply-To: <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
 <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
 <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx>
 <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
Date: Wed, 03 Apr 2024 00:37:28 +0200
Message-ID: <877chfcrx3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02 2024 at 14:16, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:
> On Tue, Apr 2, 2024 at 2:25=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> Works as well. I'm not seing the point for CLOCK_MONOTONIC and the
>> change logs are not really telling anything about the problem being
>> solved....
>>
> https://lore.kernel.org/lkml/20240104212431.3275688-1-maheshb@google.com/=
T/#:~:text=3D*%20[PATCHv3%20net%2Dnext%200/3]%20add%20ptp_gettimex64any()%2=
0API,21:24%20Mahesh%20Bandewar%200%20siblings%2C%200%20replies;
>
> This is the cover letter where I tried to explain the need for this.

The justification for a patch needs to be in the change log and not in
the cover letter because the cover letter is not part of the git
history.

> Granted, my current use case is for CLOCK_MONOTONIC_RAW but just
> because I don't have a use case doesn't mean someone else may not have
> it and hence added it.

Then why did you not five other clock IDs? Someone else might have a
use case, no?

While a syscall/ioctl should be flexible for future use, the kernel does
not add features just because there might be some use case. It's
documented how this works.

Thanks,

        tglx


