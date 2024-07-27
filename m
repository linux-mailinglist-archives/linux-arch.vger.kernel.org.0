Return-Path: <linux-arch+bounces-5658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9A93DFCD
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFB01C20FC3
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7F1802D7;
	Sat, 27 Jul 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="W3SqZwj6"
X-Original-To: linux-arch@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335387E111
	for <linux-arch@vger.kernel.org>; Sat, 27 Jul 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092092; cv=none; b=KCbs6Jcf6a34n+/0TONnq+pNhXzLqYCswmCT7MuIfJek764jk5rZoITS16X4BHP4JcMRX3LRAoMUU4hu2Vvx8RmfD+HXflOmYPbcprmDw7rpenlqMQWM0NBEs7DwLZn/2+Ycq5hattLPOv4yn/OT1HD62C/1C2UmSUr6zhsfAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092092; c=relaxed/simple;
	bh=yiWuP8Onb+fyKehtZA9+3qlxXA9OLQ0daLGmt8gHCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDkcfJrZQCZ6aBsorvpnvjZS/mkJYCdfVzxbh9I5DBvEwbDoMP0Dv7oy5xMz5NLanryy7W/MvMuxo/Sjr5M72uYuMG7alDn/jJDQpc1cRRTl1hsxGw2uxUYVMhtTOxuMJRUYU/km94qhJCyb9j/qt3LYv17jxPFif5eCWp9Mreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=W3SqZwj6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46REqWUW017051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722091958; bh=qLhE8zhbnsrLQesDE5s8eN6bXS32QqwKbPnsHmPpjPs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=W3SqZwj6xO4JInZDIxy44/G9zuWEAwQBDT8wo9oAislq4E8B456lR87n3bSU9fcTu
	 iY0V57/ee8ng08hyb4Csnb2aESguN8FAilgp5bT1uF+l0t0N6l5WFjifYiECO6bUDd
	 t5BTjYHDKkOovBhtRTqwkR8rL7aX++aINeXzjuXf7n9rHduxZMGTecM7BxEExtLP51
	 RiF9Pepy9ILquFzBv7I6nIGYyVPO16Y/OWE3V35dTFL7MdnWaaeUIgp9Z79JAPI2dj
	 iZEP64jTBjnKooEX1ccphhGHyHOYzUv04vJ6/ie7IN7IddG/d/a9WC4B2NrMWDyWKL
	 An8LLBeP0m5Aw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8A69515C0251; Sat, 27 Jul 2024 10:52:32 -0400 (EDT)
Date: Sat, 27 Jul 2024 10:52:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.cz>, Youling Tang <youling.tang@linux.dev>,
        kreijack@inwind.it, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <20240727145232.GA377174@mit.edu>
References: <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
 <ZqPmPufwqbGOTyGI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqPmPufwqbGOTyGI@infradead.org>

On Fri, Jul 26, 2024 at 11:09:02AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 26, 2024 at 01:58:00PM -0400, Theodore Ts'o wrote:
> > Yeah, that's my reaction as well.  This only saves 50 lines of code in
> > ext4, and that includes unrelated changes such as getting rid of "int
> > i" and putting the declaration into the for loop --- "for (int i =
> > ...").  Sure, that saves two lines of code, but yay?
> > 
> > If the ordering how the functions gets called is based on the magic
> > ordering in the Makefile, I'm not sure this actually makes the code
> > clearer, more robust, and easier to maintain for the long term.
> 
> So you two object to kernel initcalls for the same reason and would
> rather go back to calling everything explicitly?

I don't oject to kernel initcalls which don't have any
interdependencies and where ordering doesn't matter.

						- Ted

