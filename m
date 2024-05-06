Return-Path: <linux-arch+bounces-4216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B963E8BCB9F
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3605B22473
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670691428F1;
	Mon,  6 May 2024 10:06:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A16140366;
	Mon,  6 May 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989971; cv=none; b=oSc2SL65hgtGAgJywtl/0ZwYyQRPFJHQag/+O089fchNx0b1pZ/gDuIe7CwGWAuL86bTscziK4g1QrazzkK8yQKMgti5SKWIrCwQx7d7ukJZLOqnE0jZF/9DzaJWPCmO+JSUDx/GF7mbQrE2KEu/zbosXz8u2PjalTlWorgD0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989971; c=relaxed/simple;
	bh=3bKywxWdwXQJn9t7WE5tCeMMFA6vA0dUvFi3njX5doo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx99Cws+Mn02v9a28WeNX/Uw9MyZfPlp4znWlE7U9Q+QQb6cFhLf8Yu7G+Pw0x03Kh5rTtPs3sAlHkepPF8y1NA2ejgYbVwU1OagdFpU/gJspPA/3P91YfYKyTu+RPOOQwzWP0wFCObGhIViGNyejBLhfDOXCcW7XSSEwPw1wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXxMR3twyz9xGXN;
	Mon,  6 May 2024 17:44:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6DCB91404D9;
	Mon,  6 May 2024 18:05:58 +0800 (CST)
Received: from [10.81.216.243] (unknown [10.81.216.243])
	by APP1 (Coremail) with SMTP id LxC2BwCHexR2qzhmIrWjBw--.20188S2;
	Mon, 06 May 2024 11:05:57 +0100 (CET)
Message-ID: <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
Date: Mon, 6 May 2024 12:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20240501232132.1785861-2-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwCHexR2qzhmIrWjBw--.20188S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45urWDKw47Ary5Kw1Dtrb_yoW8Gw17pF
	WUKF43Kry7J39Ykwn5Za43X348uayftan5Gry3GrWqv3Z8CFyjvFyrtFWSgFy3Jrsaka1j
	vr1a934xZrWUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
> This commit adds four litmus tests showing that a failing cmpxchg()
> operation is unordered unless followed by an smp_mb__after_atomic()
> operation.

So far, my understanding was that all RMW operations without suffix 
(xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].

I guess this shows again how important it is to model these full 
barriers explicitly inside the cat model, instead of relying on implicit 
conversions internal to herd.

I'd like to propose a patch to this effect.

What is the intended behavior of a failed cmpxchg()? Is it the same as a 
relaxed one?

My suggestion would be in the direction of marking read and write events 
of these operations as Mb, and then defining

(* full barrier events that appear in non-failing RMW *)
let RMW_MB = Mb & (dom(rmw) | range(rmw))


let mb =
     [M] ; fencerel(Mb) ; [M]
   | [M] ; (po \ si ; rmw) ; [RMW_MB] ; po^? ; [M]
   | [M] ; po^? ; [RMW_MB] ; (po \ rmw ; si) ; [M]
   | ...

The po \ si;rmw is because ordering is not provided internally of the 
rmw, although I suspect that after we added release sequences it could 
perhaps be simplified to


let mb =
     [M] ; fencerel(Mb) ; [M]
   | [M] ; po ; [RMW_MB] ; po^? ; [M]
   | [M] ; po^? ; [RMW_MB] ; po ; [M]
   | ...

or

let mb =
     [M] ; fencerel(Mb) ; [M]
   | [M] ; po & (po^? ; [RMW_MB] ; po^?) ; [M]
   | ...

(the po & is necessary to avoid trivial hb cycles of an RMW event 
happening before itself)


Any interest?

Have fun,
jonas



