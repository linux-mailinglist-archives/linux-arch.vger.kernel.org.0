Return-Path: <linux-arch+bounces-8017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C0999E3E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BB91F244FD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453120A5F0;
	Fri, 11 Oct 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNzRRI+j"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CF20ADF7;
	Fri, 11 Oct 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632817; cv=none; b=EwtJMNgEZXS7b3TkSK0ceUIqB7HqhaOWMA8VhsJD1ArT2feFxe7xbvxGgdQgZQOt3tP8HVGafP+biFA/lutrI+7sjaF1alR14IYl7t3F6OwI6UPQD/puTO7WR01dNVq55mkrhYvW4c0zGKm37ffodSUhCwTDz+EcUjsX3K9rHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632817; c=relaxed/simple;
	bh=HQSSCIywenQzOJiT5UPu5auwm7k09dThmwbWbEkcmME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRVVmLHA6vlvg3GNNwU29K8s4zKY5o6vpQCX7BHujj6SixX8gEFBWHnkKCdYg1X7HDeFdJTjnftzCKfqFxVUvnenynNZLFTTY/Jj8C03I12Cc/AfuSCNvc13VW2jb5e269zErDTpESQl0IDKuxG5gXwNur1l6CYClUQtIvhNsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RNzRRI+j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HlhUCBO2cgAocJ0jal2+odmhS3fEGMT9ApCG3YBalmk=; b=RNzRRI+jS+E41pEvv2tM/PBMQr
	SQs+GEy9wRlJQS7LgwXIlsLPiOEfZ0lcfVl/LZAzCmJERr/wrGQx/6Jkm+z665nLQ1YxAvvKLbZgJ
	K836flQdGWfRcahrgPWsGgbE2Kv46RlU2j9210RhGvDmBYmeahOdJixtpW4jFIpXAj2/1kuIqVUzm
	9UeGFlwfEh13tOOBCEhTCdOmFs+NkVHulOmWBcYiyIrEdETWz96sC8sQ5hitRuikUOylqpHtAubjX
	bIdwQSiSdX8D+zYfq6nK2YaptkNRLX5ebrdQ9hI/fijT9vdqmXxkPzbZ/e0uearFNRK9I5GNV8P5M
	+7qkIbyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szALv-0000000Faln-258j;
	Fri, 11 Oct 2024 07:46:23 +0000
Date: Fri, 11 Oct 2024 00:46:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
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
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <ZwjXz0dz-RldVNx0@infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfPPZrxHzQgYfx7@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 10, 2024 at 03:57:33PM +0300, Mike Rapoport wrote:
> On Wed, Oct 09, 2024 at 11:58:33PM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 09, 2024 at 09:08:15PM +0300, Mike Rapoport wrote:
> > >  /**
> > >   * struct execmem_info - architecture parameters for code allocations
> > > + * @fill_trapping_insns: set memory to contain instructions that will trap
> > >   * @ranges: array of parameter sets defining architecture specific
> > >   * parameters for executable memory allocations. The ranges that are not
> > >   * explicitly initialized by an architecture use parameters defined for
> > >   * @EXECMEM_DEFAULT.
> > >   */
> > >  struct execmem_info {
> > > +	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
> > >  	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
> > 
> > Why is the filler an indirect function call and not an architecture
> > hook?
> 
> The idea is to keep everything together and have execmem_info describe all
> that architecture needs. 

But why?  That's pretty different from our normal style of arch hooks,
and introduces an indirect call in a security sensitive area.


