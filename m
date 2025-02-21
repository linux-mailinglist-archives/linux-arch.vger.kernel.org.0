Return-Path: <linux-arch+bounces-10319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C9A40048
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF747A4C24
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706C25333B;
	Fri, 21 Feb 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UteSg52R"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023F1D5173;
	Fri, 21 Feb 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168131; cv=none; b=VS+AcolZ/TkO3dJfx3zKTFZ9roP4n7LREBC00b+xOFwGSXJsw6ED3gY0ii0if7KPf0yS8gUGm2EjdYn2Tw65gfclm665n7bbR5kARje1GD0LOO0JR3nOZkzrbVb7GE0P4ipXxXmlvDY9cO/uuMaaybIVkJ7u24XdTYJQBUe/3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168131; c=relaxed/simple;
	bh=cqpH7TG6SAX4ZNWACei1aBxwCR5Ybf1VnjsqFb3f5zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbIbHYxroP0u8MyRKX32VtKC0CmrrPyh+zI/l67SIEG4d3qR7kigXCsJJ+6muaJ4bTWkJl+fiE90kmg89OxeWrLZSuswOaiKCsOADOJvza0xQWlmwtWQ56w2QTjSN676QRVZeWYuxDa1lIS63g9IFQh5CAg0k/rV+zh2L9kz7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UteSg52R; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7gGBaRe4JgYzbdGSQQDl/iu7LJKLfKjaa+/NCZsQ+Ao=; b=UteSg52R0cyjvV7m5TTbonCM1h
	nNaAO3jaW9OJTFD62ZSqIMkpbxkqDB1DnXGCDq1E9j76theeavHA/RRU5cr9Ld3y9wfjpXqbzl6ny
	StfdLe4oNTNBs7AUNYsLHfvw/kaINS1IKRZ1sucXhgJkMsTs/iy5t0nieQstbQpmCN/ql5vASIsCB
	garNWnx82z7wKP48scb0FcUXdE8h/CiJr7AzuSeezFGNc+OEyw6P8aofPitbVwLiEyPVPm69UbSh3
	xtKeubLPCtDZQLsl/R9x4n93qUl1H2Gyc9cbQjUEI73Ffxu18HzmEy3NN4RJTxgXH80wZWZPvSf6f
	vY9JATuw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZDO-00000002in9-0hY9;
	Fri, 21 Feb 2025 20:01:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48E7130066A; Fri, 21 Feb 2025 21:01:37 +0100 (CET)
Date: Fri, 21 Feb 2025 21:01:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
Message-ID: <20250221200137.GH7373@noisy.programming.kicks-ass.net>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com>

On Fri, Feb 21, 2025 at 05:02:06AM -0800, Zijun Hu wrote:
> Remove needless 'return' in void API tlb_remove_page() since both the
> API and tlb_remove_page_size() are void functions.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/asm-generic/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index e402aef79c93..812110813b84 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -501,7 +501,7 @@ static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb,
>   */
>  static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>  {
> -	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
> +	tlb_remove_page_size(tlb, page, PAGE_SIZE);
>  }

So I don't mind removing it, but note that that return enforces
tlb_remove_page_size() has void return type.

It might not be your preferred coding style, but it is not completely
pointless.

