Return-Path: <linux-arch+bounces-4551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884888D021D
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298691F2111B
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75D13AA59;
	Mon, 27 May 2024 13:47:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024E1DDEB;
	Mon, 27 May 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817669; cv=none; b=npjo9fd4rrOciJ6cDBGOQjdJX/+ewBT2AcxxuYKIYEYEF8HLCbCMob1jzqwSeKhf4okEck8xl8+RMsPzCCWyp9Ao3T2ei+9i1uzR1jGP1i+AS0f5BGQyNKZ14Irtf/mh9n4W2nyct9tTZlbDIVOcyDRtUGXU31BkitwS1GfKXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817669; c=relaxed/simple;
	bh=8xcCsB+EROXGp8PmzD+b1rGd0T94KqkDNPuU4A2t/a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw9OpHri7YNL2g9TQN1iWpss+eNFE88HP619jLyRXF5aboSgDU0fD7hMgPNgLzu33aoO5IemBBk8WD5d0edepv6lbM0c28KKVcBGcE4YwFKYE2565bAg1hqZjbZTKn2PP/pbZvUctVfCnJKXDMXUAf9XI2O+4jd/BsNLvItAgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VnxNH6XmZz9v7Hm;
	Mon, 27 May 2024 21:30:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7BF971404F0;
	Mon, 27 May 2024 21:47:35 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwDn0ibqjlRm4I0BCQ--.41868S2;
	Mon, 27 May 2024 14:47:34 +0100 (CET)
Message-ID: <7f5a586f-f4b6-4d70-b121-3d82daf54865@huaweicloud.com>
Date: Mon, 27 May 2024 15:47:20 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <79b55c10-dd06-4947-8545-20ffeb324bc6@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <79b55c10-dd06-4947-8545-20ffeb324bc6@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDn0ibqjlRm4I0BCQ--.41868S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZry7Gw1Uuw17Jw48ZrWfuFg_yoW8JrWDpF
	ZFga1xKw1DJay093yUGa9IvasY9an3XF1rW3s0yrs2ya1Yyw1xJryYvFW2gFyxtrn7A3WU
	Jw4Yv3yxXayDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI
	0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/27/2024 um 3:37 PM schrieb Alan Stern:
> On Mon, May 27, 2024 at 03:28:00PM +0200, Andrea Parri wrote:
>>>> +    |                smp_store_mb | W[once] ->po F[mb]                        |
>>>
>>> I expect this one to be hard-coded in herd7 source code, but I cannot find
>>> it. Can you give me a pointer?
>>
>> smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
>> the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".
> 
> Why don't we use this approach for all the value-returning full-barrier
> RMW operations?  That would immediately solve the issue of the
> special-purpose code in herd7, leaving only the matter of how to
> annotate failed RMW operations.


I experimented with that the other day. My idea was to use a new 
__fence{mb-successful-rmw} which would have

   Mb = Mb | Mb-successful-rmw & (domain((po\(po;po));rmw) | 
range(rmw;(po\(po;po)))

to turn only the ordering effect of fences around cmpxchg off (and the 
existance of these fences around unsuccessful cmpxchg would be the only 
difference to the current representation).

Unfortunately I didn't manage to get my changes to the .def file to 
compile (FWIW I'm on herd 7.56+03).

Maybe someone wiser with herd can figure out how to work the .def file.

Best wishes,
    jonas


