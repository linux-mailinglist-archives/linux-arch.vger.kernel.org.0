Return-Path: <linux-arch+bounces-12283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDFAD15FA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD607A47C5
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC721EF363;
	Sun,  8 Jun 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPyWCyBV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA32A1BA;
	Sun,  8 Jun 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749426428; cv=none; b=eY13bqOt1otnbRfiWTVhhFindziCBaaPJgSxUdXb+kI79h1g9D070YXOEO1+ivv/fTGMQ1GN1DGji25sRfLWS00OI5HT0rNoKGmbJlY9ReD2VjUV+pYWsu0RlUtrv5T2PfVgBrLkNbFjRlyhZtAGsv0MIQ4CJAMhNUE4c9odA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749426428; c=relaxed/simple;
	bh=He/qqF7BxEbAQ+KhVIwOAYIjY3DpawZEJHr+Xte/K6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+Ot9BiVeE5ljmtAe79J1zJs6TToDtCY2+e+9UinX7wo/NhU3KvvUcYOe1RSjiGKhkmAThp0HscSwHTA6eV+lseOUELhNknSeTOKRbd1uqR8qWNv06qsSe8pt74CGaXHhrVFmIGYkq4zLvERtVUhpwPKWgw6maqGQlAt5qww9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPyWCyBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8491AC4CEEE;
	Sun,  8 Jun 2025 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749426428;
	bh=He/qqF7BxEbAQ+KhVIwOAYIjY3DpawZEJHr+Xte/K6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPyWCyBVPXpu72efvExgg8gLAw9penLyFzlo1qRsspsqyd4JZoFxW7hHQvlnEtIIa
	 1BxGaS04c9RuFEve+dtCt1LEb2SSISR2VgjLm0WYXRDHNt8nXsOorMQAj8PjQpmAB0
	 F5rfSxl/09kNUJny72FkrWqXDDqrWHkySwoyI3r23w9s9UZxhxYgVcxmIH21znQLYr
	 RAY4VaCbmTRnWUl2bEewz1enz7kzJYX9fFC9W66bUVBifTQ9wgF652vwOiRoE9mHCR
	 SyixTBnJQbaXXeJQKz8gWyl2YRqW1kNgBMYmIhv1mCruOadbFAPFkGtBFHhXGzcMB6
	 +EWaHxDKp/9YA==
Date: Sun, 8 Jun 2025 16:46:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/13] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <20250608234646.GE1259@sol>
References: <20250601224441.778374-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601224441.778374-1-ebiggers@kernel.org>

On Sun, Jun 01, 2025 at 03:44:28PM -0700, Eric Biggers wrote:
> This series improves how lib/crc supports arch-optimized code.  First,
> instead of the arch-optimized CRC code being in arch/$(SRCARCH)/lib/, it
> will now be in lib/crc/$(SRCARCH)/.  Second, the API functions (e.g.
> crc32c()), arch-optimized functions (e.g. crc32c_arch()), and generic
> functions (e.g. crc32c_base()) will now be part of a single module for
> each CRC type, allowing better inlining and dead code elimination.  The
> second change is made possible by the first.
> 
> As an example, consider CONFIG_CRC32=m on x86.  We'll now have just
> crc32.ko instead of both crc32-x86.ko and crc32.ko.  The two modules
> were already coupled together and always both got loaded together via
> direct symbol dependency, so the separation provided no benefit.
> 
> Note: later I'd like to apply the same design to lib/crypto/ too, where
> often the API functions are out-of-line so this will work even better.
> In those cases, for each algorithm we currently have 3 modules all
> coupled together, e.g. libsha256.ko, libsha256-generic.ko, and
> sha256-x86.ko.  We should have just one, inline things properly, and
> rely on the compiler's dead code elimination to decide the inclusion of
> the generic code instead of manually setting it via kconfig.
> 
> Having arch-specific code outside arch/ was somewhat controversial when
> Zinc proposed it back in 2018.  But I don't think the concerns are
> warranted.  It's better from a technical perspective, as it enables the
> improvements mentioned above.  This model is already successfully used
> in other places in the kernel such as lib/raid6/.  The community of each
> architecture still remains free to work on the code, even if it's not in
> arch/.  At the time there was also a desire to put the library code in
> the same files as the old-school crypto API, but that was a mistake; now
> that the library is separate, that's no longer a constraint either.
> 
> Patches 1 and 2, which I previously sent out by themselves, are
> prerequisites because they eliminate the need for the CRC32 library API
> to expose the generic functions.
> 
> Eric Biggers (13):
>   crypto/crc32: register only one shash_alg
>   crypto/crc32c: register only one shash_alg

Applied the first 2 patches to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

The remaining patches have new versions in the v2 series.

- Eric

