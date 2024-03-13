Return-Path: <linux-arch+bounces-2984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4587B533
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 00:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FD7B2278C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60915D756;
	Wed, 13 Mar 2024 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IStaLHn7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B15D73A;
	Wed, 13 Mar 2024 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372777; cv=none; b=DYzh3WU9fxJ2jOcmZ+MDqFeqYqWt4aU7GMxM0GH+xOcHja+IJxFqJUqFAsLic7FJtixsZZpql26WMhR7NS6oMJvvb4yARuFbtxUHtABqI4jBSSrbVKpIxlvpc1f8YylewtlVLU5ocm51GIHWBsCBwKJ1TzLaF3phZo6YrqxMX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372777; c=relaxed/simple;
	bh=uKoPTNz9hXikzhmrHpqjI5gaiFJod+fTbCcjei1wE9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOROpBAlRc3zws2lFTc3MSZPXPhPYMXOLjJ5h4eUEyhxwr2eX+lRld6YC686lg/egWP1fvBpW5LZzuMueKh2jsI+Xh3EizbMBBnUwNw+qrmhKbkRF/zVDTuRm8EDqO0Ldmt53PVXA3sJ5VsYlTMsfX1In4W8ZsqlmL1S7Xy8Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=IStaLHn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6272AC433F1;
	Wed, 13 Mar 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IStaLHn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710372773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2t6AcJYVTsZ9/Snf6g44ng8B8OMqaLO10Cm/z5y8zI=;
	b=IStaLHn7WiiGD8jQwzg3l97P7vb9EkF8f9vdaoUCmydEib0wUZFH7jEGV5NQy2ybu3vhr3
	eouFK0zTuHtFvI/cYrxGEAb0DlP3VkGo0SOiWZbeM/fiPWeM5NK1dWVZbMVu3GmjTA+Z+T
	bb+d6+IjY/69tX+bsJ5KIoEce+8kHDo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7dd7690 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Mar 2024 23:32:53 +0000 (UTC)
Date: Thu, 14 Mar 2024 00:32:51 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
	tytso@mit.edu, x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Message-ID: <ZfI3owmQOKc4Ta_X@zx2c4.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307184820.70589-1-mhklinux@outlook.com>

Hi Michael,

On Thu, Mar 07, 2024 at 10:48:20AM -0800, mhkelley58@gmail.com wrote:
> +	/*
> +	 * Seed the Linux random number generator with entropy provided by
> +	 * the Hyper-V host in ACPI table OEM0.  It would be nice to do this
> +	 * even earlier in ms_hyperv_init_platform(), but the ACPI subsystem
> +	 * isn't set up at that point. Skip if booted via EFI as generic EFI
> +	 * code has already done some seeding using the EFI RNG protocol.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> +		return;

Even if EFI seeds the kernel using its own code, if this is available,
it should be used too. So I think you should remove the `|| efi_enabled(EFI_BOOT)`
part and let the add_bootloader_randomness() do what it wants with the
entropy.

> +
> +	status = acpi_get_table("OEM0", 0, &header);
> +	if (ACPI_FAILURE(status) || !header)
> +		return;
> +
> +	/*
> +	 * Since the "OEM0" table name is for OEM specific usage, verify
> +	 * that what we're seeing purports to be from Microsoft.
> +	 */
> +	if (strncmp(header->oem_table_id, "MICROSFT", 8))
> +		goto error;
> +
> +	/*
> +	 * Ensure the length is reasonable.  Requiring at least 32 bytes and
> +	 * no more than 256 bytes is somewhat arbitrary.  Hyper-V currently
> +	 * provides 64 bytes, but allow for a change in a later version.
> +	 */
> +	if (header->length < sizeof(*header) + 32 ||
> +	    header->length > sizeof(*header) + 256)

What's the point of the lower bound? Obviously skip for 0, but if
there's only 16 bytes, cool, 16 bytes is good and can't hurt.

For the upper bound, I understand you need some sanity check. Why not
put it a bit higher, though, at SZ_4K or something? Can't hurt.

> +		goto error;
> +
> +	length = header->length - sizeof(*header);
> +	randomdata = (u8 *)(header + 1);
> +
> +	pr_debug("Hyper-V: Seeding rng with %d random bytes from ACPI table OEM0\n",
> +			length);
> +
> +	add_bootloader_randomness(randomdata, length);
> +
> +	/*
> +	 * To prevent the seed data from being visible in /sys/firmware/acpi,
> +	 * zero out the random data in the ACPI table and fixup the checksum.
> +	 */
> +	for (i = 0; i < length; i++) {
> +		header->checksum += randomdata[i];
> +		randomdata[i] = 0;
> +	}

Seems dangerous for kexec and such. What if, in addition to zeroing out
the actual data, you also set header->length to 0, so that it doesn't
get used again as 32 bytes of known zeros?

Thanks,
Jason

