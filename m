Return-Path: <linux-arch+bounces-7956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1709980C2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B162850C8
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5741BC9FB;
	Thu, 10 Oct 2024 08:38:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B111A3BAD;
	Thu, 10 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549483; cv=none; b=rlCzRm6LcE6bcYsjsf0FrUZf/F3/zexebmwoiJfqrVtXzhUfVFNOh7eZ2Gmqd46HhTnx8/BrAOsMOXUa7ha2g7yS8lixpUloIU6sQ6LdrwJIe8PNSWIuvfedZj2eA2RSQ6G92ZPRG3u17ktj0d0G0bfqREx2PkS6fUKBx7wSUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549483; c=relaxed/simple;
	bh=ub/W3kYvflgaWeUEbEgSxJNFDKzF9y2XGhjak3MQL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVGJTqbfu2+YqsRPpZHV1/qQmHz0Zd+2r6/qA6qb5UA9uAtPAedYod+TJJahDbMuMC+hJPTqxaIAaQvGQlZPN11y4j8G7XFUbyp/BziW8b8JXzgS1GBacTYtk64zItPgT6p289JW2SEMUe/Ujo7p374y1BZyQMdWqo4FGkiGsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D670227A8E; Thu, 10 Oct 2024 10:37:57 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:37:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
Message-ID: <20241010083756.GA8685@lst.de>
References: <20241009114334.558004-1-hch@lst.de> <20241009114334.558004-2-hch@lst.de> <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com> <20241010070342.GB6674@lst.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010070342.GB6674@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 09:03:42AM +0200, Christoph Hellwig wrote:
> > I think we should try to have a little fewer nested macros
> > to evaluate here, right now this ends up expanding
> > __pfn_to_phys, PFN_PHYS, PAGE_SHIFT, CONFIG_PAGE_SHIFT,
> > page_to_pfn and __page_to_pfn. While the behavior is fine,
> > modern gcc versions list all of those in an warning message
> > if someone passes the wrong arguments.
> > 
> > Changing the two macros above into inline functions
> > would help as well, but may cause other problems.
> 
> Doing them as inlines seems useful to me, let me throw that at
> the buildbot and see if anything explodes.

The inline version instantly blows up, so I'll try just open coding
the phys to/from pfn translation instead.


