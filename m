Return-Path: <linux-arch+bounces-12140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A4AC8260
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3660500578
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB906136347;
	Thu, 29 May 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyWCGQH8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AD360;
	Thu, 29 May 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545266; cv=none; b=aIJUOUYulZFNNWujUl5euxqIyaahYIVykzgCxeqn+LSricdNA1vGsclwLFfuF8Avu5PkwDW4sD0L/ckmJ0E7KWTT3J7TTc+DfdcDXCVDELbunI+mVmYFNhTBvxT52rHyAWMeiMFn+hRbAQI97/i817VDs/ZrQJyB8evKONhVhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545266; c=relaxed/simple;
	bh=HpaSpxKPSTcKVq++ch2t3YrzhRTS1hIvLrLQoyh88o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grxrv5liZ9++TLev/ugZxdMfs7bwY9ZDSa94On5at/ucKwgZwEUw8cLuHL1wah13EIuR2ODDcu3hnsRNjUjy1PqneKf28BZYGvewDrQeJUDRHvvSxlOuiuqrN9gnasitTtDAW/0HZOU79Bkc/444RnuoliR+4MnGUgAHZ+Y7Hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyWCGQH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDDBC4CEE7;
	Thu, 29 May 2025 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748545266;
	bh=HpaSpxKPSTcKVq++ch2t3YrzhRTS1hIvLrLQoyh88o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyWCGQH8aj3D49i85BBT7NPpHwUvBNW7d1DfFwr/mwzpOzC5U7+XTtZFiWWAe14Ze
	 nhqUnY10VFWI+BKCwfDErzkzVF4tXKboIXWPiF3WPOTJTPo6c+6cM21vYBpUrO9/mN
	 sMPsJ3m64/v4Q+P8hT3rYcwitHqZ5dt7G3sw8nq+u/W/ReCZeRlJwpyZh0Wsr22aAX
	 xQCMSf21bnDaIcGcTdDvZ4CZK1D78q6RaISBNlaQveskEp46EPZFsHeJR4y/IBHKmc
	 NYuNP8oMHiKaatq8+i4kWnfFu6o59oSDZxsb5ZVDoCGlE7dj6qoySYQY8lweYQvnUH
	 TG5FI1zL6wzOg==
Date: Thu, 29 May 2025 12:00:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
Message-ID: <20250529190048.GA23614@sol>
References: <20250428170040.423825-1-ebiggers@kernel.org>
 <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com>
 <20250529173702.GA3840196@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529173702.GA3840196@google.com>

On Thu, May 29, 2025 at 05:37:02PM +0000, Eric Biggers wrote:
> On Thu, May 29, 2025 at 11:05:26AM -0600, Alex Williamson wrote:
> > On Mon, 28 Apr 2025 10:00:33 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Instead of providing crypto_shash algorithms for the arch-optimized
> > > SHA-256 code, instead implement the SHA-256 library.  This is much
> > > simpler, it makes the SHA-256 library functions be arch-optimized, and
> > > it fixes the longstanding issue where the arch-optimized SHA-256 was
> > > disabled by default.  SHA-256 still remains available through
> > > crypto_shash, but individual architectures no longer need to handle it.
> > 
> > I can get to the following error after this patch, now merged as commit
> > b9eac03edcf8 ("crypto: s390/sha256 - implement library instead of shash"):
> > 
> > error: the following would cause module name conflict:
> >   crypto/sha256.ko
> >   arch/s390/lib/crypto/sha256.ko
> 
> Thanks for reporting this.  For now the s390 one should be renamed to
> sha256-s390, similar to how the other architectures' sha256 modules are named.
> I'll send a patch.
> 
> Long-term, I'd like to find a clean way to consolidate the library code for each
> algorithm into a single module.  So instead of e.g. libsha256.ko,
> libsha256-generic.ko, and sha256-s390.ko (all of which get loaded when the
> SHA-256 library is needed), we'd just have libsha256.ko.  (Or just sha256.ko,
> with the old-school crypto API one renamed to sha256-cryptoapi.ko.)  A lot of
> these weird build problems we've been having are caused by the unnecessary
> separation into multiple modules.
> 
> - Eric
> 

Patch sent: https://lore.kernel.org/r/20250529185913.25091-1-ebiggers@kernel.org

- Eric

