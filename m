Return-Path: <linux-arch+bounces-10329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EACA4077B
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97EE19C67EF
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7D2080FB;
	Sat, 22 Feb 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yYDN+E04"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1776207E16
	for <linux-arch@vger.kernel.org>; Sat, 22 Feb 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220781; cv=none; b=aT9OqjzqLMfQUnNLNwZFJhtEmumut1VN2os0gXh9XYLH7SUvcCu6KKX7+nHdozw2JVwvq6fVICU5V/dvbZcOwT3TyWswGxElgxY8aJONIxcbWY3pD0nPrSzHwt7GhG/wHozqa6wcSDIbzr5TX+x1VbxG7aLx2sk4vjzBnYfV4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220781; c=relaxed/simple;
	bh=+MM+Sj3Py0FG+77MBxvX9ur6eehoj2ClCYpV/HT4iwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1mg1Ec8Q82HQHFGCBJ72IkFlZC2eOiMsZNFJXIB/MMGYu862+7Dqzs6n/zghuxpOEDNLU+I5ULUTW1XMNv7xtSdrkGvsiJkOybFq0DeqNTCkzFrjXkYTbjLOOv65e7IHlz3IyrU3O/r95YI+XhD3V7GoSTX5GIpIYp/LzEm+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yYDN+E04; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=mbxficQPTzs09LWwBbFhdunStNbxz1Db5LUu+U2NlSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=yYDN+E04f3AdizaUiroUuQGY41SPVVZcRqALdOpH6NFQhX3QCjWpHGcmHdHvZgXyw
	 lY1ddO0XjuI5jwoyQLYS2xsXRa555rOew3qMgB02ajNFY2naY0JiMg3EzOtw/vDBsm
	 rNcbU3RkjyAdmQBUnnLpBha3Hg45RvWSCLNO8oK0o5dE+ouOgYdV9O7OaddprvalcC
	 F7e6FcKQyQxquf6C4CR09WnXr4uHh4OXsP+wDyxaBcn55oVkRsljjd3IOmoDXx5njY
	 kMIwNWVp9xmRX9kyVkPTFuHEolnlCaw5jRp5Hj9sFk69BnUaESstfS78tB+JnoKuuq
	 DJolzLt315u8g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 00694A0092;
	Sat, 22 Feb 2025 10:38:11 +0000 (UTC)
Message-ID: <732f9f29-f794-4491-b942-45ad01b01db5@icloud.com>
Date: Sat, 22 Feb 2025 18:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
To: Arnd Bergmann <arnd@arndb.de>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-mtd@lists.infradead.org
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <5d662c4c-76f7-4e5c-82f3-2aeeaf9e3311@app.fastmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <5d662c4c-76f7-4e5c-82f3-2aeeaf9e3311@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5BaBpFy7OfeZq74ITSrzTheUfV5JFE1_
X-Proofpoint-ORIG-GUID: 5BaBpFy7OfeZq74ITSrzTheUfV5JFE1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502220085

On 2025/2/21 23:40, Arnd Bergmann wrote:
>> This patch series is to remove weird and needless 'return' for
>> void APIs under include/ with the following pattern:
>>
>> api_header.h:
>>
>> void api_func_a(...);
>>
>> static inline void api_func_b(...)
>> {
>> 	return api_func_a(...);
>> }
>>
>> Remove the needless 'return' in api_func_b().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> I have no objection to the changes, but I think you should
> describe the motivation for them beyond them being 'weird'.
> 

yes. C spec such as C17 have this description about return
statement:

6.8.6.4:
A return statement with an expression shall not appear in a function
whose return type is void. A return statement without an expression
shall only appear in a function whose return type is void.

do we need to treat below return statement as bad code style ?

void api_func_a(...);
void api_func_b(...) {
...
	return api_func_a(...); // return void function in void func
...
}

> Do these 'return' statements get in the way of some other
> work you are doing? Is there a compiler warning you want
> to enable to ensure they don't come back? Is this all of
> the instances in the kernel or just the ones you found by
> inspection?

actually, i find this weird return usage by reading code by accident
in driver core firstly:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-testing&id=a44073c28bc6d4118891d61e31c9fa9dc4333dc0

then i check folder include/ and work out this patch series.

not sure if there are still such instances in current kernel tree.


