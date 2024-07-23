Return-Path: <linux-arch+bounces-5592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A993A2CD
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB861F2152D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C7154445;
	Tue, 23 Jul 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlGImzz7"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72214C59A;
	Tue, 23 Jul 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745236; cv=none; b=jbSWCLA5C+4tqAQ3augvP2dYIT8FTgw6azhYi9+5MOBGv36UxtkIWj0M1TfF5aG+3SFRQRaVhgg/p6UM4NOpPNO5Bq9fjlW7S1xsixZlNfyouTDxSqV92eUIHW6q1hvEw+NmH8oon9nWWu5YYvs6UB22jxNHBYMdT+iAChDre5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745236; c=relaxed/simple;
	bh=NMu75Y301zEMrIr2IRooBUWNRfFIuij7M6H0IP31dhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg5EBMxGhE3r4BIr17CGdsqGeqGMe+jVuicDgjnI1VLvFvZgrNDiVWfruNn4KVMOMCE+KBwvxpiI07FxEaXKrPyIqnocP6+la0FRsRTYxaQ6p9YKkjn6Rc+UOk6pqUCGPz/Z86rc0f88BJ4qhWdveXf6KVt55+r5izTTyR4TI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlGImzz7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zGob8cqOMQFMd6ZJ7aKelgl8bYUnwmxgqspoHZfsBx0=; b=LlGImzz7gLD4aCmwv8k4A0e1DZ
	9GPGExELQMb2KbFmKQ+PVeYYxd+u3UDPu2eFN5slv6eWCOFjXC4eQv3mVkP9Lp2d2MNtl1O+afP09
	XG4BbGox2nxhz11YruHX++g9dEN3hIXRBUrmLw4jTiE4t0Ol2b9R1vqXGaOGR0qVt9Hogrell65hH
	zXMwfVspCNgUQnTfpCAkGokZP7Oca/Qb5Jo2DQMo0jZD8u27maea1kaAWaWTK7Fsc5SauwsDTCrQ5
	AEkl44+PaDhnyrKcbbS2YHSwU947HsWksD1v28wQD+UEAjWaTY3TczmHsi3L6MxjLU6HTpkDwCLdl
	9iITSJsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGaC-0000000CjEg-3FBu;
	Tue, 23 Jul 2024 14:33:40 +0000
Date: Tue, 23 Jul 2024 07:33:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <Zp-_RDk5n5431yyh@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723083239.41533-2-youling.tang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 23, 2024 at 04:32:36PM +0800, Youling Tang wrote:
> Providing module_subinit{_noexit} and module_subeixt helps macros ensure
> that modules init/exit match their order, while also simplifying the code.
> 
> The three macros are defined as follows:
> - module_subinit(initfn, exitfn,rollback)
> - module_subinit_noexit(initfn, rollback)
> - module_subexit(rollback)
> 
> `initfn` is the initialization function and `exitfn` is the corresponding
> exit function.

I find the interface a little confusing.  What I would have expected
is to:

 - have the module_subinit call at file scope instead of in the
   module_init helper, similar to module_init/module_exit
 - thus keep the rollback state explicitly in the module structure or
   similar so that the driver itself doesn't need to care about at
   all, and thus remove the need for the module_subexit call.


