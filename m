Return-Path: <linux-arch+bounces-8264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB269A37FC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 10:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC791C21CCF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C318C919;
	Fri, 18 Oct 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9wltJqq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPAq467j"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0B13C816;
	Fri, 18 Oct 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238798; cv=none; b=SSs9yCSZ7+327yIdtegDxO/H3qhcJs1q7WHJNUS0xCsu87yS/cAQaKguaIRs3V1RRZqNCwiflR8F3Se0dCiYlGfbxI/K7+YGpeQ3Vm95FfuV+BxlUQ3xbKcN1fMFNkyAkjSyH+ty/yi5mUGlNdTxs1nkzuSwSCkPvAGYI38NpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238798; c=relaxed/simple;
	bh=ANf6BuYGKL8opnpub7chBIoyi0bE06rU2iYJHMT6R38=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=ECPOqgOqEwR0ok5oAtxXRkjsm8UeHhIzD313FyCPw86DnflWFY4/P/NxYrbdTEWI2o6Pgyx9GZO0kTb94HgOe9foOnRA2yXYZxaZulbDLJxZofqu8+QfCOeJJIshtnNk8ky4bd2EKviYd16oZBBi7sdfTa7ixbbyTUcqN7oJ+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9wltJqq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPAq467j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729238795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9qhF6W1c/3/sG23aEO9tLagb3+CHQYJpHJvqkXIB/Ps=;
	b=E9wltJqqE4fpTBnohMvI18TXh8lPPJ1Xtmu5Vy77l1LIB2eppmb7XTrSNgkqxY1J9iGgqY
	deOgqo2bNx19ak+L55Px9Y/RlpgE9brajnjSPWAch6FhSgDdXA0XSXbigUYjFSoDA1KsiZ
	dKPei3MRJhYXcAULfdZSikT4LhmtMgU8R9M4Oi4eL+Z9Aile6jBfvdzz+oYC0RK6Vg2KPC
	9YE4ulAzTbxmThmqCQJV8lSNJ/lrVSaiVCgYpflQMZSBmx39XQRZgN2lEmgM0VYUOhCFX1
	Vw6CZAE5hDi7XGzEKarvxVV3Zor6oqprypgIZgO3XRZwjK6ixSnNNUBkzWDlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729238795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9qhF6W1c/3/sG23aEO9tLagb3+CHQYJpHJvqkXIB/Ps=;
	b=iPAq467jfirDKuvqaYCqXV9px/5Hu6TKGIkeCKSsovGUgr3GHHObss64N8oXRTuUbh1ytG
	POelUJ7DqUtCAHAA==
To: Mark Brown <broonie@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, Alice
 Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 netdev@vger.kernel.org, linux-sound@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-media@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: (subset) [PATCH v3 00/16] timers: Cleanup delay/sleep related mess
In-Reply-To: <172892295715.1548.770734377772758528.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 10:06:33 +0200
Message-ID: <877ca5al86.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mark,

Mark Brown <broonie@kernel.org> writes:

> On Mon, 14 Oct 2024 10:22:17 +0200, Anna-Maria Behnsen wrote:
>> a question about which sleeping function should be used in acpi_os_sleep()
>> started a discussion and examination about the existing documentation and
>> implementation of functions which insert a sleep/delay.
>> 
>> The result of the discussion was, that the documentation is outdated and
>> the implemented fsleep() reflects the outdated documentation but doesn't
>> help to reflect reality which in turns leads to the queue which covers the
>> following things:
>> 
>> [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
>

Would it be ok for you, if the patch is routed through tip tree? kernel
test robot triggers a warning for htmldoc that there is a reference to
the no longer existing file 'timer-howto.rst':

  https://lore.kernel.org/r/202410161059.a0f6IBwj-lkp@intel.com

Thanks,

	Anna-Maria

