Return-Path: <linux-arch+bounces-8018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90E999E86
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59791F22A57
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F720ADD5;
	Fri, 11 Oct 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FOUI0sx1"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A720A5F0;
	Fri, 11 Oct 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632964; cv=none; b=bsD4tWQcagemxPGOgEDRH2WS+sRaBYV8eWOZ9kfeXkW7St5oU85onQlrpsD910OxHw3BCmEU6yFqgogMXsKuEKY5XclR5Fg+cRtyzZSvEGx3caKC0SkBKHFOLysNa6Qv1PEW7+Jg4P15OGlc0xD7AayoW1mG4HPAraV3beLGHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632964; c=relaxed/simple;
	bh=lAlGhwACTRPPIfz6ZBEdhegdAHWo1BlhgB4ROXVis3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw+54RB9QY8inXtdJMPijB1HxPYjvHXC3YXmY1BAvDe04vO8wT3eEcgUcxlMAT33P54Mh2DktdEFGHFPQct+gGm8unVE4kNzA3y6TNmEsrCZnHm7Dwu0pm20vkY66VTVlGuHPZbOxBu0C6UDDLeNQRW4e6XPOWncYKDjcF8WwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FOUI0sx1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oppw89lW+K9OohLBYEY/BfZDmAvR7NJuGMECnznnan0=; b=FOUI0sx1mdI/DOKOmLrWJxvPyN
	CpXE3cQO8YpeSFBoG+B0wx95OmbVdU+6WGEXlAUbJUUhLoCkxeee2W4iTsfy69F5mw1nTKYrs3pDj
	hfHS4rbOI6TdISMbtlersRooAWvMdWm1bZs0jLikYH0xzTf4FGeKsYo2n02tgwBN/yKY21NsTyCnF
	WZNOrZfynMwUhpLdXHyGVvwBAbPajWWwRoDcAoTvCIkot2E7t7pfYUJ8Y07vkr0IQmpmNYUJjPVC+
	kAUg4pof8D4/9muR14TthcgmiAkKYk7MxMIGuUkkiJkywUQD/cmy05cgpPG/WQAzEuEModMMAKTlx
	XIpN81Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szAOj-0000000Fbgx-0FbT;
	Fri, 11 Oct 2024 07:49:17 +0000
Date: Fri, 11 Oct 2024 00:49:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Laight <David.Laight@aculab.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Christoph Hellwig <hch@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org, Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v9 1/4] Consolidate IO memcpy/memset into iomem_copy.c
Message-ID: <ZwjYfUrHfZlxBVxQ@infradead.org>
References: <20241010123627.695191-1-jvetter@kalrayinc.com>
 <20241010123627.695191-2-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010123627.695191-2-jvetter@kalrayinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 10, 2024 at 02:36:24PM +0200, Julian Vetter wrote:
> Various architectures have almost the same implementations for
> memcpy_{to,from}io and memset_io functions. So, consolidate them
> into a common lib/iomem_copy.c.

That might be the final intent of this seris, but what this patch does is
to replace the trivial memset/memcpy inline implementations with a more 
complex one that actually use the accessors.

So this actually changes behavior for those architectures that did not
provide them before quite a lot.  You'll need to explain in more
detail why that is safe and desireable.


