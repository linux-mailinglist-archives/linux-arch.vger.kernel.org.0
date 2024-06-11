Return-Path: <linux-arch+bounces-4839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2469045B1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 22:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72582B22778
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DFD7F49B;
	Tue, 11 Jun 2024 20:22:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFD639;
	Tue, 11 Jun 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137358; cv=none; b=j7cGGXcgk79cW7XU7JuPzmIkz7LOhGZH+lp/HtsmuicatAeez8INYXIV36gga0CRJAO0H4xuDK3YSObGVzk6E0TCbM0u/j8Ey994D/BqZgMYpUCOicwIu3jSir+UCHJdjNQRPh0ZeE6AhF05qbC42HZiuW6nmLvhvTmyYDowG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137358; c=relaxed/simple;
	bh=ADVyi3gtsxEt8iNfxhJM26ydN47s4hPau4g5PTZylJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p76LrqndlMBRZDRXs8YkXY4o90y4nXJWhopgIEWO4gP8g0X3uHRiU+WdvOtpJ572fTFZ2ju46LXWFH0x6vhMjiIoR4vDwEjGmogRPY8nJN3XzHoGruq6EPXTJgKjQVY2fvmCEGSIFM6QEzK0hYCNmx4KKbJPc7e5Ue88+NQCYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B03E1152B;
	Tue, 11 Jun 2024 13:22:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8483F5A1;
	Tue, 11 Jun 2024 13:22:32 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:22:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
Message-ID: <ZmiyA3ASwk7PV3Rq@J2N7QTR9R3>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org>
 <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
 <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
 <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>

On Tue, Jun 11, 2024 at 11:59:21AM -0700, Linus Torvalds wrote:
> On Tue, 11 Jun 2024 at 10:59, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'll look at doing this for x86 and see how it works.
> 
> Oh - and when I started looking at it, I immediately remembered why I
> didn't want to use alternatives originally.
> 
> The alternatives are finalized much too early for this. By the time
> the dcache code works, the alternatives have already been applied.
> 
> I guess all the arm64 alternative callbacks are basically finalized
> very early, basically when the CPU models etc have been setup.

On arm64 we have early ("boot") and late ("system-wide") alternatives.
We apply the system-wide alternatives in apply_alternatives_all(), a few
callees deep under smp_cpus_done(), after secondary CPUs are brought up,
since that has to handle mismatched features in big.LITTLE systems.

I had assumed that we could use late/system-wide alternatives here, since
those get applied after vfs_caches_init_early(), but maybe that's too
late?

> We could do a "late alternatives", I guess, but now it's even more
> infrastructure just for the constants.

Fair enough; thanks for taking a look.

Mark.

