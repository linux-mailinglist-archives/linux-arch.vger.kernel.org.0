Return-Path: <linux-arch+bounces-12605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0EBAFF219
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 21:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE60B3B0D4C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6157242902;
	Wed,  9 Jul 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bP5lh9VL"
X-Original-To: linux-arch@vger.kernel.org
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BA20468C;
	Wed,  9 Jul 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091016; cv=pass; b=ZtMAYjwOEpAeSeW9weSLiaYMxRyLUZ0jpF/j4piSYYBrY/R3hRVlAhTUFVrZ127HrFeadmu/WkvR2RRcpky5Tnlma2A7KBiC6ulFieD005vTJJQ6N7fWz9euhPFQz3GBDQbz0g88v7AU8yaobNmkVGaC505oPOP0dWm1DgKUByw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091016; c=relaxed/simple;
	bh=g9GRJAhdAGEmA5ZYVjwivHeYePoeYJ5mJKW6y6E9UTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvHSp9N5oZcafbSsZzQdxZ5DPJrjRhTVRVfFzf8gfD3YbaLxCbK5j4L2Hl0EULcqZ7wIdV0KLSv8129TFec4R5YLpjd4xeQQFfRz8Y4CRGqrMjFPp8A+UIrbHMHGW9fpdRKmFSHT0t3HL4kdA9Po+ZzkgJMAr7KRpCQEzEC/mj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bP5lh9VL; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 47B7F20BCA;
	Wed,  9 Jul 2025 19:46:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-111-53-65.trex-nlb.outbound.svc.cluster.local [100.111.53.65])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9754B23723;
	Wed,  9 Jul 2025 19:46:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752090375; a=rsa-sha256;
	cv=none;
	b=O1oyxt3r89XpSHlK1mgzZVayGQPg0X+1esZT0hTCsLWoLJbHWjq+e6iNDdBZE+jdAe2c8L
	ZgrO+e1h9MKeks44XPZQxgndnA4dcqq+3SrxTqjklmnsQHkbVCo+Qhy2nAXPxExkMpAaZm
	20Vj86rRci5Dna0Ki3I5NxUqCyN5Qsk2NB0ib+umeG/tJLZl8POLtjVFqVRa0pDIhT3qco
	+icaJVQkAZOwI3LSO3iO998ZNd3JL012olr+VId3lDg8ryH0qoZ8mTTaSXLYr/bMDEsorV
	vYyszvLLoCXWb1ajNWRIfCO4GPjjowtID5cYYTEmUM7TkpqpyOcxU2RaSDoH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752090375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=76X/WazY2+6KOc3w73+FOE9+6MaDwTt4/NFSE4CQL4k=;
	b=ffuuPuqOJwest0RDnOkHYJ1Do28Iea7WGbEn+gKLZzbnPBRhnWre5sIRfYZ+BsG/eAMO6E
	tVDKTma52+/x+N0gOPv2BHZMTARZJzoEI4Qt6OWdb70EZy/pOudP1A45ClLxO2EA809f4k
	WU35rovLunUqPnEBEldM9N0yJ1N2fqrvhbgbo5bf1gXMbyw3PAXkkzCm4YWQ4/7ySK+rvJ
	8B0ts4SFy1hj2sRle1jMKEjjNnt9hOITiuRhBhCR+kQBhRKl9bRlSFPdzst4p7g+a5bUDW
	qOrr/Ffmuipv2W/fwIsdnInNUMl43nZmZ3Vlc9qdAV2ixjatyCEfGYHiTA520g==
ARC-Authentication-Results: i=1;
	rspamd-5c976dc8b-7stp7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Obese: 349541e54122468c_1752090376120_4018561239
X-MC-Loop-Signature: 1752090376120:3016696630
X-MC-Ingress-Time: 1752090376120
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.53.65 (trex/7.1.3);
	Wed, 09 Jul 2025 19:46:16 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4bcpPd6YJvz9D;
	Wed,  9 Jul 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1752090375;
	bh=76X/WazY2+6KOc3w73+FOE9+6MaDwTt4/NFSE4CQL4k=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bP5lh9VLP6FPboYWNC2Ty9LgfK/jIojqCiqisXD8BBuwPxUKVE9kQLEhKS4G/aEbR
	 qYGAvJzv3s3GRAd6CppZnrcPLVCIphfhyJ6W6GR+fcsmBBe7yPjqKSUziG7KKuMPua
	 67Fe7tRp25nVaTb4pMfn6ukRo3BApVNQyVgNzRFGYonwx0f7mP4TmIp+YEhGDlpf3P
	 Oq4XmxcDqZiRcxi8rwMxT6ZMhwPN4DswM47g1bXq9ub2QgjCxCgbu1MpQUKaRNJGgN
	 S8PWq+59LqwCCw/gC731dlH3kkenwU/J/6gQ5lFvI3zDGAc5W7xR2tBnfbaSNkc752
	 1Gk+KmcVv7kbw==
Date: Wed, 9 Jul 2025 12:46:11 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v2 1/8] memregion: Support fine grained invalidate by
 cpu_cache_invalidate_memregion()
Message-ID: <20250709194611.f2d5q6dubzqeqhjr@offworld>
Mail-Followup-To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adam Manzanares <a.manzanares@samsung.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250624154805.66985-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250624154805.66985-2-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429

On Tue, 24 Jun 2025, Jonathan Cameron wrote:

>From: Yicong Yang <yangyicong@hisilicon.com>
>
>Extend cpu_cache_invalidate_memregion() to support invalidate certain
>range of memory. Control of types of invlidation is left for when
>usecases turn up. For now everything is Clean and Invalidate.

Yes, this was always the idea for the final interface, but had
kept it simple given x86's big hammer hoping for arm64 solution
to come around.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>---
> arch/x86/mm/pat/set_memory.c | 2 +-
> drivers/cxl/core/region.c    | 6 +++++-
> drivers/nvdimm/region.c      | 3 ++-
> drivers/nvdimm/region_devs.c | 3 ++-
> include/linux/memregion.h    | 8 ++++++--
> 5 files changed, 16 insertions(+), 6 deletions(-)
>
>diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>index 46edc11726b7..8b39aad22458 100644
>--- a/arch/x86/mm/pat/set_memory.c
>+++ b/arch/x86/mm/pat/set_memory.c
>@@ -368,7 +368,7 @@ bool cpu_cache_has_invalidate_memregion(void)
> }
> EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
>
>-int cpu_cache_invalidate_memregion(int res_desc)
>+int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> {
>	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
>		return -ENXIO;
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 6e5e1460068d..6e6e8ace0897 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -237,7 +237,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>		return -ENXIO;
>	}
>
>-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
>+	if (!cxlr->params.res)
>+		return -ENXIO;
>+	cpu_cache_invalidate_memregion(IORES_DESC_CXL,
>+				       cxlr->params.res->start,
>+				       resource_size(cxlr->params.res));
>	return 0;
> }
>
>diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
>index 88dc062af5f8..033e40f4dc52 100644
>--- a/drivers/nvdimm/region.c
>+++ b/drivers/nvdimm/region.c
>@@ -110,7 +110,8 @@ static void nd_region_remove(struct device *dev)
>	 * here is ok.
>	 */
>	if (cpu_cache_has_invalidate_memregion())
>-		cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>+		cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY,
>+					       0, -1);
> }
>
> static int child_notify(struct device *dev, void *data)
>diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
>index de1ee5ebc851..7e93766065d1 100644
>--- a/drivers/nvdimm/region_devs.c
>+++ b/drivers/nvdimm/region_devs.c
>@@ -90,7 +90,8 @@ static int nd_region_invalidate_memregion(struct nd_region *nd_region)
>		}
>	}
>
>-	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY,
>+				       0, -1);
> out:
>	for (i = 0; i < nd_region->ndr_mappings; i++) {
>		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
>diff --git a/include/linux/memregion.h b/include/linux/memregion.h
>index c01321467789..91d088ee3695 100644
>--- a/include/linux/memregion.h
>+++ b/include/linux/memregion.h
>@@ -28,6 +28,9 @@ static inline void memregion_free(int id)
>  * cpu_cache_invalidate_memregion - drop any CPU cached data for
>  *     memregions described by @res_desc
>  * @res_desc: one of the IORES_DESC_* types
>+ * @start: start physical address of the target memory region.
>+ * @len: length of the target memory region. -1 for all the regions of
>+ *       the target type.
>  *
>  * Perform cache maintenance after a memory event / operation that
>  * changes the contents of physical memory in a cache-incoherent manner.
>@@ -46,7 +49,7 @@ static inline void memregion_free(int id)
>  * the cache maintenance.
>  */
> #ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>-int cpu_cache_invalidate_memregion(int res_desc);
>+int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len);
> bool cpu_cache_has_invalidate_memregion(void);
> #else
> static inline bool cpu_cache_has_invalidate_memregion(void)
>@@ -54,7 +57,8 @@ static inline bool cpu_cache_has_invalidate_memregion(void)
>	return false;
> }
>
>-static inline int cpu_cache_invalidate_memregion(int res_desc)
>+static inline int cpu_cache_invalidate_memregion(int res_desc,
>+						 phys_addr_t start, size_t len)
> {
>	WARN_ON_ONCE("CPU cache invalidation required");
>	return -ENXIO;
>--
>2.48.1
>

