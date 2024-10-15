Return-Path: <linux-arch+bounces-8154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2699DD17
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 06:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A336D28346A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 04:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1781714C9;
	Tue, 15 Oct 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SY5JMHuh"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8129B0;
	Tue, 15 Oct 2024 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728965422; cv=none; b=eCBJyvZNMFtG78gz7G3ReHiZfgKOgzeL4+1pv8CjQ3YDIst6oUCaaffRmVnX5q5RJAk1pDHwvKt7TPbJDb/BxUQ2g2nnsbrakRv9QO27jNn0j9yn58r1+J42X6XPVtUu5EBPV8xyk6F2CZSycy6yqDBgjEobkCt9TdCjwcZxA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728965422; c=relaxed/simple;
	bh=bP0ydmliT7A3C7Nd/bJhXr4/VtNYgg6ylmhoq0xGHpY=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQUmHdvaFUPapNPxRCsSofsP567Lc076JUulSfTjFILa8xUjdSpikskWepIQLWevLjpdrS2rTtKN1SavQNxGUp56Z3OLvwMrCiUDm9IO3lKYVfrio8QU8n+zUCfjPTyJIZ7RuCsYjdPEnbmAwEiwFe17WlO9yy9A0vj7HfxN7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SY5JMHuh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:From:Date:Reply-To:To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7oo0+NFzG0+ifufE/qqCDtaU5giwdXfO9PmS95o7Kt8=; b=SY5JMHuh/AAausEpvgqOw55iPl
	Y8ImNtY8lwsSme/gxOUJfn+PUpLmjBiImSQW8MgRsf/JwD2ylancbB7Oiq7Nb5pI/K+nL0VSslrVN
	XGZDs/pfzl9qkHw9zhppqbh0CIlkbpip4FIfw3Q96wZIQ5RtgU7B+aKjPOAFhQgdyxWZRFKmjWNzj
	aB4GXacLxjCnOdKJuBNHg1xEqeG82y6hoDUIzs0VCnES/acA9z0GNZHDId+EQ6f5sxmB59pJt+3Ij
	lUGVImtl2K8gDkfxbjwy4dLx6Um+jtshEo5c8RK27ua6rOKWJTnZIKd2v54UPxT1P/adSb9eBKXwh
	o8CW4uBg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0YsX-000000071rX-3MXJ;
	Tue, 15 Oct 2024 04:09:49 +0000
Date: Mon, 14 Oct 2024 21:09:49 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
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
Message-ID: <Zw3rDS3GRWZe4CBu@bombadil.infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
 <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

Mike, please run this with kmemleak enabled and running, and also try to get
tools/testing/selftests/kmod/kmod.sh to pass. I run into silly boot issues
with just a guest.

  Luis

