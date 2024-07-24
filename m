Return-Path: <linux-arch+bounces-5617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125493B40E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82DAB238FF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC315B97D;
	Wed, 24 Jul 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xBBhe6jV"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FF14D293;
	Wed, 24 Jul 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835830; cv=none; b=WKOzRZxO8HgzyaAr/i+T0e6bFQH1iREqmup87JFBH1Obyzg2MW66oyAoStpmSf5z+EZDqbbFJmfah1swsst0vZIS4+fNxMrBr9JDRV2OQqwIz0T1dToAnnmrPeeXSrOV2w2abACbNc3/3HRlx90vTQUKPb3827MU6VygM/ljYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835830; c=relaxed/simple;
	bh=fjoCzSVNTXzDemQxHLgm77eSI43uzAqjvUS76Oxk0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izc7uYNSrv5pzSCVwZE+zEkDk3DWBpoS1Cm9osVnsLGMqBBaTyfJvNJ2Um/ZBRnek/XT4SbRYhfDV7i+NKZsh82M7xm642+eix52Sfy2onuGqU6FYvPlu5BJ7RyTpPDj7eUzxb0y848+WS6ffQ7yXn0w1L8/nuATzbitTQQMRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xBBhe6jV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=A5NCdA5yQOqvciqjVmzO4FQb/LC/NqR4RCRHik4/Oxc=; b=xBBhe6jVMTs+rNw1ry/JeDmbO3
	MNV3LRo+Yl7MrNMLXKUiUDh5a3l9B6nf0f4P0IsTIY0nSlDEHnV7a6G5I2EsV8/T4721oBI5r3MGc
	3bgO/JHGl3nAfelh+Kd6Thukp30duUluFSk8tydhbdTnaK6QW2elJGcYbFqV8rWXjiP3d5KDfa8w4
	PKjt6QhDh7m9FgZOlBwsfH+sj8NdO57AqPTZgajuCBIN3V0F78TjO4UmAGVqo581pq2+6oegH//ao
	JHXnFbMNWsFGotBDBWynEQzuNL5NRzCkOLNKenS7i9xbMEBAP0uAoZ6mo4RKLEfZS3L7srGg/rYXh
	hSFx2mNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWe9Y-0000000FoTR-2trX;
	Wed, 24 Jul 2024 15:43:44 +0000
Date: Wed, 24 Jul 2024 08:43:44 -0700
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
Message-ID: <ZqEhMCjdFwC3wF4u@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 09:57:05AM +0800, Youling Tang wrote:
> module_init(initfn)/module_exit(exitfn) has two definitions (via MODULE):
> - buindin: uses do_initcalls() to iterate over the contents of the specified
>   section and executes all initfn functions in the section in the order in
>   which they are stored (exitfn is not required).
> 
> - ko: run do_init_module(mod)->do_one_initcall(mod->init) to execute initfn
>   of the specified module.
> 
> If we change module_subinit to something like this, not called in
> module_init,

> Not only do we want to ensure that exit is executed in reverse order of
> init, but we also want to ensure the order of init.

Yes.

> This does not guarantee the order in which init will be executed (although
> the init/exit order will remain the same)

Hmm, so the normal built-in initcalls depend on the link order, but when
they are in the same file, the compiler can reorder them before we even
get to the linker.

I wonder what a good syntax would be to still avoid the boilerplate
code.  We'd probably need one macro to actually define the init/exit
table in a single statement so that it can't be reordered, but that
would lose the ability to actually declare the module subinit/exit
handlers in multiple files, which really is the biggest win of this
scheme as it allows to keep the functions static instead of exposing
them to other compilation units.

And in fact even in your three converted file systems, most
subinit/exit handler are in separate files, so maybe instead
enforcing that there is just one per file and slightly refactoring
the code so that this is the case might be the best option?

