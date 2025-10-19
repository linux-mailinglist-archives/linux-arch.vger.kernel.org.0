Return-Path: <linux-arch+bounces-14195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD598BEE9C4
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F73AD543
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B92EBB93;
	Sun, 19 Oct 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2EokHRL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E851A00F0;
	Sun, 19 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891120; cv=none; b=XHqLF6dvRtksg/rpYaCpQd0wvqWfyKJgzRoZOqo5spJ4Cn/TkCZgTu6JzpGpBu0J1SKlNei0ueCrHDOMqGwoUKzWBCBz3S9ZE0auTv0slrLqXDj6EYOZyyn3TRcK+xmuf68aD9XzkJ/k2fOaQu7wV9hIHvFwVkoglY1/dUjCpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891120; c=relaxed/simple;
	bh=AqeDRU1eKSmQXUiCZ7pwi0Bd8BGGXBM48O4Ou5Xs+sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny8OD4gi8nAij93+qSPZ92ytYCmvNp2te+9feN52PBmDlCrgJ1LDdj5X2hGC62awAnItnCA0/a6WPJfjeS0Obn/cuF4G9jS+9seTkI2xHvvDm9V2UN3sxVdmY/T5nBWmWwbDG3Y/jYnCrBraz4hwbcw1tiUMrGiFXEDLdfNHHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2EokHRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7610C4CEE7;
	Sun, 19 Oct 2025 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760891119;
	bh=AqeDRU1eKSmQXUiCZ7pwi0Bd8BGGXBM48O4Ou5Xs+sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2EokHRLd68kZBeDRRdhxJ1rDW2elFlh8EnkyaTJnHSCfqkoujh7BohpZc68H407D
	 6bUXmBrNoq7Ww0jTMF1QQwGeMEpfXz0BrGd0k+T8PJbgWDRrKfDcnhwumf2RRZV3Tp
	 M1nqa0cZRI89OYqyvuvRWeFwctcqJgDf9nK43gHk2G3mRl3usq7ey6ziFEp5oxVwef
	 8ha/lyEniLuE2fegL9ApZJO+lst38G6OUrwAE6O/NFZ/Mz1YaBFZd+ociss1pkQv9d
	 0MzWPAoBwoLUZ5+ACw5ohULeXVrjB6+3sdA7UiNPKC79wDn4zGf7+6LA7UKkZ5vUk5
	 GbYsQCDUj5ADg==
Date: Sun, 19 Oct 2025 09:23:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
Message-ID: <20251019162346.GB1604@sol>
References: <20241202010844.144356-16-ebiggers@kernel.org>
 <20251019060845.553414-1-safinaskar@gmail.com>
 <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>

On Sun, Oct 19, 2025 at 11:10:25AM +0300, Askar Safin wrote:
> On Sun, Oct 19, 2025 at 9:09 AM Askar Safin <safinaskar@gmail.com> wrote:
> >
> > Eric Biggers <ebiggers@kernel.org>:
> > > Now that the lower level __crc32c_le() library function is optimized for
> >
> > This patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to lib"))
> > solves actual bug I found in practice. So, please, backport it
> > to stable kernels.
> 
> Oops. I just noticed that this patch removes module "libcrc32c".
> And this breaks build for Debian kernel v6.12.48.
> Previously I tested minimal build using "make localmodconfig".
> Now I tried full build of Debian kernel using "dpkg-buildpackage".
> And it failed, because some of Debian files reference "libcrc32c",
> which is not available.
> 
> So, please, don't backport this patch to stable kernels.
> I'm sorry.

Right, this commit simplified the CRC library design by removing the
libcrc32c module.  initramfs build scripts that hard-coded the addition
of libcrc32c.ko into the ramdisk (which I don't think was ever necessary
in the first place, though it did used to be useful to hard-code some of
the *other* CRC modules like crc32c-intel) had to be updated to remove
it.  It looks like Debian did indeed do that, and they updated it in
https://salsa.debian.org/kernel-team/linux/-/commit/6c242c647f84bfdbdc22a6a758fa59da4e941a10#1251f9400a85485d275e1709758350aa098709a8

As for your original problem, I'd glad to see that the simplified design
is preventing problems.  There's an issue with backporting this commit
alone, though.  This was patch 15 of a 19-patch series for a good
reason: the CRC-32C implementation in lib/ wasn't architecture-optimized
until after patches 1-14 of this series.  Backporting this commit alone
would make crc32c() no longer utilize architecture-optimized code.

Now, it already didn't do so reliably (and this patch series fixed
that).  However, backporting this commit alone would make it never do
so.  So it would regress performance in some cases.

Since the errors you're actually getting are:

    [   19.619731] Invalid ELF header magic: != ELF
    modprobe: can't load module libcrc32c (kernel/lib/libcrc32c.ko.xz): unknown symbol in module, or unknown parameter

I do have to wonder if this is actually a busybox bug or
misconfiguration, where it's passing a compressed module to the kernel
without decompressing it?  And removing the module just hid the problem.

- Eric

