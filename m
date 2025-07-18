Return-Path: <linux-arch+bounces-12854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44737B0A3CD
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 14:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8421E568679
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D125C810;
	Fri, 18 Jul 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXwlOf3B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l/3AuDaZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1E215F42;
	Fri, 18 Jul 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840157; cv=none; b=oU/sKPQqFQReNKhzMG1LRSIeDso7JwqIdMsMp6eyIs36xtOrIbKwCB9ABOJaMmmg+wAcG+M0zKBNBwweZYFrL9wwftHnFjuPA6Ord7SsCWr9zCbnt7k0bffv+tjHVvYmoIH4nog8t2QtgvHCIv58bKtRH/JuGNTpIySB3whtpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840157; c=relaxed/simple;
	bh=xTdaXyncEUDDdFe5YvyeWdY1Q33FEyyDElnwYwfJoOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVwXxzv9R5v3hpuSs59HkW62r6A4i9OCVQOXKKm4ncwdCqC3xLIbOXeanUJMMnIMkl6MBU2F9UmuB0T+hqsa9XpxQLsA03LuSTjwhhSBtkGqwKW5WkA/pdGWNxXtkxTzhWV4zj/xlJf8NMWcmD1jCMzYoKm3RpEVhdjJ+EM8SI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXwlOf3B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l/3AuDaZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 14:02:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752840154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR8GFtFedVx/r5PUglTQ7W4jl5yYcSzjkrHKB16Mp2o=;
	b=MXwlOf3B0OYwe8S9UVY01/IN3oyDX9gPT0AwAe3Yf87RnwgKO1/C/L8y63hnn2U+ZnPvYS
	f572/Ti+oZ4l3BuQ0A6x52Zfx78w6gYtAzTFLmfeQbYqGXAR7mA3XkB8yXPP7uy9tJckGm
	uv2d8wT2yMurqp8OWg2lZJFQxxuzSkI4R8d9cPs3KNKvy1oYC3s6GiqaZX38a3xLkKfi7F
	cFbx9nkB+UpMgGmEtZnrynNh5xbynqxQArWv1HonUDki8cq7H38QccKCUOehV36fAXgGXf
	Bhmvg6O+9KATg/umwPd4uPhSGVXK4UbAm3NB1Unv5RxRDKeOk9Zb+t68Qb0oNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752840154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR8GFtFedVx/r5PUglTQ7W4jl5yYcSzjkrHKB16Mp2o=;
	b=l/3AuDaZRE9QGNhT2YED4BqPE5yu63+ZT/B4KRo05B2TlyLCe4aF4QMElu/QQhnU4pygV2
	key+l2XsKkGLdvDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
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
Message-ID: <20250718140115-1f81a425-6215-413e-828d-4fa69f96c938@linutronix.de>
References: <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
 <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
 <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
 <3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>
 <20250716152041-189100b1-7f5e-4388-8ada-b79ec09d18f5@linutronix.de>
 <69499cb9-b13b-4eec-a7c4-c219a77c6260@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69499cb9-b13b-4eec-a7c4-c219a77c6260@sirena.org.uk>

Hi Mark,

On Wed, Jul 16, 2025 at 03:35:09PM +0100, Mark Brown wrote:
> On Wed, Jul 16, 2025 at 03:23:24PM +0200, Thomas Weißschuh wrote:
> 
> > Can you try the following?
> > I missed this despite the double-checking after the last reported issue.
> 
> I needed to fix that up a bit, it was missing an update of the final ret
> in the function and didn't apply directly to -next for some reason so I
> had to manually apply but it seems to do the trick, thanks!
> 
> Tested-by: Mark Brown <broonie@kernel.org>

The fix for this is now in tip/timers/ptp and should be in -next tomorrow.
Thanks again for the report and sorry for the breakage.

(...)

Thomas

