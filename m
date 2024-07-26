Return-Path: <linux-arch+bounces-5641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04C93D4BA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DD41C22342
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB3EDF;
	Fri, 26 Jul 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="suO6XDt/"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83C17E9;
	Fri, 26 Jul 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002685; cv=none; b=hPO/9VmdudtCLujDq77WcWnCJpkr2gbaU766woI612CX94DS4HGXljxEQT9zyguWoqQpMt9FQgIvHChnI0+jwCxXf8GP9aP0q6HxyxjdIQz/lx3lp1vN+EKKZjXjaudArjAV+1PYl3zwQvq1S/bws2jXADSKzXImbLUFGCXzQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002685; c=relaxed/simple;
	bh=mGYkfLMx5xSppW42+VBC/lCfQ+1IfuC5w0WSpPyM+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj8qRdaJ4Wuc1qxUrLFEs9Oyaq2Nf6ZfnW4MT9F1/+dolvWvKAcjf5uVkG9N52QYeEPq98l79a/tUgWxDKiPYEgGOI19xcJ2zIWXmjaPJtm4JfmGqJ6xjz1UgGoRGIxWF8ybZOpGDaZyS3b4TYZcmpojBi4MX15Cw7RkwE5f8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=suO6XDt/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vOWFGTk3bX2JnJgg72QTxHrQdHDuBA3HzMoxxCzGYMQ=; b=suO6XDt/eOV0jFSI7gqQoOPT+2
	jp85W3VnB5jiIuQJdG/Mnu7EQ1Oq1C/+uCdtOIwnS17Vr3IZ1iAbq4ju03OfuES452pMKdNqYazou
	PA78iP23EoVIA/ZnT09UKBzTQpyZTd7hwcaE5p5ScLMA0tQdS+4LwquQK2PLSnezYVY5Ei8uMSCSp
	n06A1WG9iOXmrW6R/RPhxBcaCj+/vliP1+8mmQ8uPvaIi/8uZ0ANGycblbWJWuvb9DD4mc1l3d1Cm
	uO2hRGid65D/hCPtXAmwVlyU4vppYFOUrBEuFCDoZWe9NGliRHJWJ1+NKqYfsKmJSLG+I8Q6vICI6
	d1Jalw7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXLYh-000000045IF-3eRS;
	Fri, 26 Jul 2024 14:04:35 +0000
Date: Fri, 26 Jul 2024 07:04:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, kreijack@inwind.it,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <ZqOs84hdYkSV_YWd@infradead.org>
References: <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 26, 2024 at 04:54:59PM +0800, Youling Tang wrote:
> Based on this patch, we may need to do these things with this
>
>
> 1. Change the order of *.o in the Makefile (the same order as before the
> change)

While we'll need to be careful, we don't need to match the exact
order.  Most of the calls simply create slab caches / mempools and
similar things and the order for those does not matter at all.

Of course the register_filesytem calls need to be last, and sysfs
registration probably should be second to last, but for the vast
amount of calls the order does not matter as long as it is unwound
in reverse order.

> 2. We need to define module_subinit through the ifdef MODULE
> distinction,

Yes.

> When one of the subinit runs in a module fails, it is difficult
> to rollback execution of subexit.

By having both section in the same order, you an just walk the
exit section backwards from the offset that failed.  Of course that
only matters for the modular case as normal initcalls don't get
unwound when built-in either.

> 4. The order in which subinit is called is not intuitively known
> (although it can be found in the Makefile).

Link order through make file is already a well known concept due to
it mattering for built-in code.


