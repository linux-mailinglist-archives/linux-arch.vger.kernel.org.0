Return-Path: <linux-arch+bounces-4445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C438C72DF
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 10:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A531B1C225DD
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1D13D63A;
	Thu, 16 May 2024 08:32:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A213D604;
	Thu, 16 May 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848320; cv=none; b=Jmw8E34qAkkWPvQDorQ1aEno3rq/ThJkm97OMeaCQUYKYfIn8Zy/Tl+zD4eGxK7VnQrRHAGDuNiOwTajnQ0XKI7GK+da7d9tmcEUmrPYtKmJjtBPlhheSq/CszVfKsSmjYcrWtHZ5gkerqxKXTFp9X+RNsPaC+f9m2ZD3thcbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848320; c=relaxed/simple;
	bh=iY6FIn6/CSyk7BNN3Z4qn1YatE46WXMjgrOZzM/0EQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlUnLBUEN+tCk2YTf/DnCWS8ECMPghdzy2OX3RQSziTd4oWFYNMkslvFJ3+MtvbBCXoyS4h5UrUb52H4pSHNHTTJow5umBERa5YyExdDmcNOi/YisOE8DL9QU07BwSXuAlx6yAfxM7DnV4IcGE8FKiYx7azjc1s7XvkB7+y9KBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vg2v76fVlz9v7Nd;
	Thu, 16 May 2024 16:14:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C3781140665;
	Thu, 16 May 2024 16:31:40 +0800 (CST)
Received: from [10.45.154.179] (unknown [10.45.154.179])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRixEVmHIZBCA--.6320S2;
	Thu, 16 May 2024 09:31:40 +0100 (CET)
Message-ID: <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
Date: Thu, 16 May 2024 10:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAHQCRixEVmHIZBCA--.6320S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4xtFWxKrWUtFyDXF1kZrb_yoW8ZrWkpF
	sxG34kKrykJwsxuw1DA39rJr1ava1rGrWUJF15Wwsay3Z0gF1IqF15tayYvay7Wrs7WF1j
	vF42vas8Z3WDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
> Hernan and Jonas:
> 
> Can you explain more fully the changes you want to make to herd7 and/or
> the LKMM?  The goal is to make the memory barriers currently implicit in
> RMW operations explicit, but I couldn't understand how you propose to do
> this.
> 
> Are you going to change herd7 somehow, and if so, how?  It seems like
> you should want to provide sufficient information so that the .bell
> and .cat files can implement the appropriate memory barriers associated
> with each RMW operation.  What additional information is needed?  And
> how (explained in English, not by quoting source code) will the .bell
> and .cat files make use of this information?
> 
> Alan


I don't know whether herd7 needs to be changed. Probably, herd7 does the 
following:
- if a tag called Mb appears on an rmw instruction (by instruction I 
mean things like xchg(), atomic_inc_return_relaxed()), replace it with 
one of those things:
   * full mb ; once (the rmw) ; full mb, if a value returning 
(successful) rmw
   * once (the rmw)   otherwise
- everything else gets translated 1:1 into some internal representation

What I'm proposing is:
1. remove this transpilation step,
2. and instead allow the Mb tag to actually appear on RMW instructions
3. change the cat file to explicitly define the behavior of the Mb tag 
on RMW instructions

There are probably two ways to achieve this:
a) change herd7 to remove the special behavior for Mb, after that we 
should be able to do everything else in the .cat/.bell/.def files.
b) sidestep herd7's behavior by renaming Mb to _Mb in the .def file,
  and then defining Mb=_Mb in the .bell file, and define the semantics 
of the Mb tag in the .cat files.


The latter would not include modification to herd7, but it's a bit hacky.

I'm not sure if the second way really works since I don't know exactly 
how the herd7 tool does the transpilation,  e.g., if it really looks for 
an Mb tag or rather for the names of the instructions.

Does it make sense?

jonas


