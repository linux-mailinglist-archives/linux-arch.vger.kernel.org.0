Return-Path: <linux-arch+bounces-12586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B43AFB42D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E90161EF3
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4D275867;
	Mon,  7 Jul 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PrO4gOCB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIMzXGKA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619522A7F9;
	Mon,  7 Jul 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894202; cv=none; b=RZOLaAT0YHUJqxscs6fFaJMQe/WIIWM95YZSKcNaKfyYE+svg265ueEFMpK+vwQg82NOa1hdbUumTHWpXReS2bFvYlXyfWTw5CP2dwH0tigIJM9Kwni0kRlEGDtcDnWDKytYgIc0VgFkCtLCwKnolNDLZ2hQB+QE5Lw321R2a3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894202; c=relaxed/simple;
	bh=gwGMCcSgthgpvJwi3Tz2lYnh+90TcrOXqec8mO0R2cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cw7Qq5iKR9OJHBllXnESznpHzlIejtz0YKit5fZzBDirMStMIkm0XaOQbsxhQIuZy7OU2gGJP2Pjebgk1e+TLA6cONg3ajX2e2DU399+4pekvtE/lTBauANWeP7zhDEmtVyYLGF58FN/k5TllbfZs6k79d/WRiXQIsyPS9npYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PrO4gOCB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIMzXGKA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751894198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQiLw6osaoomL6XHJIB9L74mE4TG/l+SOI/9v+iCbZ8=;
	b=PrO4gOCBQEoJQOvNC3cnV+csw9i+Ur2uK9M4JKRkiAKSRka78oeRLBGLJEQLWPLTzcvLde
	B72lqCPZwVKzt0Rk2TAIP4CHqOhJ6bk7388uEd4BYoCY8kzhH/iIRyJy0lOz/dN0bghjyb
	ctyYspN4Gd+leLUCjfZ0KeMrMrXMdnkybe85qKE/YOBvBZk865ojJ4tXENm5HWYvY5sm8E
	LEqyiC0+NrsVIqCnWex3WsRZ0rg0cd1f2CG9Iwn/NH68TLKd/+4SU+DeZqfY/SgMK4S+sA
	bJGNZV+wj/InA+qcf5gUbIPFevvVOWSz0uH3TbO2OKrdGc5TFSxOCvGyhMRSug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751894198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQiLw6osaoomL6XHJIB9L74mE4TG/l+SOI/9v+iCbZ8=;
	b=yIMzXGKAosqPgDmoRSm/jdewQDjBi7L2WNRXVi1+obyTr33OQ2/6chzHQkAFEiKXfITk2N
	ANyVRY9NUhvkxyAA==
To: Arnd Bergmann <arnd@arndb.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, Nam
 Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 11/14] vdso/vsyscall: Update auxiliary clock data in the
 datapage
In-Reply-To: <2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fastmail.com>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
 <877c0ksd1p.ffs@tglx>
 <2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fastmail.com>
Date: Mon, 07 Jul 2025 15:16:36 +0200
Message-ID: <874ivorvij.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07 2025 at 13:34, Arnd Bergmann wrote:
> On Mon, Jul 7, 2025, at 08:57, Thomas Gleixner wrote:
>> On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
>>>=20=20
>>> +#if defined(CONFIG_GENERIC_TIME_VSYSCALL) && defined(CONFIG_GENERIC_GE=
TTIMEOFDAY) && \
>>> +	defined(CONFIG_POSIX_AUX_CLOCKS)
>>
>> CONFIG_GENERIC_GETTIMEOFDAY requires CONFIG_GENERIC_TIME_VSYSCALL, but
>> that's not expressed anywhere. This stuff has grown too many config
>> options over time:
>>
>> GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO, GENERIC_VDSO_DATA_STORE
>>
>> All architectures except SPARC64 use the generic code and the generic
>> VDSO data store implementation. That config maze wants to be
>> consolidated.
>
> Would it help to replace the custom sparc64 vdso with the
> thing that parisc does and call the fallback directly?

Definitely.

> I doubt anyone still cares about the clock_gettime() performance
> on sparc64, and removing it would remove all those special cases:
>
>  arch/sparc/Kconfig                  |   1 -
>  arch/sparc/include/asm/vvar.h       |  75 --------
>  arch/sparc/kernel/Makefile          |   1 -
>  arch/sparc/kernel/vdso.c            |  69 --------
>  arch/sparc/vdso/Makefile            |   2 +-
>  arch/sparc/vdso/vclock_gettime.c    | 340 +++---------------------------=
------
>  arch/sparc/vdso/vdso.lds.S          |   2 -
>  arch/sparc/vdso/vdso32/vdso32.lds.S |   3 +-
>  arch/sparc/vdso/vma.c               | 265 +---------------------------
>  9 files changed, 28 insertions(+), 730 deletions(-)

That's definitely an argument :)

> (the added lines here also fix the missing clock_gettime64,
> which was equally blocked on the sparc64 oddities)

I'm all for it.

Can you post a patch to that effect?

Thanks,

        tglx

