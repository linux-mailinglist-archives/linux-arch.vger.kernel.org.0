Return-Path: <linux-arch+bounces-5631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3E93C681
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1781F2329C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721819CCEB;
	Thu, 25 Jul 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIOpP/z0"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F71993AE;
	Thu, 25 Jul 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921650; cv=none; b=E3to6Jy9eNbbjZbVmXAAyVjrECMQyAxKdqYU6ROoyqvW0m872YdP+8d2fkAvIV3cVhUdcv4I2Rb+QHQdxzhs6AmFAHnRddr+L6Lz2Ck1L4/VFHzPljgfjSVEThcGElWA+D0IRpogkErqk9/ZMraTeEu6bwb7VSlns9I/OtVsYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921650; c=relaxed/simple;
	bh=mosRgo+TNXHCMViMqQ63lOJKcR81W989gSomumQQF28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdpEZh96s+4+d1sd65vGeNpCHuz+mv6brr0yxXYwhxkNwb+o9nUtTs1zP6gZEF7F22beQUZKCo4ecKkgEecTuf6OpYWYsEU9Cr5HrMjqLM8wLJfUdu5Frb5qMZeQeDih26DG42z6n5Rv21D2bpY034nT541WYB47xzIDw9uLHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LIOpP/z0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jf02KJptUmzqNSH7cWf1ELLoEYpwrFBHCIF0xHDo8l0=; b=LIOpP/z0HDXBvgis90fj8E5C4a
	mKo04fF6xe5Kfd7gqhDDo/Ltpr6NVq86cDZZflinaEq8T3lDMs7VaQyEvc+UdG7DdZgLDnNTB64qF
	OzbeX9Jfb1r6PqIxfPAO4MeQrtJ6ObM7nkMmX4RV7s5Sodywr272B2RBteD0PacNJBgYNiVqurMZU
	psJmvT3z99KULg2rvesB8JAhCoLgJTSa8xGEpp+LMV2A9xYxYM/4lyJ4VFLC5IQuiFyLccQ6eu+MS
	oTzVGMoZDIhsp629Bhp3yThgyrqDwXxfqCe0wNzbqthfraFbl+zYMWSNZ1TW7fLBiWf4YGDBWFkRl
	EkrFh6Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX0Tj-00000001QbE-0QCv;
	Thu, 25 Jul 2024 15:34:03 +0000
Date: Thu, 25 Jul 2024 08:34:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Youling Tang <youling.tang@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <ZqJwa2-SsIf0aA_l@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 25, 2024 at 05:30:58PM +0200, Arnd Bergmann wrote:
> Now I think we could just make the module_init() macro
> do the same thing as a built-in initcall() and put
> an entry in a special section, to let you have multiple
> entry points in a loadable module.
> 
> There are still at least two problems though:
> 
> - while link order is defined between files in a module,
>   I don't think there is any guarantee for the order between
>   two initcalls of the same level within a single file.

I think the sanest answer is to only allow one per file.  If you
are in the same file anyway calling one function from the other
is not a big burden.  It really is when they are spread over files
when it is annoying, and the three examples show that pretty
clearly.

> - For built-in code we don't have to worry about matching
>   the order of the exit calls since they don't exist there.
>   As I understand, the interesting part of this patch
>   series is about making sure the order matches between
>   init and exit, so there still needs to be a way to
>   express a pair of such calls.

That's why you want a single macro to define the init and exit
callbacks, so that the order can be matched up and so that
error unwinding can use the relative position easily.

