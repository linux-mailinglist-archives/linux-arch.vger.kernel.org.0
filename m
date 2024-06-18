Return-Path: <linux-arch+bounces-4960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3FD90C931
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 13:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE04A1C22F43
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67315CD76;
	Tue, 18 Jun 2024 10:20:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F582D98;
	Tue, 18 Jun 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706052; cv=none; b=U4CrPfQap/aPFhxEJ8Jt2FHULUAxpdWF4ZwYo/I9EOxM2XntcA7akd0FCsFvJFj+p7cV0EvBolvSfEEWRzgMPOAMsPjc5ZYnKiLcXfrEJoZBo9ubk/dRG/yH2XxUpdFUsJoCfjXjJP8BxmGsdpRG3l1Zt2fg/zSQTbR/QLmNEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706052; c=relaxed/simple;
	bh=pGodE3qWq+wDKqfQ+tqM+fIvlcAWHzIcMuELcfr1Cug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfKk+uo3+NTTTshTLubiASjxShJR3LIbwwZUIQW/rPfqEmtS7eqMREMHfbNrbO49Jg333eUXFhWFXnU4pp1zlzPHZs199LeF2ftX6X6ywKmobT3uqgZ3DOTs7vksuDP+Lu6REvFZ5zM77xDBXUq2NDqd/JQTWG6Kj9ET8Q6YrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3Mks2CVzz9v7Hl;
	Tue, 18 Jun 2024 18:03:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 388A81407F5;
	Tue, 18 Jun 2024 18:20:37 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP2 (Coremail) with SMTP id GxC2BwA3vzlpX3FmJUqoAA--.41471S2;
	Tue, 18 Jun 2024 11:20:36 +0100 (CET)
Message-ID: <ecacb016-55d8-8158-ee9c-1b7a22f498e6@huaweicloud.com>
Date: Tue, 18 Jun 2024 12:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, stern@rowland.harvard.edu,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <ZnC-cqQOEU2fd9tO@boqun-archlinux>
 <07513d65-386d-1bfb-f5ad-8979708d5523@huaweicloud.com>
 <ZnFZPJlILp5B9scN@andrea>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ZnFZPJlILp5B9scN@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwA3vzlpX3FmJUqoAA--.41471S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4xGrWfZF1DurykGry3Arb_yoWDJFc_Kr
	yqgFWqka1Utr4Fgr47AFs5AF4SvFZYkF4vyw4rJwnxA3W3J39rJFyktwnrAayYvw4I9rnr
	GFZ8Gr43G3srXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 6/18/2024 11:54 AM, Andrea Parri wrote:
>> This follows from rmw \subset po. However, this might not be immediately
>> clear for the reader so having it explicit is a good idea.
> 
> Sure.  How about as follows:
> 
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> index 2fe270e902635..8255a2ff62e5f 100644
> --- a/tools/memory-model/Documentation/herd-representation.txt
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -14,7 +14,7 @@
>   #	SRCU,	a Sleepable-Read-Copy-Update event
>   #
>   #	po,	a Program-Order link
> -#	rmw,	a Read-Modify-Write link
> +#	rmw,	a Read-Modify-Write link; every rmw link is a po link
>   #
>   # By convention, a blank entry/representation means "same as the preceding entry".
>   #
> 
> I can respin the patch shortly to add something along these lines and
> the collected tags.
> 
>    Andrea

Sounds good to me.

Hernan


