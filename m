Return-Path: <linux-arch+bounces-7950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8C997DEC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBA51C22B59
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F91B5ED8;
	Thu, 10 Oct 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QWjL/ef7"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF91B5821;
	Thu, 10 Oct 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543437; cv=none; b=rgLAUc2jAvi9yFot8AyeCJxqAFySikr1wYoUh62bsqNd6n+gv3Tv1Wv5041kq8DoYSbjk1W6EYVZaiQRdCqt8Vjs51FvCxJhy4bncUHJFAdpvrDTRZzlVvsgoA8vADQbgKyUrbIUZbh/W2IIjodUEue6RL3ATNQF8ckkR9qNZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543437; c=relaxed/simple;
	bh=oj/BBMw4DR0yIHfUIvM6A/ROqwO4brmjZ0ZZqDLqlW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1cbQASRMBLgayACFGHLtEGirVnAbNUPzjMBbdhoA8y3Ij6J2Jb13+Tk9l1nnI17pmKeM2Z/syfz6BR/OkY6Y/p0dgIYuim4K3Ot3vO+ROJKdntOL+UBGm8TJRQLsVIPccno1dgeX2SbNCZztyuAAh9wq/ctSDrceTjBH3jqIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QWjL/ef7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=053yPSqgX+xVLoacqjtpWuCBNx3Ew/0eqSAR54be0Yo=; b=QWjL/ef7t4NfdHQ7+ikpJ84WE6
	Tv3JStjrA26fGK50QoFCrOZKD8MPCk2cUy19aXnEhRSMGgdtvuO05QCRtCngoHhMQ33YSkxggcwcl
	/8eTdvS/gyJ8yjj4OHnjgnxJVDyZl/cUu24C1a7S1zejQqboASikt51Fh9Ntt0Smk3Slk9O/RzO4P
	HtOuCDb4Jbeh3HIGDy01x3nuah1xCKNQHjX2IUCo/yxp53VfhvoZC4lQtEWvsXnxm0vcujiphLfuA
	brUDkf5ycgRwkSBfRJX0/yVyYdmNgNWOH3sLEAXvaVdG+AQFXKlL23ma1MPX2I8m8b13OCjrlebZS
	vz4QzXyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syn6b-0000000Bl2f-08gV;
	Thu, 10 Oct 2024 06:57:01 +0000
Date: Wed, 9 Oct 2024 23:57:00 -0700
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
Subject: Re: [PATCH v5 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <Zwd6vH0rz0PVedLI@infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-7-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-7-rppt@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
> +			       struct module *mod);
> +extern void apply_retpolines(s32 *start, s32 *end, struct module *mod);
> +extern void apply_returns(s32 *start, s32 *end, struct module *mod);
> +extern void apply_seal_endbr(s32 *start, s32 *end, struct module *mod);
>  extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
> -			  s32 *start_cfi, s32 *end_cfi);
> -
> -struct module;
> +			  s32 *start_cfi, s32 *end_cfi, struct module *mod);

Please drop all the pointless externs while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

