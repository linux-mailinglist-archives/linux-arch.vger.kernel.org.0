Return-Path: <linux-arch+bounces-8977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C79C4598
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A5B2CCAB
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAB1AA7A4;
	Mon, 11 Nov 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="PgBd5q5e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe06.freemail.hu [46.107.16.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0B1AA790;
	Mon, 11 Nov 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351702; cv=none; b=UwW0ExHl0zHLYR2RjC7F314tonFaRvwjGM4JpR1rMvhQB1OTFetZG9PUCOOGcZCVOt2SmN2YHrkBfxcD7qo4omW3cevrWlZHdfwgLHLHst0P+ibV1xd2wAHe3ypvDjxgvhyA4U/5+jVuk5ramMtoFsrB2QUjgbYsmxXKbJwmYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351702; c=relaxed/simple;
	bh=UtSgjuzEwSV4pK01rFMS52u5MHc7iMF3VZbj5BclubE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvrYd+awDOTRSTHk9aG/1MyulINPFYqnA6C7ppli59wyefNHVVB7F9rsPaGmykCuxTIYXOMKnaKG6bigxZSpKZNyhFfVRHZfBOdErYuvcEpH2DXD9eXUdXLgG76+M3hq1Sm6qZ3x865CE+Y1rpci5/IC2Q25baOtZYFhLWZttn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=PgBd5q5e reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XnJdC4gP3zG0m;
	Mon, 11 Nov 2024 19:54:55 +0100 (CET)
Message-ID: <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
Date: Mon, 11 Nov 2024 19:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: paulmck@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1731351296;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=4004; bh=qJ/mzoKk4xgDRJxP72WGwXHAX6ngG7CWXgNfNcEi594=;
	b=PgBd5q5eHam1yg0N9i+NrmxBnFazq8c0uviLO6US4oSVUnttTQadBlXaNcHx6aH1
	EWiOwGusokhAQzuEu0AnCZ7b9zo1e/ySRTiMOjc02ShC/fnH0D4HmG4x7l3x0uql+ae
	QiAYip7QSywkJxnOSOl+tWgRlJ1tM1mtB94IswhJwRpGzKT3hfO1PQS04Z9t0Reju9A
	02FbA1RPUIa8CrNQy0Nl7KmQLH5znbIP5czZpm4hYrQM4AsmFjE6dxVBp8Xq4eHAAir
	+rF8UX0fbkYdPhNrnH6lmj7nsX/gZL3rU3RxhnAsgMzWxRuBw533mdjbx5cBBlLJtMB
	F1Izdskttg==

2024. 11. 11. 17:54 keltezéssel, Paul E. McKenney írta:
> On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> The goal is to fix Linux repository for case-insensitive filesystem,
>> to able to clone it and editable on any operating systems.
>>
>> Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
>> "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
>>
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
> 
> Ummm...  Really?
> 
> Just out of curiosity, which operating-system/filesystem combination are
> you working with?  And why not instead fix that combination to handle
> mixed case?
> 
> 							Thanx, Paul

Windows and also MacOS is not case sensitive by default. My goal is to improve 
Linux kernel source-tree, to able to develop it in any operating systems for 
example via Visual Studio Code extensions/IntelliSense feature or any similar 
IDE which is usable in any OS.

There were some accepted patches which aim this same goal.
https://gitlab.freedesktop.org/drm/kernel/-/commit/231bb9b4c42398db3114c087ba39ba00c4b7ac2c
https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?h=for-curr&id=8bf275d61925cff45568438c73f114e46237ad7e


> 
>> ---
>>   tools/memory-model/Documentation/locking.txt                    | 2 +-
>>   tools/memory-model/Documentation/recipes.txt                    | 2 +-
>>   tools/memory-model/litmus-tests/README                          | 2 +-
>>   ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
>>   4 files changed, 3 insertions(+), 3 deletions(-)
>>   rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
>>
>> diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
>> index 65c898c64a93..42bc3efe2015 100644
>> --- a/tools/memory-model/Documentation/locking.txt
>> +++ b/tools/memory-model/Documentation/locking.txt
>> @@ -184,7 +184,7 @@ ordering properties.
>>   Ordering can be extended to CPUs not holding the lock by careful use
>>   of smp_mb__after_spinlock():
>>   
>> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
>> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>>   	void CPU0(void)
>>   	{
>>   		spin_lock(&mylock);
>> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
>> index 03f58b11c252..35996eb1b690 100644
>> --- a/tools/memory-model/Documentation/recipes.txt
>> +++ b/tools/memory-model/Documentation/recipes.txt
>> @@ -159,7 +159,7 @@ lock's ordering properties.
>>   Ordering can be extended to CPUs not holding the lock by careful use
>>   of smp_mb__after_spinlock():
>>   
>> -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
>> +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
>>   	void CPU0(void)
>>   	{
>>   		spin_lock(&mylock);
>> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
>> index d311a0ff1ae6..e3d451346400 100644
>> --- a/tools/memory-model/litmus-tests/README
>> +++ b/tools/memory-model/litmus-tests/README
>> @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
>>   	spin_lock() sufficient to make ordering apparent to accesses
>>   	by a process not holding the lock?
>>   
>> -Z6.0+pooncelock+poonceLock+pombonce.litmus
>> +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>>   	As above, but with smp_mb__after_spinlock() immediately
>>   	following the spin_lock().
>>   
>> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>> similarity index 100%
>> rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
>> rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
>> -- 
>> 2.47.0.windows.2
>>


