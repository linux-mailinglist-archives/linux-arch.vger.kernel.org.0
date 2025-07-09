Return-Path: <linux-arch+bounces-12596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E5AFE15F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329D63AE2F6
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035FC26FA56;
	Wed,  9 Jul 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKzHusUQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yl+jodkn"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88B26A1A8;
	Wed,  9 Jul 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046471; cv=none; b=T1/wlmEuogvB3wvjHqG+PMj1rqvgU/Cu/Y+u71biAvCCBr+E/eqv2iOZ7e40gZ3yXOdHK2UzgYPzDFxQvDhZut/ZjLrqJieMEhlBP0z8qj8uGI9f9eqJnjuvxRCPd6AUuHgRKo2l1sulFDOTUKYpOrfHvW3kYBZ4Eha9X5lNMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046471; c=relaxed/simple;
	bh=9whL7fZ7QNpBHrXMf0gaj/yMX5MMOUjvUSZtUHBR0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVZ22uRolXi/T0wIDTX9l9b6I1vJZ8TBPFJYLjg1knmpWJy1h/vHfb1QX+G4zZeg76wXNGyRmBg5Ky2B3jLi0eogiS6HXQix98RctgefY+qPT0jf0LJ9fZ3guJV1XMCvnzvkMJaaBSM1MJ6AZhQRx0gJXPhot1Q9gewjyxqTLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKzHusUQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yl+jodkn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Jul 2025 09:34:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752046467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rJt4heSROgDS1eV9ocRaQHZQ3lJ1qX0A+5cng2rs84=;
	b=PKzHusUQs+w0o4p0sZCP9FjgK6pS2tok18H/l9wBTus+Fnd2mt8mIxmot+O55FNVBY0l74
	kKPUYZNYjrw4yYxpMExxG5gh3hWMKhBjOfDxeR55mTI5XnN2VO5dPHoHIf+menq6THLNua
	4ZW4Ag/C7e5TYAEFHrHwm+NwKsEFgS1nr9J6i5u0x+p/AhaXLZHq8t+4xx5oht0FMmkI9X
	YetbSJVb74Yl4W9Jv1SEoepeZD7p3OZm0Qvs3EMywvT3D9DSgGjkxtaFdGfCQf6sS6sAPP
	vOv8o0ILi7wL1QghNp3NTFlbn/L+3JiMFRFEqxtZcmsIa11x1uERp4a4/6phHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752046467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rJt4heSROgDS1eV9ocRaQHZQ3lJ1qX0A+5cng2rs84=;
	b=yl+jodkn7KTLjpkGEy0Z/8kw3gAECyIK38lKFA1jDazOKrm6eOGWMbFhBFgaijK22nfLfD
	twbjIvJAWKpLYQBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>

Hi Marek,

On Tue, Jul 08, 2025 at 05:49:18PM +0200, Marek Szyprowski wrote:
> On 08.07.2025 17:17, Marek Szyprowski wrote:
> > On 01.07.2025 10:58, Thomas Weiﬂschuh wrote:
> >> The internal helpers are effectively using boolean results,
> >> while pretending to use error numbers.
> >>
> >> Switch the return type to bool for more clarity.
> >>
> >> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> >> ---
> >> † lib/vdso/gettimeofday.c | 58 
> >> +++++++++++++++++++++++++------------------------
> >> † 1 file changed, 30 insertions(+), 28 deletions(-)
> >
> > This patch landed in today's linux-next as commit fcc8e46f768f 
> > ("vdso/gettimeofday: Return bool from clock_gettime() helpers"). In my 
> > tests I found that it causes serious problem with hwclock operation on 
> > some of my ARM 32bit test boards. I observe that calling "hwclock -w 
> > -f /dev/rtc0" never ends on those boards. Disabling vdso support (by 
> > removing ARM architected timer) fixes this issue.
> 
> I spent some time analyzing the code refactored in this patch and it 
> looks that the following change is missing:

Thanks for the report and investigation!

> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index c5266532a097..7e79b02839b0 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -344,7 +344,7 @@ __cvdso_gettimeofday_data(const struct 
> vdso_time_data *vd,
>  ††††††† if (likely(tv != NULL)) {
>  ††††††††††††††† struct __kernel_timespec ts;
> 
> -†††††††††††††† if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
> +†††††††††††††† if (!do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
>  ††††††††††††††††††††††† return gettimeofday_fallback(tv, tz);
> 
>  ††††††††††††††† tv->tv_sec = ts.tv_sec;
> 
> 
> In my tests this fixed the hwclock issue on the mentioned boards.

This fix looks correct to me.


tglx:

Are you going to fold the fix into the commit or do you want a proper patch?


Marek:

If a new patch is required, do you want to send it? You found and fixed the
issue after all. If not, I'll take care of it.


Thomas

