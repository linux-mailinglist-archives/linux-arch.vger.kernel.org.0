Return-Path: <linux-arch+bounces-10295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08566A3F58D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CC518837E3
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1020897B;
	Fri, 21 Feb 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tyXONUDb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623F1E87B;
	Fri, 21 Feb 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143540; cv=none; b=BiXcpMBYHd1sQIvjSG81qVOaYt3ZUGw6QER2rtW4gelbY2BJn9Gl6ZzfZwzTlDYHJEwSJ8jCt/K25Pe2WIbUwp2x4SzpMqNkT9u7Sx2C12rPugtcJdISE5N4PhUfEO91c5X0nqLD1RZZG8SI9dOXDtQaJ4x8GRUeaBRxuhpWLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143540; c=relaxed/simple;
	bh=OaIEfRGrNHujGIM2xLDrlaaE7zfxvSiYKjihwGmoU78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7fZ/I4x3XgCkfU6kS+AsyyHt8uAp11SW7/GwoW+PTttHWPk+5KpFzithrdPARbxzfYItRybU34ZfUniUSIAo/oRr1VhSCL1xgHdOsFskwebGmtvOljkBhqmaW3ctsUPqzyS5p3TPZa4J0ImnRGl7u45vPkBH0s8kYoNH2UfCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tyXONUDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF81C4CED6;
	Fri, 21 Feb 2025 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740143539;
	bh=OaIEfRGrNHujGIM2xLDrlaaE7zfxvSiYKjihwGmoU78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyXONUDbGQ78MxsudewWlzaPrGsFnl2q/eB10uxmLxkUWIEIPE62xYNKYKKcUGAhr
	 RPQvR4591QqFmp/SBvlWCc55VgxYql2SEwFsM+Ss8aba8JFiNjATNYZ43c6E0SVGDQ
	 WgAk6f+2vY/eqZV/Iie1hLQLtLIh5+agINDhu+wU=
Date: Fri, 21 Feb 2025 14:12:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
	Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
Message-ID: <2025022145-ungodly-hanky-499e@gregkh>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>

On Fri, Feb 21, 2025 at 05:02:05AM -0800, Zijun Hu wrote:
> This patch series is to remove weird and needless 'return' for
> void APIs under include/ with the following pattern:
> 
> api_header.h:
> 
> void api_func_a(...);
> 
> static inline void api_func_b(...)
> {
> 	return api_func_a(...);
> }
> 
> Remove the needless 'return' in api_func_b().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (18):
>       mm/mmu_gather: Remove needless return in void API tlb_remove_page()
>       cpu: Remove needless return in void API suspend_enable_secondary_cpus()
>       crypto: api - Remove needless return in void API crypto_free_tfm()
>       crypto: scomp - Remove needless return in void API crypto_scomp_free_ctx()
>       sysfs: Remove needless return in void API sysfs_enable_ns()
>       skbuff: Remove needless return in void API consume_skb()
>       wifi: mac80211: Remove needless return in void API _ieee80211_hw_set()
>       net: sched: Remove needless return in void API qdisc_watchdog_schedule_ns()
>       ipv4/igmp: Remove needless return in void API ip_mc_dec_group()
>       IB/rdmavt: Remove needless return in void API rvt_mod_retry_timer()
>       ratelimit: Remove needless return in void API ratelimit_default_init()
>       siox: Remove needless return in void API siox_driver_unregister()
>       gpiolib: Remove needless return in two void APIs
>       PM: wakeup: Remove needless return in three void APIs
>       mfd: db8500-prcmu: Remove needless return in three void APIs
>       rhashtable: Remove needless return in three void APIs
>       dma-mapping: Remove needless return in five void APIs
>       mtd: nand: Do not return void function in void function

These span loads of different subsystems, please just submit them all to
the different subsystems directly, not as one big patch series which
none of us could take individually.

thanks,

greg k-h

