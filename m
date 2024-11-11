Return-Path: <linux-arch+bounces-9018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9429C48D3
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 23:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE04FB22EF1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307CE1BD4E5;
	Mon, 11 Nov 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="Mgw4HU9T"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe06.freemail.hu [46.107.16.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF681ACDE7;
	Mon, 11 Nov 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361165; cv=none; b=BzKEdPae0dLQ3WHdoS/7QC3nrgPmRv5B8bHd2H9i8Uo6H7q41ooFK6AcdLy0/4WeAmkZivzpKTFWNQPwKSYPFlkuTo6hJ1A/FRQ4Li/jCvGoF37U0Lp9HcdXhHohimFph765kTYg2mDwGEwsw85bn98VdwDOlY7GJw5PCZbWKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361165; c=relaxed/simple;
	bh=7mtrYbKX1PzvX0aWs2QT3B2Csk5pIZ87YKCO3xMdJCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doh9TBTBoWXzyLU4+20l+q1ktJI3hukbum3fA742ZoWpm8knLeBh0G/kBdt8l4HkKiI1FvaQvDg5qxiWcncVnLGX94JnNwDqC3/qLiiXJRRWk92MSFu/TjDdsjEBfa9d6a2syzF2mfDygEfnyA14+fjQ5Gg9WoaR1FiDua2Sqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=Mgw4HU9T reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XnNGp364BzFLy;
	Mon, 11 Nov 2024 22:39:14 +0100 (CET)
Message-ID: <10ffb1e1-163d-4e30-9be3-0f229f3b7492@freemail.hu>
Date: Mon, 11 Nov 2024 22:39:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: Boqun Feng <boqun.feng@gmail.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, torvalds@linux-foundation.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <ZzJ13eM2SNNB3fl7@tardis.local>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <ZzJ13eM2SNNB3fl7@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1731361155;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=8385; bh=GJDf37E7zz9efSWD5z/VGlGxs8Mo0IVFgh397H9UMhE=;
	b=Mgw4HU9TJA0EG5rSyo4xXvh9c+4YyaQf/o9uyRKetNMB/tc4lB53J5RQ7/AEje9o
	gs7D4W3NSlrYy9hVnPeqn+oy/A3PBIuJM6FemKsl6tOqo6iweo7QuMfV/xliZ0bBayK
	I9t+QkolzEnenrJNNiGVwIW1vJ2QdLcVoTZquEtcnetEnel8ZQZexlGHafpIKnUeJgQ
	xZcDCxNhXHR983XcjfmfBrO1DK789JiT2GyZ702SUoV7mYy1VjBBLdbSkdFqR7nIw9n
	ijyMRy8bLyPexdo7vNOo17tTV+jXS2HvH+AJkI2ZMEM8WgR2kTXe2hlmDGr5RxcAGHW
	/m1z2KlptA==

2024. 11. 11. 22:23 keltezéssel, Boqun Feng írta:
> On Mon, Nov 11, 2024 at 10:15:30PM +0100, Sz"oke Benjamin wrote:
>> 2024. 11. 11. 21:29 keltezéssel, Paul E. McKenney írta:
>>> On Mon, Nov 11, 2024 at 08:56:34PM +0100, Sz"oke Benjamin wrote:
>>>> 2024. 11. 11. 20:22 keltezéssel, Paul E. McKenney írta:
>>>>> On Mon, Nov 11, 2024 at 07:52:50PM +0100, Sz"oke Benjamin wrote:
>>>>>> 2024. 11. 11. 17:54 keltezéssel, Paul E. McKenney írta:
>>>>>>> On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
>>>>>>>> From: Benjamin Sz"oke <egyszeregy@freemail.hu>
>>>>>>>>
>>>>>>>> The goal is to fix Linux repository for case-insensitive filesystem,
>>>>>>>> to able to clone it and editable on any operating systems.
>>>>>>>>
>>>>>>>> Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
>>>>>>>> "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
>>>>>>>>
>>>>>>>> Signed-off-by: Benjamin Sz"oke <egyszeregy@freemail.hu>
>>>>>>>
>>>>>>> Ummm...  Really?
>>>>>>>
>>>>>>> Just out of curiosity, which operating-system/filesystem combination are
>>>>>>> you working with?  And why not instead fix that combination to handle
>>>>>>> mixed case?
>>>>>>>
>>>>>>> 							Thanx, Paul
>>>>>>
>>>>>> Windows and also MacOS is not case sensitive by default. My goal is to
>>>>>> improve Linux kernel source-tree, to able to develop it in any operating
>>>>>> systems for example via Visual Studio Code extensions/IntelliSense feature
>>>>>> or any similar IDE which is usable in any OS.
>>>>>
>>>>> Why not simply enable case sensitivity on the file tree in which you
>>>>> are processing Linux-kernel source code?
>>>>>
>>>>> For MacOS:  https://discussions.apple.com/thread/251191099?sortBy=rank
>>>>> For Windows:  https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity
>>>>>
>>>>> In some cases it might work better to simply run a Linux VM on top of
>>>>> Windows or MacOS.
>>>>>
>>>>> They tell me that webservers already do this, so why not also for
>>>>> Linux-kernel source code?
>>>>
>>>> Why we not solve it as simple as it can in the source code of the Linux
>>>> kernel with renaming? It would be more robust and more durable to fix this
>>>> issue/inconviniant in the source as an overal complete solution. Nobody like
>>>> to figth with configuraition hell of Windows and MacOS, or build up a
>>>> diskspace consumer Virtual Linux with crappy GUI capapilities for coding big
>>>> things.
>>>>
>>>> Young developers will never be willing to join and contributing in Linux
>>>> kernel in the future if Linux kernel code is not editable in a high-quality,
>>>> easy-to-use IDE for, which is usable in any OS.
>>>
>>> There are a great number of software projects out there that use mixed
>>> case.  Therefore, can an IDE that does not gracefully handle mixed case
>>> really be said to be either high quality or easy to use?
>>>
>>> In other words, you have the option of making the IDE handle this.
>>>
>>>> Need to improve this kind of things and simplify/modernize developing or
>>>> never will be solved the following issues:
>>>> https://www.youtube.com/watch?v=lJLw94pAcBY
>>>
>>> Sorry, but that video does not support your point.  In fact, the presenter
>>> clearly states that this sort of tooling issue is not a real problem
>>> for the Linux kernel near the middle of that video.
>>>
>>> 							Thanx, Paul
>>>
>>>>>> There were some accepted patches which aim this same goal.
>>>>>> https://gitlab.freedesktop.org/drm/kernel/-/commit/231bb9b4c42398db3114c087ba39ba00c4b7ac2c
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?h=for-curr&id=8bf275d61925cff45568438c73f114e46237ad7e
>>>>>
>>>>> Fair enough, as it is the maintainer's choice.  Which means that
>>>>> their accepting these case-sensitivity changes does not require other
>>>>> maintainers to do so.
>>>>>
>>>>> 							Thanx, Paul
>>>>>
>>>>>>>> ---
>>>>>>>>      tools/memory-model/Documentation/locking.txt                    | 2 +-
>>>>>>>>      tools/memory-model/Documentation/recipes.txt                    | 2 +-
>>>>>>>>      tools/memory-model/litmus-tests/README                          | 2 +-
>>>>>>>>      ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
>>>>>>>>      4 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>>>      rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
>>>>>>>>
>>>>>>>> diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
>>>>>>>> index 65c898c64a93..42bc3efe2015 100644
>>>>>>>> --- a/tools/memory-model/Documentation/locking.txt
>>>>>>>> +++ b/tools/memory-model/Documentation/locking.txt
>>>>>>>> @@ -184,7 +184,7 @@ ordering properties.
>>>>>>>>      Ordering can be extended to CPUs not holding the lock by careful use
>>>>>>>>      of smp_mb__after_spinlock():
>>>>>>>> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
>>>>>>>> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>>>>>>>>      	void CPU0(void)
>>>>>>>>      	{
>>>>>>>>      		spin_lock(&mylock);
>>>>>>>> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
>>>>>>>> index 03f58b11c252..35996eb1b690 100644
>>>>>>>> --- a/tools/memory-model/Documentation/recipes.txt
>>>>>>>> +++ b/tools/memory-model/Documentation/recipes.txt
>>>>>>>> @@ -159,7 +159,7 @@ lock's ordering properties.
>>>>>>>>      Ordering can be extended to CPUs not holding the lock by careful use
>>>>>>>>      of smp_mb__after_spinlock():
>>>>>>>> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
>>>>>>>> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>>>>>>>>      	void CPU0(void)
>>>>>>>>      	{
>>>>>>>>      		spin_lock(&mylock);
>>>>>>>> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
>>>>>>>> index d311a0ff1ae6..e3d451346400 100644
>>>>>>>> --- a/tools/memory-model/litmus-tests/README
>>>>>>>> +++ b/tools/memory-model/litmus-tests/README
>>>>>>>> @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
>>>>>>>>      	spin_lock() sufficient to make ordering apparent to accesses
>>>>>>>>      	by a process not holding the lock?
>>>>>>>> -Z6.0+pooncelock+poonceLock+pombonce.litmus
>>>>>>>> +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>>>>>>>>      	As above, but with smp_mb__after_spinlock() immediately
>>>>>>>>      	following the spin_lock().
>>>>>>>> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>>>>>>>> similarity index 100%
>>>>>>>> rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
>>>>>>>> rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>>>>>>>> -- 
>>>>>>>> 2.47.0.windows.2
>>>>>>>>
>>>>>>
>>>>
>>
>> There is a technical issue in the Linux kernel source tree's file
>> naming/styles in git clone command on case-insensitive filesystem.
>>
>>
>> warning: the following paths have collided (e.g. case-sensitive paths
>> on a case-insensitive filesystem) and only one from the same
>> colliding group is in the working tree:
>>
>>    'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
>>    'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
>>
>>
>> As you a maintainer, what is your suggestion to fix it in the source code of
>> the Linux kernel? Please send a real technical suggestion not just how could
>> it be done in an other way (which is out of the scope now).
>>
>> Is my renaming patch correct to solve it? Question is what is the most
> 
> No, because once you do a checkout to a commit that previous to your
> changes, things are going to break again. The real "issue" is git use
> case-sensitive file names, so unless you can rewrite the whole history,
> your "solution" goes nowhere.
> 
> Regards,
> Boqun
> 
>> effective and proper fix/solution which can be commited into the Linux
>> kernel repo to fix it.


My renaming solution can not fix the old history line, but after this patch in 
latest master branch there are no any issue anymore, in git cloning. This the 
bare minimum solution which can fix its "cloning" issue for the future.

