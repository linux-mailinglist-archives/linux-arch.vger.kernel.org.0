Return-Path: <linux-arch+bounces-5644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA193D805
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D338CB23439
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88517CA06;
	Fri, 26 Jul 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oArlGx+H"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8917A580;
	Fri, 26 Jul 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017352; cv=none; b=cYEjYbJZOHsy7BDbQ0JHfSXVOea2pqBnUaRJTivQ/iPXN+CGL6HXsjxxi7uyBzbXvzHEUOpltCsIvXxYIWr+/tmuwCW/myhLTyWOaHUOG5fVY3gG4+Z/pRYZFsQ43dv63q+EvSfGfWm79jUW2/Bd99zJ9YYG14x6DexS/Ze1qmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017352; c=relaxed/simple;
	bh=QwKVfIJx6b6w9eytozal7rkLHjdJGPTRw1tI+tPnJqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFb7021O/AvY6lrOp3UjunxQ1ABWd6IQAMhj20+TLe3DWWCfSTyFi2ncvIyUFl+YfUsWyihtkpIDtD1zv8ib2bA/J4N2txMPlarhFroOi+DeldLMWdK67Svrs16UJuNAZ3y+4JOzwtXN6mcEosetZXfNGdrMumLPI3L8vIwpBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oArlGx+H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Y+bBdbxxKC2hf51b7J1S8qThB2b/5XgdfKw1OYTUmk=; b=oArlGx+Huj22K57mLVmHcbr0Xl
	MiQWzuEi4Bl7fRZsVt+B9ZKIiRlk60bv4A1VwbYD2R+Rij6yZOAmguXQjSY/MHCs+c5GLg+B3THb3
	3L32kWuUMtGuW5OmDt0vugl+4K77MJTbYl21N3h8WQHlnLaDt19jUm/cZTwsI/giT5Mdk2ZVaQSEi
	dAPaioHkwR/mfs6CveVJ30rbYPtXcU+9XwlzNWTKLLmrSaqNALfDlg5Bho5b/WSTNBGtSdnkr8Fxd
	Kg9ecy0O4QzGYhFP4PuJgMaBPF/t2ijbsQYxLefX5IusHSMB6Z92ApoMggnQ+t2OmX4XcWnwFI/4X
	MPHP0EfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXPNG-00000004cOz-4BYF;
	Fri, 26 Jul 2024 18:09:02 +0000
Date: Fri, 26 Jul 2024 11:09:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: David Sterba <dsterba@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Youling Tang <youling.tang@linux.dev>, kreijack@inwind.it,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <ZqPmPufwqbGOTyGI@infradead.org>
References: <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726175800.GC131596@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 26, 2024 at 01:58:00PM -0400, Theodore Ts'o wrote:
> Yeah, that's my reaction as well.  This only saves 50 lines of code in
> ext4, and that includes unrelated changes such as getting rid of "int
> i" and putting the declaration into the for loop --- "for (int i =
> ...").  Sure, that saves two lines of code, but yay?
> 
> If the ordering how the functions gets called is based on the magic
> ordering in the Makefile, I'm not sure this actually makes the code
> clearer, more robust, and easier to maintain for the long term.

So you two object to kernel initcalls for the same reason and would
rather go back to calling everything explicitly?


