Return-Path: <linux-arch+bounces-10331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8242A407C7
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED137AA110
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50C209F5E;
	Sat, 22 Feb 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HhStBCZN"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF11EE031
	for <linux-arch@vger.kernel.org>; Sat, 22 Feb 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222055; cv=none; b=gFx+Z68FAE9yv2sfU6gKclmIOtRzQZ9TGSVmKDSxSVBztmL2ZXtfJt3gf8yO13U8Y24BG5kNdHZV9oFRpWHn9lMQM8G8F83VvP/MjRQBaCVR/nR7npZwSeWHlrbr3zln5boDRtQkDFWTAWUUMzTtxwzMID4fgD19X11JX8EnaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222055; c=relaxed/simple;
	bh=s5PMq4K2vUmCJ7mWo835mcJtSukLKOG4lecc2nZmroI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTjnA98nYQvX3BVm8uaLrFNPv06CcThv6gZjXsemvJSt5Rixsbd/g6zfCduQPa+EdyqYojzqD1InRC1EGhN3+NAVyqyeX9exR85IdmM23HLnQm/w7ykjwMR296q2jz/47NV7qtAe96vJFEPvaIicpvmXlrA/TUZ5r9YZOLj+LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HhStBCZN; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=UhO/oKP5iMw5fHjgaGRWOOpphrslB5BPutH1Bqw2Dkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=HhStBCZN3rVcd9EC6oBRvG6abifGqlnPtcBVpdm6i/PmmBuQa0QJPHyLR1FLsYmXk
	 MvvGwxnVyjgIAQUePoznfvb7VEqM2/2CzwoYBfpUQAlvZbnYih/hmf83Ex5BvNFrdQ
	 PbfYoJ6GNXR9EuX2Q1IkypReed+wxDFG/c9O7uFQFsKRQdeX9qYk5H4Dvd9QURFidN
	 MaOu/D4ITgbWB/BaBzseWqBas93vN7EeBu7C7tTfSVogYryn4akeV915HBecUZbsev
	 T9vaSLH2CkX0yMcrX7poOXKdwAfoNE9h2RgWTSTlng3BI8SOCu2qBQQAo94LS+WVDT
	 77yqa5YwGC84Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id C1B66201011A;
	Sat, 22 Feb 2025 11:00:33 +0000 (UTC)
Message-ID: <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>
Date: Sat, 22 Feb 2025 19:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
To: Peter Zijlstra <peterz@infradead.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250221200137.GH7373@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xYMDZO87E-9u-9wzotp6QmCV6S-rGtqV
X-Proofpoint-ORIG-GUID: xYMDZO87E-9u-9wzotp6QmCV6S-rGtqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=885
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502220088

On 2025/2/22 04:01, Peter Zijlstra wrote:
>>   */
>>  static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>>  {
>> -	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>> +	tlb_remove_page_size(tlb, page, PAGE_SIZE);
>>  }
> So I don't mind removing it, but note that that return enforces
> tlb_remove_page_size() has void return type.
>

tlb_remove_page_size() is void function already. (^^)

> It might not be your preferred coding style, but it is not completely
> pointless.

based on below C spec such as C17 description. i guess language C does
not like this usage "return void function in void function";

C spec such as C17 have this description about return
statement:
6.8.6.4:
A return statement with an expression shall not appear in a function
whose return type is void. A return statement without an expression
shall only appear in a function whose return type is void.

