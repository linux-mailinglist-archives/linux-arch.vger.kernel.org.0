Return-Path: <linux-arch+bounces-1169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C581CF26
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1E2B23FCE
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2672E82C;
	Fri, 22 Dec 2023 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bfpfTrI5"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610B2EAE1;
	Fri, 22 Dec 2023 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=vw2xJXdXJeIT5ActmphmNEF7eo4MB+vqQYgma6m08/c=; b=bfpfTrI5MQYIfzI+1LYg1vp+mk
	LMIX9SlXaOfuang2lp+Du9aRJjvLewbOZbhKLp4IUvLV+SjieFuKXOb+Qm7beIHKbNfB5mMvjcw2+
	H1o3Q/wUWnWzb6RdmJaX18LBp6319pitTg4f5doXJ3F2eRB4f/1R3fsLV11IlVl7ahEy2aJjvAE3e
	PqukyPsAzMTOwc94DaOXVvQ2wZhAIAc8KWoYGN5grVeDbXCBZjo5ax6wQ0F/+dnTV7eywwFzaWyPL
	6rV3SVu0wX/9P2wG5itEFow94m1fCqdZC+PbaMuxokskjnbYAFEUtrs6uMMlagESg4gsSK227Dxuk
	KXKS7EDg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlrh-006nkW-2U;
	Fri, 22 Dec 2023 20:11:25 +0000
Date: Fri, 22 Dec 2023 12:11:25 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab
 entries
Message-ID: <ZYXtbRM6AsnWP1fG@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-2-deller@kernel.org>
 <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
 <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
 <ZYUnkSF6hcyPq9tG@bombadil.infradead.org>
 <ZYUn9c4z9yFWMeH4@bombadil.infradead.org>
 <CAK7LNASg+Z0Vx+9ORpuv_5RdgzH4RDfGNEz5nEz71S_j7H18eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASg+Z0Vx+9ORpuv_5RdgzH4RDfGNEz5nEz71S_j7H18eQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 22, 2023 at 04:01:30PM +0900, Masahiro Yamada wrote:
> On Fri, Dec 22, 2023 at 3:08 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Dec 21, 2023 at 10:07:13PM -0800, Luis Chamberlain wrote:
> > >
> > > If we want to go bananas we could even get a graph of size of modules
> >
> > Sorry I meant size of number of symbols Vs cost.
> >
> >  Luis
> 
> 
> 
> But, 1/4 is really a bug-fix, isn't it?

Ah you mean a regression fix, yeah sure, thanks I see !

 Luis

