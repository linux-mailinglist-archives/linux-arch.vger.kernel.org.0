Return-Path: <linux-arch+bounces-13929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23ABBE426
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7256A188A5CF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06DD2D3EF6;
	Mon,  6 Oct 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O5Td4M0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZUe14lP"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277C286890;
	Mon,  6 Oct 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759199; cv=none; b=GoDAvke7v+ihgYuG9o0oIE1SeXKU3yzxI1n6G0dx3arvDOj1+ZdLsEBE0fHFnA+SBT8zUH38mGCTbAhwRFvKeoHd/aDdDvvkuLfCuESTO1leP2R3Fo04p+LnnOD345Bp1ez9vGZhMm7aOKXiOrGQ0rUvoc9cIYT8/PhTphlb3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759199; c=relaxed/simple;
	bh=SlGxfVB6uJAZCp8OniNzRHbsLy7NwkAdaPiK8JpqFsw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HQOYA2z87zhQAbMeLwGxzjL+j1ILPvjxN9VWKQKhEFEVwjy1yF+4zONlEyPDZZJvzKfmaPg2snSl9SQFI4naY/29XmShKzHgrYwNUY6Vj4PSw36MUEIEim50P6T5WMVt8/ha3osFpOsDTmG63FQCepaCoclssBDAn6mxVVZxJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O5Td4M0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pZUe14lP; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id C953A130012F;
	Mon,  6 Oct 2025 09:59:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 06 Oct 2025 09:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759759195;
	 x=1759766395; bh=w0YgHYUD1DNiamGuYJ8Uc7rHKe+uulOY6oYPOU7RrCc=; b=
	O5Td4M0zxodW0Mt5RCzpzgTJHDVdDYHtSdn9t1tbx7tl/nVxO7z/KWELZWpu0LOn
	ylZTpWaS342r8Spy4xc43MLdT1o6KLRNKvhHtkdExApn80Mo9qO7zx3Hrp3mtU73
	f0YRsuUoDNRVj2CQykIyVytikPMGfo1EBjY4urbzvbrFzV4rHdwa23a6uDIPPXDV
	mxOCfXuAd5TJ5/g88FK9gxc15VH5EDhKdjB2/zzL8nJuipLHG+CMmlneb5baMbO9
	cRPWHSCANlzJvysRWDvsMT0i5YuDjZSC7JqTbW34WUsrM+Rm/il1Dyvo8bP487bb
	Hb0+U+1wtm9zp8y+3ix6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759759195; x=
	1759766395; bh=w0YgHYUD1DNiamGuYJ8Uc7rHKe+uulOY6oYPOU7RrCc=; b=p
	ZUe14lPGbL8ze3Apn246Y3kEbbd7W/UUKMdLtf99qF/xH/F8kMC+KZE2rOi0y7fL
	Pi4dv/jxzYN3qPfyWRMumdmPg/dgv7smKsoVTjMRPeKMZ7GvpuxF/vQMn02NF60a
	qWLk2Fu0yZ0xXPby2q4IfOaH0UCpHeFrgFXReDfo5Tm+7GU9tWwDkvrmpXGX1jaN
	xHqas/yLbpysyW4FJq0mDBmd+tFtguck4VP41RGb9sACZh+RYdbuH31YmLei2Dtn
	D9oKnJG4iDqgcQhpBXHmwXQGNBsMoiooEKWSnrZw29kG8Q7byr+Jabdes7166pIb
	puQiMY6eLcjoHgsDMQPHQ==
X-ME-Sender: <xms:WsvjaBjSYDKn7sVOKcBLQTAd3052cWn157ajhOYS3qwMiJou-Phv5w>
    <xme:WsvjaA3YqclYdh0Y2CCpFN1I8x1g5aXNJ36OMBVIfJTLbKfZc17Z8DxYkSPwoM50Y
    pxKFD20Q1R6VKX8j9IqixpdKM-UjOsTFDeDUcbzNCaVjB8YIMbd2hM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnh
    ekrdguvgdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhm
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepnhguvghsrghulhhnihgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hsrghlihhlrdhmvghhthgrsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:WsvjaBgNeAmBhSpplpWpN4KyyZbl3EWzz1-dTnUM7FI6JAYOYjzrug>
    <xmx:WsvjaMljSWxvWNks6w8zMGnjp1PV89PJCaSyRGSRdua97RChDid9IQ>
    <xmx:WsvjaOQ-u8cwrz0kEE_dpm5piZMjt-1VUmwm6KjtTlmTSpZtsIi_Sg>
    <xmx:WsvjaIWAnwScPeD2Ip3igmKTIFTxtWosbAKc_ekvJIQBQfido1nNTQ>
    <xmx:W8vjaEQmSyPzKl7gUm1IS_pihOri_F7E7MuFCORZw0MVwOS8E6ARSgRo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C2AF700069; Mon,  6 Oct 2025 09:59:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEeN2bv3GoZZ
Date: Mon, 06 Oct 2025 15:59:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Ott" <sebott@redhat.com>, "Tariq Toukan" <tariqt@nvidia.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Mark Bloch" <mbloch@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gal Pressman" <gal@nvidia.com>,
 "Leon Romanovsky" <leonro@nvidia.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Michael Guralnik" <michaelgur@nvidia.com>,
 "Moshe Shemesh" <moshe@nvidia.com>, "Will Deacon" <will@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Justin Stitt" <justinstitt@google.com>, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev, "Ingo Molnar" <mingo@redhat.com>,
 "Bill Wendling" <morbo@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, x86@kernel.org,
 "Yisen Zhuang" <yisen.zhuang@huawei.com>,
 "Leon Romanovsky" <leonro@mellanox.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Guralnik" <michaelgur@mellanox.com>, patches@lists.linux.dev,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Jijie Shao" <shaojijie@huawei.com>, "Simon Horman" <horms@kernel.org>,
 "Patrisious Haddad" <phaddad@nvidia.com>
Message-Id: <0097472c-10fd-42b4-8430-c65f958b0c7d@app.fastmail.com>
In-Reply-To: <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
 <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test reliability for
 ARM64 Grace CPUs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 15:57, Sebastian Ott wrote:
> On Mon, 29 Sep 2025, Tariq Toukan wrote:
>> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
>> +				size_t mmio_wqe_size, unsigned int offset)
>> +{
>> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
>> +	if (cpu_has_neon()) {
>> +		kernel_neon_begin();
>> +		asm volatile
>> +		(".arch_extension simd;\n\t"
>> +		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
>> +		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
>> +		:
>> +		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
>> +		: "memory", "v0", "v1", "v2", "v3");
>> +		kernel_neon_end();
>> +		return;
>> +	}
>> +#endif
>
> This one breaks the build for me:
> /tmp/cc2vw3CJ.s: Assembler messages:
> /tmp/cc2vw3CJ.s:391: Error: unknown architectural extension `simd;'
>
> Removing the extra ";" after simd seems to fix it.

I sent that fixup earlier today:

https://lore.kernel.org/all/20251006115640.497169-1-arnd@kernel.org/

     Arnd

