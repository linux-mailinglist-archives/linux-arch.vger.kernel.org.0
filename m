Return-Path: <linux-arch+bounces-1160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760E81C4E2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 07:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A238DB21187
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A863B5;
	Fri, 22 Dec 2023 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2WhdYAI2"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB279C4;
	Fri, 22 Dec 2023 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=w9MY9eXNL5W2g7BPEGUzibaZ91+MkZJyljEwF4Vk5yA=; b=2WhdYAI2Pjno84kZFvAuqepLxb
	2DC69uXoDn0Gzt1zQzYyTV7E7m6RUC1aNGv8kRJsrgBS4gg4aAwYvaz3ev5IBj/WjOFNoq8fwunbf
	1mJTpowR5VunDkux3hiU9uFBMkzjXes+inf8P2PJ7J8c1pi/xYvnNgfRfcGW4PTdd+dTr6DY2be+p
	MNuOEUrPA3tQOdpBWjvly8kLii4Ft0+aLaAHoXX3CLsABsSt3+ktn2kglpkKXl58Nmx1PnY3bl973
	uYKy/t0DHV1Q4SGMF6zUPrpsKeTcj2Nz4Go/XVq6bkWzA2VWxDeCEAzB8O8bnfdenNggYFffrPJf2
	MrjqEAOA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYgk-0052pK-04;
	Fri, 22 Dec 2023 06:07:14 +0000
Date: Thu, 21 Dec 2023 22:07:13 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab
 entries
Message-ID: <ZYUnkSF6hcyPq9tG@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-2-deller@kernel.org>
 <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
 <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 22, 2023 at 01:01:23AM +0900, Masahiro Yamada wrote:
> On Thu, Dec 21, 2023 at 7:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Thu, Nov 23, 2023 at 7:18 AM <deller@kernel.org> wrote:
> > >
> > > From: Helge Deller <deller@gmx.de>
> > >
> > > An alignment of 4 bytes is wrong for 64-bit platforms which don't define
> > > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS (which then store 64-bit pointers).
> > > Fix their alignment to 8 bytes.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> >
> >
> > This is correct.
> >
> > Acked-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Please add
> >
> >
> > Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> >
> >
> 
> 
> If there is no objection, I will pick this up
> to linux-kbuild/fixes.

The new selftests I've suggested should help get perf data to cover both
modules and built-in kernel symbols given find_symbol() will first hit
built-in symbols first before modules with one caveat: we'd want to extend
the selftest with a part which builds a module built-in with also tons
of other symbols.

So I'm all for you taking this but I don't think we need to rush for the
same reasons I mentioned in my reply to Helge.

I think it would be nice to get real perf data with perf stat as I
suggested, and include that in the commit logs. I think it would also be
useful to include a description about the fact that there is no real fix
and that the performance hit is all that happens as the architecture
just emulates the aligment. In the worst case, if exception handlers
are broken we could crash but that is rare although it does happen.

If we want to go bananas we could even get a graph of size of modules
Vs cost on misaligment as a relationship with time. Without this, frankly
cost on "performance" is artificial.

Thoughts?

  Luis

