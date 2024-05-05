Return-Path: <linux-arch+bounces-4212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B498BC340
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87879B20DA4
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F86DD0D;
	Sun,  5 May 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McWQbNDY"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05A1E861;
	Sun,  5 May 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714937625; cv=none; b=D3XbBtbWTpZeOGK+DrC1ZgO8s8053RdoJCIw9nmzw6rEwsR+2ghMuyCLelRqGqECFoDDNUVmRiFPBb9yWFkn6ke0jBA/zu8Ul/eQlWNXwMMQ7EA8xKVEKOUMWXZJE1P0iyZy6lTgflVEKIHm30FfOpbuueIZsOVePO8x8btmfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714937625; c=relaxed/simple;
	bh=FAa895ktb1uP1Vp93a9G7q8BSm2alQQQ6zACrN4BDCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLoxacyzy9oeAMGCyE+tnpKycRFnCKBJGPSofpNOp1GpHh1FentXLWmJTfeNzYKstObhv9K2Y4at5xfwo6P2jHgNEp1Y1vqpI+kQIkCJh+3nTEJtxSRS75HHmJwoOVz64Q8AWGnqg0zsMJtwqQlTpYxWryLmhp0Hsho5XjOCyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=McWQbNDY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ir7v3reFern2bMfdElsM96VZnzXzk0n4uUJTOAif+1Q=; b=McWQbNDYzuYXgpSXDP4LItZWas
	c+G1yOfrbEspOzp1y83MmoVq+GjM65/lDs5ubikEffoKy6knBTT0Cnta994MJYbor6t7/xL39+xZY
	ql5OkyzdVJnqVLsZA07ot1DBjiNfK/PRj32i+7icc4KxOKtjuizlh6PQ2yg/Gh2uW00MtWrZH+noT
	DmGe+qrgLQzl+Vjiy6wLJXFRAfjYNsLD6oxZNRyY3G4+BY0/9l8y8NCR4bpLwA4zkQq+SpC8pRlQ7
	1jq7R+FD/uXz6shSAQhD3+U1mfsV1BoTVZ/bSVu26krBG1rtN+CtsWnH1RZsq3KB14EYp0oR36XWz
	2afx1NrA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3hc8-0000000587A-2v0C;
	Sun, 05 May 2024 19:33:36 +0000
Date: Sun, 5 May 2024 12:33:36 -0700
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
	Liviu Dudau <liviu@dudau.co.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
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
Subject: Re: [PATCH RESEND v8 00/16] mm: jit/text allocator
Message-ID: <ZjffEEsRIb8r0jG6@bombadil.infradead.org>
References: <20240505160628.2323363-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505160628.2323363-1-rppt@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sun, May 05, 2024 at 07:06:12PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Hi,
> 
> The patches are also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v8
> 
> v8:
> * fix intialization of default_execmem_info

Thanks, applied and pushed to modules-next. If we find fixes, let's
please just now have separate patches on top of this series.

  Luis

