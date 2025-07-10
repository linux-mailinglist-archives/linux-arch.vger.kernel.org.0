Return-Path: <linux-arch+bounces-12625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6588AFFA0C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A8D3A6603
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418821DDD1;
	Thu, 10 Jul 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="utTOpPZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqPrZSVD"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872152E36F1;
	Thu, 10 Jul 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129941; cv=none; b=M4q7r7shTEzwJdaujjSKzWp67EHx0rEJ0KFxR8sbRHGr4++kLqEmHfpEH2Wn5g1od1Q3NIVqahQ7+bgkD5OQ33Msh4sCUgw9F4vgeJi5Z+2sady5hL71TVUeEKtRW8WxiXRzPn4AeE9PGTGkVnNanuw4ImP6spzdaOlrQT1Z0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129941; c=relaxed/simple;
	bh=vEraTyZu/cB91N9OhUSTcFV7TlgH8A/Vl0OqqTepf84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldzt0llaw9iaSBbnHMZwpMvixSTnENm2wMRvJjORWaQwMjLLcUNTCj0zVRrD7MYFlShbhkoXLEuOqv+qo11q/FosYwuHToGGM/X2P+HBnPCC+G7WSClRHLFu50oEqJozaImk6t65f0VBprCIdh+ygYawGj0Dwn16PQsrVElZlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=utTOpPZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqPrZSVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 08:45:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752129937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEraTyZu/cB91N9OhUSTcFV7TlgH8A/Vl0OqqTepf84=;
	b=utTOpPZ3Rr5l8NMuhIPetHGpxhd0tKFMuY8koLXmylBNlhA7a0i1FT/HadVhURS0cRk2oO
	REfhl6TCj7DSAOutwu6sLPVx7DShHlD4wH+eoX9P6ohPAzByRVW6jIa+HgrRGfTxudwRdD
	ErfXmeGddfJmXFgb6tWG5Jnkwe6nyT0ivfJcZZlz9YeDXomdyY66TzNwD8yIPK/GzwAS9A
	7JSonn3edG/vCd7yaW/2uQf05TmoO3bMnaHTZtQ80Iy7d3DDt9RcLdHBGTQpP7O4WqMqrU
	0F0YrQPqWwRQAzA9arYgNKBdgQD3Hxb5El6MV4XYme1+m3UzfZWNlV5cMawuug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752129937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEraTyZu/cB91N9OhUSTcFV7TlgH8A/Vl0OqqTepf84=;
	b=EqPrZSVDHE9txmU3vmPhXr4VBExvS+/rQq0MWOrBauSTx+GCSEz837og4V9ziUynF1Txij
	qLWXkPt+pBMbTlDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH] vdso/gettimeofday: Fix code refactoring
Message-ID: <20250710084337-0c82b93c-85f2-4305-95ba-8cb14042aed2@linutronix.de>
References: <CGME20250710062301eucas1p1b61431dc31a5933087b45c246866fb17@eucas1p1.samsung.com>
 <20250710062249.3533485-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710062249.3533485-1-m.szyprowski@samsung.com>

Hi Marek,

On Thu, Jul 10, 2025 at 08:22:49AM +0200, Marek Szyprowski wrote:
> Commit fcc8e46f768f ("vdso/gettimeofday: Return bool from clock_gettime()
> helpers") changed the return value from clock_gettime() helpers, but it
> missed updating the one call to the do_hres() function, what breaks VDSO
> operation on some of my ARM 32bit based test boards. Fix this.

Thanks again for the report and fix.
This change has already been folded into the original commit by tglx.
It should show up in todays -next tree.

> Fixes: fcc8e46f768f ("vdso/gettimeofday: Return bool from clock_gettime() helpers")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Thomas

