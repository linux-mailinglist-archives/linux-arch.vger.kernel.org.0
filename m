Return-Path: <linux-arch+bounces-4494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158D8CC77A
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 21:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF5EB20A1B
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36C146004;
	Wed, 22 May 2024 19:48:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACEA3F;
	Wed, 22 May 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407326; cv=none; b=MzhnDi2ha54S1asBfIn3y7swdYVnhVsrX+JQU+A7ytWiIlkX1ze1ncwmp6E45TnltykUTqefc6I584NTtxWDJrPj7SuSPcGkR8TozBKFB+n+/8Drd5y+5gHrpkGSoggsYBqEmgUH+MOSMkslGCoa8Id5yZhNvBQBkbqiHIpn4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407326; c=relaxed/simple;
	bh=HdAT56sJXNa4TBXRL+PSM8UK/YONNo0f7tIuiu+4yYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFQLGWOwH2VBqLcqW0q0PBKRFeDj0pEJpA3RhNR8K8hgwlz5MS+Zek1h3kU5CZ2ieus21M3GawkM3hFyldQZuXfS7u2ZDEUVtwYmOtz0ZE4tztf+20R7/ARS9RrXMXFDFsXdQSz/0VbLzFMSj6e7I6IRPF3qYpSCwpwfSq48GYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Vl1d65fL0z9v7Hl;
	Thu, 23 May 2024 03:31:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 24B10140489;
	Thu, 23 May 2024 03:48:34 +0800 (CST)
Received: from [10.48.210.253] (unknown [10.48.210.253])
	by APP2 (Coremail) with SMTP id GxC2BwDHASYHTE5mbkOzCA--.18061S2;
	Wed, 22 May 2024 20:48:33 +0100 (CET)
Message-ID: <22b9837b-16c2-5413-3cd7-4d3a47252a6a@huaweicloud.com>
Date: Wed, 22 May 2024 21:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LKMM: Making RMW barriers explicit
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
 <ba7120a5-9208-4506-bf99-2bfa165180c5@rowland.harvard.edu>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ba7120a5-9208-4506-bf99-2bfa165180c5@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDHASYHTE5mbkOzCA--.18061S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWDWF18JFyxGr4fJFy8Grg_yoWrGrW3pF
	WxAa4Ska1kt3s29w4xZ392qFyF9a1rGr48Jr95t3sYy34Y9r1FyF9xKa1YkFyDCr4rXw12
	vw4YqFy8Z3Z8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 5/22/2024 8:20 PM, Alan Stern wrote:
> On Wed, May 22, 2024 at 06:54:25PM +0200, Andrea Parri wrote:
>> Alan, all,
>>
>> ("randomly" picking a recent post in the thread, after having observed
>> this discussion for a while...)
>>
>>> It would be better if there was a way to tell herd7 not to add the 'mb
>>> tag to failed instructions in the first place.  This approach is
>>> brittle; see below.
>>
>> AFAIU, changing the herd representation to generate mb-accesses in place
>> of certain mb-fences...
> 
> I believe herd7 already generates mb accesses (not fences) for certain
> RMW operations.  But then it does some post-processing on them, and that
> post-processing is what we are thinking of changing.
> 
>>> If you do want to use this approach, it should be simplified.  All you
>>> need is:
>>>
>>> 	[M] ; po ; [RMW_MB]
>>>
>>> 	[RMW_MB] ; po ; [M]
>>>
>>> This is because events tagged with RMW_MB always are memory accesses,
>>> and accesses that aren't part of the RMW are already covered by the
>>> fencerel(Mb) thing above.
>>
>> ... and updating the .cat file to the effects of something like
>>
>>    -let mb = ([M] ; fencerel(Mb) ; [M]) |
>>    +let mb = (([M] ; po? ; [Mb] ; po? ; [M]) \ id) |
>>
>> ... can hardly be called "making RMW barriers explicit".  (So much so
>> that the first commit in PR #865 was titled "Remove explicit barriers
>> from RMWs".  :-))
> 
> There is another point, something we didn't spell out explicitly in the
> email discussion.  Namely, in linux-kernel.def there is a long list of
> instructions along with corresponding herd7 implementation instructions,
> and those instructions explicitly contain either {once}, {acquire},
> {release}, or {mb} tags.  So to a large extent, these barriers already
> are explicit in the memory model.  Not in the .cat file, but in the .def
> file.
> 
> What is not so explicit is how the {mb} tag works.  Its operation isn't
> as simple as the operation of the {acquire} and {release} tags; those
> just modify the R or W access in the RMW pair as you would expect.
> Instead, an {mb} tag says to insert strong memory barriers before the R
> access and after the W access.  This is more or less what the
> post-processing mentioned earlier does, and Jonas and Hernan want to
> move this out of herd7 and into the memory model.
> 
>> Overall, this discussion rather seems to confirm the close link between
>> tools/memory-model/ and herdtools7.  (After all, to what extent could
>> any putative RMW_MB be considered "explicit" without _knowing the under-
>> lying representation of the RMW operations...)  My understanding is that
>> this discussion was at least in part motivated by a desire to experiment
>> and familiarize with the current herd representation (that does indeed
>> require some getting-used-to...); this suggests, as some of you already
>> mentioned, to add some comments or a .txt in tools/memory-model/ in order
>> to document such representation and ameliorate that experience.  OTOH, I
>> must admit, I'm unable to see here sufficient motivation(tm) for changing
>> the current representation (and model): not the how, but the why...
> 
> Well, it's not a big change.  And in my opinion, if something can be
> moved out of herd7's innards and into the memory model files, then doing
> so is generally a good idea.
> 
> However, I do agree that there will still be a close link between
> tools/memory-model/ and herdtools7.  This may be unavoidable, at least
> to some extent, but any way to reduce it is worth considering.

I can give my motivation as a tool developer. It would be much simpler 
if one could find all the information to support lkmm in 
tools/memory-model/ (in the form of the model + some comments or a .txt 
to cover those things we cannot move out of the tool implementation), 
rather than having to dive into herd7 code.

Hernan

> 
> Alan


