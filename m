Return-Path: <linux-arch+bounces-15661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70729CF4B26
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 198113077451
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED53128B9;
	Mon,  5 Jan 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMWzCZfl"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416062F617F;
	Mon,  5 Jan 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629212; cv=none; b=rpewPv8jfcIby6NT8e9c7d4AEPYsobxFuq85NLer9L11tr78vRUYhNOkUEpbpTQwIQnA79wOZFgV0rm3+wTk7D24Lg2t3agiFUYLFdJgroQ1a0ktnXG6LpamBiUsIJMqJiWPH2j/uModRRdPmh+ORCRJeo3wVnwu8NgDfjNlz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629212; c=relaxed/simple;
	bh=YbTzSLHhAYmijkZzLivGtQAooxHiC482fredUCLKpoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxMJazQfUc1QniG7r41ygBno0dMjbjpY5kiaRG3LYQ58Zh8GwwdnIj5lZH3NZ28XDGQxcGsseQNesw8Y/mPeH3WdZbhfbsOBOvybYEWPOCwuHAscOLLMltE/yRF4ybpc1rCPncWbMhMwmDR55fbfG50J4MHWNCUgwAHSMAuhzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tMWzCZfl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q0iBjd0YhfUVfWpbsXjI9nH/GWQSV+La52Wwa31/MwE=; b=tMWzCZflW02SCaNW7kWwaei/9l
	2iZYWSIRisarrGeEtb/0fssNor+4XKmmeSwG4Z7SZ3GoulKyTNSTXqQgqAbFb07lz/bBJGmW/l/Ow
	PnhtFeHqMAh2sjb95AkYN4s5/LGvnh8OACL2pNXdZJqa+njMBaln0knjUNVQiK/25kIYWg5y+OMgM
	7W8D128qAFJ/KIDLzDrjlWs90qJT7Vap7sgZgFOIrh9Rz5nSLnsJHAkXPDupR5aHmQ1N3o5jAbRnk
	ETPmV6izqQ6+v1RAzFDqDSpYbc5RLfWmcHg2z8H8bHwGwYs7K+pNN4Gz8pIOo9LWGqd6hU62BkH+e
	4vlw5U7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcn6J-0000000AaHB-2Zs5;
	Mon, 05 Jan 2026 16:06:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A02D0300E8E; Mon, 05 Jan 2026 17:06:34 +0100 (CET)
Date: Mon, 5 Jan 2026 17:06:34 +0100
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
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 3/4] atomic: Add alignment check to instrumented
 atomic operations
Message-ID: <20260105160634.GA2393663@noisy.programming.kicks-ass.net>
References: <cover.1767169542.git.fthain@linux-m68k.org>
 <f8cfe0d121be0849f5175495e73eafeeb85e1ad3.1767169542.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cfe0d121be0849f5175495e73eafeeb85e1ad3.1767169542.git.fthain@linux-m68k.org>

On Wed, Dec 31, 2025 at 07:25:42PM +1100, Finn Thain wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add a Kconfig option for debug builds which logs a warning when an
> instrumented atomic operation takes place that's misaligned.
> Some platforms don't trap for this.
> 
> [fthain: added __DISABLE_BUG_TABLE macro.]
> 
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Checkpatch.pl says...
> ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'
> ---
> Changed since v5:
>  - Add new __DISABLE_BUG_TABLE macro to prevent a build failure on those
> architectures which use atomics in pre-boot code like the EFI stub loader:
> 
> x86_64-linux-gnu-ld: error: unplaced orphan section `__bug_table' from `arch/x86/boot/compressed/sev-handle-vc.o'

Urgh, so why not simply use __DISABLE_EXPORTS, that's typically (ab)used
for these things?

Also, unless __DISABLE_BUG_TABLE goes live inside asm/bug.h and kills
all __bug_table emissions, its a misnomer.

Furthermore, that SEV thing is broken and needs to be fixed anyway, this
isn't helping it much. noinstr code should not be using instrumented
things to begin with.

