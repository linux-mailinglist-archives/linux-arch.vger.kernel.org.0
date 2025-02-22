Return-Path: <linux-arch+bounces-10330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FAA4079F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF72425180
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B865520967B;
	Sat, 22 Feb 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ao4p1n4T"
X-Original-To: linux-arch@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68192080E8
	for <linux-arch@vger.kernel.org>; Sat, 22 Feb 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221525; cv=none; b=XJGbGLALWRKf/P2v2lsbTTDuHuiUnA6DD+FBhMu8WrhGrTe8S/RwPb56mFcZnOtZcbPHTFi8LkDKEFwiL/ociA+97kUVIf+RaTu6QnYbIVTa8U6Fe5DYgLn9YV0xPERSteLySbhCYg7vsP/TD55VKE0PGB5b162I6xFXglTwg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221525; c=relaxed/simple;
	bh=Ytjx5IaKFk1D/yhTaHPuuZcMJMTW1vj3cyaFkvR9PvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lqs4Zx0SyZpy3Gm/OSOhrEakzu6cIaxnamzYZjNt7FZRq0s9xDMSxT/7DP+CINyHbXyuCUnRV9dLpJdwJpKLD64KpHCmeOfAFYszSvZQVr/q6CW1/ibfBnm7nsYOvCDgkkt9iL8HcyLqXyaQ2+eU6xqfH19NBwzdT0lk5gUpwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ao4p1n4T; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=rgvQfOLC7f+M02f6hvzxNZIZUkpYeai7A7dWzk8uoIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=Ao4p1n4TrSRRxXxkSH05UqzT/HgGCVsxu62sY49QJR1PuEtvfkjoljG6DYIsPV1Jo
	 Uoed4vqcpZcyby4LnXmShg/OPtqYjLumfWHHUDlYfNqQ6dQN22Ftnqmx6O36rZw4pn
	 Zow40fUE1JPdJ6sCCjY/WYjE+FPhsJ3Qn3uALPQJvHkyeXkgHkQYcEmil8PulKL+fJ
	 fUkhds+oHSvwMCTYtsOSOPQcBSN/J5AwXkpjyTyw6eT8WOu4oEaeNQASEoQIT4MOfi
	 C0yQ4S9F9AXSKb3ZkHgdSRi1KtFKXciIEp5TNHrDn78nvw5GkDRlcaWTiJS2gmJ4GI
	 tcmo7WXp+ddNA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 56304180100;
	Sat, 22 Feb 2025 10:51:42 +0000 (UTC)
Message-ID: <a2cf1f09-83d7-402b-94c1-88feec10a513@icloud.com>
Date: Sat, 22 Feb 2025 18:51:17 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
To: Johannes Berg <johannes@sipsolutions.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
 <20250221110042.2ec3c276@hermes.local>
 <9af9413b7ab41c6b2db5f862d0fa50e9de279d67.camel@sipsolutions.net>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <9af9413b7ab41c6b2db5f862d0fa50e9de279d67.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f652v4ma64Vm3Io7f6-KRKFfH-wFIu9m
X-Proofpoint-GUID: f652v4ma64Vm3Io7f6-KRKFfH-wFIu9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2502220087

On 2025/2/22 03:36, Johannes Berg wrote:
> On Fri, 2025-02-21 at 11:00 -0800, Stephen Hemminger wrote:
>> Is this something that could be done with a coccinelle script?
>>
> Almost enough to do this:
> 
> @@
> identifier fn;
> expression E;
> @@
> void fn(...)
> {
> ...
> -return
> E;
> }
> 
> 
> It takes a long time to run though, and does some wrong things as well:
> if the return is in the middle of the function, it still matches and
> removes it erroneously.

if return is in the middle, we may need to convert the return statement
in to two statement as [PATCH 18/18] does:
https://lore.kernel.org/all/20250221-rmv_return-v1-18-cc8dff275827@quicinc.com/

namely, Convert  "return func(...);" to "func(...); return;"

C spec such as C17 have this description about return
statement:
6.8.6.4:
A return statement with an expression shall not appear in a function
whose return type is void. A return statement without an expression
shall only appear in a function whose return type is void.


so, do we need to treat "return void function in void function" as
bad code style and make coccinelle script check this bad usage?






