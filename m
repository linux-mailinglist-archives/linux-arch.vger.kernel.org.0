Return-Path: <linux-arch+bounces-12179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B6ACA10D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 01:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA5171168
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC922356BA;
	Sun,  1 Jun 2025 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHFxc2VE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EE190696;
	Sun,  1 Jun 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748818836; cv=none; b=Hzi7BbTPXekyFGIG3Y/Hsh85Tlitt3JZN9bO2ffT/k1J/ZAszndm+26nK3jLyGUERuwxyx75nXGJJ4ZeVO+K2Ihzs2gPadu3cFznmq4bTASn8SXYdneJjgKUi5Hi80nfVWTCjZnf18ciFOG02g1C4Ya6evA2h3h309I8BMuG3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748818836; c=relaxed/simple;
	bh=9iuAqFgWuAM8zbaClmJE1PWkDiz9aDszJI49BnUralg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkV/L9mOeKnECfMVYjcgH2DpCnOQ/iOCbx1SwZHNmPRFVwPfHP0JoJwQ2OmWOUYs6xEMP/BRxXaM5GBKHtFw7MelaX/tgp5ylhkA0yBSTEVHXVSH7TlT8JHQ/JMRonxJTsAtePzc3XSyuznFmz4ThijOhrriVXwoXf3ELvdM4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHFxc2VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CC5C4CEE7;
	Sun,  1 Jun 2025 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748818833;
	bh=9iuAqFgWuAM8zbaClmJE1PWkDiz9aDszJI49BnUralg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHFxc2VElAHlFA2+p6pUxtFWEe5J4xv+o56KAxPCmT8t7sop9JD+tvRSV5M6+149b
	 3yslurmUrK9306e+AjqkjU66ZE4+J12qO4pfC9GKOwcLYIKirbFU/Rg2oRbbVA43ns
	 5uDfSlrlHs9e9hvwYN9GazeDaNtZ3XeMSpkJHQHb3lkfbDihKnyqOzItzJyKZ/V5SA
	 kll91RZkjqNe9evwrPUGhmeKBh/iuKFMYirrTrajg0Qa5HWH48c/p5D7scSRNhf3bP
	 g9JW0K0QMuooWlvxhFXufeAQiYS/ENsn141k7rnLZBFnOMguZuObdXNfv/1/r4saJT
	 S2ckVl3S2NSgA==
Date: Sun, 1 Jun 2025 16:00:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
Message-ID: <20250601230014.GB1228@sol>
References: <20250428170040.423825-1-ebiggers@kernel.org>
 <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com>
 <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
 <20250529211639.GD23614@sol>
 <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
 <20250530001858.GD3840196@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530001858.GD3840196@google.com>

On Fri, May 30, 2025 at 12:18:58AM +0000, Eric Biggers wrote:
> On Thu, May 29, 2025 at 04:54:34PM -0700, Linus Torvalds wrote:
> > On Thu, 29 May 2025 at 14:16, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
> > > similar), the current behavior is that ext4.ko depends on the crc32c_arch()
> > > symbol.
> > 
> > Yes, I think that's a good example.
> > 
> > I think it's an example of something that "works", but it certainly is
> > a bit hacky.
> > 
> > Wouldn't it be nicer if just plain "crc32c()" did the right thing,
> > instead of users having to do strange hacks just to get the optimized
> > version that they are looking for?
> 
> For crc32c() that's exactly how it works (since v6.14, when I implemented it).
> The users call crc32c() which is an inline function, which then calls
> crc32c_arch() or crc32c_base() depending on the kconfig.  So that's why I said
> the symbol dependency is currently on crc32c_arch.  Sorry if I wasn't clear.
> The SHA-256, ChaCha, and Poly1305 library code now has a similar design too.
> 
> If we merged the arch and generic modules together, then the symbol would become
> crc32c.  But in either case crc32c() is the API that all the users call.
> 
> - Eric
> 

I implemented my proposal, for lib/crc first, in
https://lore.kernel.org/lkml/20250601224441.778374-1-ebiggers@kernel.org.
I think it's strictly better than the status quo, and once applied to lib/crypto
it will solve some of the problems we've been having there too.  But let me know
if you still have misgivings.

- Eric

