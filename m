Return-Path: <linux-arch+bounces-4544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E38D0108
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322321F2460B
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD615ECCA;
	Mon, 27 May 2024 13:15:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176315E5DD;
	Mon, 27 May 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815721; cv=none; b=NXswnXU1R5ohu3+5uKpDXuVbW+ZFJCmMIJAxQMAA/5jZUgzKA55YHg742nxkCoB+EWP2Hdgsy8V7ZMTrWqy/QFDGdxTXngX1wn6hSib7aLJUBJPvJgby7VEKbD+f1XP0xYn7CrCENEVd6CJrS5nxieOCsQiZGG7mZN4OnM93hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815721; c=relaxed/simple;
	bh=h6jP6IddeCizaqoE9jp2cmuBloJpEnUogauaN3oACqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcfk1t5KO4ZD9gUN3HhoVgfj0xjzENHvn47KsGn79Imi4wTNEJiRDw9KkilzBfv52TsoYFWVlejlIb8m2f0KvwWm9HkzHsd5f7Mq5/nODaIX/n7WBAKP3fSrZA/PixPGgTW0YTTpn/98eOvFEcv4k9Bneaphl0ZA8j02CI22fvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VnwYK53M7z9v7Jb;
	Mon, 27 May 2024 20:53:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7F8CB140113;
	Mon, 27 May 2024 21:15:15 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP1 (Coremail) with SMTP id LxC2BwCXjhdWh1RmqDwFCQ--.43980S2;
	Mon, 27 May 2024 14:15:14 +0100 (CET)
Message-ID: <747c6690-5314-4c23-b48d-1b463d058e0d@huaweicloud.com>
Date: Mon, 27 May 2024 15:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 Andrea Parri <parri.andrea@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>
 <ZlC5q7bcdCAe7xPp@andrea>
 <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCXjhdWh1RmqDwFCQ--.43980S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/27/2024 um 2:25 PM schrieb Hernan Ponce de Leon:
> On 5/24/2024 6:00 PM, Andrea Parri wrote:
>>> What's the difference between R and R*, or between W and W*?
>>
>> AFAIU, herd7 uses such notation, "*", to denote a load or a store which
>> is also in RMW.
> 
> I also got confused with this. What about the following notation?
> 
>      R[once,RMW] ->rmw W[once,RMW]
> 
>>
>>    Andrea
> 



Note that the * is also what herd will show in its graphs.

   jonas


