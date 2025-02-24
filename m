Return-Path: <linux-arch+bounces-10340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19829A42087
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 14:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9131606C3
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5924889A;
	Mon, 24 Feb 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iS/A260A"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82E24886D;
	Mon, 24 Feb 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403456; cv=none; b=YOCQspX/5qtQcTBaOdKgwGKyZWnkdinTQy5JbcbWoA1S09d2UgM3lD3u/Cc9kNSsO71eHk6ej7hxBw08DWNSR/b+fxVuQX+Ml+ZSKvaE8SBpPfI6gk9hi2HSfVn8dwrw1a0eVetaM7YXQeiGrue8Y3XU+vMV2tV69I5w6WhQ1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403456; c=relaxed/simple;
	bh=1k6wjU0I1KWrs2CqF0lxTRBsEKFiGTnFa6NfOjTfvFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix+LZILOXgXIdW3Q9i/vi8bDakVUz7MhKHmxT0FAGiq6hP3s7WSSx1JE4CTQBfZe49kkzm23B1eqg8j3g6gBqoaTxMiOtnygpm09sbPGxEKUgUpOdPnVzu/JB6qRJHqXkcKhgTR1JHG+pawH8brR1Fe3o6/icglL3E2CShwE+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iS/A260A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OwmwOu+Cjzvd/Dyh2oCLg1P9uzBvkTbz8Qibak6RkKs=; b=iS/A260A40VI6SQ9dsr0Pe2Ec0
	+4I/Bpalp0CX65hp2mHNsbxfdLQ3ZQMp/MO3XTCmulOZ1LdYifv6XmmjBsEkUzc7/Ofye9OegILGU
	jhMbWZFAabjv9F1E7Tdsq+St//fzgpJbTghlaQ08rLhkZfj4YHNl3RsAgWE0X2VcL1qmU/ZGIqy9s
	q3djqUzHMEgyRNxqJ4zMlGJrlo+rBDv3+zWiBCnZolwsUOv1flDL0UYKwJjrhfaGLVZBSL82vN7Ui
	z/ItUQgAbHGrhpvvZGv/LP7zX+kb01JmoNnF7MGJbWqiG9NuEPEKF3SG3il1lVkgYfzh0ukPwqkvp
	tlhJKBVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYR9-00000007Gtp-2twK;
	Mon, 24 Feb 2025 13:23:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2A18300164; Mon, 24 Feb 2025 14:23:54 +0100 (CET)
Date: Mon, 24 Feb 2025 14:23:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Vignesh Raghavendra <vigneshr@ti.com>, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: Re: [PATCH *-next 01/18] mm/mmu_gather: Remove needless return in
 void API tlb_remove_page()
Message-ID: <20250224132354.GC11590@noisy.programming.kicks-ass.net>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <20250221-rmv_return-v1-1-cc8dff275827@quicinc.com>
 <20250221200137.GH7373@noisy.programming.kicks-ass.net>
 <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f36be7c-6052-4c5d-85ff-0eed27cf1456@icloud.com>

On Sat, Feb 22, 2025 at 07:00:28PM +0800, Zijun Hu wrote:
> On 2025/2/22 04:01, Peter Zijlstra wrote:
> >>   */
> >>  static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
> >>  {
> >> -	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
> >> +	tlb_remove_page_size(tlb, page, PAGE_SIZE);
> >>  }
> > So I don't mind removing it, but note that that return enforces
> > tlb_remove_page_size() has void return type.
> >
> 
> tlb_remove_page_size() is void function already. (^^)

Yes, but if you were to change that, the above return would complain.

> > It might not be your preferred coding style, but it is not completely
> > pointless.
> 
> based on below C spec such as C17 description. i guess language C does
> not like this usage "return void function in void function";

This is GNU extension IIRC. Note kernel uses GNU11, not C11

