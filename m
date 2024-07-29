Return-Path: <linux-arch+bounces-5679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD493FDE1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1353A1F22DFE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC2186E37;
	Mon, 29 Jul 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ej0EAM7w"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D615A87C;
	Mon, 29 Jul 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279465; cv=none; b=V8b3s5GhYug9n1U5LJ2pOovYJyICThH3y4ft3MIRWg3VX/VCBv4qU8RgtguukBUF9KvB1aeEmPSsyQXem3KUfSI71M2FAsDpuMlRTKXfMHUH7F1XUkk5lW4VUll663xtnMVXSiCyvkiy90X1vsTzBej4zq1d2g31kqXuGxWzcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279465; c=relaxed/simple;
	bh=DH6q17wJwE/X5Qp0zBeWBEB/NztwTzM0wLQxTlpxGTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyqRHkVa9oaJDIs2UZIVdA/uNwb3dtWpoZEQ0kTkiyBuLpiV7ED4W9qC+7fEIQSpjvIAq/ub2C6fK7mT2NNVb/2vuVUHJ8oa+CrYJc9fFh6UZI/WWcbvXDE4L4mgJqA4WJ9NqdrmHmaWvFhEpSSRV5iMax9jAB7qi1VKn5wfeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ej0EAM7w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bI98vnr4STfnlezdFEzg4Ja3ISFYbT1ZwioxbeX8MKA=; b=ej0EAM7w2vW2zx7IVBK5UWb6kj
	wN1ljrPR09MnAd97P+fTuB/kR5lUi1RXb/2QVebNH54cfJkcVdn1DRLq3wIEF0L6HoO11Wpaq31KH
	b3HS8xuAqVh03lWz/yE/u/Ow4kdwDfTmmKIn1lYNQAiHIsSLGMaD6CF3yGFFxC5Vu9WtjGlQ60UOy
	Q4BgloNHbkwvChMYnO+355i5pha1GxRbPUdTrd6mvYaBUccsoS/rnsx/t69CMPNmh+bDgQ7LKqIkf
	Sjd3SluVefNGGxsPirSouasiVgrHnm6V+d9KUEa831qxQ9pkwr7Uw7PFflXMznzSAxHEHWl7Kshw0
	rtNYHKgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYVYt-0000000CPTa-3gro;
	Mon, 29 Jul 2024 18:57:35 +0000
Date: Mon, 29 Jul 2024 11:57:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Youling Tang <youling.tang@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	David Sterba <dsterba@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	kreijack@inwind.it, Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <ZqfmH9vJo4ikr1RG@infradead.org>
References: <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
 <ZqPmPufwqbGOTyGI@infradead.org>
 <20240727145232.GA377174@mit.edu>
 <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
 <20240729024412.GD377174@mit.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729024412.GD377174@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Jul 28, 2024 at 10:44:12PM -0400, Theodore Ts'o wrote:
> >
> > Personally, I prefer the implementation of method two.
> 
> But there's also method zero --- keep things the way they are, and
> don't try to add a new astraction.
> 
> Advantage:
> 
>  -- Code has worked for decades, so it is very well tested
>  -- Very easy to understand and maintain
> 
> Disadvantage
> 
>  --- A few extra lines of C code.
> 
> which we need to weigh against the other choices.

I think option zero is the right option for you and David and anyone
scared of link order issues.

But I know for XFS or the nvme code having multiple initcalls per
module would be extremely helpfu.  I don't really want to drag Youling
into implementing something he is not behind, but I plan to try that
out myself once I find a little time.


