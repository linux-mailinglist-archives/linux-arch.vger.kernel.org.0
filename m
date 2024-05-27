Return-Path: <linux-arch+bounces-4550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51C8D01EB
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4281C20B00
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3A15575E;
	Mon, 27 May 2024 13:40:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EB13A250;
	Mon, 27 May 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817236; cv=none; b=tCp9YNGstpjjv3terWVbBkk+atAPoRs2HsbjZuU5vis0eNI6BC7HB3Bxy6nR53ivR/9y0cwfIbWwgNH32EwMXF4OZXdJEg4h0TN6K4hhEtclO2bgN8G47TKbe/jLP0UwvyzEIU4Vzjb1TBR77Z7ZiIqu9bx0+lXQKAzS0mANNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817236; c=relaxed/simple;
	bh=i+fmA1Usq+yf1h8sd1JSGhI2faM4avD4s7E3zhr+kbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KC01pgjakEejUC9iLa8WhdfHM/je0AxbZGA4uSBHFE5KVxr/hchZ2X9+aFzxQIncIz5i9SOz75wa6jux8SiKm3UHc0Ce3gSddCcGH+7nJfCcLCNZr7G9fUIakSv4Y+mfadYVYXQr3N6uFSpVqAlx8s53gEviFMVThOhXD81xAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VnxCy3RfMz9v7JS;
	Mon, 27 May 2024 21:23:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CC536140113;
	Mon, 27 May 2024 21:40:29 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwD3MCVAjVRm63gBCQ--.51164S2;
	Mon, 27 May 2024 14:40:29 +0100 (CET)
Message-ID: <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
Date: Mon, 27 May 2024 15:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Andrea Parri <parri.andrea@gmail.com>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZlSKYA/Y/daiXzfy@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwD3MCVAjVRm63gBCQ--.51164S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4fZw43Xw18XF47uF4DArb_yoW3Xwb_GF
	ZakrykGryYkFsrKF48XFZ0v34rG393XrZ3t347KayI9F93CrW5Wrs7ZryfArnrGanIyF12
	krZI9rsYvw4DAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r
	1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/27/2024 um 3:28 PM schrieb Andrea Parri:
>>> +    |                smp_store_mb | W[once] ->po F[mb]                        |
>>
>> I expect this one to be hard-coded in herd7 source code, but I cannot find
>> it. Can you give me a pointer?
> 
> smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
> the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".

By the way, I experimented a little with these kind of mappings to see 
if we can just explicitly encode the mapping there. E.g., I had an idea 
to use
     { __fence{mb-successful-rmw}; __cmpxchg{once}...; 
__fence{mb-successful-rmw}; }

for defining (almost) the current mapping of cmpxchg explicitly.

But none of the changes I made were accepted by herd7.

Do you know how the syntax works?

     jonas


