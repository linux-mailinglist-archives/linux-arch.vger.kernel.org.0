Return-Path: <linux-arch+bounces-3027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2287F1AF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 22:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5841C20F51
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FD58137;
	Mon, 18 Mar 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D1Aevv10"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38058131;
	Mon, 18 Mar 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795808; cv=none; b=oXIBmbXpvKm5xEEoL4OatqQhd6tCBHNY2mzQk/Re4P+csrBW689GlmQA7Hq/R5DRLNb/Zawe9ZR/iVJEIhYInVKThUi4DuBhxHEl6/I5ytzLp/GHehRljT/J7Ys1eLyrH7Y4shEFX0NVSwBOLWEFyFpFnStuCYGa1b1ymKlSyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795808; c=relaxed/simple;
	bh=KNXL8yB39oiiaWyS+GffR+XGWq4A3cnUOIdO5iI9gsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC3u27OmxqfH86RH5YsjwypJQPbgP+s5fKXhJG1bgvDOTG7tq4H7aI77lP+arcBSNVp4ipN7tuoSyAzeNdQnORyjomI8kgfwyJ8KGgv9JZ4R1MzLncaoROZVHdyEjkWZ0j/r9uTrPd92gj+23BsRydQAMRP3BiCXnLcAP/NGb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=D1Aevv10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA0C433C7;
	Mon, 18 Mar 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D1Aevv10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710795802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UmPCZS+23vmAnJgCoa+okS36dhoUEjEhsL1XUB+hRz0=;
	b=D1Aevv10LyR+ZL5FYo9+nIGr2xbCDWF52PSQ99g8mSEHCkqWZ3lgC7uyyJqeV8W6W71iGq
	T3wk0PBhGBIF6SJLXTdR6Ck3bXpibLdx9fr/lTRX4QB7VmeqLEHsRiGTKkKuhtgEQv7rol
	0fhrn/Q86e/X3d7mhkfROjXe9ITzNsg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79ecf448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 21:03:22 +0000 (UTC)
Date: Mon, 18 Mar 2024 22:03:21 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, tytso@mit.edu, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Message-ID: <ZfisGSPX9et2hGzx@zx2c4.com>
References: <20240318155408.216851-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318155408.216851-1-mhklinux@outlook.com>

Hi Michael,

On Mon, Mar 18, 2024 at 08:54:08AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A Hyper-V host provides its guest VMs with entropy in a custom ACPI
> table named "OEM0".  The entropy bits are updated each time Hyper-V
> boots the VM, and are suitable for seeding the Linux guest random
> number generator (rng). See a brief description of OEM0 in [1].
> 
> Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in
> Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
> Via this path, the rng is seeded very early during boot with good
> entropy. The ACPI OEM0 table provided in such VMs is an additional
> source of entropy.
> 
> Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
> doesn't currently get any entropy from the Hyper-V host. While this
> is not fundamentally broken because Linux can generate its own entropy,
> using the Hyper-V host provided entropy would get the rng off to a
> better start and would do so earlier in the boot process.
> 
> Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
> code in Linux take advantage of the OEM0 table to seed the rng. For
> Generation 2 VMs, use the OEM0 table to provide additional entropy
> beyond the EFI_RNG_PROTOCOL. Because the OEM0 table is custom to
> Hyper-V, parse it directly in the Hyper-V code in the Linux kernel
> and use add_bootloader_randomness() to add it to the rng. Once the
> entropy bits are read from OEM0, zero them out in the table so
> they don't appear in /sys/firmware/acpi/tables/OEM0 in the running
> VM. The zero'ing is done out of an abundance of caution to avoid
> potential security risks to the rng. Also set the OEM0 data length
> to zero so a kexec or other subsequent use of the table won't try
> to use the zero'ed bits.
> 
> [1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf

Looks good to me. Assuming you've tested this and it works,

 Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for the v3.

Jason

