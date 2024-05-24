Return-Path: <linux-arch+bounces-4533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020398CE959
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 20:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC6D2817FF
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EAC3B293;
	Fri, 24 May 2024 18:10:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43223B1A3;
	Fri, 24 May 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574200; cv=none; b=h7JVcpu1e3hj/oxaPzf4WC3TGfa8U2+FfeFh9PspF7Y2Ee71ch1ZMoV+WSvoc0Pk+w5CaMMtfhpoG72WixHVmg1iNz8yq3+tVsxLtrNljPZ+lK7LXQRzW/d15XdAYA3t3NUsRQbhYZ8NMfJJZFdGVZyP0ueLII92NVvdyaqQdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574200; c=relaxed/simple;
	bh=OpEg4tnxAfumgql19ci41Ux2BVE1kkAJMz9U8MpGbOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfO07I6ZinYUD6UjwkT8gyP9ovPGCgCsrYAsxybhBp64Fh3DyyvkKN3C61XAwULohCdx5f0EjSIIRe1Joj7smZFwjM3p4ulkXEHRZsxl1t1RHHTg7o/NK/VGCYrQBI5/s0pWiz9uwuJKSs9+51s5dT/fg2bb0oE0jO+Cij8Bqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VmCL815Fvz9v7Hm;
	Sat, 25 May 2024 01:52:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C0124140794;
	Sat, 25 May 2024 02:09:41 +0800 (CST)
Received: from [10.45.153.18] (unknown [10.45.153.18])
	by APP2 (Coremail) with SMTP id GxC2BwBXkSXb11BmqTLTCA--.35053S2;
	Fri, 24 May 2024 19:09:41 +0100 (CET)
Message-ID: <99cc68a9-477a-4ebe-b769-465a4016bdf6@huaweicloud.com>
Date: Fri, 24 May 2024 20:09:28 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>, Boqun Feng <boqun.feng@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
 <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
 <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>
 <a3c10533-1d86-4945-8bda-c0bdf4b14935@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <a3c10533-1d86-4945-8bda-c0bdf4b14935@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBXkSXb11BmqTLTCA--.35053S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GryxGry3Kw4rAF18CrWDCFg_yoWxJw17pF
	W3Ga4DKw4kJF47u39Yvr4UZa4FyrWrJF43Xrn5K34UZwn8Ka4qqFW2y3Wa9FW7Ars7Za1j
	q3yFya47C3WDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IUUXdbUUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/24/2024 um 4:53 PM schrieb Alan Stern:
> On Fri, May 24, 2024 at 07:34:06AM -0700, Boqun Feng wrote:
>> On Fri, May 24, 2024 at 10:14:25AM -0400, Alan Stern wrote:
>> [...]
>>>> Not really, RMW events contains all events generated from
>>>> read-modify-write primitives, if there is an R event without a rmw
>>>> relation (i.e there is no corresponding write event), it's a failed RWM
>>>> by definition: it cannot be anything else.
>>>
>>> Not true.  An R event without an rmw relation could be a READ_ONCE().
>>
>> No, the R event is already in the RWM events, it has come from a rwm
>> atomic.
> 
> Oh, right.  For some reason I was thinking that an instruction could
> belong to only one set, R or RMW.  But that doesn't make sense.

I thought the same, so I perhaps contributed to that confusion.

> 
>>> Or a plain read.  The memory model uses the tag to distinguish these
>>> cases.
>>>
>>>>> that it would work is merely an artifact of herd7's internal actions.  I
>>>>> think it would be much cleaner if herd7 represented these events in some
>>>>> other way, particularly if we can tell it how.
>>>>>
>>>>> After all, herd7 already does generate different sets of events for
>>>>> successful (both R and W) and failed (only R) RMWs.  It's not such a big
>>>>> stretch to make the R events it generates different in the two cases.
>>>>>
>>>>
>>>> I thought we want to simplify the herd internal processing by avoid
>>>> adding mb events in cmpxchg() cases, in the same spirit, if syntactic
>>>> tagging is already good enough, why do we want to make herd complicate?
>>>
>>> Herd7 already is complicated by the fact that it needs to handle
>>> cmpxchg() instructions in two ways: success and failure.  This
>>> complication is unavoidable.  Adding one extra layer (different tags for
>>> the different ways) is an insignificant increase in the complication,
>>> IMO. And it's a net reduction when you compare it to the amount of
>>> complication currently in the herd7 code.
>>>
>>> Also what about cmpxchg_acquire()?  If it fails, it will generate an R
>>> event with an acquire tag not in the rmw relation.

I would like that, but that is not the current implementation, a failed 
atomic_compare_exchange always produces a R*[once]; this behavior is 
currently hardcoded in herd7.

>>>  There is no way to
>>> tell such events apart from a normal smp_load_acquire(), and so the .cat
>>> file would have no way to know that the event should not have acquire
>>> semantics.  I guess we would have to rename this tag, as well.
>>
>> No,
>>
>> 	let read_of_rmw = (RMW & R)
>> 	let fail_read_of_rmw = read_of_rmw / dom(rmw)
>> 	let fail_cmpxchg_acquire = fail_read_of_rmw & [Acquire]
>>
>> gives you all the failed cmpxchg_acquire() apart from a normal
>> smp_load_acquire().
> 
> Yes, I see.  Using this approach, no further changes to herd7 or the
> def file would be needed.  We would just have to add 'mb to the
> Accesses enumeration and to the list of tags allowed for an RMW
> instruction.
> 
> Question: Since R and RMW have different lists of allowable tags, how
> does herd7 decide which tags are allowed for an event that is in both
> the R and RMW sets?

After looking over the patch draft for herd7 written by Hernan [1], my 
best guess is: it doen't. It seems that after herd7 detects you are 
using LKMM it simply drops all tags except 'acquire on read and 'release 
on store. Everything else becomes 'once (and 'mb adds some F[mb] sometimes).

That means that if one were to go through with the earlier suggestion to 
distinguish between the smp_mb() Mb and the cmpxchg() Mb, e.g. by 
calling the latter RmwMb, current herd7 would always erase the RmwMb tag 
because it is not called "acquire" or "release".
The same would happen of course if you introduced an RmwAcquire tag.

So there are several options:

- treat the tags as a syntactic thing which is always present, and
  specify their meaning purely in the cat file, analogous to what you
  have defined above. This is personally my favorite solution. To
  implement this in herd7 we would simply remove all the current special
  cases for the LKMM barriers, which I like.

  However then we need to actually define the behavior of herd if
  an inappropriate tag (like release on a load) is provided. Since the
  restriction is actually mostly enforced by the .def file - by simply
  not  providing a smp_store_acquire() etc. -, that only concerns RMWs,
  where xchg_acquire() would apply the Acquire tag to the write also.

  The easiest solution is to simply remove the syntax for specifying
  restrictions - it seems it is not doing much right now anyways - and
  do the filtering inside .bell, with things like

     (* only writes can have Release tags *)
     let Release = Release & W \ (RMW \ rng(rmw))

  One good thing about this way is that it would work even without
  modifying herd, since it is in a sense idempotent with the
  transformations done by herd.

  FWIW, in our internal weak memory model in Dresden we did exactly this,
  and use REL for the syntax and Rel for the semantic release ordering to
  make the distinction more clear, with things like:

     let Acq = (ACQ | SC) & (R | F)
     let Rel = (REL | SC) & (W | F)

  (SC is our equivalent to LKMM's Mb)

- treat the tags as semantic markers that are only present or not under
  some circumstances, and define the semantics fully based on the present
  tags. The circumstances are currently hardcoded in herd7, but we should
  move them out with some syntax like __cmpxchg{acquire}{once}.

  This requires touching the parser and of course still has the issue
  with the acquire tag appearing on the store as well.

- provide a full syntax for defining the event sequence that is
  expected. For example, for a cmpxchg we could do

     cmpxchg = { F[success-cmpxchg]; c = R&RMW[once]; if (c==v) { 
W&RMW[once]; } F[success-cmpxchg] }

  and then define in .bell that a success-cmpxchg is an mb if it is
  directly next to a cmpxchg that succeeds.

  The advantage is that you can customize the representation to whatever
  kernel devs thing is the most intuitive. The downside is that it
  requires major rewrites to herd7, someone to think about a reasonable
  language for specifying this etc.



Best wishes,
   jonas



[1] https://github.com/herd/herdtools7/pull/865


