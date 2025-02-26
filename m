Return-Path: <linux-arch+bounces-10374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69461A45D9A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CC1174BF5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D0219312;
	Wed, 26 Feb 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f8lZWyvS"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15647218858
	for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570353; cv=none; b=uY9eBIeMBS35aKEFLFESgobDFE/1sYVm5KkCPYHeyXwRvCIivTFzJRx20+dR7+lSy1XhFR36s+SsMIcC3rPHkeoGMv2NDkLR0j1L1oHwjl4d/aXA7YA6N1VzyrHv6w4EQ/q2bnDb6KWtyMHONZmY/AnF2pNQ+S8/z69GHgMBSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570353; c=relaxed/simple;
	bh=C0kSWoh3LIV+HuMudMUFcqmX7KtzIL+dLkLS0LuQI+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPpyqAxKbl3yHXkeg2f85LxHTum34p4RQneFDJPj8zf0OOEK1cbjEuTLDWXTG6rO3KCgWg8jmpCfOB2HqaQ1altDMkWDubcAKpGB81c6N8yUzR/02QflMiFLX1DdWmNWKmO1mBx23OECasC9hfBP77FosLQ4CzqFxk1Fq/HOBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=f8lZWyvS; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=UlmH7lnQ/SSIrKM5aMl2BHpkT+fwdodZZLv8W8GXIsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=f8lZWyvSDPQwKr7SDXIE6VdW5kZrI22cRU+v86cMZBg8M63ib8K+MKQDsZPYVZ+Mz
	 VIc01nNZYPIWEtaq9AznMiQTF7n48OFpxRM5YhSgpY2okVb9cwuvzP1KIikiB+2fRu
	 d+7AduZcNoirLHLK7K4h8pgvS0d1L0tQbLrFrF/Od88tDX/EZXod457QB5bg4qbmFp
	 DbogBPgs3Q7iQQ0mZfmhQRiw2/P900rSG5OeZM5GDf/tYeCwP0bcGCpZ97ZFFl8n8G
	 biW93Aup+84jC3T2ck5W5lDGV0KXW+sjwetmqndyZG8OIOv24PsphQXGiGBlN7Elxi
	 r4aI2TycTa3Rw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 5CEAB180350;
	Wed, 26 Feb 2025 11:45:37 +0000 (UTC)
Message-ID: <a6dfff9c-ab0e-4308-81e7-62d8ea04d62b@icloud.com>
Date: Wed, 26 Feb 2025 19:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
To: David Howells <dhowells@redhat.com>
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
References: <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>
 <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com>
 <20250221200137.GH7373@noisy.programming.kicks-ass.net>
 <2298251.1740496596@warthog.procyon.org.uk>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2298251.1740496596@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iqw5w_RmeMXu0iJloMXtrzoP0X8vVIzf
X-Proofpoint-ORIG-GUID: iqw5w_RmeMXu0iJloMXtrzoP0X8vVIzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=985
 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502260094

On 2025/2/25 23:16, David Howells wrote:
> Zijun Hu <zijun_hu@icloud.com> wrote:
> 
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
> That may be true... for now.  But if that is changed in the future, then you
> will get an error indicating something you need to go and look at... so in
> that regard, it's *better* to do this ;-)
> 

i understand your point.

if the callee tlb_remove_page_size() is in the same module with the
caller tlb_remove_page. it is meaningless to watch the callee's return type.

otherwise, provided the callee is a API which is provided by other
module author. once the author changes the API's return type, he/she
must take effort to cleanup this weird and lots of usages, that is not
nice for API provider.

this is a common issue. i will list my reasons why this usage is not
good in cover letter of this series
> David
> 


