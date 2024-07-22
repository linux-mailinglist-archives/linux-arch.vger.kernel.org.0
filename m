Return-Path: <linux-arch+bounces-5555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95E93912A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9FB1C21665
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063E16DC38;
	Mon, 22 Jul 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uscHRmSR"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7AF16DEDD;
	Mon, 22 Jul 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660341; cv=none; b=fKqAJRD1VmHvJCQv/7cud6AxaAMW8tm4CjRcu1ijYJlISaKVCdew3pcocSgVn5JjOxMKSICMNUfMWEGcN1Op4Ef8XNuOe0rJoFSxrfmV98WWN78wvF9XfjpDA9Hmbrg1u0pSr7uSJhMXs09yroc0iweF1gqgzC2oeMwE9A18mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660341; c=relaxed/simple;
	bh=JQ0jOuwY7OGAtG7S+RKj2MsWF2RILfYys1zXtfeTUZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+X6Pf0GKhobDqH+fKJ5iQHneGlhLMv3dq62NZt+a5G5ob0DS/5gPpt9KB1eltw1Tl1G05jrTmjpS4aXLdvx34ONy7+lTc+LdkQVGRUoDTtPRdXs7RTCctuMA1gRzXKmVtfY1Lk+kkalV5jFNEmP5px90mBY/257ZaoDZQ8kBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uscHRmSR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0suE9iJedWZqthG1aOPFasnjcurHspan+ck/bWfHjIM=; b=uscHRmSRk+y+GLKM2By67lV+UU
	XSe59nM+l1Wg4HS0TEVTy8Isy4qoRD3oDcyXG01Zr5MGgKKuptPm4GszuWQaT/o8pRNdYYP+rW8Pg
	1N4v40UJ2ZySxHcyHfcEX/+ZK4CYBW0R/8qdLu5PVChSyWm5/6a9ep9e/nqjUom3qWbOTNGwqIT0y
	j9t2EvHFCj/arb0e8JdsN2gigvaj0N++Wic+yEFZWCUsYQB0ehtMRYIojlE6lLS1EO5EAM2ZoN8mE
	D+xQpR4L8SF519STJZ9dEed/Pep3joo3U/GQyxfP3cjmVgp/VI8xufqfttws5kLMp01SAxxETU0DZ
	WZDAYEnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVuV4-00000009r7o-3jBD;
	Mon, 22 Jul 2024 14:58:54 +0000
Date: Mon, 22 Jul 2024 07:58:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>,
	Clement Leger <clement@clement-leger.fr>,
	Guillaume Thouvenin <thouveng@gmail.com>,
	Jean-Christophe Pince <jcpince@gmail.com>,
	Jules Maselbas <jmaselbas@zdiv.net>,
	Julien Hascoet <jhascoet@kalrayinc.com>,
	Louis Morhet <lmorhet@kalrayinc.com>,
	Marc =?iso-8859-1?Q?Poulhi=E8s?= <dkm@kataplop.net>,
	Marius Gligor <mgligor@kalrayinc.com>,
	Vincent Chardon <vincent.chardon@elsys-design.com>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v3 24/37] kvx: Add memory management
Message-ID: <Zp5zrkwyagnkoY7F@infradead.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-25-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-25-ysionneau@kalrayinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#include "../../../drivers/iommu/dma-iommu.h"

This is not a public header as you can guess from the file path.

> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		break;
> +	case DMA_FROM_DEVICE:
> +		break;
> +
> +	case DMA_BIDIRECTIONAL:
> +		inval_dcache_range(paddr, size);

Doing this just for bidirectional is weird unless your architecture
never does any speculative prefetching.  Other architectures
include DMA_FROM_DEVICE here.

> +#ifdef CONFIG_IOMMU_DMA
> +void arch_teardown_dma_ops(struct device *dev)
> +{
> +	dev->dma_ops = NULL;
> +}
> +#endif /* CONFIG_IOMMU_DMA*/

This should not be needed right now.  And will be completley
useless once we do the direct calls to dma-iommu which we plan
to do for Linux 6.12.

> +void arch_setup_dma_ops(struct device *dev, bool coherent)
> +{
> +	dev->dma_coherent = coherent;
> +	if (device_iommu_mapped(dev))
> +		iommu_setup_dma_ops(dev);
> +}

And this seems odd, as iommu_setup_dma_ops is called from the iommu
code and you shouldn't need it here.

I also wonder if we can come up with a way to do the ->dma_coherent
setup in common code and remove a few of these arch hooks entirely.


