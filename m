Return-Path: <linux-arch+bounces-10354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFCA436C6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 09:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE263B70A2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B2174EF0;
	Tue, 25 Feb 2025 07:59:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DE17DFF3;
	Tue, 25 Feb 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470366; cv=none; b=t03NM71/g0n8PQaPNiyBMW5DRDbaWKj5vOORKIHMt6SmNR72dra7hMjdcFh+omrLPnCPB3RzLJadBFmJqM5tyHRnh2dyBGfLMHzyHxdm3XagyStc1RNDrZ5iEnjv7VnblqtuOPUzYVlNAWvkA5KX4Bb/Hqs98hcRcgH7JqZjia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470366; c=relaxed/simple;
	bh=nu9yynYk0XIGZa52r+Naeo8gTBGfALG27Mv+5Wx/NJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdztTdE+0/myenkHg1y2ozlftHT9X5nSeqvDt3SsDGvuxwXCfxKMfWDgREcLqesrEImo3NVoW9FASxykruyNrw3fgopWZjODCkHKLyl9cX+lM9Dg43ZSiEHP+M5AE+8NaSylflLnqTPc7J03LYE4Ik6BRjgrO9g3Y1Y3dJo7Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z288J41Lcz9v7N8;
	Tue, 25 Feb 2025 15:18:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 48FDB140361;
	Tue, 25 Feb 2025 15:40:59 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP2 (Coremail) with SMTP id GxC2BwD3X+L9c71nhYEeAw--.47156S2;
	Tue, 25 Feb 2025 08:40:58 +0100 (CET)
Message-ID: <756aed25-f4de-4c2f-b6e8-5bf67c0fde69@huaweicloud.com>
Date: Tue, 25 Feb 2025 08:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 6/7] tools/memory-model: Switch to softcoded
 herd7 tags
To: Akira Yokosawa <akiyks@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev, kernel-team@meta.com,
 mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
 <20250220161403.800831-6-paulmck@kernel.org>
 <105532ce-a41d-4f14-8172-cd68bdffae1d@gmail.com>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <105532ce-a41d-4f14-8172-cd68bdffae1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwD3X+L9c71nhYEeAw--.47156S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47uF18Xr1xKw48tr4DXFb_yoW8uF4kpa
	yrWa43KF1kJrWa9w1xWa1qvFy5Xan3Jr1UJrnrA3s5ZFy293WakrySg3WqqF9rA3yI9w4Y
	yr1jg3WkC3s8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 2/25/2025 5:24 AM, Akira Yokosawa wrote:
> On Thu, 20 Feb 2025 08:14:02 -0800, Paul E. McKenney wrote:
>> From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>>
>> A new version of herd7 provides a -lkmmv2 switch which overrides the old herd7
>> behavior of simply ignoring any softcoded tags in the .def and .bell files. We
>> port LKMM to this version of herd7 by providing the switch in linux-kernel.cfg
>> and reporting an error if the LKMM is used without this switch.
>>
>> To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
>> RMW which do not return a value and define atomic_add_unless with an Mb tag in
>> linux-kernel.def.
>>
>> We update the herd-representation.txt accordingly and clarify some of the
>> resulting combinations.
>>
> 
> Having failed to hear from Jonas or Hernan in response to my question at:
> 
>      https://lore.kernel.org/lkmm/ec97f28e-31ad-4a45-ac87-fab91e27d4ee@gmail.com/

Sorry Akira, I lost track of the thread and forgot to answer.

> 
> , let me guess.  Past contributions strongly suggest that Hernan looks after
> herd7 changes and Jonas takes care of LKMM side of changes.

Yes, this is correct.

Hernan

> 
> So my suggestion is to add a Co-developed-by tag of Hernan here:
> 
> Co-developed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
>> Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Tested-by: Boqun Feng <boqun.feng@gmail.com>
> 
> , and let me add a Tested-by:
> 
> Tested-by: Akira Yokosawa <akiyks@gmail.com> # herdtools7.7.58
> 
>          Thanks, Akira
> 
>> ---
>>   .../Documentation/herd-representation.txt     | 27 ++++++++++---------
>>   tools/memory-model/README                     |  2 +-
>>   tools/memory-model/linux-kernel.bell          |  3 +++
>>   tools/memory-model/linux-kernel.cfg           |  1 +
>>   tools/memory-model/linux-kernel.def           | 18 +++++++------
>>   5 files changed, 30 insertions(+), 21 deletions(-)


