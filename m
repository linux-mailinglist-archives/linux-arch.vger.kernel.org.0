Return-Path: <linux-arch+bounces-3607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C578C8A200C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B731F25133
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A117C9B;
	Thu, 11 Apr 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JjAOYQGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwnCRI67"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37591754B;
	Thu, 11 Apr 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867044; cv=none; b=JHSmEn5wwU/2UW/QU79hwmpt2QHfmlDHzcuusKuAD9l9l+x8XkCsHm3RZl8a/hX76yLemaOsY/ZyRmo/uTiXk1/OQaERWlo9HsaXmqMZG1+Mip+3ArqUzhl4p0wnwbDr+Ihn3A/1188a0DcPGoJO5EobiXQQBjvjFKzR73SOyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867044; c=relaxed/simple;
	bh=v0h2YnKyvi/FUjQO8wsyr2ccrwSEozzRKJqDGzOluPs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g4VgdwGYCLXrdVli98wvuNamaYVc7yCB0tZcuge+V5gFccM7mpUYnMx6WiZEjNnk0h5eQH8FRg35024ZnqboanKz9BfYOb7o/zmEyzGOKBMuxrbKCC4yRn1GnoRlBFxi5vf0Z4tTnSsXHaE+6gs0+9R4Ax1i89yFmVJFSHA6Upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JjAOYQGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IwnCRI67; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 833041C0009F;
	Thu, 11 Apr 2024 16:23:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712867037; x=1712953437; bh=JsuFLbAEjN
	o6Pvyug1LI/IFqLsqKGpq5+U0wO0rRgwo=; b=JjAOYQGN8yunrqafnwxnDSFe0+
	qnm7WuRckh2f2/1Bx7vcudDdDW5T54MJjqnrutUlFmoipuXXq45pWV1Ew9Xeb2Xm
	hcVC++M9Bxyi+rQPO8tsnd2khrxLZJkxxgnppP5zbhAyGGGe31y6huY3AI8PDScZ
	ElBBOoKc8MbFtjwtmP8TjjEC+F9y8lQ+fwD1LOlNRIegmNEtRwIMzQdGkvqCk04+
	/hk/EUPNNkNo167Ckqnk6UUHLAXQ6vQkg7TyCZA3+oJZ6+lNbvSafwf1IgYgniKx
	0ldCOL9J2tmeGHT4FhnANgmn2h8d55nAHGVXTpinWHYlSxdN5ZljpqK8ycDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712867037; x=1712953437; bh=JsuFLbAEjNo6Pvyug1LI/IFqLsqK
	Gpq5+U0wO0rRgwo=; b=IwnCRI67E37UT8PkBtjjJj+JwAaXfB/yQT4bnTtdSTaP
	CsJC3lnLCLkGvn2s5saYs8We3/MqwkgRMgX+EQl5n8lLKyuiDYQyeAwNNPY1wLQJ
	WCUPgyUfrKqISshpgzozDcwkmzdVK9jUeP1EdvYV0xIF357LlY2t39i9O70hv+mM
	mBnbZv7+5NKYMaeEx/zdKEhUWHHiEkUplMKftFsjipJhfAUppsLEXBctrHym9e2w
	lCNt+kWm7tEAWNFfcj1KV8G2hOAAlk3BIoD91K3rWRzcT445WkP2g9Pov+0XZ96Y
	bE0Wh2Hk1sdzBPnqpKzckGkLdrKkhSvB54kMgO/x8A==
X-ME-Sender: <xms:20YYZoJn7WvT9eEOBU1G7N1hW30AmgGyJTc_zR1IXlgBvEW-WXMEog>
    <xme:20YYZoL64a6bw_KYLQbmSp6OwjSBsDEb4qQgH6PVEhJH56g77l2Asqp_sY7aJYkgc
    yx00ArKdbb-SMlQvnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:20YYZovNgCBdVmC_1lDcA-pVqVwbaXw9dYUzLcCaX-1CCAx_57zrJA>
    <xmx:20YYZlbSidqnph_CUwPU7Mja2KL8a5KeRzznPHmqTeGZDUUPp02KoA>
    <xmx:20YYZvaWM5ek40gIgg9rhjY0DZynwI-SnzVNg7jigfADzt9IeBErzQ>
    <xmx:20YYZhDnRroG2_xxOda4OTO_V0Muhq9jmgCY607oUyxnXQlOscqa5A>
    <xmx:3UYYZojPUsAS9W0ge6yR4cip9kLqz_forzx3auM_rJv3vr53AcZl0bs2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A8515B6008D; Thu, 11 Apr 2024 16:23:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65a7d714-1004-4ba3-9c03-7c691f3c3dc7@app.fastmail.com>
In-Reply-To: <3-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References: <3-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Date: Thu, 11 Apr 2024 22:23:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Leon Romanovsky" <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev, "Ingo Molnar" <mingo@redhat.com>,
 "Bill Wendling" <morbo@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 Netdev <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, x86@kernel.org,
 "Yisen Zhuang" <yisen.zhuang@huawei.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Leon Romanovsky" <leonro@mellanox.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Guralnik" <michaelgur@mellanox.com>, patches@lists.linux.dev,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Jijie Shao" <shaojijie@huawei.com>, "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v3 3/6] s390: Stop using weak symbols for __iowrite64_copy()
Content-Type: text/plain

On Thu, Apr 11, 2024, at 18:46, Jason Gunthorpe wrote:
> Complete switching the __iowriteXX_copy() routines over to use #define and
> arch provided inline/macro functions instead of weak symbols.
>
> S390 has an implementation that simply calls another memcpy
> function. Inline this so the callers don't have to do two jumps.
>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/s390/include/asm/io.h | 7 +++++++
>  arch/s390/pci/pci.c        | 6 ------
>  include/linux/io.h         | 3 +++
>  lib/iomap_copy.c           | 7 +++----
>  4 files changed, 13 insertions(+), 10 deletions(-)

For the common code bits:

Acked-by: Arnd Bergmann <arnd@arndb.de>

> -void __attribute__((weak)) __iowrite64_copy(void __iomem *to,
> -					    const void *from,
> -					    size_t count)
> +#ifndef __iowrite64_copy
> +void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>  {

I'm always happy to see __weak functions get cleaned up.

      Arnd

