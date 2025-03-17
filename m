Return-Path: <linux-arch+bounces-10922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0ADA66078
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BB7175483
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA95202C42;
	Mon, 17 Mar 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II67G/Jd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67A202984;
	Mon, 17 Mar 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246843; cv=none; b=gLqL8ptizm/A1jb05xIwEs8wuFnDoSeyKUf3Km5B8qJ13Latf8Xg2yKswngSGFWbA9NuFiE5BWCDcY8l1V+l39o1hUwU/fNPt7KBY3TTaNL82KoymwiYrSWAo9AbVLxgRhkbwGPwXBIJ1Aex7QRe48fNr01p/qTqku+WpPBJZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246843; c=relaxed/simple;
	bh=z6q9Yf8R8e67nexnPrspZoEOpoHL0DbFkk7kRkc46xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGRTCXW2wtcUMtm5FIoEvWaoNcSU8clzHkEOq3BTPdFjCHPNS8O4cK1XG7BVO1H2DJNfZEEWTeW3iDwPAkUfyMCEB44IkxZPOldjy4GNyeqlcWOh+sBf1goONUeCK1KKM/jIu0oxXQwX65ffUZgA3JSB650R1YcohV1ILQg0Nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II67G/Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02828C4CEED;
	Mon, 17 Mar 2025 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742246842;
	bh=z6q9Yf8R8e67nexnPrspZoEOpoHL0DbFkk7kRkc46xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=II67G/Jdr5TfcE01THKWrfcwC/dnbFzFkjhZ/KsoAq2A9DhzXqWXp9a0/SwpXk4M4
	 tyr6h2Sy2vrO+CkZC+u7/Q8EucIo3X0V/EGyPnEsSAaIMy/EfuZTmK1p/wKnfP2qEn
	 YLagUIHnGVRuaViHS6pGD7YUqZHRXtRI6wUsxGRL77z67hJw8JpEr85uEV2Qb95ehw
	 V06Fcf3zKRi1BReiHq+PIsLz7s7EsBC/Av59tamayb0Clb0/aIuq4zFMkD16YkZZ61
	 9u/ZYqndehxwtCUPEf2t+vqeCmRI8thPtzOaVSO+7vgGsdGsnrxqIBeH1FSn9/0eNB
	 XwDkQ0FOmKqQg==
Date: Mon, 17 Mar 2025 21:27:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, mhklinux@outlook.com,
	ltykernel@gmail.com, stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org, eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, daniel.lezcano@linaro.org, joro@8bytes.org,
	robin.murphy@arm.com, arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, ssengar@linux.microsoft.com,
	apais@linux.microsoft.com, gregkh@linuxfoundation.org,
	vkuznets@redhat.com, prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v6 00/10] Introduce /dev/mshv root partition driver
Message-ID: <Z9iTuJRSnKAD5t15@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Mar 14, 2025 at 12:28:46PM -0700, Nuno Das Neves wrote:
> This series introduces support for creating and running guest virtual
> machines while running on the Microsoft Hypervisor[0] as root partition.
> This is done via an IOCTL interface accessed through /dev/mshv, similar to
> /dev/kvm. Another series introducing this support was previously posted in
> 2021[1], and versions 1-4 of this series were posted in 2023[2].
> 
> Patches 1-4 are small refactors and additions to Hyper-V code.
> Patches 5-6 just export some definitions needed by /dev/mshv.
> Patches 7-9 introduce some functionality and definitions in common code, that
> are specific to the driver.
> Patch 10 contains the driver code.
> 
> -----------------
> [0] "Hyper-V" is more well-known, but it really refers to the whole stack
>     including the hypervisor and other components that run in Windows
>     kernel and userspace.
> [1] Previous /dev/mshv patch series (2021) and discussion:
> https://lore.kernel.org/linux-hyperv/1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com/
> [2] v4 (2023):
> https://lore.kernel.org/linux-hyperv/1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com/
> 
> -----------------
> Changes since v5:
> * Rework patch 1:
>  1. Introduce hv_status_printk() logging macros which print the raw HV_STATUS_
>     code along with string [Roman Kisel]
>  2. Iterate over an array of data items to get the string and errno for the
>     hv_result_to_*() functions. [Michael Kelley]
>  3. Use hv_status_printk() to log errors in hyperv/irqdomain.c and
>     hyperv-iommu.c [Easwar Hariharan]
> * Minor cleanup, improvements, and commit wording changes in patches 2, 3, 4, 6
>   [Roman Kisel, Easwar Hariharan, Michael Kelley]
> * Fix issues with declaration and lifecycle of hv_synic_eventring_tail in patch
>   7 [Michael Kelley]
> * Improve detail and clarity of commit message in patch 8 [Michael Kelley]
> * Minor cleanups in patch 9 - uapi types -> kernel types, #ifdef CONFIG_X86_64
>   -> CONFIG_X86 for consistency, fix HVCALL_* ordering, remove redundant
>   __packed, use explicit enum value [Stanislav Kinsburskii, Easwar Hariharan,
>   Michael Kelley, Tianyu Lan]
> * Minor fixes and cleanup in patch 10 [Michael Kelley]
> * Add MODULE_DESCRIPTION() to patch 10 [Jeff Johnson]
> 
> Changes since v4:
> * Slim down the IOCTL interface significantly, via several means:
>   1. Use generic "passthrough" call MSHV_ROOT_HVCALL to replace many ioctls.
>   2. Use MSHV_* versions of some of the HV_* definitions.
>   3. Move hv headers out of uapi altogether, into include/hyperv/, see:
> https://lore.kernel.org/linux-hyperv/1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com/
> * Remove mshv_vtl module altogther, it will be posted in followup series
>   * Also remove the parent "mshv" module which didn't serve much purpose
> * Update and refactor parts of the driver code for clarity, extensibility
> 
> Changes since v3 (summarized):
> * Clean up the error and debug logging:
>   1. Add a set of macros vp_*() and partition_*() which call the equivalent
>      dev_*(), passing the device from the partition struct
>      * The new macros also print the partition and vp ids to aid debugging
> 	   and reduce repeated code
>   2. Use dev_*() (mostly via the new macros) instead of pr_*() *almost*
>   everywhere - in interrupt context we can't always get the device struct
>   3. Remove pr_*() logging from hv_call.c and mshv_root_hv_call.c
> 
> Changes since v2 (summarized):
> * Fix many checkpatch.pl --strict style issues
> * Initialize status in get/set registers hypercall helpers
> * Add missing return on error in get_vp_signaled_count
> 
> Changes since v1 (summarized):
> * Clean up formatting, commit messages
> 
> Nuno Das Neves (9):
>   hyperv: Log hypercall status codes as strings
>   arm64/hyperv: Add some missing functions to arm64
>   hyperv: Introduce hv_recommend_using_aeoi()
>   acpi: numa: Export node_to_pxm()
>   Drivers: hv: Export some functions for use by root partition module
>   Drivers: hv: Introduce per-cpu event ring tail
>   x86: hyperv: Add mshv_handler() irq handler and setup function
>   hyperv: Add definitions for root partition driver to hv headers
>   Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs
> 
> Stanislav Kinsburskii (1):
>   x86/mshyperv: Add support for extended Hyper-V features

Series applied to hyperv-next. Thanks.

I had to fix one minor compilation issue in patch 10, but nothing major.

I also folded the following patch to a previous patch that introduced
MSHV_ROOT (not in this series).


diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 794e88e9dc6b..3118d5472fab 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -57,7 +57,7 @@ config HYPERV_BALLOON
 
 config MSHV_ROOT
 	tristate "Microsoft Hyper-V root partition support"
-	depends on HYPERV
+	depends on HYPERV && (X86_64 || ARM64)
 	depends on !HYPERV_VTL_MODE
 	# The hypervisor interface operates on 4k pages. Enforcing it here
 	# simplifies many assumptions in the root partition code.

Wei.

