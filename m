Return-Path: <linux-arch+bounces-12806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D42B075CC
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918E01C26C1E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB522F5324;
	Wed, 16 Jul 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jr7yW1St";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhtKs3oC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7A2F50A2;
	Wed, 16 Jul 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669298; cv=none; b=VlLlTs4GczpkqhdLojX+XWuemAQgRXho/kY8o0Ul9LuewHMGYktbR2KwmYFCZLVeyb52Dw4eBiKZTcWVkUrEBKlOsK7UgFcCzFR2xQJhcPZXvM3vapslOWVjseAtT2zHgrZozv8mI+AIbDSDB6yRBxusWty4ab68zQEAYiG+gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669298; c=relaxed/simple;
	bh=gkTA+RqjCHC68tJbw4bD81duBd7b8LW939bw6ak6h7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlvqxxeVedLWanPmX/+YD9W1NSRMOQQWEBm7vzwznkP07UME6sGOEHLe106/Pf1TgmFpumgFxuzHlq9xyNckhseb5xOGQ/AcIuE9hFsxvqvAeFo+f37Tc4lKVkqU56WnbDzznVW0z46hS1g+SV7ctMiOKa1rMplVQZZBY5sa+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jr7yW1St; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhtKs3oC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 14:34:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752669294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fEnjbbKyTxyrZsE1OYbDMRhkU2rjxm5lmX9q9XVcTQ=;
	b=jr7yW1StQGvdmfSH/ntkCN484pPYyrdQ8ebehJqFX5XvF8hFghBWTm+XawIPGkVqU6odhF
	2EMKo5rmskotYgZlv8Tlbpr2uCok6p4PAwVqFAFCC5IPDeFCXZmqGau3JaH08Jrzk2QC+o
	kBPXyzNA0pM02cpthWmofqQAzdr1X/1naxZoxtUinlKT2FMuI+lgSAkacj7IzWtadVxTXu
	gXJSWBEkVzyVoDrkxiJWHEOPOXpqjtqqrcc1L7m/A7vDbS4qS5rfTbbqoUYB0e9r6oCyIQ
	1gSR5QbSEGGLOaaStaahTqf3h4YcdoW7M4UBilgSKHDF3hi0EDCbGGB442KUDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752669295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fEnjbbKyTxyrZsE1OYbDMRhkU2rjxm5lmX9q9XVcTQ=;
	b=lhtKs3oCgqYEqqeqZs0f/3dzh4LmhYhJC7i0EzznnY3yCMvYZRqS7ygS8danxe5AXG2dWA
	s/2x9DTvzFI6hUBg==
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
Message-ID: <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
 <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>

On Wed, Jul 16, 2025 at 01:25:06PM +0100, Mark Brown wrote:
> On Wed, Jul 09, 2025 at 10:04:21AM +0200, Marek Szyprowski wrote:
> > On 09.07.2025 09:34, Thomas Weißschuh wrote:
> > > On Tue, Jul 08, 2025 at 05:49:18PM +0200, Marek Szyprowski wrote:
> 
> > > This fix looks correct to me.
> 
> > > tglx:
> 
> > > Are you going to fold the fix into the commit or do you want a proper patch?
> 
> > > Marek:
> 
> > > If a new patch is required, do you want to send it? You found and fixed the
> > > issue after all. If not, I'll take care of it.
> 
> > If it is possible to fold it into original patch then go ahead, it would 
> > make less noise imho. If you need a formal patch, I can send it in a few 
> > minutes.
> 
> This issue has been present in -next for a week and is causing a bunch
> of disruption to tests that end up relying on the vDSO - do we have any
> news on getting a fix merged?  Perhaps it makes sense for Marek to just
> send his patch so that it's there if needed?

That fix has been in -next since next-20250710.
If you still have issues, I'll take a look.


Thomas

