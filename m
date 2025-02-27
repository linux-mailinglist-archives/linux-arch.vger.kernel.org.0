Return-Path: <linux-arch+bounces-10423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8BA47E37
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 13:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A904167F3D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02A22D7BE;
	Thu, 27 Feb 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GLbbhl50"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10841DFFC
	for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660525; cv=none; b=e45o0I3YrYcLqPCbHzpym7V1lMhDuSihQ0TbLyGtoe6kTVjztxvw8h5YQiGcNJ1Ws8Z3FkuNFvJ++GqCJOiEPZpzWN2dP3lJTyPLukHl8rYM1hklMEGeFLku8zkba4ik07LB0G4JSgkFatte/+MaH5nZX7PSk9oJKB49E+VJHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660525; c=relaxed/simple;
	bh=yX9IP9tWJLI9/Byl8rHeAtn/q4pN2nne6lrg8q8ydYA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oyzYrSYF6mpnxiThWWFSb1emRFLr98T9uPqIupeiZxjnnErR8ljVmXLbvNfiAhKGV/AEpfKuR2mNTqm32i9nnDTyBSzhXIWnYwDcz5cV9nKGOCsBxwE9PI4aoYVCoG6oPmJxxd9igKVTMwvcexih7w6DpUgc/YGpkQ0Kpz0jpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GLbbhl50; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3a4gDmWNcm/PN/PkyXMAH7J982HJ/SWLRPrRdcNbL0I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:x-icloud-hme;
	b=GLbbhl50/6s4XSz2hWsI2pBZw9mNkyoy4mfVS3ceyWFxtT2IXAgPw4vR2c4niyC8z
	 Cn2HmQiD1m50m37YfMI08jjxHRfhEn42+FHcXSScomZlHKDtu+Wp54dOblB3imAZgA
	 8Sh5FnBSf63pOv7KKwz4PnuK53+FcygvCr7GQVeYyjKkuNNU3G7hg7+mVfYTDQsuYn
	 V/LofsjZFEnKZpfyRxF2x9XD81VAonZ5IWIEsKoP+zCePc8L+vIyjsVPd78Yr1B3dG
	 y7y+n4035LJBFthLQyoBxgdJQehrL+qDmYWtQI5x+p4yNMchSmlhXEXKe5LinKs/Im
	 ZmDofqUPOnkdw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 9DDEC3E1E07;
	Thu, 27 Feb 2025 12:48:23 +0000 (UTC)
Message-ID: <46d17d84-5298-4460-96b0-9c62672167a0@icloud.com>
Date: Thu, 27 Feb 2025 20:48:19 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zijun Hu <zijun_hu@icloud.com>
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-mtd@lists.infradead.org
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dWcj_ItTiibsX6WGOwhQtepLygIMQOy8
X-Proofpoint-ORIG-GUID: dWcj_ItTiibsX6WGOwhQtepLygIMQOy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2502270097

On 2025/2/21 21:02, Zijun Hu wrote:
> void api_func_a(...);
> 
> static inline void api_func_b(...)
> {
> 	return api_func_a(...);
> }

The Usage : Return void function in void function

IMO, perhaps, the usage is not good since:

A) STD C does not like the usage, and i find GCC has no description
about the usage.
   C11/C17: 6.8.6.4 The return statement
   "A return statement with an expression shall not appear in a
function whose return type is void"

B) According to discussion, the usage have function that return type
   of the callee api_func_a() is monitored. but this function has below
shortcoming as well:

the monitor is not needed if the caller api_func_b() is in the same
module with the callee api_func_a(), otherwise, provided the callee is
a API and provided by author of other module. the author needs to clean
up lot of usages of the API if he/she changes the API's return type from
void to any other type, so it is not nice to API provider.

C) perhaps, most ordinary developers don't known the function mentioned
   by B), and also feel strange for the usage

