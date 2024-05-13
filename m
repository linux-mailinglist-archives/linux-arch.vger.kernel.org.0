Return-Path: <linux-arch+bounces-4351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A695D8C3A8D
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 05:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82A21C20E31
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BE2145B38;
	Mon, 13 May 2024 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAsKf9af"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1717550;
	Mon, 13 May 2024 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715572212; cv=none; b=SIQwAjawQdY8mUMGMP5QW+VrdQMgJNIhO3QelSfkSManJQSjhLfR/JkcpkGxSMV7iQrk0sD1XHHS2wZFyHvKv9r0DJXqmRRlbxNKJjwNJcZZY3E83GkLJvPHDtu18aIKe/JOquQtqYNXpUy//wqrXjYKTZQFL8vnQJvKH9ku5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715572212; c=relaxed/simple;
	bh=MGTswH+ycDm+Z0xLNMLXbS/39xZfnuBcHx01JRhTwW8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jhDs2rW9Ulk+gyd97ag2kflxZZC+BlG6ijb4vZ4HIvJUx+Gy4+9K6k/ifHmI57qrt4/RnsQEB9r1JzHiU+tc519fKpCB4djDCCmlOKIHZAxA1rwOR/0Qb2ahKZbaRQ56NxcS1hu8x7Bb6BWpBE9CsGxQxUaDquUNNid3Qad/d6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAsKf9af; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso1003803b3a.1;
        Sun, 12 May 2024 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715572211; x=1716177011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukfBIF37rYMMlBPzD+fTpi6myzQQyGmtqO3iNDaaqS8=;
        b=kAsKf9afiFPMjNlJPWO6z3a1kuI4UNX5aqeOYnDCUrjphhB9iZ8P5HsYojmW3UyM9q
         vSx0HcSTszazbYXCMFIfS+j7MZ4S2gHQZDjxRRf4umK+L/YAsj/KQmG3PY6pfmGFL/iV
         +hQwP5qtqDjweCbugBREwLQyJED05eIlp73FMDKF0KoVWOOw0ya506Xs76PS3Zz9JORh
         dYvE1gWQnO9TwvFlvwLrAALnKaep/qhEAU7tDkNDeh/lVb3jdxloCcehFrTl8uD6P8pb
         9QJZuyyapG3o/BHIt7+4pEYIDK14h7Eftw8KZ7GLn4OxBoxnWFkWlpuL4q20LRh7dXjF
         aEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715572211; x=1716177011;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukfBIF37rYMMlBPzD+fTpi6myzQQyGmtqO3iNDaaqS8=;
        b=dBksP8JnbvQ50gMC3JM6uifTEQ4NS8EWxILUwhjNt2uIYsCBf20FKMPu35yOwu5EtP
         98u9vDJLE5I+PrBvq6N6erjlk1GcXrDDsJSNt4Qk55F/0XNxckNt+xrmUJfeso+wt8Y6
         8uTPlUvycWaw0g7gGNQk2oL5ru/2SYMUid9W2SvL62+zTDYcMvbCgb3Us9JoNSWdWGEe
         ihHokMao0t5TjqTnFnURdM1OsAsmWqix4Ah1dx5SibDnU+GSU3jnAoqJDXMlvO5HQm0/
         +Y1In+5LpgS8eBejSvxJXVZvCcGmbDgr9ViyRuoVpUP8jHurR3JEo1bLYBj97qPKDFjW
         cyGw==
X-Forwarded-Encrypted: i=1; AJvYcCVZA7ZfQTYvsznGSFCxRA9isT5kZ/onYVJhNedy0avmtmCDZ1HprnwqfDwtUEIVHojjxz7o0hYbkHQrNG5l9phpW/AczwMk8C6cNO5MD3q7LSNfh/pHgnqmgCBut3EjMGAvdmcpQPp4Vh6bXDJKTVSFeMzR7e1/mjmIBY1e6wSCxGIF5aqO
X-Gm-Message-State: AOJu0Yx3rqIsEqEah6qCr5OY2VfGeG9IC4CCiyjovDicbl355Jz/TVFU
	3jSoeYFHGilqBZ8ASU/pAHr+3FnRkXPl2BZbBkLE2Jj8TesiXB1s
X-Google-Smtp-Source: AGHT+IHO8M41Do1dDcsR6nTZkVpeexuJXyYUCU/JTWttd4o8GfkoIc6EzsHuj3ww08xSWPBGErev1Q==
X-Received: by 2002:a05:6a00:140f:b0:6f4:4d09:15f8 with SMTP id d2e1a72fcca58-6f4c90b5d8amr16267889b3a.5.1715572210732;
        Sun, 12 May 2024 20:50:10 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66c43sm6380673b3a.9.2024.05.12.20.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 20:50:10 -0700 (PDT)
Message-ID: <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
Date: Mon, 13 May 2024 12:50:07 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: paulmck@kernel.org
Cc: arnd@arndb.de, glaubitz@physik.fu-berlin.de, ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, mattst88@gmail.com,
 richard.henderson@linaro.org, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, Ulrich Teichert <krypton@ulrich-teichert.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 07:44:25 -0700, Paul E. McKenney wrote:
> On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote:
>> On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
>> > And that breaks things because it can clobber concurrent stores to
>> > other bytes in that enclosing machine word.
>> 
>> But pre-EV56 Alpha has always been like this. What makes it broken
>> all of a sudden?
> 
> I doubt if it was sudden.   Putting concurrently (but rarely) accessed
> small-value quantities into single bytes is a very natural thing to do,
> and I bet that there are quite a few places in the kernel where exactly
> this happens.  I happen to know of a specific instance that went into
> mainline about two years ago.
> 
> So why didn't the people running current mainline on pre-EV56 Alpha
> systems notice?  One possibility is that they are upgrading their
> kernels only occasionally.  Another possibility is that they are seeing
> the failures, but are not tracing the obtuse failure modes back to the
> change(s) in question.  Yet another possibility is that the resulting
> failures are very low probability, with mean times to failure that are
> so long that you won't notice anything on a single system.

Another possibility is that the Jensen system was booted into uni processer
mode.  Looking at the early boot log [1] provided by Ulrich (+CCed) back in
Sept. 2021, I see the following by running "grep -i cpu":

>> > [1] https://marc.info/?l=linux-alpha&m=163265555616841&w=2

[    0.000000] Memory: 90256K/131072K available (8897K kernel code, 9499K rwdata, \
2704K rodata, 312K init, 437K bss, 40816K reserved, 0K cma-reserved) [    0.000000] \
random: get_random_u64 called from __kmem_cache_create+0x54/0x600 with crng_init=0 [  \
0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1 [    0.000000]
                                                     ^^^^^^

Without any concurrent atomic updates, the "broken" atomic accesses won't
matter, I guess.

        Thanks, Akira


