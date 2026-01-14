Return-Path: <linux-arch+bounces-15793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E329D1EF8D
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 14:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF3AA300F6A1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42739A7F3;
	Wed, 14 Jan 2026 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o5O0fVjj"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25E349B0A;
	Wed, 14 Jan 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396035; cv=none; b=mVTFxBwAv4BKPRU8rdzd4Ut5AQOTJH6yEgaGqqzBS2yljSE1c/WIPmkifk4bBGnOUZF7y9sxN0H2G0gKqRMI7n7PoI5C/BlkRzRE7n7cHXGZa4obE2POW82OyUQUhe/ksI2pBYuMIuaEjgmWs1VqiE0uLRdKidiLv32/bmBy1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396035; c=relaxed/simple;
	bh=494HrHF0odc3qjfHZTbGKxMt/JQuHQDVh91/V7jleyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDHko0ftdpppTgt9ayRlxFYiQakd8CkQ1se6R1u4qKbWbjck172XmshGvJpCU6520+W0Y20oFvLIaaOCdoUVKJ0gpLavHG14cyGTfD3LJYiIJTSnmgdRi5nLOtHReOG/JM0vX4YHhSsmFHwHgyt8CFXT4VKCSUCcGZzZv+CgdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o5O0fVjj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fyWL+E9yB213HC+XbKKPFkof5RMwUvNvxik7cDpGBIs=; b=o5O0fVjjT861S1Q9jOEqjzB8Qu
	bedeQjx594j4au0gOU7X+maZEF0bvVwFYKXA9BmOd6Cg6xga5+otgqfzbueW1CvoddvTvkWMn1aI6
	mMRshcM3Oi3ITdG29NdLZuSUiWL1j2KN6nuqeExljjV4AVGFzdTt/ezOLz3u71pCY+iPU8w9SdDtN
	e4np0FoUjzASDNdaZQhVGwESuL6yuKSh2IqvMpuPLazrvx5aEOFySPkwaS3PavByU0OYk0f4m12MU
	2z0O+FTEqdDlevwtWLNNISBm0X6sFjIZ9FwswRl45tPfU2EEFpmiQkHNyWuFSqRIirWR5syUyvvZz
	2gcYuscg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg0aW-00000004skF-2pm5;
	Wed, 14 Jan 2026 13:07:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D67B3005AA; Wed, 14 Jan 2026 14:07:04 +0100 (CET)
Date: Wed, 14 Jan 2026 14:07:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Sasha Levin <sashal@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/4] atomic: Add alignment check to instrumented
 atomic operations
Message-ID: <20260114130703.GC830755@noisy.programming.kicks-ass.net>
References: <cover.1768281748.git.fthain@linux-m68k.org>
 <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>

On Tue, Jan 13, 2026 at 04:22:28PM +1100, Finn Thain wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add a Kconfig option for debug builds which logs a warning when an
> instrumented atomic operation takes place that's misaligned.
> Some platforms don't trap for this.
> 
> [ fthain: added __DISABLE_EXPORTS conditional and refactored as helper
> function. ]
> 
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> 
> ---
> Checkpatch.pl says...
> ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'

Feel free to add:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

