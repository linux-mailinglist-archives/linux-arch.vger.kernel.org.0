Return-Path: <linux-arch+bounces-12148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46363AC859F
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7D189D902
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBE20E6;
	Fri, 30 May 2025 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orABEw9G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888E632;
	Fri, 30 May 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564340; cv=none; b=M3n9WKcZM/jouy45uvOUx1o1IuD9GsNBUicwPvdHtsR3ErEAe85ffJRPviqWfNL1fnw4KEJ7d1Plper7QJ456WmPYMLZ3vj1l/gJP/NNeut0f1vtRsy5II5YHbo1l8MLEJdFtlBkhULjVFK+dOHDZR6HRtsCeumBFByLhHN5XOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564340; c=relaxed/simple;
	bh=fzOvslZ2yd+4RFEep1dbc5ORhnJiU65cwMbwzfxOuJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQxp6A9RY1nrq88AxmE7wiBVZX7blhSHevBzx+sojjrN0DUiFH5kI1VIOO147QRejlMXG46zd6yytpkout9LQjxGe1k0NSssh4/eqdEE84uyNF6oiE4BbTSwvBiVAYMKKQTSg9MgQEfhE1FNKvKZvQm6V6R/GLVDLuJY53UPxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orABEw9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1318DC4CEE7;
	Fri, 30 May 2025 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748564340;
	bh=fzOvslZ2yd+4RFEep1dbc5ORhnJiU65cwMbwzfxOuJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orABEw9GW8hha5WEfX4nOeo6UClo8SCkt06HiIxuvuXY7GIfYcPzgNE32XTnhzdfX
	 kKMuYGPwMqs+WLu0Qj8v4D5q6qNBKBDogc8zbaCiVXEQrnWp9+f4G6a49QkyH5AQMF
	 dDx8VrJ3wVC7iECbcZX0SpWm8aiThHGfvOpkVjVWpDL+74WBH03Q2Ykt1cb+GFASa2
	 NU60WR7MaU4No+If0hsqwvEwuY0P3bfo2S5jzwxo83RXY/5/tgfmwQm04dF8NWmBDR
	 v1DbNr/Hjp64FvFbXKbCNsalVpnA3MSbZXY5ojWWQl9zts6A8OtUTG4mPMeo4MMzkm
	 Ln6fC4JypHUAQ==
Date: Fri, 30 May 2025 00:18:58 +0000
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
Message-ID: <20250530001858.GD3840196@google.com>
References: <20250428170040.423825-1-ebiggers@kernel.org>
 <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com>
 <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
 <20250529211639.GD23614@sol>
 <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>

On Thu, May 29, 2025 at 04:54:34PM -0700, Linus Torvalds wrote:
> On Thu, 29 May 2025 at 14:16, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
> > similar), the current behavior is that ext4.ko depends on the crc32c_arch()
> > symbol.
> 
> Yes, I think that's a good example.
> 
> I think it's an example of something that "works", but it certainly is
> a bit hacky.
> 
> Wouldn't it be nicer if just plain "crc32c()" did the right thing,
> instead of users having to do strange hacks just to get the optimized
> version that they are looking for?

For crc32c() that's exactly how it works (since v6.14, when I implemented it).
The users call crc32c() which is an inline function, which then calls
crc32c_arch() or crc32c_base() depending on the kconfig.  So that's why I said
the symbol dependency is currently on crc32c_arch.  Sorry if I wasn't clear.
The SHA-256, ChaCha, and Poly1305 library code now has a similar design too.

If we merged the arch and generic modules together, then the symbol would become
crc32c.  But in either case crc32c() is the API that all the users call.

- Eric

