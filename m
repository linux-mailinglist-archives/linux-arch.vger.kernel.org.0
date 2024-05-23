Return-Path: <linux-arch+bounces-4509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F88CDB60
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 22:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3422C1F24C89
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409B84A4D;
	Thu, 23 May 2024 20:31:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570982C8E;
	Thu, 23 May 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496263; cv=none; b=tPXhwseqhQ1UUoe82XMtJ7N1jBr6cW+mQ17h3BTh3IqzdpHXzBe6Ic9NBllmEjZTnIsPu3mBfwout4XuTg+gEYsF51EeMpOWNn32LgwhsEFgDHc8I+hqtJGUkh9+3fuuOMtZMaSrWInJYVAXE6sAtUIZW7zJGM6jv9LIpAWfuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496263; c=relaxed/simple;
	bh=xwfm1kmXiKCv+NYSUVC4LiJEEx87EhlweHt1yl3WpGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJVWOa0rPr5P4ZGCjQ/laduN8PTiPGQqY2GYiuzhG7KOPg5AQQCp7wDKdplZy8RzJ7moq+2K1iYS6CHKdSL7YKCnvVDYZ7ENsTjJiMzUMPsvkP6+yo1n2PIdQ+MSPsF04YumT7/7VQLv8XP/IqqQypcd9W6lcYPy3f3lEJQM0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VlfWR11Rdz9v7Hp;
	Fri, 24 May 2024 04:13:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B59BA140717;
	Fri, 24 May 2024 04:30:51 +0800 (CST)
Received: from [10.81.203.103] (unknown [10.81.203.103])
	by APP2 (Coremail) with SMTP id GxC2BwA3bSFwp09mQETECA--.21072S2;
	Thu, 23 May 2024 21:30:51 +0100 (CET)
Message-ID: <1b1485f8-9c84-4221-b955-622dbf2fd953@huaweicloud.com>
Date: Thu, 23 May 2024 22:30:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
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
 <73e08b17-cb2a-4e14-a94f-7144c5738684@huaweicloud.com>
 <Zk9waJNBwifS/Ops@andrea>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Zk9waJNBwifS/Ops@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwA3bSFwp09mQETECA--.21072S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF47uFW5CF1fKw43tryUAwb_yoW3Ar45pF
	W7KFWFkr1ktr40kw1xAw4xX3WFyas5tFy5Zrn8Kw48Aan0grWSvr1Ikr4F9FyDWrs2vr1j
	vw4jqa4kCFyDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 5/23/2024 um 6:35 PM schrieb Andrea Parri:
>> I would phrase it more extreme: I want to get rid of the unnecessary
>> non-standard parts of the herd representation.
> 
> Please indulge the thought that what might appear to be "non-standard"
> to one or one's community might appear differently to others.

Certainly. And of course, the formalization of the LKMM doesn't have to 
be optimized for the WMM community, even though I suspect that they (and 
possibly the tools they develop) are the main direct consumers of the 
formalization.

> Continuing with the example above, I'm pretty sure your "standard" and
> simple idea of mb-reads and mb-writes, or even "unsuccessful" mb-reads
> will turn up the nose of many kernel developers...  

I'm not sure how true that is. Firstly I'm not sure how many kernel 
developers really read the formalization and try to see what it does, 
rather than relying on tools to gain an intuition of what's going on.

But let's say a kernel developer wants to make sure that their intuition 
of how cmpxchg works is matched by the formal model, e.g., they want to 
double check that the formal model is correct
after they got some unexpected results in a herd7 litmus test.

How would they go about it today? The only way is to read the OCaml 
source code, because there's no other code that obviously defines the 
behavior. At best, they would read

atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)

see the Acquire, Release, and Mb references in the model, and think "ok, 
so '__cmpxchg{acquire}' means I get an Acquire tag in the success case 
which gives acq_po ordering, '__cmpxchg{release}' means I get a Release 
tag in the success case which gives po_rel ordering. Therefore 
'__cmpxchg{mb}' must give me an Mb tag in the success case. That would 
give me mb ordering, but not between the store and subsequent 
operations, and that's just wrong."

But of course this "understanding by analogy" is broken, because there's 
a bunch of special OCaml match expressions in herd that look only for 
release or mb and just give totally different behavior for that one 
case. Every other tag behaves exactly the same way.

At worst they wouldn't even guess that this only is the success ordering 
(that's definitely what happened to us in the weak memory model 
community, but we don't matter for this argument).

A better situation would be to do something like this:

                                        (*success*)(*fail*)
atomic_cmpxchg_acquire(X,V,W) __cmpxchg {acquire}  {once} (X,V,W)
atomic_cmpxchg_release(X,V,W) __cmpxchg {release}  {once} (X,V,W)
atomic_cmpxchg(X,V,W)         __cmpxchg {mb}       {once} (X,V,W)

and being explicit in the model about what the Mb tag does:

      | [M];fencerel(Mb);[M] (* smp_mb() and operations with Mb ordering 
such as cmpxchg() *)
      | [M];po;[R & Mb] (* reads with an Mb tag - coming from full fence 
rmws - are ordered as-if there was an smp_mb() right before the read *)
      | [W & Mb];po;[M] (* correspondingly, writes with an Mb tag are 
ordered as-if there was an smp_mb() right after the write *)

And suddenly you can read the model and map it 1:1 to the intuition that 
you can treat a successful cmpxchg() (or an xchg() etc.) as-if it was 
enclosed by smp_mb().

There doesn't need to be a real fence.


> The current repre-
> sentation for xchg() was described in the ASPLOS'18 work

Do you mean the one example in Table 3?
What about cmpxchg() or cmpxchg_acquire()?

> But that's not the point, "standards" can change and certainly kernels
> and tools do.  My remark was more to point out that you're not getting
> rid of anything..., 

We're definitely getting rid of some lines in herd7, that have been 
added solely for dealing with this specific case of LKMM.

For example, there's some code looking like this (for a memory ordering 
tag `a`)

                 (match a with ["release"] -> a |  _ -> a_once)

which specifically refers to the release tag in LKMM and we can turn 
that into

                 a

with no more reference to any LKMM tags. Of course, this is not the 
Linux community's problem, just the herd (and others who want to use the 
literal cat file of LKMM) maintainers who have to deal with it.

And imagine that at some point you want to add another tag to the linux 
kernel - like for example for 'accessing an atomic in initialization 
code, so that the compiler can do optimizations like merge a bunch of 
bitwise operations'. Let's call it 'init.

What will be the behavior of

WRITE_INIT(X,V) __store{init}(X,V);

with the current herd7? Honestly I have no clue, because there might be a

                 (match a with ["release"] -> a |  _ -> a_once)

somewhere that will turn this 'init into 'once. We'd have to comb the 
herd7 codebase to know for sure (or hope that our experiments are 
sufficiently thorough to catch all cases).

 >you're simply proposing a different representation

I wouldn't phrase it like that, since it's a representation many people 
familiar with WMM would expect, but admittedly that doesn't have to be 
the deciding factor.

> asking kernel developers & maintainers to "deal with it"

Deal with what, no longer having to learn OCaml to be sure that the 
LKMM's formal definition matches the description in memory_barriers.txt?
Otherwise, I don't see anything that changes for the worse.
With the change, people need to think for a few seconds to see that the 
explicit rules in the .cat file are a formalization of "treat xchg() as 
if it had smp_mb() before and after".
Without the change, they need to read an OCaml codebase to see that is 
meant by

atomic_xchg(X,V,W) __xchg{mb}(X,V,W)

So I don't see any downsides.


I would also support making the representation explicit in the .def 
files instead, with something like

cmp_xchg(x,e,v) = { if (*x==e) { smp_mb(); int r = 
__cmp_xchg{once}(x,e,v) ; smp_mb(); return r } else { __read{once}(x) } }

Then you get to keep the representation.
Without knowing herd's internals, I have no idea of how to seriously 
specify a meta language so that herd could effectively and efficiently 
deal with it in general. But one could at least envision some specific 
syntax for cmpxchg with a code sequence for the failure case and a code 
sequence for the success case.

Personally I don't prefer this option, firstly because I don't see a 
good reason for the Linux community to go their own way here. I don't 
think there's really much of a problem with saying "this is the 
intuition; this is how we formalize it" and for the two not to be 
completely identical. It happens all the time, and in this case the gap 
between "we formalize it by really having two smp_mb() appear in the 
graph if it's successful" and "we formalize it by providing the same 
ordering that the smp_mb() would have if it was there" isn't big.
Especially for those kernel people who have enough motivation to 
actually deep dive into the formalization in the first place. But it 
makes it a lot more accessible for the WMM community, which can only 
benefit LKMM.

And secondly because people will probably mostly focus on the .cat file, 
which means that it's still a bit of a booby trap to put something so 
important (and perhaps surprising) into the .def file, but at least one 
that is in the open for people who are more careful and also read the 
.def file.

 > I am looking forward to something more than "because we can".

- it makes it easier to maintain the LKMM in the future, because you 
don't have to work around hidden transformations inside herd7
- it makes implicit behavior explicit
- it makes it easier to understand that the formalization matches the 
intention
- it makes it easier to learn the LKMM from the formalization without 
having to cross-reference every bit with the informal documentation to 
avoid misunderstandings


Have a good time,
   jonas





