Return-Path: <linux-arch+bounces-7342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331697AAF7
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 07:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C9D1F24127
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 05:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1D7BB15;
	Tue, 17 Sep 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="uE7YHFnc"
X-Original-To: linux-arch@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8124F20C
	for <linux-arch@vger.kernel.org>; Tue, 17 Sep 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550538; cv=none; b=MZdUbXWbP3CBXQPp8DuXSu48ZCMrHJzKwc6o7HUCAPbgbejQTaL3KX5PC9F3K9EajFWN37O3EZEih3u2FREVfITddsbhJZ7QQ8vOp/wQV85nydKvinvcc/MsGQ7fkac0nxFJ016oWlVnNiKLQlNxxxtNf+uo04Xx1p4b/jbI7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550538; c=relaxed/simple;
	bh=FROrw0IXlzItQSfhHRHUvjIOTBu4ABMZqIMKJtQffAE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BtadYQCUYOYGqWlTYn9BGxpKuog4ezH7ZAgJuJ+6FRpzumlmM1FKQCyXilUmlr6HgthRiUZwcOEdRBvtWvk242+7isv8VYBkja4FzH8hv5Xf1tFyY+8uTZej6QKkZbxbG6ELCrR725UsnlaOd/Bxlg1vwmr2ZEXrGkJzAslsGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=uE7YHFnc; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id qQf2sEuii3ZMyqQf2s4PfP; Tue, 17 Sep 2024 07:22:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726550528;
	bh=ox/BUEVjGvecYqicoCV10v4Q9kXMIsRKDm9TgbacwPA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=uE7YHFncSbIkns75ceMLvKBWR2lLESwDluJGLQhQBCQV5lrcOaRwCaTNTSOfcQpVq
	 HJm+j7e1uOEsx+GUZ7TkF+WOOqssb6mQ20ALFlGIaRf9KYFvSjIxmC0ctChK9RKjkP
	 VHegYqJfxnmpTt+hhya69OXSYxRcdh4NY3Nx4ludydVSWdFFHnCuY48Vq5d4BGuFHH
	 iIBCrqPhkEWoNiBUDqoomBPmojMFvpSGzksiXevYTJzesiUhHvUmNIIDj1if0WR1dK
	 bCJHsDM4ZJQSKYDiq97zSpNKRY9B+XwVjxgT8qhAE/jWfxA728uT22uHSOZu+Yfgmr
	 KFRvY0tmnJyeg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 17 Sep 2024 07:22:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <6cbedd50-c2d5-4ad7-8133-774eebd9d2f1@wanadoo.fr>
Date: Tue, 17 Sep 2024 07:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 00/15] timers: Cleanup delay/sleep related mess
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
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
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <c794b4a6-468d-4552-a6d6-8185f49339d3@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/09/2024 à 22:20, Christophe JAILLET a écrit :
> Le 11/09/2024 à 07:13, Anna-Maria Behnsen a écrit :
>> Hi,
>>
>> a question about which sleeping function should be used in 
>> acpi_os_sleep()
>> started a discussion and examination about the existing documentation and
>> implementation of functions which insert a sleep/delay.
>>
>> The result of the discussion was, that the documentation is outdated and
>> the implemented fsleep() reflects the outdated documentation but doesn't
>> help to reflect reality which in turns leads to the queue which covers 
>> the
>> following things:
>>
>> - Split out all timeout and sleep related functions from hrtimer.c and 
>> timer.c
>>    into a separate file
>>
>> - Update function descriptions of sleep related functions
>>
>> - Change fsleep() to reflect reality
>>
>> - Rework all comments or users which obviously rely on the outdated
>>    documentation as they reference "Documentation/timers/timers- 
>> howto.rst"
>>
>> - Last but not least (as there are no more references): Update the 
>> outdated
>>    documentation and move it into a file with a self explaining file name
>>
>> The queue is available here and applies on top of tip/timers/core:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux- 
>> devel.git timers/misc
>>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> 
> Hi,
> 
> not directly related to your serie, but some time ago I sent a patch to 
> micro-optimize Optimize usleep_range(). (See [1])
> 
> The idea is that the 2 parameters of usleep_range() are usually 
> constants and some code reordering could easily let the compiler compute 
> a few things at compilation time.
> 
> There was consensus on the value of the change (see [2]), but as you are 

Typo: there was *no* consensus...

> touching things here, maybe it makes sense now to save a few cycles at 
> runtime and a few bytes of code?
> 
> CJ
> 
> [1]: https://lore.kernel.org/all/ 
> f0361b83a0a0b549f8ec5ab8134905001a6f2509.1659126514.git.christophe.jaillet@wanadoo.fr/
> 
> [2]: https://lore.kernel.org/ 
> all/03c2bbe795fe4ddcab66eb852bae3715@AcuMS.aculab.com/
> 
> 
> 
> 


