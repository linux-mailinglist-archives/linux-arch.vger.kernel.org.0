Return-Path: <linux-arch+bounces-10341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256FA42460
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD52619C211E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE11A239E;
	Mon, 24 Feb 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QlrLaWEd"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172919C54F
	for <linux-arch@vger.kernel.org>; Mon, 24 Feb 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408372; cv=none; b=Hn+PfC9nhYKGrSGVfRv37UWTOWTDIzNVEzTegYbSudI621okHry2dw5wiKngHmqshjKQFzF51o6gKXrQvnXVeRETZpxY2ed4G5TsEfw07hDAEu1cEGFk6+VVQpBaEUsuKWu7ACAu7OpQ0jZ2+ZEWjtcxrC2oQztg9c8Q9p9dehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408372; c=relaxed/simple;
	bh=fxHn5PpLrOvrhy3T9+DU0/Qq00yPM+Mp8t95xmMWsSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppREOxntXM4gV6nKSftPh4K3ywf56l/61J0pDsgXD9QSUDRp0WKVO6uh7NQfuVkJXLCLuc400wfwEvzJJj4ZtAqIYX1r8XWpEhKoHkEGKb5E1r9WsIAKmGmoFZ1GwL9dnOYj6/5wmEqfrn0QFOVyJ/aw13ZBCF4jseOwLvaI7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QlrLaWEd; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=SxARc5+mPnL0BjR2iW5rWJ4TF8233iOHpKnJbbHiSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=QlrLaWEdYFkfsu8fuz6nbUdcj79Q8tJSmKk2HA1yeaCmsuHQSOTGqxvHL7yUmSH26
	 akU6WkcZrQNFnHq+BJaLeGPq0iB3wrn9quZ3+XX7TL6W2416KdFvIkp5eq2vQ9b1mC
	 1W3KDPpIj0DisqfGR5RfGhPUGajT30GJk6SpSRctraMh5Bn8xJKesYr+HLgu8FHVrW
	 5Dfwx7CMvdnY4JwcEN6gg2auvHgazI6WEAwJkihz3N6RwdjmSunhSudO5G6dDlNdEp
	 B1QbwPUm6oUVtf0ONAKjCUdMnGgia+x/d6OTzrZdtjaV4ethm0Xnv3yRyjfFnT2Mpt
	 tk5oRw9q9GBwg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 01FF82010282;
	Mon, 24 Feb 2025 14:45:49 +0000 (UTC)
Message-ID: <a28f04e5-ccde-4a08-b8fa-a9fa685240b1@icloud.com>
Date: Mon, 24 Feb 2025 22:45:44 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250224132354.GC11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rwcKYw_iCScrLPUxt294xX4BCs8xvrO1
X-Proofpoint-GUID: rwcKYw_iCScrLPUxt294xX4BCs8xvrO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=911 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240105

On 2025/2/24 21:23, Peter Zijlstra wrote:
> On Sat, Feb 22, 2025 at 07:00:28PM +0800, Zijun Hu wrote:
>> On 2025/2/22 04:01, Peter Zijlstra wrote:
>>>>   */
>>>>  static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>>>>  {
>>>> -	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>>>> +	tlb_remove_page_size(tlb, page, PAGE_SIZE);
>>>>  }
>>> So I don't mind removing it, but note that that return enforces
>>> tlb_remove_page_size() has void return type.
>>>
>>
>> tlb_remove_page_size() is void function already. (^^)
> 
> Yes, but if you were to change that, the above return would complain.
> 
>>> It might not be your preferred coding style, but it is not completely
>>> pointless.
>>
>> based on below C spec such as C17 description. i guess language C does
>> not like this usage "return void function in void function";
> 
> This is GNU extension IIRC. Note kernel uses GNU11, not C11

any link to share about GNU11's description for this aspect ? (^^)




