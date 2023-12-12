Return-Path: <linux-arch+bounces-907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3476980E415
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4951C21ACA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C2156DE;
	Tue, 12 Dec 2023 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhOHsMUx"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451DA1;
	Mon, 11 Dec 2023 21:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lgLwTEhQVr7SeOkAbXZIpqhiCYecdKkb92XRhk3Nnto=; b=YhOHsMUxRMFey39Ub+BOoHUSpN
	6MD2YvGw42vNtElnYki1NxJH9KlY8dt3Xm1HkV2P6cve8n0OT2lWYfK3Du2qGpAm+OR+Cys5wPkIf
	LE4znGLFwFzfwfuhB6/ZRcFvqHR3KNSaEVVBM4sFec7GGKvkoEBEVIp1GDKF6IeHVHVxytGCrpZCx
	1faM9v6zX2g+69mh7wf3OyXFWKq/ZNrIB+bGXJyrwEC02dodJ4tmwi4CT68czYOjwgp+Y+4GW16Am
	Y55OjcCnUTKf5hamO76diNt+t88idSnTc+d8igc/Ad7wSE/4sh15ZHLMvQYX/GREDrEwnDJrL70OT
	pMrg2+hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCvmR-00ApZl-36;
	Tue, 12 Dec 2023 05:58:07 +0000
Date: Mon, 11 Dec 2023 21:58:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeelb@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
Message-ID: <ZXf2b/Bmupwm9LaD@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please don't spread scatterlists further.  They are a bad data structure
that mix input data (page, offset, len) and output data (phys_addr,
dma_offset, dma_len), and do in a horrible way for iommmu mappings that
can coalesce.  Jason and coworkers have been looking into the long
overdue API to better support batch mapping of better data structures,
and this is a prime example of new code that should be using.

