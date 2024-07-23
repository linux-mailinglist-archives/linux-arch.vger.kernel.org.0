Return-Path: <linux-arch+bounces-5591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6093A268
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076871C22375
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996A1514EE;
	Tue, 23 Jul 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8GmUkxE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FB139CEE;
	Tue, 23 Jul 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744206; cv=none; b=Fv4/+0MIqXOzJYCV/g4389salnhXlyu3t62wFVC3rggUcDrESw4sZsBr3lOsoxdH7oT/y5YdiRLaZWeQ4SzXJtmWgPn1zU7GM172gP6icQGWnvFmS1HiEQ3G1DycdWaPbv7D8tf/ShlKXxJnRy4wipHciEMTJpUgtZfwvcXruug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744206; c=relaxed/simple;
	bh=1NmQUjCjX2CORNW2EbzYdrnjMQxLTnASH0DH4yM2MXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cnk+vxnCACGafAi6oMunrY9MTmO53lc6QM9buVVkW73vMMlxWCZ+5E+XkinIvCrEH6bDzCfI+P05i7q31r2qDlIo8fEYBoAUs6ofUCvfTbhHdl0r54da7pq+7RrAMu+NnXuhvuUQ8CF+DPC8yMFXj/T2AMNcU2uTTCKkHHRiWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8GmUkxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E017C4AF0A;
	Tue, 23 Jul 2024 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744206;
	bh=1NmQUjCjX2CORNW2EbzYdrnjMQxLTnASH0DH4yM2MXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8GmUkxEaPhzIWe/Uwp0/nke16W42Xqyz+YNk8rGF/xQoQfmOWCBfIh2ElBZEqbI8
	 j922EY72ISv+su6t7yVtZ7es+BGJa9T3V9DPRLlRqnNND2WZuYM4Ooc2zxgeyCK32r
	 4ysfZYG51JbdaE/Yza0k176zZ6pqnh5BJs+t2ce8kj+URW2P1DgronK5jJjLOVov2h
	 sEMLBQd0VJMPhzHB/BPQ/4dcE0IGP2Aq8uplTQaMo34n2tT2CFqeGJbj98AAGM1Y9S
	 m13OiVGg45x+8ha/GIdfXwMfBJU27H1CZjvfJMI7GnWqYZw2FSXASZHpjvEDsW+D77
	 /1nMF8ebhIU2g==
Date: Tue, 23 Jul 2024 15:16:40 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20240723141640.GA26137@willie-the-truck>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com>
 <20240705112502.GC9231@willie-the-truck>
 <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
 <20240708135243.GA11898@willie-the-truck>
 <ZowGLMX1xpuxlpqA@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowGLMX1xpuxlpqA@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 08, 2024 at 04:30:52PM +0100, Mark Rutland wrote:
> On Mon, Jul 08, 2024 at 02:52:43PM +0100, Will Deacon wrote:
> > On Fri, Jul 05, 2024 at 10:58:29AM -0700, Linus Torvalds wrote:
> > > On Fri, 5 Jul 2024 at 04:25, Will Deacon <will@kernel.org> wrote:
> > > So on x86-64, the simple solution is to just say "we know if the top
> > > bit is clear, it cannot ever touch kernel code, and if the top bit is
> > > set we have to make the address fault". So just duplicating the top
> > > bit (with an arithmetic shift) and or'ing it with the low bits, we get
> > > exactly what we want.
> > > 
> > > But my knowledge of arm64 is weak enough that while I am reading
> > > assembly language and I know that instead of the top bit, it's bit55,
> > > I don't know what the actual rules for the translation table registers
> > > are.
> > > 
> > > If the all-bits-set address is guaranteed to always trap, then arm64
> > > could just use the same thing x86 does (just duplicating bit 55
> > > instead of the sign bit)?
> > 
> > Perhaps we could just force accesses with bit 55 set to the address
> > '1UL << 55'? That should sit slap bang in the middle of the guard
> > region between the TTBRs
> 
> Yep, that'll work until we handle FEAT_D128 where (1UL << 55) will be
> the start of the TTBR1 range in some configurations.
> 
> > and I think it would resolve any issues we may have with wrapping. It
> > still means effectively reverting 2305b809be93 ("arm64: uaccess:
> > simplify uaccess_mask_ptr()"), though.
> 
> If we do bring that back, it'd be nice if we could do that without the
> CSEL+CSDB, as the CSDB is liable to be expensive on some parts (e.g.
> it's an alias of DSB on older designs).

DSB?! Are you sure? I thought it was basically a NOP for everybody apart
from a small subset of implementations.

Will

