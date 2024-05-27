Return-Path: <linux-arch+bounces-4552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D28D09A2
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03EA1C20F33
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748E15F326;
	Mon, 27 May 2024 17:58:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6515F321;
	Mon, 27 May 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832693; cv=none; b=OKWn0SI3a5GH/nLIQzyedOYnagvr/FJSX5TQTm/tlEaGiLVgBEJ/S/FibRh5R6SHB7N2Drq+9GLGkTcnNkNCbh84CJns4uCh7zBcSHZzAkW92CjQatMcZZzmjNupn1g+wZj1OQdHcKstQbptK+Z8pGrKpOOyrmjkfpNak+rIIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832693; c=relaxed/simple;
	bh=jDAFrzgHrHC254nXAC5kmkv2OBSuJlA9e/44Od3NNqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2xBRP+GQ5VvDAeDo6T6u3afPOD912nx1x0JojUa2F2GbUajrSCY9atazhcXckwu+om7vU9v8SqvCgk5dOtwPstK+RmWr01PE1PT9J1X0wL957PWCmUETa0lNGpBxEB/y58LdrWdmb9EhXkZLN1vLwvzlPyuUHdESMTS3iAIicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Vp2xD5kw9z9v7Hm;
	Tue, 28 May 2024 01:40:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8F059140485;
	Tue, 28 May 2024 01:57:56 +0800 (CST)
Received: from [10.81.209.100] (unknown [10.81.209.100])
	by APP2 (Coremail) with SMTP id GxC2BwDXDySXyVRm8m8ECQ--.35226S2;
	Mon, 27 May 2024 18:57:56 +0100 (CET)
Message-ID: <5a9bc579-01ad-0b0f-bcba-c8f0bd932331@huaweicloud.com>
Date: Mon, 27 May 2024 19:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 jonas.oberhauser@huaweicloud.com
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ZlSKYA/Y/daiXzfy@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDXDySXyVRm8m8ECQ--.35226S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUZFykuF48uryfAF4ktFb_yoW8Jw4kpa
	47GFZ8t3WDXayUZw1kGay3ZF1Iy395tFyUXF9Ygr13Cr45K34fJr4fKrZ0kFyDuw4Iya4U
	A3y5trZxAa9aya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 5/27/2024 3:28 PM, Andrea Parri wrote:
>>> +    |                smp_store_mb | W[once] ->po F[mb]                        |
>>
>> I expect this one to be hard-coded in herd7 source code, but I cannot find
>> it. Can you give me a pointer?
> 
> smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
> the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".

Ok, so some fences where added in the .def file (this) while other 
programmatically (e.g., xchg). We should at least be consistent about 
how this is done. Based on previous comments, it seems most of us agree 
this should go the the .def file.

> 
> 
>> What about spin_unlock?
> 
> spin_unlock() is listed among the non-RMW ops/macros in the current table: it
> is represented by a single UL or "Unlock" event (a special type of Store event
> with (some special) Release semantics).

I was blind. Sorry for the noise.

> 
> 
>> I found the extra spaces in the failure case very hard to read. Any
>> particular reason why you went with this format?
> 
> The extra spaces were simply to convey something like "belong to the previous
> row/entry", but I'm open to remove them or other suggestions if preferred.

I find it easier to read without the extra spaces. The empty column on 
the left already tells me this is a continuation of the previous row.
But I don't see this as a blocker.

> 
>    Andrea


