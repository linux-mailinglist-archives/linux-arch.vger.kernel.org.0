Return-Path: <linux-arch+bounces-15867-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18EAD3AA8B
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF64B3019970
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543536AB46;
	Mon, 19 Jan 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jaNERwwI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLEuXHsn"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495E36999D;
	Mon, 19 Jan 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830078; cv=none; b=cp2epA1DW5DZC3bQlO/CvmtGPAVnfC2EvYtqOSG6Kcd5nUmilVdrcZ7WvOXld7cuEoR07pzi7nNJZLPmFd2/PWoUKsTVarVh4TZwgzvB7T3buLsk/CvW2nodAPhNq16QdRCFfHU/7joScK+1b8YUne27TXxKK5qdkzBicJePlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830078; c=relaxed/simple;
	bh=oVdx3cIc0dMEnIutawq+qTTWCVNcuBjYE9hqwaaxoM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGC+40Evsk7ojb+giTXlu1luA3mjEprVo96YYXHMt4p34e7KnG7J6us/5uMDqYSufTBjars0k9u+icUbjCSlq0T+CJMSjhu/Xwirl9bYlwCo2PQS9u1CH6Ha65gG2U0RM0fa1GDtCq977Fk66vx7d5TdjjKwes88br3RGV2Ax5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jaNERwwI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLEuXHsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 14:41:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768830075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8DQuCSjqZcOp0ukZjubxvPi4HiOBJqZty0BJ1RXCO4=;
	b=jaNERwwIwOe8s10At6ZYavtCo9DOHAtmhY/ziVl8LqVmv4uM0FcaONWPZWA6XrGza9SLqG
	yvMmuKZNPJVwTY2tCIJ+beFIG6OvLzMyiHFBU7On5tpEU49O3rxQRsLUztqJLXVBXLD0ZZ
	lZNkFCIubGb0JSeGwom5yIxIl2eWauzcqtvFQVJR4LxA4K8SYrn4u9tj3ThUXwY085PwnH
	yM+kuMCMBHwHJTU9BEiQzZUpbwzO3Mc/0xCSpsnlH4ezTyBkqn5Suf8499oPPUwztc0p78
	de2C74kHoo87muA5eGS/tDJ5oxZvY+hJF3cj0Ywi35Jr2+1c9brb/kzcC2pMzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768830075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8DQuCSjqZcOp0ukZjubxvPi4HiOBJqZty0BJ1RXCO4=;
	b=eLEuXHsnNhwpAu5MO+KusHxbyTsxnbvRmPuhpR4aYjFbn3FIMd1vbkN9DFtK0CZC2BXUpo
	05BX7Va86/oRcdCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <20260119100619.479bcff3@pumpkin>
 <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
 <20260119103758.3afb5927@pumpkin>
 <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
 <72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>

On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 19, 2026, at 11:56, Thomas Weißschuh wrote:
> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote:
> >> 
> >> Don't you need a check that it isn't wrong on a user system?
> >> Which is what I thought it was doing.
> >
> > Not really. The overrides defined by arch/*/include/uapi/asm/bitsperlong.h are
> > being tested here. If they work in the kernel build I assume they also work
> > in userspace.
> 
> I think You could just move check into include/asm-generic/bitsperlong.h
> to make this more obvious with the #ifdef __KERNEL__, and remove the
> disabled check from my original version there.

Ok. I'd like to keep your existing test though, as it tests something different
and it would be nice to have that too at some point.


Thomas

