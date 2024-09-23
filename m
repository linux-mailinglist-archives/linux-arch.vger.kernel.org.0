Return-Path: <linux-arch+bounces-7374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C97897EDD6
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE255B20AC3
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25419CC1F;
	Mon, 23 Sep 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBfKNMCo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ncg/SvYz"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF512C526;
	Mon, 23 Sep 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104381; cv=none; b=ZGo9tdZl5yAFrXG7JM570DRLGThoaQWbjQ6we/oBm42+Q2c6o23gQDIvFVnEAcKvBdjPKjYF4/a8J+DawN5JKovPya34881evC51OjIxiQqz4M3qgLJZm/CXF+Y4Qsfez+NyM/LjTdtCAkPzFTKKbH92pb54nwGXIXBQd7smCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104381; c=relaxed/simple;
	bh=cMr7bXWI7gtfyAzSse1AawSl0oobveTp5Oo0fERlJx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSomddfwlgRRhGhrKs24LtLAgDW5D9LvieIo+ce1/YOyfUcmyzO0h1HQ9y23BGzoEWSGCJ3GcBgRcQ+icnlxZ/gKqKT8TTc77iaGMh/Z7716TrCayAqz6bc24cm+svOaoSI2h36uskrtIcZYKCg6E0YKV+oSbIXjm12QqdordAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PBfKNMCo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ncg/SvYz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727104377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elBGvOspzH3iGmK1fYd/bVgzyP8I6OQGyztmlAKbFJU=;
	b=PBfKNMCoXVgqUMQ+jS8J96N56vpHFkiEIv7N0xlOaDipsFXHcUA3PDP3QEcMOcBBsigKcu
	ep2rSt1lLmY2DOAonrtcys3ggssiwc2a9tr/YB5alUERWPb6VXbNoKRZigHzcgV4755VTn
	wYk2+oEYFTBeLTvaEZ2pCcfw4KlNVPS6/D7TaIAiY0D8BB+WIJhmIwmXannp8UhBY3G1mi
	G3uxSUcypZgacKtqZK/L7EwPqpg1IfqrNDdQvgliRnYaxsk4TTzPhYuwSgE1DT6uKROso/
	5t/eiTVejV5slXI2ZzVLWwCneMD86d/J/xsNeJTYKgO8rphcsMBTmkNWCz+K2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727104377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elBGvOspzH3iGmK1fYd/bVgzyP8I6OQGyztmlAKbFJU=;
	b=Ncg/SvYzGFuvGC711XUusZn2/nNt5VKfdynTFfYe/Dj4+RDnjWTCN3ea404B/VToJ/4LZq
	lwKy9a1/BRdLjSCQ==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org,
 SeongJae Park <sj@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>, Joe
 Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, netdev@vger.kernel.org, linux-sound@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch
 <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 00/15] timers: Cleanup delay/sleep related mess
In-Reply-To: <6cbedd50-c2d5-4ad7-8133-774eebd9d2f1@wanadoo.fr>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
 <6cbedd50-c2d5-4ad7-8133-774eebd9d2f1@wanadoo.fr>
Date: Mon, 23 Sep 2024 17:12:56 +0200
Message-ID: <87ed5aietj.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> Le 16/09/2024 =C3=A0 22:20, Christophe JAILLET a =C3=A9crit=C2=A0:
>> Le 11/09/2024 =C3=A0 07:13, Anna-Maria Behnsen a =C3=A9crit=C2=A0:
>>> Hi,
>>>
>>> a question about which sleeping function should be used in=20
>>> acpi_os_sleep()
>>> started a discussion and examination about the existing documentation a=
nd
>>> implementation of functions which insert a sleep/delay.
>>>
>>> The result of the discussion was, that the documentation is outdated and
>>> the implemented fsleep() reflects the outdated documentation but doesn't
>>> help to reflect reality which in turns leads to the queue which covers=
=20
>>> the
>>> following things:
>>>
>>> - Split out all timeout and sleep related functions from hrtimer.c and=
=20
>>> timer.c
>>> =C2=A0=C2=A0 into a separate file
>>>
>>> - Update function descriptions of sleep related functions
>>>
>>> - Change fsleep() to reflect reality
>>>
>>> - Rework all comments or users which obviously rely on the outdated
>>> =C2=A0=C2=A0 documentation as they reference "Documentation/timers/time=
rs-=20
>>> howto.rst"
>>>
>>> - Last but not least (as there are no more references): Update the=20
>>> outdated
>>> =C2=A0=C2=A0 documentation and move it into a file with a self explaini=
ng file name
>>>
>>> The queue is available here and applies on top of tip/timers/core:
>>>
>>> =C2=A0=C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/l=
inux-=20
>>> devel.git timers/misc
>>>
>>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>>=20
>> Hi,
>>=20
>> not directly related to your serie, but some time ago I sent a patch to=
=20
>> micro-optimize Optimize usleep_range(). (See [1])
>>=20
>> The idea is that the 2 parameters of usleep_range() are usually=20
>> constants and some code reordering could easily let the compiler compute=
=20
>> a few things at compilation time.
>>=20
>> There was consensus on the value of the change (see [2]), but as you are=
=20
>
> Typo: there was *no* consensus...
>
>> touching things here, maybe it makes sense now to save a few cycles at=20
>> runtime and a few bytes of code?
>>=20

Sorry for the late reply. I'll check it and will come back to you.

Thanks,
	Anna-Maria


