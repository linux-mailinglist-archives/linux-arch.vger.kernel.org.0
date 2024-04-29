Return-Path: <linux-arch+bounces-4053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70F8B5EFD
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5BB1F249E1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8F84D27;
	Mon, 29 Apr 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WeJYpsdE"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1D82881;
	Mon, 29 Apr 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408168; cv=none; b=pwiPNM0dnd8a5olKvq6zlCrnLQ/ZJSnZX+wLMcxq6hOo7ZbXZ6ukZWBfPxK2Ne/34VzfZ37Y5Yv8WPYfnl3XZ1NsbnAu8eZ/jE2/1LOW59bYvPw8wVooiaa2qIu7XQ7j+Yqu4Ny7rsj4X4l/3eh7QAjFDv8J+Souq13vJCUP1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408168; c=relaxed/simple;
	bh=nYPavCCoxidSZbCRihx8B881f2cuJlxE/5foMBuO5Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxSGEYurpSFh7g0ZnhocmQfmGn6KTOTDr8X6IcILLXDqE9myECmUnm5g1PlD1nlXYh7uDaFaNiJjCc7d3ycXSrDFSB01cfGqJ4+jleC7fXABHMzBElanKBoI0gonu9N0b/VKdps6TiOj9voIg5tBLuzQrU17AzCJSyl3w3nS0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WeJYpsdE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KPqOap7oAAWDfgBIlLA+hhXhc3DGpgBlCQEjbi7Mkqg=; b=WeJYpsdE3pzRcYrUgXjXEHgq2F
	Au0hu0pqNCFmhBhQ4KGrogKlFJGZwGMtM4SyFfUKNtbHcOXXep7Vnw+z0PRJndd8b2PkadZ7Zn3Ac
	Bd44/JfmM5Zohl7D4h0zs8FSYQcvvYKs6qMG9ibpx1uCS9buAn8FVT19gnFMrXXiB2+gKId3huUSy
	Z2Zftq+4UXv2spyyS8wfG+0A+n484k0N00StfXYvvfIeI6X9PrVp1Y56s2LcwAI5R44Jnehlf0rFO
	PZ4u2QpnVH6ViWEp0fgDMWG03NWBmgbJMYFGUg1CJuVS0paDnd1njBSdL5tf7bYmwL6Z0+5iy1/L0
	Lihz29cw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1TsW-00000003aGE-0Yao;
	Mon, 29 Apr 2024 16:29:20 +0000
Date: Mon, 29 Apr 2024 09:29:20 -0700
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
Subject: Re: [PATCH v7 00/16] mm: jit/text allocator
Message-ID: <Zi_K4K-j-VB_WI4i@bombadil.infradead.org>
References: <20240429121620.1186447-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429121620.1186447-1-rppt@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 03:16:04PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Hi,
> 
> The patches are also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v7
> 
> v7 changes:
> * define MODULE_{VADDR,END} for riscv32 to fix the build and avoid
>   #ifdefs in a function body
> * add Acks, thanks everybody

Thanks, I've pushed this to modules-next for further exposure / testing.
Given the status of testing so far with prior revisions, in that only a
few issues were found and that those were fixed, and the status of
reviews, this just might be ripe for v6.10.

  Luis

