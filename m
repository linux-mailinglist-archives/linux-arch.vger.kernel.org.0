Return-Path: <linux-arch+bounces-4502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E48CD5B4
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43B71F21F89
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606C146D79;
	Thu, 23 May 2024 14:26:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094714B95F;
	Thu, 23 May 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474410; cv=none; b=S1M+nZOWcQ+Ydkw2t+fOj2yiEhcwYOBWNH+HlEM8V6XwALyKqoDUi9OR+Zjmcps1Ik3SK+qrvY691NCMV/zQzgh+EikN0CT40IDowcizX9A4+ev7r7WH9JyjgNWfhWbl6TmTh3SLt5GQmLD4RjJt4N9GRuXTB7Syk+7Fm7Mbt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474410; c=relaxed/simple;
	bh=4ZTfeHLk7LxYh2MHgfFTHV1Mkbq6o/Rj4CDuHvRj8qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc0DDeoZqHLB63gv9tsXkvxcfwoL9CkUDV2M/dc9KRWw7QLDwAoi+N6ADKxla7VdOSbAR1WP47aq4usbPcoKNgTQuFwlS4fiaGTeyFWD2MfPqjgq6hAPnphtVIhWUO67meFF/EoyL4h99NSnaiX0CI0RYYwVWiGTdYFklRihIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VlVRJ23Ydz9v7Hl;
	Thu, 23 May 2024 22:09:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3D7FD1405E1;
	Thu, 23 May 2024 22:26:36 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP1 (Coremail) with SMTP id LxC2BwC3qxQSUk9mdIXECA--.15568S2;
	Thu, 23 May 2024 15:26:35 +0100 (CET)
Message-ID: <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
Date: Thu, 23 May 2024 16:26:23 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwC3qxQSUk9mdIXECA--.15568S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxuryUAFW5uw1fXrWUurg_yoW8Kw17p3
	ySkas5KF9Yq34Ikry09w47A34FkrW0qF15Jrn5trWakFn09F1Sqw4xA3yruF98Arsaq3W0
	vay5A34DAayDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 5/23/2024 4:05 PM, Alan Stern wrote:
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

I am not fully sure how herd7 uses the .def file, but I guess something 
like adding a second memory tag to __cmpxchg could work

cmpxchg(X,V,W) __cmpxchg{mb, once}(X,V,W)
cmpxchg_relaxed(X,V,W) __cmpxchg{once, once}(X,V,W)
cmpxchg_acquire(X,V,W) __cmpxchg{acquire, acquire}(X,V,W)
cmpxchg_release(X,V,W) __cmpxchg{release, release}(X,V,W)

Hernan

> 
>>> 	[M] ; po ; [RMW_MB]
>>>
>>> 	[RMW_MB] ; po ; [M]
>>>
>>> This is because events tagged with RMW_MB always are memory accesses,
>>> and accesses that aren't part of the RMW are already covered by the
>>> fencerel(Mb) thing above.
>>
>> This has exactly the issue mentioned above - it will cause the rmw to have
>> an internal strong fence that on powerpc probably isn't there.
> 
> Oops, that's right.  Silly oversight on my part.  But at least you
> understood what I meant.
> 
>> We could do (with the assumption that Mb applies only to successful rmw):
>>
>>   	[M] ; po ; [Mb & R]
>>   	[Mb & W] ; po ; [M]
> 
> That works.
> 
> Alan


