Return-Path: <linux-arch+bounces-15833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B9D2DBAD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 09:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0775430334CD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78A2EAD09;
	Fri, 16 Jan 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/jQrK6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RTgGeyK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6C2C08A8;
	Fri, 16 Jan 2026 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550977; cv=none; b=tDFp0trYozUniGzI/NhFhRQ2VC3UJCbOs8hX+3/y3UCxGeUXq1dvzcQbfXTOPzGGSHYXwB5gfppS3mu9uqCqpEcxFf1U1FyOh6SkbKyuqBZ6vNN6MNnD5KrQFUK8FUNsWmfOfe4hzCoMuWSPkwN6X2q59s88HfxciTf6vXIqjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550977; c=relaxed/simple;
	bh=ymCMJZy3EhNkNMPrzpDzpHTKvbPh7HrX7sFnhPZJ5BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHSXZ4IQZZoaC6bY9/Pshy371RVFeGweztIR60PCvIjcecP73rLO3RV+PUNu5w1KtbwTxzUUT+uKl+7wReAXGfg2tuEW0PTPB1KZ6NgFD5Xacy6WH4lQaT4tYHjbHCC5oWTrYOq8+sdUPGAH6Mew92j8b4a470WEZPkAeAYvl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/jQrK6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1RTgGeyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 09:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768550974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7k58QhIZNjngBZicVsAmDNAK61KtLmcSMLd8h5nCi4=;
	b=n/jQrK6pGILQ1Blmz0AWG2qL1C7P5ppW1qkQXd8PPSUW+WIpo54gd5GWPLjWDxwNjTJuxJ
	lWWyX9AQP84xtNEX8VM4KnIseJsVTXFqCRPEuS3ELCOnzT9KRnR5TsDdEYOchKW5vPOzK2
	drgrA2uCUj8Ag5/HpRjVD5a/r4RI6VknPHvY1HGYysHHjXb+g3Og9LjzYHjUXfc1pvBUp8
	WBESpdYKd2DumNCyyFyAeRX3o18qTlB+Wloox0m8FtO6Hey0VmBXitsYWOcJ10OUFeMXa2
	6k5TFHeIPdN3lk/1iv42MFjwuum/TAO6e0Y4Lka85LsEwUR3EPzrSSiZvH/5DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768550974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7k58QhIZNjngBZicVsAmDNAK61KtLmcSMLd8h5nCi4=;
	b=1RTgGeyKfuuOE6MV0q9/AomY21M6kpPews4bSunFc0Ryfah2+5dMkSHtvg9rIqRLO3GNoX
	Vm7Tx9BqqtLmWCDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
Message-ID: <20260116090719-23bdcfe2-ee80-49bf-9545-61dd1e94e7c4@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
 <edeb782d-f413-48e6-b6b5-36961aacfcdd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edeb782d-f413-48e6-b6b5-36961aacfcdd@app.fastmail.com>

On Fri, Jan 16, 2026 at 08:49:12AM +0100, Arnd Bergmann wrote:
> On Fri, Jan 16, 2026, at 08:40, Thomas Weiﬂschuh wrote:
> > When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> > are used. These are combined with the 32-bit CFLAGS. This confuses
> > sparse, producing false-positive warnings or potentially missing
> > real issues.
> >
> > Manually override the CHECKFLAGS for the compat vDSO with the correct
> > 32-bit configuration.
> >
> > Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
> > Closes: 
> > https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kdev@gmail.com/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> > +CHECKFLAGS_32 := $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32
> > +
> >  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
> > +$(obj)/vdso32.so.dbg: CHECKFLAGS = $(CHECKFLAGS_32)
> 
> Have you checked if something like this is needed for x32 as well?

It didn't show up in my testing. I think this is explained by the x32 vDSO
being built as 64-bit and only converted to x32 afterwards.

Thomas

