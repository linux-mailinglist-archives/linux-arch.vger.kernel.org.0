Return-Path: <linux-arch+bounces-1292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C388826AD3
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB331C21E3B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560111716;
	Mon,  8 Jan 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fy176uqq"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B41173A;
	Mon,  8 Jan 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nTS1Uj9X0YK5sE131pQWTs2iFDkjMx4GKaOmTl5jpqE=; b=Fy176uqqVZeORczKkanJckGA3E
	rjRR9SFWlqdBWFeQhMUeo2x5lV8XpdYa4GI0iYUzJ6xe4JfoH/ClDNDCMVJub0LPMWEwUwd8I8dr0
	WwH6zcQyiGmBNcE7Fs8axj5Vg+MNCFSetI0lVOGPKPgwxoNDApJeoPP6xe17PMl4YbYUkYENMyduB
	f083OT27kxtEMpbQucthM3SKI66TxkTOiSrMzwOmJqYthGOqjcJQX6LHBVpu97K2Nyn2Uoe2m6xiJ
	DGQPT42ehYs1d42jNISUDZY/OxsBiSJHVw2pJE0uDLbTxsdKq7BFvXx0o48duef+zb5iDUsv9NZhu
	bOOsB0Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rMm44-004Uoy-0z;
	Mon, 08 Jan 2024 09:37:00 +0000
Date: Mon, 8 Jan 2024 01:37:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZZvCPMcYq6KBs7ND@infradead.org>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-8-samuel.holland@sifive.com>
 <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
 <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
 <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Jan 07, 2024 at 10:39:07AM +0800, Huacai Chen wrote:
> > Do you mean that LoongArch32 does not support double-precision FP in hardware?
> > At least both of the consumers in this series use double-precision, so my first
> > thought is that LoongArch32 could not select ARCH_HAS_KERNEL_FPU_SUPPORT.
> Then is it possible to introduce CC_FLAGS_SP_FPU and CC_FLAGS_DP_FPU?
> I think there may be some place where SP FP is enough.

Let's defer that until it is actually neeed.

