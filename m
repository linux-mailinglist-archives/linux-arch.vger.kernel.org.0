Return-Path: <linux-arch+bounces-12587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF95AFB446
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DD11887481
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2429B78F;
	Mon,  7 Jul 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4dKB5W1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzxWP6gL"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECB28ECF2;
	Mon,  7 Jul 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894343; cv=none; b=MSbV47qppsYWQqTnqpwRMTzRrHNzT7w8ee10grCrL144iJU/YkS5YjOR35c0QYBzuGKvz6z24FcRhYJB4vFSeWw6Tb3uYuLDhh2505kZr3mP8icm27OPjbUgLNfwUsHFv8WVtsc4wCeCwaFbUGp33771/8bX969ca9hQWcyP9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894343; c=relaxed/simple;
	bh=unpSKTFzLaDlkd0/9ndQM6FmFBUbqbcfpFb1tp2+T00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYYJ8UOcemWL6HyJrbxib4TnB4oUDtcxtn0980FwKNQycplDW2hdZBOLLs6UDbmoW5I3ixiUkry6/+5Gc93SmKXzMPKMihHl3U8pqWnb1Y7YugKcnxW1fhDoyQw/OXsL3ZoFVYAMjix0gCq55F7YpBnoG/pFl7KI9AHcepJ5Qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4dKB5W1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qzxWP6gL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751894339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhF2JcPNoR0FO9hi7SfPGNigJ/u6PP1goT7e88VaZuU=;
	b=g4dKB5W1tyUW+YFRe2KJ1+HB6LwWDjm/QZ2/L9NDFe4rdlRCHuLkJBv4HloYruslJQf5Az
	ieZU4/v9UxbqEzoGcBqanZ0k21K8cvkEwMvuf8UGcms97EyaGRM40+9zi93ja1sX5hUNKN
	zkqpWZNTFAbGzjaSLkmswwkf2wQfJEQaaH9OY9hsqO5bDaLNrt7TVdiMgskqAUDsdmVz5f
	LK1pzRL76mNB2cZEb4LxSfZFMUaFYuG7bElIf+lnM1/95IE0fP2PydPccW0QYz0NL4Xs1+
	+bY8n791+LJ9r3V6A0nzKBlEpOxgj0MjLjBKxfjPd7t/amoUxczOmVi2+9gJpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751894339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhF2JcPNoR0FO9hi7SfPGNigJ/u6PP1goT7e88VaZuU=;
	b=qzxWP6gLU7cYzA2dZHMLb/Y4QyVyqAL0s3+PqLn+lmwdq52+JB3dp/vkPtESBH93QhFzqr
	mzn8dCRoEljMkKAQ==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse
 <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao
 <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 14/14] selftests/timers/auxclock: Test vDSO functionality
In-Reply-To: <20250707082144-159cd778-47f3-428f-878c-8c22d4f297fc@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-14-df7d9f87b9b8@linutronix.de>
 <87cyadrrpk.ffs@tglx>
 <20250707082144-159cd778-47f3-428f-878c-8c22d4f297fc@linutronix.de>
Date: Mon, 07 Jul 2025 15:18:58 +0200
Message-ID: <871pqsrvel.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07 2025 at 09:17, Thomas Wei=C3=9Fschuh wrote:
> On Sun, Jul 06, 2025 at 10:26:31PM +0200, Thomas Gleixner wrote:
>> On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
>>=20
>> > Extend the auxclock test to also cover the vDSO.
>>=20
>> I'm not really convinved, that this is the right thing to do. Why can't
>> this just extend selftests/vDSO instead of creating these
>>=20
>> > +#include "../vDSO/parse_vdso.c"
>> > +#include "../vDSO/vdso_config.h"
>> > +#include "../vDSO/vdso_call.h"
>>=20
>> cross directory oddities? Confused.
>
> Then we'd have to duplicate the auxclock management into the vDSO selftes=
ts.

Fair enough.

> I intend to introduce some vDSO accessors which force the usage of the vD=
SO
> fastpath by using parse_vdso.c to directly call into the vDSO and seccomp=
 to
> inhibit the fallback syscalls.
>
> Or, to avoid a dependency we could move the vDSO parsing one step up to
> tools/testing/selftests/vdso_support.h, and clean up the interfaces.

Maybe that's not the worst thing as there are VDSO tests in several
places by now.

Thanks,

        tglx

