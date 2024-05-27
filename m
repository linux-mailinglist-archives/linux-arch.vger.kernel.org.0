Return-Path: <linux-arch+bounces-4545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0B8D011F
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730B3B22C15
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7415ECE6;
	Mon, 27 May 2024 13:17:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65515DBC1;
	Mon, 27 May 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815846; cv=none; b=Xv5zJM1fnZzUo8muBySoKxo7iJJGExDJV8OJuOf4Mc6xAUkkB8EIvK75f/knBl3Z71BdkAsXjgWDPrmyjMr4TuKdqksoBDM4RuIrPUJaGIxLhD/4ghbdk1nhVs4PYJkAoQVk5+2KRcv7JjQS/WZrcfQo+sPa+pEl5jm+/MeF+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815846; c=relaxed/simple;
	bh=P9Sp2M8DvUMb5rgeT8Yrm7zVrQWRZ2B/cS+bWosHL4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLpKDvei0nNPJsBDUiwoe6HIyUxyhkgL3iglTOvaoJv6fumsjxVV6OEF13+V+xdpuMfdD8Cb23Z9Rro8fXfrMbyR8o+8eiO4QHAskzVlKj9fPjjostF9SfmhPAXF9jkwsN/spdpVssJsaot5kAGkyhoniehE8xI/t0pkD3hnAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vnwj81qCNz9v7Hm;
	Mon, 27 May 2024 20:59:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 884761403D2;
	Mon, 27 May 2024 21:17:10 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP1 (Coremail) with SMTP id LxC2BwCXjhfJh1RmaUIFCQ--.43989S2;
	Mon, 27 May 2024 14:17:09 +0100 (CET)
Message-ID: <d0bc38bc-e089-48d9-80a5-aafa54e98595@huaweicloud.com>
Date: Mon, 27 May 2024 15:16:55 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Andrea Parri <parri.andrea@gmail.com>, stern@rowland.harvard.edu,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 hernan.poncedeleon@huaweicloud.com
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZlC0IkzpQdeGj+a3@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwCXjhfJh1RmaUIFCQ--.43989S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY67AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/24/2024 um 5:37 PM schrieb Andrea Parri:
>> - While checking the information below using herd7, I've observed some
>>    "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
>>    IAC, that's also excluded from this table/submission.
> 
> For completeness, the behavior in question:
> 
> $ cat T.litmus
> C T
> 
> {}
> 
> P0(spinlock_t *x)
> {
> 	int r0;
> 
> 	spin_lock(x);
> 	spin_unlock(x);
> 	r0 = spin_is_locked(x);
> }
> 

Since 0 executions are generated, possibly herd things there's a deadlock.

Could be either a problem with the deadlock definition, or do you need 
to initialize the lock somehow?


