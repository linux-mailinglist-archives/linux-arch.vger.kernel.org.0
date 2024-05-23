Return-Path: <linux-arch+bounces-4503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888F8CD5B9
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B36B207CF
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1CC14B96C;
	Thu, 23 May 2024 14:28:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51B13DBA0;
	Thu, 23 May 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474482; cv=none; b=JmZUhbhUV2CK7PaKmbge3o0neDmPTTA2bQ2aL4ycXjxiWCvk7c3gJKLzivkh+raFTKpGSd73l4B4G7ccCA6PA2Fy22QOJsBg8fmRsDULeKL4qInYLB2MwWtmjcaBumkHLmFYMe3QW1lQXLINR3avL8qVnXfCz5jzFaxcvObjYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474482; c=relaxed/simple;
	bh=eB/7rWESfrYmRqM6rr4HsTv1P8DImOvlfke5DBkb77A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxN8HI2BcIPa8l9et6HHnltTqimcPEkX+BozQdyW4h+X9Ej5OZwXIDfpwwkXnAgSsSZQoauedbSFUv8ooJ7pCK61gJ5cEB13tdknrB7ihjmTF/2x86swuhrcb510HCDZYR7bx1RIo2f7+Am7cxEr3st7iQOdrkB/j0P/KkrPH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VlVM46bgQz9v7Jb;
	Thu, 23 May 2024 22:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C614D1407F5;
	Thu, 23 May 2024 22:27:43 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwAXAydUUk9moRnACA--.19046S2;
	Thu, 23 May 2024 15:27:43 +0100 (CET)
Message-ID: <73e08b17-cb2a-4e14-a94f-7144c5738684@huaweicloud.com>
Date: Thu, 23 May 2024 16:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Andrea Parri <parri.andrea@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, boqun.feng@gmail.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <Zk4jQe7Vq3N2Vip0@andrea>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Zk4jQe7Vq3N2Vip0@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAXAydUUk9moRnACA--.19046S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF18tF4fCF1rJFW7Xr47Arb_yoW7Wr45pF
	WkKa40ka1DJ3409w1vvws7XFy5uFZ5Gay5JF98J34kAFs8ur929r15KayY9a4kGr4kA34j
	vrWjqry8u3WDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/22/2024 um 6:54 PM schrieb Andrea Parri:
> Alan, all,
> 
> ("randomly" picking a recent post in the thread, after having observed
> this discussion for a while...)
> 
>> It would be better if there was a way to tell herd7 not to add the 'mb
>> tag to failed instructions in the first place.  This approach is
>> brittle; see below.
> 
> AFAIU, changing the herd representation to generate mb-accesses in place
> of certain mb-fences...
> 
>> If you do want to use this approach, it should be simplified.  All you
>> need is:
>>
>> 	[M] ; po ; [RMW_MB]
>>
>> 	[RMW_MB] ; po ; [M]
>>
>> This is because events tagged with RMW_MB always are memory accesses,
>> and accesses that aren't part of the RMW are already covered by the
>> fencerel(Mb) thing above.
> 
> .. and updating the .cat file to the effects of something like
> 
>    -let mb = ([M] ; fencerel(Mb) ; [M]) |
>    +let mb = (([M] ; po? ; [Mb] ; po? ; [M]) \ id) |
> 
> .. can hardly be called "making RMW barriers explicit".  (So much so
> that the first commit in PR #865 was titled "Remove explicit barriers
> from RMWs".  :-))
> 
> Overall, this discussion rather seems to confirm the close link between
> tools/memory-model/ and herdtools7.  (After all, to what extent could
> any putative RMW_MB be considered "explicit" without _knowing the under-
> lying representation of the RMW operations...)  


My view is a bit different. There's more or less standard theory for 
weak memory models, including how operations at the source code level 
map to events in the graph.

Part of that standard theory are relations like rmw, and the 
circumstances under which they appear in the graph.

You'll see these relations in generic papers about weak memory models, 
like GenMC, Hahn, etc. as well as in pretty much every specific memory 
model like TSO, C11, PowerPC, VMM, etc., totally independently of herd7 
(even though these notations have historically developed together with 
herd).

Naively I would expect that a tool like herd7 would be a generic WMM 
exploration tool, which follows these standards with a very obvious 1:1 
mapping of what we see in the code and the events we see in the graph, 
plus perhaps a thin and explicit configurable herd7-specific mapping 
layer like what we see in linux_kernel.cat to configure the syntax for a 
specific model.

In that mapping layer, we currently see that xchg() is an exchange 
operation with an Mb tag. Just like an smp_load_acquire is a read with 
an acquire tag.
Or so it seems.

Instead, we find that contrary to what's written in that file, and 
contrary to the conventions, an xchg() is an F[mb] ; R[once] ; W[once] 
; F[Mb]. And in fact a cmp_xchg could even be a R[once].

That's because the herd7 tool isn't quite as generic as one might think, 
but rather specifically "detects" that it's running the LKMM and then 
the mapping isn't what you'd naively think, but something hidden in the 
OCaml implementation of herd7.

That would be comparable to a popular tool for matrix calculations using 
the syntax
[ 10  5  4
   3   4  2 ]

to define a 2x3 matrix, unless one of the values is -3, in which case it 
becomes a vector of 6 elements, because that's what a really important 
user of the tool wanted, and then didn't see enough of a need to change.

My point is that to anyone who has seen standard matrix notation, this 
syntax in a matrix-computation-tool looks like it would be a matrix, 
right? And it usually is a matrix; then it should always be a matrix.

I usually say I don't look much at natural language documentation and 
only read code, because code doesn't lie. In this case, the natural 
language documentation is saying the correct thing thanks to the hard 
work of a lot of people, but the code (in .cat etc.) doesn't do what it 
seems to be doing.

And I think that should be changed, both to reduce the anyways high 
mental load of reading the code without having to do mental 
transformations in your head, and also to make herd more Lkmm-agnostic.
In the ideal world, herd doesn't know anything about Lkmm except what we 
tell it through tools/memory-model, and generic things like C syntax + 
semantics.

So when using syntax like dom(rmw), I don't see it as confirming the 
close link to herd more than before, but rather depending more on 
standard notations and conventions, and relying on herd's close link to 
those standard notations (such as using rmw for the rmw relation and 
dom(r) for the domain of r) for dom(rmw) to mean what anyone who has 
deeply read a couple of modern WMM papers would expect.



> My understanding is that
> this discussion was at least in part motivated by a desire to experiment
> and familiarize with the current herd representation

I would phrase it more extreme: I want to get rid of the unnecessary 
non-standard parts of the herd representation.

Those parts have led me astray several times. Ok, who cares about me, 
but even Luc once forgot about the non-standard parts and thought it is 
a bug:

https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904

I also know that Viktor stumbled over it before and also suggested we 
change it.

I think there's 0 benefit to them, they're just wasting people's time 
and energy and lead to misunderstanding.

Ok, this e-mail became long. Hope it at least helps clarify my 
motivation :))

jonas


