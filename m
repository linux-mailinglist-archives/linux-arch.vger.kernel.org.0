Return-Path: <linux-arch+bounces-9373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF29EFE64
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 22:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A076928B335
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1C1D79A0;
	Thu, 12 Dec 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH2/FhwS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C81BDA97;
	Thu, 12 Dec 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039414; cv=none; b=tkQJeEkp6LLsn+cPH23qH4XGjxeTFoV+pwUGDODPDX0GTnLBCSxtXbBTrNXQyXOz/k+YZqnsvqUDut0GGz32c50Fnz5EJV0bPL5iHzvock5qEjyVJq84BD2Q+68VBLsGWDbUMzQ6ZJAzRd/C21qAgDXaIWGYHs0RKT5u4tQjvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039414; c=relaxed/simple;
	bh=PHriXmjed1B69c3djyjvkmAXWJdj4dHw/YPneJYuUAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB00hSzyvJhbUjnuNe+ocNcM8u143L6XOdZ+LDTrQuDeiNVYIFtv5v0pihfQTcp8PwSlTaGHP6VEHQLIFVwvW0367vvmXnfQUEcHRsMk4DKGHcnkfZ4P7EyBwHDuQWy8ss1QW7bEsiypAEAH2z8FIZEG60PXjMErXIsLnCoI30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH2/FhwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2649C4CECE;
	Thu, 12 Dec 2024 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734039414;
	bh=PHriXmjed1B69c3djyjvkmAXWJdj4dHw/YPneJYuUAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MH2/FhwShqp7EWFFC3jfr4d+2oZCa20/FnZU5iVe0RANd6fKcEAOyDhg0LLQyaNdv
	 pmcO1UA39z9T58KNzm3XqDgKZLt9DANUUG/t5ExAKz614iBk5RIziVkypwNC13qWI/
	 2jgx8/jNKF8KHoU70DoOStCkXzsY2DWe7Gy7xhwaxyfEWC7lCkz0hzy7gfwWy8zmlh
	 sfPlm+mOSKY2gWzBbJ//8l/5F8fh0C+09QXwhbUwyN/4/yF50D7F95w1IcIXPfDq5o
	 Rmn0xSAZwOmoInwAfNONVB8zNVzZ3YOg+2vIxg41k5G5rU83HUMrYl+rOEe76FzOCW
	 MmzPg4mkgbLrQ==
Date: Thu, 12 Dec 2024 13:36:52 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 00/12] Wire up CRC-T10DIF library functions to
 arch-optimized code
Message-ID: <20241212213652.GA39696@sol.localdomain>
References: <20241202012056.209768-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202012056.209768-1-ebiggers@kernel.org>

On Sun, Dec 01, 2024 at 05:20:44PM -0800, Eric Biggers wrote:
> This patchset is also available in git via:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-t10dif-lib-v2
> 
> This patchset updates the kernel's CRC-T10DIF library functions to be
> directly optimized for x86, arm, arm64, and powerpc without taking an
> unnecessary and inefficient detour through the crypto API.  It follows
> the same approach that I'm taking for CRC32 in the patchset
> https://lore.kernel.org/lkml/20241202010844.144356-1-ebiggers@kernel.org/
> 
> This patchset also adds a CRC KUnit test suite that covers multiple CRC
> variants, and deletes some older ad-hoc tests that are obsoleted by it.
> 
> This patchset applies to v6.13-rc1 plus my CRC32 patchset.  It can be
> retrieved from git using above command.  This is targeting 6.14.
> 
> Changed in v2:
>   - Rebased onto v6.13-rc1.
>   - Tweaked crc_t10dif_arch() for arm32 and arm64 to not call
>     crypto_simd_usable() more times than is necessary.
>   - Added patch removing redundant crc16_kunit.c which got added in v6.13-rc1.
>   - Made some small tweaks to crc_kunit.c.
>   - Listed Ard as a reviewer in the MAINTAINERS entry.
>   - Dropped scripts/crc from MAINTAINERS entry, as it hasn't been added yet.
>   - Clarified a commit message.
>   - Added Reviewed-by and Acked-by's.

FYI, this patchset is now in linux-next via the crc-next branch in my repo.
Additional reviews and acks would always be appreciated, of course.

- Eric

