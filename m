Return-Path: <linux-arch+bounces-13924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC9BBD9EE
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA57B34A0A4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3D221F2D;
	Mon,  6 Oct 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xv+hHh8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVUQ4z9n"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2121FF33;
	Mon,  6 Oct 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745335; cv=none; b=XSrk8th02wZYk7gSxZ4/qj5ItypUsqIBLeX2sL9UUPKLTD3yvaapqUYmASy2FnEt+3MR9kezWTuTBlA6PmRi+tugfou18NK34lmep8Eqed1YrHpxVAHa1GjmjnjMrLiWT3DwFebKioXP7KrPifIrAfwUT8UWKiMVvI1U3HsxlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745335; c=relaxed/simple;
	bh=nfEsxyB4YyiAx7fj233Qw7pmXuD415nurNZ6hP7+ylg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qv82BWl4y+7B8jnOZxY5ZZaelybGykDy5FBUnl4pgW9ybUSmdQr3tOlSSlYGea+wZCyEJQbkkEPtCdoaq+ji+oaQIpXnDjps5q5VggLQUnA5jYbjHT3nJB8j5aazB2AzDVAf5+OUpwBPLQTkqTkQ3p3A3Olh8vWWUc76+mZsELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xv+hHh8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVUQ4z9n; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D3C41400129;
	Mon,  6 Oct 2025 06:08:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 06 Oct 2025 06:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759745331;
	 x=1759831731; bh=v9jcf12RMaGrVw1XHniiTo8z5pZT/QU9LYYWNAmYHBw=; b=
	xv+hHh8XwAkyDCB0Yn+qhFVv4aoeSIrhaMBUxdwjMDm7N88o1hTC0jjzP5rYzAN2
	vbv65JzB4SqZckiFcfAbiWexxjuf0NxBSxzpy4q8TeP086JANgnK6tu9/ZJY4hAY
	1w+YdcBb2PVAIh9bLjGx2DPxHG1ejKWBBKxP9rjVORMfKunN5r3ZNsn2yom8i/DQ
	lYCRwGJPl20Iu3UBfTgfcyUeZ5QghivjHlfTgjf7zO0RfI98sR3iM4/2yAp15pry
	3rR5JVxkQR8d1tpUTE+vA+zx3KcFNMiEmGZ18UL8uYZhqn8oSmm9RFw+lauZsJst
	NxiRYcsZXH47P6nio7FMdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759745331; x=
	1759831731; bh=v9jcf12RMaGrVw1XHniiTo8z5pZT/QU9LYYWNAmYHBw=; b=N
	VUQ4z9ngSFNOvYi05t7YhWg2wqYSKuRStbVc6WddSV0iBtZ9tst+8BklrEGNU7hJ
	8vclI2dwWvRzqAyvARC9ywc6e5PGRS/Ua5NNmRP/fUTOPo2f61RZeHdnMdTqdqJk
	T3bIl047WRTpwB8MrJXQCdE03C/UV65i1H40EAX2MnPQacaFIeXgFvru5RPuY4oN
	m3Ql8Xd/O2s3CRWkTwy2cv6Ij0KcVvgsuTnah6OnEcVAvBHWNA3KHJ4QOFoZnplX
	BfKLHf1CKu0mvzr9cDhAqlrV0O0gwWCyA+rD/JJWkDEqlmcR5hLp/wQahMquoDs4
	kcAl0zs75Ml91k2aujuvA==
X-ME-Sender: <xms:MpXjaAhz3bg7rO_MipAdFV2E63wVZgjZg01j3Kv16ZdOGd1FNrGJkA>
    <xme:MpXjaD3-kYK04oG7Odi_X7CuMry2wNCcFYcgCHehO73Yv1Pj5XiZWyQlA5qaVfhtq
    X7cPtIYJRTRFoZJlnLQ3C_zjTT94N80UXn7ZP9aJokKYuP1pK2HYiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:MpXjaEd--Hn2WCVfuO3jVfW1QyYPJClRtvmZ0rkcw5g6WDcAbDfV-w>
    <xmx:MpXjaMkMIH4awT4Y3WN7AfaGUlEGEaiFggyFkZ_GAzBIefuLbKwwAw>
    <xmx:MpXjaBwpXhME92KoWQnTBlTtW9PeXOSfz5NTqmijKdkhFS9S3YZgoQ>
    <xmx:MpXjaHxIRGtZ7XbsSMc8VUFQZgmANWPFVKtwIVy6YMwFS_erbwoRzA>
    <xmx:M5XjaNrf9Bl03eUUGqMzuPGctKDLOsZa4nh1M78S7-8tbgAP6DDKOSfA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B803E700069; Mon,  6 Oct 2025 06:08:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Mon, 06 Oct 2025 12:07:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <d9e3f41e-d152-4382-bb99-7b134ff9f26f@app.fastmail.com>
In-Reply-To: <257a045a-f39d-8565-608f-f01f7914be21@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
 <257a045a-f39d-8565-608f-f01f7914be21@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 11:25, Finn Thain wrote:
> On Tue, 30 Sep 2025, Arnd Bergmann wrote:
>> On Tue, Sep 30, 2025, at 04:18, Finn Thain wrote:
>> 
>> Since there is nothing telling the compiler that the 'old' argument to 
>> atomic*_try_cmpcxchg() needs to be naturally aligned, maybe that check 
>> should be changed to only test for the ABI-guaranteed alignment? I think 
>> that would still be needed on x86-32.
>>  
>> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
>> index 9409a6ddf3e0..e57763a889bd 100644
>> --- a/include/linux/atomic/atomic-instrumented.h
>> +++ b/include/linux/atomic/atomic-instrumented.h
>> @@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>>  {
>>  	kcsan_mb();
>>  	instrument_atomic_read_write(v, sizeof(*v));
>> -	instrument_atomic_read_write(old, sizeof(*old));
>> +	instrument_atomic_read_write(old, alignof(*old));
>>  	return raw_atomic_try_cmpxchg(v, old, new);
>>  }
>>  
>
> In the same file, we have:
>
> #define try_cmpxchg(ptr, oldp, ...) \
> ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
>         kcsan_mb(); \
>         instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> })
>
> In try_cmpxchg(), unlike atomic_try_cmpxchg(), the 'old' parameter is 
> checked by instrument_read_write() instead of 
> instrument_atomic_read_write(), which suggests a different patch.

Right, we still need the effect of instrument_read_write() for
kasan/kcsan sanitizing with the correct size, only the alignment
check from the instrument_atomic_read_write() is wrong here
here.

It looks like Mark Rutland fixed the try_cmpxchg() function this
way in commit ec570320b09f ("locking/atomic: Correct (cmp)xchg()
instrumentation"), but for some reason we still have the wrong
annotation on the atomic_try_cmpxchg() helpers.


> This header is generated by a script so the change below would be more 
> complicated in practice.
>
> diff --git a/include/linux/atomic/atomic-instrumented.h 
> b/include/linux/atomic/atomic-instrumented.h
> index 9409a6ddf3e0..ce3890bcd903 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>  {
>  	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
> -	instrument_atomic_read_write(old, sizeof(*old));
> +	instrument_read_write(old, sizeof(*old));
>  	return raw_atomic_try_cmpxchg(v, old, new);
>  }

This looks good to me.

Mark, I've tried to modify your script to produce that output,
the output looks correct to me, but it makes the script more
complex than I liked and I'm not sure that matching on
"${type}"="p" is the best way to check for this.

Maybe you can come up with a version that is clearer or more robust.

      Arnd

diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 592f3ec89b5f..9c1d53f81eb2 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -12,7 +12,7 @@ gen_param_check()
 	local arg="$1"; shift
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
-	local rw="write"
+	local rw="atomic_write"
 
 	case "${type#c}" in
 	i) return;;
@@ -20,14 +20,17 @@ gen_param_check()
 
 	if [ ${type#c} != ${type} ]; then
 		# We don't write to constant parameters.
-		rw="read"
+		rw="atomic_read"
+	elif [ "${type}" = "p" ] ; then
+		# The "old" argument in try_cmpxchg() gets accessed non-atomically
+		rw="read_write"
 	elif [ "${meta}" != "s" ]; then
 		# An atomic RMW: if this parameter is not a constant, and this atomic is
 		# not just a 's'tore, this parameter is both read from and written to.
-		rw="read_write"
+		rw="atomic_read_write"
 	fi
 
-	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tinstrument_${rw}(${name}, sizeof(*${name}));\n"
 }
 
 #gen_params_checks(meta, arg...)


