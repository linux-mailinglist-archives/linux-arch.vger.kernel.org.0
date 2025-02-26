Return-Path: <linux-arch+bounces-10373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A250FA45D27
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 12:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E520D172EEF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75C2153EB;
	Wed, 26 Feb 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rWtw35VN"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCF215050
	for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569439; cv=none; b=FqHAyGEP8Drhq0zo8nGU6SlhoIWq+FbuzAtEkQIl/voEyDnUUqcjHOqN7wzwMn1hw6nlogFuWGE8vsd6qxKrjOzdxmhck5Mwv46SCCR7tvSQMp3OygyA+wZd30c8IkCqYPmiMbbj5XQBYdFl3D31Krw4KAE6T8o0adxIxTqN+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569439; c=relaxed/simple;
	bh=SNcREccD3RAme9xYt3R+kilxl7SAdbri9ontWGXnon8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NATwmVanCs5baVK1/l8S0p3WIm48X6Se3M3TuL+tlPtnraRmF931pCL2aMWQwSe9vqJrPLCmJx0/Zi9JXc8jioWVX03fNH3wPZNG9GQRtgTKZNBTH4ik0dJK9xF3fHxW3YOGNm4YwsYVh0ANh1xNqZWlZfnAhvqryHoWMPwSq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rWtw35VN; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=SOdlXl7RXO630hj2D8KbTA/iuYN0f3n9ChpjV2oMRbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=rWtw35VN5C7ebUryxGYabBiGNkfRxevNXaKu3lmmbcfRwCfqvGmsARTKGVlEDc3vJ
	 IUw+i/jF2/O7wPykYL7GtrScwR7YHPk2KZArZBlYEByVg4HG2euMsCf4SLAhxqqINe
	 T4aLRNRVMNlFJyn+/hO3Lmf6LkZiGLt8eWLCMvUUCNYIgCuhqhS16/5+FYQBrqDBv9
	 cTNT5EvlskIwUWEEZthrUNkKMbaMBoPHtGY9C1f3/Wkj+mhDFLP1F1CqAqbIZvoN+x
	 V8XpPNLsrc2QkugOEEdKPXC0Zg7dBaQpmDQ+gMVmCM7ShlzUTzFJzMqx6xBRgIBMy+
	 ioIbkere3zE9w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id EAC1C18036A;
	Wed, 26 Feb 2025 11:30:23 +0000 (UTC)
Message-ID: <d70d059e-37aa-431d-986c-5666f006d610@icloud.com>
Date: Wed, 26 Feb 2025 19:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Peter Zijlstra
 <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-mtd@lists.infradead.org
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com>
 <20250221200137.GH7373@noisy.programming.kicks-ass.net>
 <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>
 <20250224132354.GC11590@noisy.programming.kicks-ass.net>
 <a28f04e5-ccde-4a08-b8fa-a9fa685240b1@icloud.com>
 <15c121c7-aeed-480e-8b1a-8ff23b4a3654@intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <15c121c7-aeed-480e-8b1a-8ff23b4a3654@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BXt7ADwYEBiuzX8MsPltF1M0d6Q_8HN4
X-Proofpoint-ORIG-GUID: BXt7ADwYEBiuzX8MsPltF1M0d6Q_8HN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=993
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502260092

On 2025/2/26 01:27, Przemek Kitszel wrote:
>>>>> It might not be your preferred coding style, but it is not completely
>>>>> pointless.
>>>>
>>>> based on below C spec such as C17 description. i guess language C does
>>>> not like this usage "return void function in void function";
>>>
>>> This is GNU extension IIRC. Note kernel uses GNU11, not C11
>>
>> any link to share about GNU11's description for this aspect ? (^^)
> this is new for C17 or was there for long time?
> 

Standard C spec has that description for long time.
Standard C11 spec also has that description.

> even if this is an extension, it is very nice for generating locked
> wrappers, so you don't have to handle void case specially
> 
> void foo_bar(...)
> {
>     lockdep_assert_held(&a_lock);
>     /// ...
> }
> 
> // generated
> void foo_bar_lock(...)
> {
>     scoped_guard(mutex, &a_lock)
>         return foo_bar(...);

above is able to be written as below:
      scoped_guard(mutex, &a_lock) {
	foo_bar(...);
	return;
      }
> }
i will list my reasons why this usage "return void function in void
function" is not good in cover letter [00/18] of this series.



