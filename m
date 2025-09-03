Return-Path: <linux-arch+bounces-13368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA61B426D9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F21747EF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD02D23A8;
	Wed,  3 Sep 2025 16:25:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7412D060D;
	Wed,  3 Sep 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916756; cv=none; b=ijfYj36QRPWyZ3trnHEuLaYy6IZoIp4HCuObQQVeD24o4WbzsB2vHWtwh2Vejb+BwzT/tpHfeKMDj/eKqjqNKmhxgkLsR7qDRZH/DYuTeNh/qx7U2rsg5cElUyEEOFFHyynNw5LOk4pEs/h0oQCRm1CCbdcPk+Drzo4O5cK9Rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916756; c=relaxed/simple;
	bh=WxOhRzpdwSLHGxEMD/Hq6XP5EashyFQMzoSMcPTo0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMnzNQvQIapyzuC8uOo5Xgjl6wKCv9WE9iGWeZgWfL3cS9L08Y0w+YazhfAhhzxpKsMS8ti2BHEw0+q+1Vqgpm2O63JwpOk9SwJDw2SBnr0I2AHRe401w5N0OhE5RGc0u31SpKFHHA+Pxkk2ng5Fe3YzQ9k6lvrJn0TvQ6VmiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F67C4CEE7;
	Wed,  3 Sep 2025 16:25:51 +0000 (UTC)
Date: Wed, 3 Sep 2025 17:25:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: james.morse@arm.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/8] arm64: Select GENERIC_CPU_CACHE_MAINTENANCE and
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <aLhsDCcMcqhXM0x6@arm.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820102950.175065-6-Jonathan.Cameron@huawei.com>

On Wed, Aug 20, 2025 at 11:29:47AM +0100, Jonathan Cameron wrote:
> Ensure the hooks that the generic cache maintenance framework uses are
> available on ARM64 by selecting ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.
> 
> The generic CPU cache maintenance framework provides a way to register
> drivers for devices implementing the underlying support for
> cpu_cache_has_invalidate_memregion().
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e9bbfacc35a6..15bf429b3f59 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -21,6 +21,7 @@ config ARM64
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CC_PLATFORM
> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION

We could drop this if GENERIC_CPU_CACHE_MAINTENANCE selects it.

>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
> @@ -146,6 +147,7 @@ config ARM64
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select GENERIC_CPU_AUTOPROBE
> +	select GENERIC_CPU_CACHE_MAINTENANCE

Either way:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

