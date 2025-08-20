Return-Path: <linux-arch+bounces-13226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEBDB2D9E1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7CF5E121C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9612D94BC;
	Wed, 20 Aug 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xk/l9Yjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqPIa7gz"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A112459D4;
	Wed, 20 Aug 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684910; cv=none; b=cpSYtc9xzG7M/Z1UsEU/mwIYBi3iJzCi4TbUgZYzQx0BnkGYjrdVfThQ++4cf9PEvODgTP+FRlqMmun4uF2xK2sm4bK1Ss+5L4eiLx3xrUd8JaHnCL6ZUNh5qqtJr65KAmER2Ue2xf98gBMweZdSuIUKu2wAPluAXJQ7UGJw+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684910; c=relaxed/simple;
	bh=uahLgJ+9Vb1frTk4rhXXm3v4WzbXDg3Zmu/qGvO8wY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew+5emFedoCTUE8w+zoHDF+vHW6xUN/RQCZxWxGIpXnwtWzgdT/9BDgQSWdzxJiwO3JEgpn7LEDkHtjoSqHz1/up6+GjjCjAotgJh1PrxSsfOeOcJOU4XJ812tK+WXyq4SAjmDV8t2/IosqiDN7f5xidLbs8DTCa5KaJ+qVqfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xk/l9Yjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqPIa7gz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 12:15:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755684907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq9Rp/OuC3PCbtXKJ+rrICU+++sBXQCJ0QqJmyLjg+I=;
	b=xk/l9YjbZxA1WTuNZDPDzZ8Wdc5Ml1Z8iLcrdiinHR/jwkPKoZe+/Yal4T3iQYwXywj3aL
	TuAdMOj+eQI0qmH4cwrwb6A3GMEaaVQoSspG8drK9wAs5SV2ideGv0qB3XhysuV56KbSJ4
	Ji1ZYj+TAl0GzjJEk9GVKmLEw7BefXb3EhPgFPnViqNPKbjRmStIhai3NtAluEf5PrZHVV
	T4448Dt1lvhIAkl03wcMAqvjtP2i+hGi5Mem2w/M3c9233P9HviyrsxwKIaTEioVDHmkb5
	w4lNJSNOF2EW+K8iCdf0/FKJRU8M0mcWk1yvh6VZByLxUK8W+1DJdnpNq/W+nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755684907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq9Rp/OuC3PCbtXKJ+rrICU+++sBXQCJ0QqJmyLjg+I=;
	b=uqPIa7gzVKO93eAxiDkhCF2+ypJHv38VRv3c6TBXEdvdEQOGkI4lmIgUVLp7mtuPYYNrwu
	m3d54o5VitT9DoBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Stultz <jstultz@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
Message-ID: <20250820113704-8b174953-f02a-4376-9359-e4007914ac2a@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
 <CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com>

Hi John,

On Wed, Aug 20, 2025 at 01:03:56AM -0700, John Stultz wrote:
> On Tue, Jul 1, 2025 at 1:58 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Expose the auxiliary clocks through the vDSO.
> >
> > Architectures not using the generic vDSO time framework,
> > namely SPARC64, are not supported.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Just as a heads up, I've just been bisecting and this commit seems to
> be causing problems on arm64 devices, running 32bit versions of
> kselftest nanosleep or inconsistency-check tests. Running the 64bit
> versions of the tests are not showing issues.

Thanks for the report, I can reproduce the issue.

> From my initial digging, it looks like clockids that aren't vdso
> enabled (CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID,
> CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALARM) are somehow getting caught
> in the vdso logic and are *not* falling back to the syscall (stracing
> the test I don't see syscalls happen before the failure), and the
> values returned don't look to be correct.

The generic vDSO code assumes that it can use the UAPI headers, also in the
compat vDSO. This is true for most architectures, as the UAPI headers work
correctly in 32-bit and 64-bit mode. On arm64 this is different, as the headers
from arm64/ are never used by regular 32-bit userpspace. So
arch/arm64/include/uapi/asm/bitsperlong.h defines __BITS_PER_LONG=64 even when
used by the 32-bit compat vDSO. The commit you identified uses __GENMASK()
which uses __BITS_PER_LONG. Due to the mismatch between __BITS_PER_LONG and the
real long datatype we run into an out-of-bounds shift and therefore undefined
behaviour. And of course -Wshift-count-overflow is explicitly disabled.

There are a few possible fixes, none of which is really great.
I'll send some patches.

> The inconsistency-check output looks like:

(...)

> Which hints we're returning nanosecond values in the tv_sec field somehow.

That seems to be an artifact of the UB from above, this happens even if
do_aux() just returns 'false'.


Thomas

