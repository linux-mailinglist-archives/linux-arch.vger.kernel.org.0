Return-Path: <linux-arch+bounces-5318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F692A5B0
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DFE1F21D08
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE21E89A;
	Mon,  8 Jul 2024 15:30:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25E1E4AD;
	Mon,  8 Jul 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452659; cv=none; b=OkPaoOVvn1poh9RruD7Sm87kIbpJhdEvYybsaBV2sFnPJuHI+KJwYLqTWNvyHz/1/YhLcNdIJCJB0/Sgvw86bRPD3GQcS2Rj4vIXJX+G7hCTd5CxAfJnxd7IkGDznTOqnl/7R+R83hMcyLgF/QFYTC6y34rjKM5U5QfCSqZ6XGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452659; c=relaxed/simple;
	bh=Lwo56LEJ+JzdObtQ/rKRAwmMqlyi5w4m3mqotYQ3LZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6/DZkX0ZccI9/uVEi6xgOKCgxZQsQQ1S/QWVxumZR9FcQ1WbTany3LdpYW2slzZtLoThpRT6Z1KGJU9PZN42Nzk3c4LD1BNN9UeLq7n/GpT66838sjQrEnc07hWtKg3UK/e4ESy6vi1hr8PEtnPMUglbD2uvhA4ZldFh+fZut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080AB1042;
	Mon,  8 Jul 2024 08:31:22 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FE03F641;
	Mon,  8 Jul 2024 08:30:54 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:30:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Message-ID: <ZowGLMX1xpuxlpqA@J2N7QTR9R3>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com>
 <20240705112502.GC9231@willie-the-truck>
 <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
 <20240708135243.GA11898@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708135243.GA11898@willie-the-truck>

On Mon, Jul 08, 2024 at 02:52:43PM +0100, Will Deacon wrote:
> On Fri, Jul 05, 2024 at 10:58:29AM -0700, Linus Torvalds wrote:
> > On Fri, 5 Jul 2024 at 04:25, Will Deacon <will@kernel.org> wrote:
> > So on x86-64, the simple solution is to just say "we know if the top
> > bit is clear, it cannot ever touch kernel code, and if the top bit is
> > set we have to make the address fault". So just duplicating the top
> > bit (with an arithmetic shift) and or'ing it with the low bits, we get
> > exactly what we want.
> > 
> > But my knowledge of arm64 is weak enough that while I am reading
> > assembly language and I know that instead of the top bit, it's bit55,
> > I don't know what the actual rules for the translation table registers
> > are.
> > 
> > If the all-bits-set address is guaranteed to always trap, then arm64
> > could just use the same thing x86 does (just duplicating bit 55
> > instead of the sign bit)?
> 
> Perhaps we could just force accesses with bit 55 set to the address
> '1UL << 55'? That should sit slap bang in the middle of the guard
> region between the TTBRs

Yep, that'll work until we handle FEAT_D128 where (1UL << 55) will be
the start of the TTBR1 range in some configurations.

> and I think it would resolve any issues we may have with wrapping. It
> still means effectively reverting 2305b809be93 ("arm64: uaccess:
> simplify uaccess_mask_ptr()"), though.

If we do bring that back, it'd be nice if we could do that without the
CSEL+CSDB, as the CSDB is liable to be expensive on some parts (e.g.
it's an alias of DSB on older designs).

> Dunno. Mark, Catalin, what do you guys reckon?

I think there's a slight variant of the x86 approach that might work,
I've posted in my reply at

  https://lore.kernel.org/lkml/ZowD3LQT_KTz2g4X@J2N7QTR9R3/

Mark.

