Return-Path: <linux-arch+bounces-7339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0297A83C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73768B24BEF
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564E168DA;
	Mon, 16 Sep 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QrriRmjV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26C158527
	for <linux-arch@vger.kernel.org>; Mon, 16 Sep 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518035; cv=none; b=XR8hFMksygcKa2g3uo+qtTJx286acXzohBuAx/LQkL76+AdO3ub3z83c8TZhI7zu7GDjEFeYWkBXrIwzyCH76ku7KW1I6mhOXvHV/CmtBxDyx8WKHf6YJU1kp8bKIar0eQgIDpK2h7iRyqn9wG8nRw8srh1FDgiJ/XmXs+NjIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518035; c=relaxed/simple;
	bh=AIia4lKEZbObyaFYhUbFcNZrhB13MUM4zPKIfR30Obo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5yGw+JlVs/gNVUuNfqqbFgB9Eko6wUoJMsVxDHWvUBYaE112P+wG4UTeu+kh6/rA9/XsXEzpt5KOXVt2t7g88tGhg7NxQ95nY853w0VPQLxf5g/H4TpPNKRMUWfiIhHTyWU/gjca4Iga0Ep3n/D9uM7g+FoqnEb8sLBDp21cCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QrriRmjV; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id qICnsCJi7wFpSqICnsB9XJ; Mon, 16 Sep 2024 22:20:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726518025;
	bh=3Knrr3RbC4JV3H2uQiTkpSAIzSvcPBfz3YbMOwmqzNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QrriRmjVayvdZ9yvTrDorx9oh8DoqEJ9P43q3xnDcEZNreDtgqJE3mJ5HkFLby/Xx
	 jyAeNmPyXwcG/0ceO29wqGO1fVfkmlk1m+a2ocC8mtq9sHA9PcQHat6bT7aUMIAPfu
	 xyQzpH6ueoDHTTIWVUSR8dA3vMlIuJoP/Rrmxe3lVHgAJENm4GJBj6hLz3GeRvlfgW
	 sQfLtTHbVfptWrMxz5esjpPqqVSHbo+NTWyg4ZzGQQHah8gi/ZidOtVZESucMZM+PV
	 0Hrat1oFOHpBoWeQ5krLf+YsQelixQWf0T2GQqvdF2wNcVD388coEnvVe8JjJzYXeU
	 E5ApLFFl6o2fQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 16 Sep 2024 22:20:25 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
Date: Mon, 16 Sep 2024 22:20:15 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] timers: Cleanup delay/sleep related mess
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org,
 linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 07:13, Anna-Maria Behnsen a écrit :
> Hi,
> 
> a question about which sleeping function should be used in acpi_os_sleep()
> started a discussion and examination about the existing documentation and
> implementation of functions which insert a sleep/delay.
> 
> The result of the discussion was, that the documentation is outdated and
> the implemented fsleep() reflects the outdated documentation but doesn't
> help to reflect reality which in turns leads to the queue which covers the
> following things:
> 
> - Split out all timeout and sleep related functions from hrtimer.c and timer.c
>    into a separate file
> 
> - Update function descriptions of sleep related functions
> 
> - Change fsleep() to reflect reality
> 
> - Rework all comments or users which obviously rely on the outdated
>    documentation as they reference "Documentation/timers/timers-howto.rst"
> 
> - Last but not least (as there are no more references): Update the outdated
>    documentation and move it into a file with a self explaining file name
> 
> The queue is available here and applies on top of tip/timers/core:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Hi,

not directly related to your serie, but some time ago I sent a patch to 
micro-optimize Optimize usleep_range(). (See [1])

The idea is that the 2 parameters of usleep_range() are usually 
constants and some code reordering could easily let the compiler compute 
a few things at compilation time.

There was consensus on the value of the change (see [2]), but as you are 
touching things here, maybe it makes sense now to save a few cycles at 
runtime and a few bytes of code?

CJ

[1]: 
https://lore.kernel.org/all/f0361b83a0a0b549f8ec5ab8134905001a6f2509.1659126514.git.christophe.jaillet@wanadoo.fr/

[2]: 
https://lore.kernel.org/all/03c2bbe795fe4ddcab66eb852bae3715@AcuMS.aculab.com/



