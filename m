Return-Path: <linux-arch+bounces-4504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE78CD5EF
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B46BB22571
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11F13C3C9;
	Thu, 23 May 2024 14:37:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891412B171;
	Thu, 23 May 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475035; cv=none; b=ueMwAO+4XPGQqVoBRTZ0q6xse/Klhqi4kLTzkQbBjAb26JuvpGEQ7ijU9XDFFzxp5MIWk7qnrIydJOKg5tl344V0KnId1d2YG3thUYwYuuDbP8uIpi9FoJoz4/l710hKJcpngbb38N5e0PvaDL/vADv71EdIKHcSYlJ4CHkpOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475035; c=relaxed/simple;
	bh=gbTUHrtXsQLEAfxPpyRzN9dLmybrI0g1EIZJvIeWbS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OboPz89fREzqJr9FePsjhS9+spB0x+SqpQ/nLoK5ItKa8BfQu47iFk65GngdnYkRJXDFnZyTArH7xYX6X9jQFPYcJNnXe4Fii8lE7aHx7yz+WX/fTBASq11YBS1vKB2W1qsnjKnv1RfmxtwwAYNh1EwsAe5PnkKSjl7Ee9gA/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VlVYq34Lbz9v7Js;
	Thu, 23 May 2024 22:15:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 19CF8140665;
	Thu, 23 May 2024 22:37:01 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwCn4CSDVE9mLzXACA--.32576S2;
	Thu, 23 May 2024 15:37:00 +0100 (CET)
Message-ID: <edc0665a-6301-428b-9611-f53d5f05eb69@huaweicloud.com>
Date: Thu, 23 May 2024 16:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCn4CSDVE9mLzXACA--.32576S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy5Cr4DWw4kCw1UGw1DGFg_yoW8uF48p3
	yfK3WrKF1ktFWI9ryUZw42ya4S93W0qFWUJrn5J3yayFs093WxtF48Jw4rCFy3Zrs3X3Wj
	vFW0v34xAa98AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
	-UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/23/2024 um 4:05 PM schrieb Alan Stern:
> On Thu, May 23, 2024 at 02:54:05PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/22/2024 um 4:20 PM schrieb Alan Stern:
>>> It would be better if there was a way to tell herd7 not to add the 'mb
>>> tag to failed instructions in the first place.  This approach is
>>> brittle; see below.
>>
>> Hernan told me that in fact that is actually currently the case in herd7.
>> Failing RMW get assigned the Once tag implicitly.
>> Another thing that I'd suggest to change.
> 
> Indeed.
> 
>>> An alternative would be to have a way for the .cat file to remove the
>>> 'mb tag from a failed RMW instruction.  But I don't know if this is
>>> feasible.
>>
>> For Mb it's feasible, as there is no Mb read or Mb store.
>>
>> Mb = Mb & (~M | dom(rmw) | range(rmw))
>>
>> However one would want to do the same for Acq and Rel.
>>
>> For that one would need to distinguish e.g. between a read that comes from a
>> failed rmw instruction, and where the tag would disappear, or a normal
>> standalone read.
>>
>> For example, by using two different acquire tags, 'acquire and 'rmw-acquire,
>> and defining
>>
>> Acquire = Acquire | Rmw-acquire & (dom(rmw) | range(rmw))
>>
>> Anyways we can do this change independently. So for now, we don't need
>> RMW_MB.
> 
> Overall, it seems better to have herd7 assign the right tag, but change
> the way the .def file works so that it can tell herd7 which tag to use
> in each of the success and failure cases.

Yes, that would be good.
In principle herd should already support this kind of logic for e.g. C11 
which also has distinct success and failure modes.
But of course I don't know if there's syntax to make this change in 
.def, let alone what it would look like.


> But at least you
> understood what I meant.

I do try :) (: :)

> 
>> We could do (with the assumption that Mb applies only to successful rmw):
>>
>>   	[M] ; po ; [Mb & R]
>>   	[Mb & W] ; po ; [M]
> 
> That works.

Ok, I'll prepare a patch for this and Andrea or anyone else can still 
interject.
I suppose the patch would not change the semantics at all with the 
current herd7, since Mb does not appear on any reads and writes for the 
time being.

best wishes,
   jonas




