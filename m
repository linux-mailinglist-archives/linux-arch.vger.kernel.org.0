Return-Path: <linux-arch+bounces-3604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437378A1F96
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA692862E3
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A071755A;
	Thu, 11 Apr 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6WjKA9G"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB3205E1A;
	Thu, 11 Apr 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864532; cv=none; b=XlaHC7zX76LVzfJ6evy+NPMSmJVh5NQ3NIw5DUMZaexrH3d1Z6gZmYZYj55HutU4TweXlZRH7Q1eTWAyfVJZeQuL5Gx/2LoHTA/WLTQyOfuwW3khTWJoP26jh3rPLzd1EYnGfs1Yn7syVyeLFXtBohmU/nyhrT2euC2UwQJF0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864532; c=relaxed/simple;
	bh=X8P1ZrYs4XscfQnXoOsg7tnFxIk3wKaA03HALumhDfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T90FIiRFuPofZNA8XmOLbapTjyyfz1rKVsgsfxmvv+qK1WJAF+pXOBV+P9EQ4OpHNU6AUnIK3QiK4oUNBYWtk9rnyd4zyPYR5gKvaoRpUiAfR0EcY6ebsH9RJx4qDfue0uUPdYmZLG2F/1aQP79yVMXD4LSyN+70AI+2iWpef34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6WjKA9G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GLmQ6OAiLByfHZ0eGe8X2lInPvVUnYvYGHLtnSFpmng=; b=p6WjKA9G6dX+WyDufUHAVMvzmt
	TEEuKUVS+thzRELnqAjvnH6i10dz570nqrjJL9ZXGf4bZS1nXuY4F57S1i8sknzzTiosXrRMWtwja
	Wl2QVyKMVPgdD4djWPDJyYc1qh+eRSQYF6g3SQ+FxVhW8CjBgW1dMrDQA2/rPtVx22R2m4mjZa233
	XbfrF3KCbxbV4a2eULYCR2JvTK5mnLn6In5XBzJIKJGJJDaTbAKriC0c3xg5TIewrOd+koQ0lcmWE
	yuu9PAFmPro1hKpehzsdur/j+e2m4dzk/qfRpBgrPaEio0j2aD0jKKMt0SHDFcdZ3PlSFQUBMlTG7
	n33Z/seQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv0JB-0000000Dvah-2hQJ;
	Thu, 11 Apr 2024 19:42:05 +0000
Date: Thu, 11 Apr 2024 12:42:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
Message-ID: <Zhg9DXzagPbpNGH1@bombadil.infradead.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160051.2093261-6-rppt@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> module_alloc() is used everywhere as a mean to allocate memory for code.
> 
> Beside being semantically wrong, this unnecessarily ties all subsystems
> that need to allocate code, such as ftrace, kprobes and BPF to modules and
> puts the burden of code allocation to the modules code.
> 
> Several architectures override module_alloc() because of various
> constraints where the executable memory can be located and this causes
> additional obstacles for improvements of code allocation.
> 
> Start splitting code allocation from modules by introducing execmem_alloc()
> and execmem_free() APIs.
> 
> Initially, execmem_alloc() is a wrapper for module_alloc() and
> execmem_free() is a replacement of module_memfree() to allow updating all
> call sites to use the new APIs.
> 
> Since architectures define different restrictions on placement,
> permissions, alignment and other parameters for memory that can be used by
> different subsystems that allocate executable memory, execmem_alloc() takes
> a type argument, that will be used to identify the calling subsystem and to
> allow architectures define parameters for ranges suitable for that
> subsystem.

It would be good to describe this is a non-fuctional change.

> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

> diff --git a/mm/execmem.c b/mm/execmem.c
> new file mode 100644
> index 000000000000..ed2ea41a2543
> --- /dev/null
> +++ b/mm/execmem.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0

And this just needs to copy over the copyright notices from the main.c file.

  Luis

