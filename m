Return-Path: <linux-arch+bounces-4446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142B8C7345
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B9284036
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC323142912;
	Thu, 16 May 2024 08:52:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A42D054;
	Thu, 16 May 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849537; cv=none; b=qsLhu7XDXfKpV4d3tnEzSE8OcgTFN/NG4iz4Ex26DH0yrCN3s8yUsFyshRIpQ7PQaDp++viW1SYDtMeNZKkBs2DKllT1uJN3Gt/4q11EBEXS2xVJxb1YXZXV6p1dPoo1Wd+U5P+7gxsv1wS146Tm3j7DkhFnTA5TiCHpG70y4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849537; c=relaxed/simple;
	bh=EPyGLyG+K4E+o1cu+2hycPZHn68duC90xuBVoJXjJzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLxgNd+XMo0ElFr2SV8gcvrYDP8UHNVrfQWy+mHFT2xe1XWVaTXX5Zaq6OpRO2EmBrGAuKpDSO33d76NRfIRlS6SphqwcnyJw4DT7Ovus6+Nh/4m3sc9gYQqySfJX4fgA6alDHj5BBDeqEs7Q6KERgd5ADsO29+sS1pBIhH6u9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Vg3LZ40zSz9v7Hm;
	Thu, 16 May 2024 16:35:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 37875140628;
	Thu, 16 May 2024 16:52:04 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP1 (Coremail) with SMTP id LxC2BwCnmhMqyUVmGfBGCA--.55916S2;
	Thu, 16 May 2024 09:52:03 +0100 (CET)
Message-ID: <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
Date: Thu, 16 May 2024 10:44:05 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LKMM: Making RMW barriers explicit
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCnmhMqyUVmGfBGCA--.55916S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kZw1rJry5JFW3tw17Awb_yoW8ArWfpF
	sxC3yvkr4DJ393uwnrZr47XryFqan3JrW8Jr93Wws3Aas8KF1xKFs8tayj9FZxXrs7uF42
	qr1aqas8u3WDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
> 
> 
> Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
>> Hernan and Jonas:
>>
>> Can you explain more fully the changes you want to make to herd7 and/or
>> the LKMM?  The goal is to make the memory barriers currently implicit in
>> RMW operations explicit, but I couldn't understand how you propose to do
>> this.
>>
>> Are you going to change herd7 somehow, and if so, how?  It seems like
>> you should want to provide sufficient information so that the .bell
>> and .cat files can implement the appropriate memory barriers associated
>> with each RMW operation.  What additional information is needed?  And
>> how (explained in English, not by quoting source code) will the .bell
>> and .cat files make use of this information?
>>
>> Alan
> 
> 
> I don't know whether herd7 needs to be changed. Probably, herd7 does the 
> following:
> - if a tag called Mb appears on an rmw instruction (by instruction I 
> mean things like xchg(), atomic_inc_return_relaxed()), replace it with 
> one of those things:
>    * full mb ; once (the rmw) ; full mb, if a value returning 
> (successful) rmw
>    * once (the rmw)   otherwise
> - everything else gets translated 1:1 into some internal representation

This is my understanding from reading the source code of CSem.ml in 
herd7's repo.

Also, this is exactly what dartagnan is currently doing.

> 
> What I'm proposing is:
> 1. remove this transpilation step,
> 2. and instead allow the Mb tag to actually appear on RMW instructions
> 3. change the cat file to explicitly define the behavior of the Mb tag 
> on RMW instructions

These are the exact 3 things I changed in dartagnan for testing what 
Jonas proposed.

I am not sure if further changes are needed for herd7.

Hernan


