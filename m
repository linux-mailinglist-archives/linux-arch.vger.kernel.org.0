Return-Path: <linux-arch+bounces-12584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B13AFACDE
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF65E162560
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FF194C75;
	Mon,  7 Jul 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhtGtvh3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnfD40do"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA411CA9;
	Mon,  7 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872662; cv=none; b=OoQnN5jLt/NNPcRoBYghvASlozyneCTbe6bhZS4CWUuhjz3Q3E4m7MlHOoIqyaCSsakE24TMsNGXFqsF5RHNpI0a7Pdb0Gw8IQIh5hYep1fJ81hsORqZcT+Nk+hAsHprLWc6PCBSHzwvI9NTH6poNsWTDLllRGdc60NCGKuuSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872662; c=relaxed/simple;
	bh=WhNf+Mv2o7SC55RfYBkyMZ5Y0+LW0VT7F7eg8c1VfTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGSTX9W3Pj6BqaLkevzQG5dRf/AwMQuXakkFIwXKhHUhsI3dyRL8af/Xgwc8dQYYZVudKN4wOnUOeWEIV1LBMkQQf6JMC4R8XjTZVE0ivsUpKosOO8BuhpTomFAMYAjMSGIqwZgi0yI0PBHlvoZS8C7oA0DBwJKuRY0yIaHrnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhtGtvh3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnfD40do; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 09:17:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/WStYiskJlC9vtFGHNC+sPWwitqyX7fxMoCs588isM=;
	b=QhtGtvh32awCFpfqpR2dJaiwNHLWjOmVyhvSndn0b63g94XfjTMJ1RRyyqpEIr7JdIqmwl
	13P36MLNuKlX/+PFh039jimOSaVZsDjZ7HbTvJxsYxgexNw01Vm1aTgoIJ47lH+TD2w+P5
	sienvSrWBk5V6dN6gE9zMg2FreZsH/3Pp0Q3r7D6xXIK6as7C3n1GXSIzWs/qrf5Ny3z88
	mfAY+pTt1xe4PlyDoUHZUi8EjvbMw/Z1Oirtj7qBCb7XenxsaKLSSHYez2sdkJgrlTTpq2
	s7o9ppUkpQrtH/81GmuE65u33drwRNh9ncLj5C06xYCGP8c6SUszQO7bMlqW5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/WStYiskJlC9vtFGHNC+sPWwitqyX7fxMoCs588isM=;
	b=MnfD40doN7968bBafMzUUuxvXIN7riBiqfvyeTNHu/Denfp9g8nSDItEZuPDjAJ8ePxb0E
	dY6jK4C8Lu6VUkBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 14/14] selftests/timers/auxclock: Test vDSO functionality
Message-ID: <20250707082144-159cd778-47f3-428f-878c-8c22d4f297fc@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-14-df7d9f87b9b8@linutronix.de>
 <87cyadrrpk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyadrrpk.ffs@tglx>

On Sun, Jul 06, 2025 at 10:26:31PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 01 2025 at 10:58, Thomas Weißschuh wrote:
> 
> > Extend the auxclock test to also cover the vDSO.
> 
> I'm not really convinved, that this is the right thing to do. Why can't
> this just extend selftests/vDSO instead of creating these
> 
> > +#include "../vDSO/parse_vdso.c"
> > +#include "../vDSO/vdso_config.h"
> > +#include "../vDSO/vdso_call.h"
> 
> cross directory oddities? Confused.

Then we'd have to duplicate the auxclock management into the vDSO selftests.
And the knowledge about the expected clock_getres() return values.

In general I think we need to introduce some reuse of the vDSO parsing code
from other selftests in any case. For example the timens selftests call the
vDSO by just invoking the libc wrappers. But the libc may not support a vDSO,
have it disabled for some reason or the vDSO itself falls back to a syscall.
I intend to introduce some vDSO accessors which force the usage of the vDSO
fastpath by using parse_vdso.c to directly call into the vDSO and seccomp to
inhibit the fallback syscalls.

Or, to avoid a dependency we could move the vDSO parsing one step up to
tools/testing/selftests/vdso_support.h, and clean up the interfaces.


Thomas

