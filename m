Return-Path: <linux-arch+bounces-10721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92024A5F53E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E73119C2681
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA98267B1F;
	Thu, 13 Mar 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3n7WI2+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BA267B13;
	Thu, 13 Mar 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871024; cv=none; b=Xa2vtqLJL5L+pnMi7JHf0IOiLX2IiVTj/mgyh+ANN2sFRaCMn3Hfoi17oAfhPR4B2JpM3iEpERUUBEYyh8XCwigfw8gjjNxLxqI21UZkMh3Uo6caTwO1XXMMR4W+Gq/tYZC8OKyzfZXZXmFme6JlXQGbnXb4plDmTNmO4Tpbg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871024; c=relaxed/simple;
	bh=cSyffy+PWmVQesGeNOfjRD3854cMxOy2XIo3+guxtEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nSpF6ydcVzqrFewG8iJvKy9K8bXE5fSTuSU9I7GhLr1wVttOh9vJaA/UASPTIrXtWw7sGDB6+K00BVcMisNgVbooyyuVjwEj2ObwvlhsVOZLDVg6Wi0IBJpcVzWLYhYzshzmjypd4aMwBlI86rEX5kLgJSx41Bzxgjr3CrFXRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3n7WI2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E8C4CEDD;
	Thu, 13 Mar 2025 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741871024;
	bh=cSyffy+PWmVQesGeNOfjRD3854cMxOy2XIo3+guxtEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W3n7WI2+kNBRhRstzjeL3M06/rCnf1LzWx2YyBLD01j8VmFJANn56CrImwA8yW2+T
	 S0sch8ELktEv1lgKKdJE8batVk23w+yl7Go8YUO4NPYFP3oR+x6ZlO7uJb/jlanFvX
	 S7ZjZTXv/idYIrZSik396jx+G+Yrzt4aKXk/agPeTHfga4jUvCgUIBaYVPj9qEB7u9
	 zFE7QK8bZEplyvWlCoOpYD10A3xrxtVXiRkIZRvB6lxI7GnFZqr67QFT9R/jWP/dS4
	 BRO2/qxom67N+cLtVTodyDfZllKLzMgiaZThXp0n9imUIQcuY7xDNHmMOvwHFRcqNF
	 SCzy9gFfTB/iA==
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
 Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
Subject: Re: (subset) [PATCH *-next 15/18] mfd: db8500-prcmu: Remove
 needless return in three void APIs
Message-Id: <174187101580.3629935.6842247156301298100.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 13:03:35 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Fri, 21 Feb 2025 05:02:20 -0800, Zijun Hu wrote:
> Remove needless 'return' in the following void APIs:
> 
>  prcmu_early_init()
>  prcmu_system_reset()
>  prcmu_modem_reset()
> 
> Since both the API and callee involved are void functions.
> 
> [...]

Applied, thanks!

[15/18] mfd: db8500-prcmu: Remove needless return in three void APIs
        commit: ccf5c7a8e5b9fe7c36d8c384f8f7c495f45c63a0

--
Lee Jones [李琼斯]


