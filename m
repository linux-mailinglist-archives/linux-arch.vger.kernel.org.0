Return-Path: <linux-arch+bounces-7946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1495997DB1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493F91F22A65
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794371A42D8;
	Thu, 10 Oct 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pkikn0l9"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F71A304A;
	Thu, 10 Oct 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543278; cv=none; b=iMvNaFF8ND0bgz9noAMf/4zIpvXZ/Wen7jAJKqgUjFDdupPmR4X3nvzNx6c4XCBDmHln5YhPUwl8IB9UpmK28nccAiuG0h6iyZmheDN0phz2lpU+xv+UjJ1ddClb/4VTnwIhqAmsPiTek/GVWBj/5bc16MPC8PNh9GdLaRrqf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543278; c=relaxed/simple;
	bh=YQimVMZqPQ8HeavdLfQUBaFM7vHD1wKidCLf9+Spd54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaS/c2YhsmVTtmomqXvq/VaPFsQHr6SJQjqlFG+QgoLllwb6ko8y60uG1ZjAUcNtH2QVWd7R8s91kwCvoLdwXM+HMBk8Lo3Ul33opxYPY/GgY6g1oavmT+YQLTOKZ0Krb+Mle8Xm0OC46Q0dZvN83x3M8Iq7QtyTR/jWdOwY1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pkikn0l9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l9uqvIs7KaBM8jKZiiP+47rSYlM+HcdGDx8MG0uieP0=; b=Pkikn0l9YV6IbkwdMYYYCh7NS0
	+bbHbF45MU5mE1Rb3r9FII7FXayka1iyxVG7DxF8G4bp4UvbmBPvBXdRuLXOELz0YXQIDC8U5Vn/Z
	p9TLWCXHDeIkv9jMspqGVrsh6ZAZflPmbSh+0Buo8JVPN3NtIEsSbcNt5fO4pYKDvwm0BaYhbAo+N
	oNRfxee9fN9eH5HZGZktQTD2xofG2NZkmjD02X0R0ddOsfVe32xN+q0mOP5NTLyXNDy/F9gYSQgQ6
	a6T7FZrz/gQpO3gePE4DR+RzB3Q5ElwqokanAq8dbu2GoF4JKzdy2n24Yyu3ivAljHZfXKQHFYvVQ
	fygr48vQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syn3r-0000000BkI0-1JPh;
	Thu, 10 Oct 2024 06:54:11 +0000
Date: Wed, 9 Oct 2024 23:54:11 -0700
From: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v5 1/8] mm: vmalloc: group declarations depending on
 CONFIG_MMU together
Message-ID: <Zwd6EwZ67lC3oxZ2@infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-2-rppt@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 09, 2024 at 09:08:09PM +0300, Mike Rapoport wrote:
> +/* for /proc/kcore */
> +extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
> +
> +/*
> + *	Internals.  Don't use..
> + */
> +extern __init void vm_area_add_early(struct vm_struct *vm);
> +extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);

Please drop the externs while you're at it. (one more down below)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

