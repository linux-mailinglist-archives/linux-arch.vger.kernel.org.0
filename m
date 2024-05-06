Return-Path: <linux-arch+bounces-4222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769378BD2E0
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8A21F249B1
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DFF13D51F;
	Mon,  6 May 2024 16:31:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E2156F34;
	Mon,  6 May 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013081; cv=none; b=BISXfW7sg5B2S6V9jTIxHbzgiGviq2ISst+Rq3HEmNDY9ZM7wd8gvzSBvHPr2x3NhN3TFTNIYnxmV7SXw0CjnqHkRX8ELiI2PkGpJwWPPeNc4s3Ctff3NW6WkTDSCwOKA7eyfkZKPxcUx45aLm5H9Xz0rO9tRcDIaDe2fOrdsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013081; c=relaxed/simple;
	bh=Er0V6WEj6xcmIloHj8PhBrFsH5cQFszCcAIUgKVv2lg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j534JZnNFdYMpB+o1jNt9vJiI7A3frUYg3KO2eT5zBtOENvg6P5mfnEZicrfaQ04tjvZdsNCnBdu99hvT3ftIcbiljQ2l8sDFp2zlakLhTOHjsxKV/1vvwt3uNli+LuBQIh3t3aixPD546MeyiL/zsXuBhBXjDI74ZiJ2ECF2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY6166k6Xz9xHvY;
	Tue,  7 May 2024 00:14:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 31CD5140444;
	Tue,  7 May 2024 00:31:04 +0800 (CST)
Received: from [10.48.135.242] (unknown [10.48.135.242])
	by APP2 (Coremail) with SMTP id GxC2BwDHASa4BTlmcv6hBw--.23635S2;
	Mon, 06 May 2024 17:31:03 +0100 (CET)
Message-ID: <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
Date: Mon, 6 May 2024 18:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, Frederic Weisbecker <frederic@kernel.org>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
In-Reply-To: <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDHASa4BTlmcv6hBw--.23635S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13Cw4kXw4UKr47Cr1Dtrb_yoW8KryxpF
	ZrKF1FyryDJ3y093y0v3Z8Xw1rZws3Ja15tw1fKrWjyan8GF1jvFy5trWF9ry2yrZak3Wj
	qr1F93yxZryUAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/6/2024 um 12:05 PM schrieb Jonas Oberhauser:
> 
> 
> Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
>> This commit adds four litmus tests showing that a failing cmpxchg()
>> operation is unordered unless followed by an smp_mb__after_atomic()
>> operation.
> 
> So far, my understanding was that all RMW operations without suffix 
> (xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].
> 
> I guess this shows again how important it is to model these full 
> barriers explicitly inside the cat model, instead of relying on implicit 
> conversions internal to herd.
> 
> I'd like to propose a patch to this effect.
> 
> What is the intended behavior of a failed cmpxchg()? Is it the same as a 
> relaxed one?
> 
> My suggestion would be in the direction of marking read and write events 
> of these operations as Mb, and then defining
> 
> (* full barrier events that appear in non-failing RMW *)
> let RMW_MB = Mb & (dom(rmw) | range(rmw))
> 
> 
> let mb =
>      [M] ; fencerel(Mb) ; [M]
>    | [M] ; (po \ rmw) ; [RMW_MB] ; po^? ; [M]
>    | [M] ; po^? ; [RMW_MB] ; (po \ rmw) ; [M]
>    | ...
> 
> The po \ rmw is because ordering is not provided internally of the 
> rmw

(removed the unnecessary si since LKMM is still non-mixed-accesses)


This could also be written with a single rule:

      | [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]


> I suspect that after we added [rmw] sequences it could 
> perhaps be simplified [...]
> 

No, my suspicion is wrong - this would incorrectly let full-barrier RMWs
act like strong fences when they appear in an rmw sequence.

  if (z==1)  ||  x = 2;     ||  xchg(&y,2)  || if (y==2)
    x = 1;   ||  y =_rel 1; ||              ||    z=1;


right now, we allow x=2 overwriting x=1 (in case the last thread does 
not propagate x=2 along with z=1) because on power, the xchg might be
implemented with a sync that doesn't get executed until the very end
of the program run.


Instead of its negative form (everything other than inside the rmw),
it could also be rewritten positively. Here's a somewhat short form:

let mb =
      [M] ; fencerel(Mb) ; [M]
    (* everything across a full barrier RMW is ordered. This includes up 
to one event inside the RMW. *)
    | [M] ; po ; [RMW_MB] ; po ; [M]
    (* full barrier RMW writes are ordered with everything behind the RMW *)
    | [W & RMW_MB] ; po ; [M]
    (* full barrier RMW reads are ordered with everything before the RMW *)
    | [M] ; po ; [R & RMW_MB]
    | ...



Good luck,
jonas


