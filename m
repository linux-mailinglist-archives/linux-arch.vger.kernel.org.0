Return-Path: <linux-arch+bounces-5629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC91D93C46E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198DC1C21998
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBE19D082;
	Thu, 25 Jul 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL5/OYQ+"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB619D07A;
	Thu, 25 Jul 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918392; cv=none; b=aglWUHhzA1enAx8OC47rV6Lx13R0rX12qHFT1L3neSLewyjfCw8Kg6M2uct9iServYFZ4Z0jYEaPwzEcJaSQIi1W9qqFjzmgc365mkksIKiDYyAvOZE3ShNEamV5r71hr4Qo2IWqvWzat/Rt29XNipFXuBRlDq2D97QCiGCpJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918392; c=relaxed/simple;
	bh=8iE2fLIuKiX/R1Mck8oWn/wV8sca/R7pF11OZS3T544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y75VAZin04y/PrJkF93Tza6NV/OTJVo6aAMI73txpqM1ultU1NrZBiTzqyjZJttXWcqrb42xNbuz0n2CMLJVIs9Mdeb9JFG+CJwGU1jJGoyJnWFBO3v/zkpzTrRQ+XL0oNqMHzeJ54LoUOyd2Z5JT4PwMWLmMut9SlSl019LnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WL5/OYQ+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fT+P3bL2alqk783XUIpMyvxWyxVKIMjRx9YDa8Msrv8=; b=WL5/OYQ+RT6V2Tl5hRTNfUjVwL
	oYtEItO5DN/EmTddff9oHpV7Z1VvU/Hz+Wd/ZHHcYbz51Wp7Pyq1+pk0K/7zQPkMmENAMlmbCODHD
	e5Vr8IhAmtm1e63eRQfIZYn4YhuFhEfyTM2m+FX40WG1cnKnrVwE7Qp3XJyhDFybOgRokQsOqhLVU
	exQ2/h/Jc8DM+0kWg1+tInyN9tyTGSg30g+Urn5OCITbb2OMIKeZqU36FmGsCWt4pMVGSDnv5zLvN
	cjcI8uRXUENjfZNyTD2zcw+U34WMrESbsJV14YTD1M0PxUQTTJxWSlubgoMyN5eOUzZyr4+eXPHz4
	BZFIqkRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzdC-00000001Iql-2cGb;
	Thu, 25 Jul 2024 14:39:46 +0000
Date: Thu, 25 Jul 2024 07:39:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <ZqJjsg3s7H5cTWlT@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 25, 2024 at 11:01:33AM +0800, Youling Tang wrote:
> - It doesn't feel good to have only one subinit/exit in a file.
>   Assuming that there is only one file in each file, how do we
>   ensure that the files are linked in order?(Is it sorted by *.o
>   in the Makefile?)

Yes, link order already matterns for initialization order for built-in
code, so this is a well known concept.

> - Even if the order of each init is linked correctly, then the
>   runtime will be iterated through the .subinitcall.init section,
>   which executes each initfn in sequence (similar to do_initcalls),
>   which means that no other code can be inserted between each subinit.

I don't understand this comment.  What do you mean with no other
code could be inserted?

> If module_subinit is called in module_init, other code can be inserted
> between subinit, similar to the following:
> 
> ```
> static int __init init_example(void)
> {
>     module_subinit(inita, exita);
> 
>     otherthing...
> 
>     module_subinit(initb, exitb);
> 
>     return 0;
> }

Yikes.  That's really not the point of having init calls, but just
really, really convoluted control flow.

> module_init(init_example);
> ```
> 
> IMHO, module_subinit() might be better called in module_init().

I strongly disagree.


