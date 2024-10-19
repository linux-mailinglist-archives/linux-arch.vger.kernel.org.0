Return-Path: <linux-arch+bounces-8289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2FD9A514D
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 00:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B153E1C21A73
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 22:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F86192D60;
	Sat, 19 Oct 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNM1wyZQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57B19258E;
	Sat, 19 Oct 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729376369; cv=none; b=sUBCeUSNzoSlVbJCupLYefThBrCQ9Bc1gbU9bPojhYKPurp5QGvZv00Mv172muSYp6OchuGRp1RxSoi7aVTMFPrzhx6S9qLz2lvdtFKOFIGqfL5VKVnzstvSVnPbMB+T4PHNGChltQ9QRLKdDC55ZrQ9tS4xrzlA3hRxpexgI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729376369; c=relaxed/simple;
	bh=daUc5xecu7xI5c+UkC320lN7WO6Pv9zdDCfjUjy8L1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3Z4LhLxa1zY0ozplyFw9ACUh4Mi+SCmQaIjc8hhjye5JOSBp/AjMAW/fm9QFcOb75ZRZu29VkyLdw8nU0+MyhdXzJlL4SRYgp7gXOQ+ZT1jK4g84BgNW7EfCEFVngYdK88iJIw0pKgquhXDL2rLcxPNNEcrcqpQ62F4FJqRVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNM1wyZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B925C4CEC5;
	Sat, 19 Oct 2024 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729376368;
	bh=daUc5xecu7xI5c+UkC320lN7WO6Pv9zdDCfjUjy8L1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNM1wyZQW4Fo3UYmtYtZPgjiHgu/H4XI/+27SeHDRGuyHhrsjIEj389botXDz7xzU
	 oRoliDromsIEdrwgMdf3d6+NrBy7bXYMTE2T/8I1/d4kB9gjHsLS/MIoIKs8EASeaT
	 aBxIiobIWyjFiwv9/poZDmy2HqvjFhixH+91U8zwdcdRhqXgTkEFbn2iL08Ol1J7ou
	 HP420DfIrrmCeqEBftQC/r/u9iEdCqnooHwASpRmuOZ6oVBWARW5PE0Gis4BiiIMsJ
	 95hjSW/bv4/gU/7p/7MsytMe7tkh0nWplVzjhpV678uD6QoJdFyqaGyiUG8CRghoje
	 30qArBjHZQnlg==
Date: Sat, 19 Oct 2024 15:19:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/8] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Message-ID: <ZxQwbXh5v7eJmuyh@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-3-rppt@kernel.org>

On Wed, Oct 16, 2024 at 03:24:18PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explicitly
> specify node ID will use huge pages only if size_per_node is larger than
> a huge page.
> Still the actual allocated memory is not distributed between nodes and
> there is no advantage in such approach.
> On the contrary, BPF allocates SZ_2M * num_possible_nodes() for each
> new bpf_prog_pack, while it could do with a single huge page per pack.
> 
> Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
> NUMA_NO_NODE and use huge pages whenever the requested allocation size
> is larger than a huge page.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

