Return-Path: <linux-arch+bounces-7623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53098DE39
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9471F26B1D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CB1CF7D4;
	Wed,  2 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ftkGpiO2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66EOsvZj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC1EEE6;
	Wed,  2 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881324; cv=none; b=eQTD/n1ZfeNUwZPCBktYN9tVRVlGpdlyFt6AXI8ABc0fUxT8ZryxyNDcOjn41+ekgf2IFMwSQXiPfCEYqTGiS31MAmTZXnpk1Iy2ZmanI4C6SnglcooR1wErHN0GnAdiSOiioTRHapZdAr4TSiS0y3+/+m2nU0mTwSDIOK5g4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881324; c=relaxed/simple;
	bh=kHPrgvuXQnFDt4DC9o2RoZFRavHHbItmknfMXeNGOgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTkydji5xL9N1NtlOyoxOTKItNdi44qno+Bz6cmrvkHEMSzYcQQ7fFCAxpXKBssiEcBAmsT7qYzHOSl4XNjtVTzaTeI1Y0hNyGaXQTRG42ut4FdfUeWsU6KQhTawFI75cfx5ozkUp1uTr07dFjuK5TNMYmB819ulgg16USsU5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ftkGpiO2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66EOsvZj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727881320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTt9TS57bBm1l7LQiiCDKRjlEdSZZZ3DNQMytk52ARU=;
	b=ftkGpiO2tQC3XBHrw0qujIV1hNeH8PfnQMQ9VwuLCIjxOCO4+RIEAn9I80jccRGLuUfOSk
	qXDh4sI7V1MWbCrSHSvJfBEk8auCJI7R8ToxkbfDQSDW3bm1jTqVibdG24MrR1GkrAzUv7
	Nglg5c6UKJD0HkpjdmTN43ERgM4RzKphWDH/FzS7rAkB6mBTwRcgr3It2HD85k6P6AksaL
	TKjMavUpYwVbOYdL7WX09DxO+A6FMPf31BDuSzqfaSYwbj/UxUygslhbSgNLXtVjaN8iVG
	f8x+SSD8udWBVY6NiUPl5wAkEiUQIWiCAFA2kEwDfY+0UziV4DdNXPHQvjrFJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727881320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTt9TS57bBm1l7LQiiCDKRjlEdSZZZ3DNQMytk52ARU=;
	b=66EOsvZjXy/H8TUUFSCmjovMyk1OBLtQIimAE8qOVHy7xmFexHyu16tDAVzVdvfGB0RUNK
	FPjKICAnWvLC8OCQ==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Frederic Weisbecker
 <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org,
 linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nathan
 Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mauro
 Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/15] timers: Cleanup delay/sleep related mess
In-Reply-To: <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
Date: Wed, 02 Oct 2024 17:02:00 +0200
Message-ID: <87ttduwntj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16 2024 at 22:20, Christophe JAILLET wrote:
> Le 11/09/2024 =C3=A0 07:13, Anna-Maria Behnsen a =C3=A9crit=C2=A0:
>
> not directly related to your serie, but some time ago I sent a patch to=20
> micro-optimize Optimize usleep_range(). (See [1])
>
> The idea is that the 2 parameters of usleep_range() are usually=20
> constants and some code reordering could easily let the compiler compute=
=20
> a few things at compilation time.
>
> There was consensus on the value of the change (see [2]), but as you are=
=20
> touching things here, maybe it makes sense now to save a few cycles at=20
> runtime and a few bytes of code?

For the price of yet another ugly interface and pushing the
multiplication into the non-constant call sites.

Seriously usleep() is not a hotpath operation and the multiplication is
not even measurable except in micro benchmarks.

Thanks,

        tglx

