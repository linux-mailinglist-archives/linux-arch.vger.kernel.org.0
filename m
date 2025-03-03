Return-Path: <linux-arch+bounces-10510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB636A4BE9A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC122165DFE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9341F8BAF;
	Mon,  3 Mar 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="M9LNaQQM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mr85p00im-hyfv06021401.me.com (mr85p00im-hyfv06021401.me.com [17.58.23.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D61F8671
	for <linux-arch@vger.kernel.org>; Mon,  3 Mar 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001435; cv=none; b=MlSyve2erj4PfUgftZ5jKFNbVWItiqp57aey053ZvohVghks7HZqLXten0iJhZXFusE9to8vwekjFJXKMoE/jK74lPqyNBeaYmPR7zAMyAHgYid8sbQnBEVW2gey+g/DFamkHOaHqAYLKooYKR28oGBkvTyzRQV2xL+wV0AR+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001435; c=relaxed/simple;
	bh=X0LU3aYn4lUmJVogH7zjqoCFEavVUNcoV5t1PZiDF6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRlBYnEOp9BpHZlxSLftsnzJOf5yx4zpNOF/qiXN/bWzlWOHAlAFD0pxyhdZCpSWYp6MwRPxGl21dxl37TdIUSTf1P0deMT4xv4KXOIBzu36Zn5doWFpXm2Qgm5UTMJvoAmxwst4Jw2Ak1iQbo+ax4/UvEjtQdGLqKy9wzORLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=M9LNaQQM; arc=none smtp.client-ip=17.58.23.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=OZOLugLSboUaxk503olOimdjHThkYZSt/rnUocHx7qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=M9LNaQQMBVnDvn7O9dkyxfqENe+n3CTiJTPQ2UQFIHq6HOYn5yqN3iDQ3RVhMcn23
	 RYbgEyO7lbqW+H+rJi6eLqXyW0ofbGlb2TozfcwQt+N3LDxfRINewpBQO64R70O6JP
	 Fj4pbqb3B74JtNoj/kfZRb0TgXmhRDVBpuDr2nHUHUnQnsoslms9i4lxHUEqE597f0
	 dsKBFbP0qhEmAOCAG72w3Jw4tGGCdcmaS+BdhFHar4cmpTgkAp9kjNy3bhZerCy1fm
	 yb4VLYz3eRYNRP0qJgIXtuCQgNCwAPfOp2U/Lehb0PDMMPAW6dfU3J1HAJf8t1L7ga
	 V8U2HDDNFoYsA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPSA id D31F830384C0;
	Mon,  3 Mar 2025 11:30:17 +0000 (UTC)
Message-ID: <ca719ca0-ee14-4022-bf61-5794d7ec8d3a@icloud.com>
Date: Mon, 3 Mar 2025 19:30:13 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
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
 <46d17d84-5298-4460-96b0-9c62672167a0@icloud.com>
 <20250227130347.GA5880@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250227130347.GA5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VRiK2BwrsvBlqf3istvRC36nkjOjRITT
X-Proofpoint-GUID: VRiK2BwrsvBlqf3istvRC36nkjOjRITT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 clxscore=1015 mlxlogscore=855 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503030088

On 2025/2/27 21:03, Peter Zijlstra wrote:
>> C) perhaps, most ordinary developers don't known the function mentioned
>>    by B), and also feel strange for the usage
> It is quite common to do kernel wide updates using scripts / cocinelle.
> 
> If you have a specialization that wraps a function to fill out a default
> value, then you want the return types to keep matching.
> 
> Ex.
> 
> return_type foo(type1 a1, type2 a2);
> 
> return_type my_foo(type1 a1)
> {
> 	return foo(a1, value);
> }
> 
> is a normal thing to do. The whole STD C cannot return void bollocks
> breaks that when return_type := void, so in that regards I would call
> this a STD C defect.

The usage is a GCC extension.
but the usage is prone to be used within *inappropriate* context, take
this patch series for an example:

1)  both foo() and my_foo() are in the same module
2)  or it seems return type void is the best type for foo(). so no good
reason to track its type.



