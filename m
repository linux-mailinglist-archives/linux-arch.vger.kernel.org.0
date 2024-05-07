Return-Path: <linux-arch+bounces-4234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D230F8BDDB7
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E154284188
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A1A14D458;
	Tue,  7 May 2024 09:03:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22714D447;
	Tue,  7 May 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072636; cv=none; b=kRnO+236K0MjvXPimNqhJ16a1eIaqGsR5gW513235PxZu1TWny8JJUxAduXJ7ZrFEnTdbvMJjWH9ofYABKd/V2ZH4SYEkXOWeYAKaTwk934jPqKzupKoeiCIuM4StoKH/rTHgbvO4bJbYumNBdolCLD3KJZuMnSZxKoA/4v51H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072636; c=relaxed/simple;
	bh=2xnallKHSfS3jGvqNeNimXCB0bIdex0YoRsg8+jbQVg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cymAvXR65S8Xmbi3rh0S/7vjvV4e/QxSc7/TNUlZEiQIbgOBVtH5BK02lICbKo5tQ99v3xvXA+TO4n0i1vkxCjkJhbNVxExN/zm8xiwvp2aNSOzphvHGTIYofuUV8/Mko1m1NKtvYOrRTjQKSZZrZ3Je98Z29R01EEFkgepj+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VYWx16Pqrz9xFmK;
	Tue,  7 May 2024 16:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A417E14010C;
	Tue,  7 May 2024 17:03:44 +0800 (CST)
Received: from [10.45.158.162] (unknown [10.45.158.162])
	by APP2 (Coremail) with SMTP id GxC2BwB3sSVh7jlm51OtBw--.22983S2;
	Tue, 07 May 2024 10:03:43 +0100 (CET)
Message-ID: <fd2369ed-1e84-4e44-ac80-cd316f8e7051@huaweicloud.com>
Date: Tue, 7 May 2024 11:03:27 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
To: Alan Stern <stern@rowland.harvard.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, akiyks@gmail.com,
 Frederic Weisbecker <frederic@kernel.org>, Daniel Lustig
 <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
 <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
 <c168f56f-dfae-4cac-bc61-fc5a93ee3aed@rowland.harvard.edu>
In-Reply-To: <c168f56f-dfae-4cac-bc61-fc5a93ee3aed@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwB3sSVh7jlm51OtBw--.22983S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryrCrW7tFy5Ww4DKw1rZwb_yoW8CrWfpa
	9rKa10kr1UXr4Sk34qqw43JrWFvwsrJay5WFyrXFWqyayqkF4SyF4Yvry5Kr93Jws7Jw42
	yrWYga92vayDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgEksDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/6/2024 um 9:21 PM schrieb Alan Stern:
> On Mon, May 06, 2024 at 11:00:42AM -0700, Paul E. McKenney wrote:
>> On Mon, May 06, 2024 at 06:30:45PM +0200, Jonas Oberhauser wrote:
>>> Am 5/6/2024 um 12:05 PM schrieb Jonas Oberhauser:
>>>> Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
>>>>> This commit adds four litmus tests showing that a failing cmpxchg()
>>>>> operation is unordered unless followed by an smp_mb__after_atomic()
>>>>> operation.
>>>>
>>>> So far, my understanding was that all RMW operations without suffix
>>>> (xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].
> 
> It's more accurate to say that RMW operations without a suffix that
> return a value will be interpreted that way.  So for example,
> atomic_inc() doesn't imply any ordering, because it doesn't return a
> value.
> 

I see, thanks.

>>>> barriers explicitlyinside the cat model, instead of relying on implicit
>>>> conversions internal to herd.
> 
> Don't the annotations in linux-kernel.def and linux-kernel.bell (like
> "noreturn") already make this explicit?

Not that I'm aware. All I can see there is that according to .bell RMW 
don't have an mb mode, but according to .def they do.

How this mb disappears between parsing the code (.def) and interpreting 
it (.bell) is totally implicit. Including how noreturn affects this 
disappeareance.

In fact most tool developers that support LKMM (Viktor, Hernan, and Luc) 
were at least once confused about it. And I think they read those files 
more carefully than I.

https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904

Note that while there's no explicit annotation of noreturn in the .def 
file, at least I can guess based on context that it should be annotated 
on all the functions that don't have _return and for which also a 
version with _return exists.


have fun,
   jonas


