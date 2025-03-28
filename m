Return-Path: <linux-arch+bounces-11178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A7A7504E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D36188E88E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4314A0BC;
	Fri, 28 Mar 2025 18:22:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44B1D0F5A;
	Fri, 28 Mar 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186165; cv=none; b=b8M3hkdckV9M/r18FSGOfIxJvN70cjc1RtalrJ7uWBN74DXcNrWKT2P1l+hG6s8kV4uHj2Ig7SM7e9sWkb1qfWa+Xh+KUnrE55Ni5Y2Bmfasr1VIiLZL5yYvgdyO+9nWSgCrHAAmAkPppee2TdoFCDAfPMWxM2i9+iO9lQ7xz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186165; c=relaxed/simple;
	bh=Ny0RjglG9ntzXvLkOv5t+0QuNIJ/nl9JHX8l5aV8dto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JErMCbqpNx1yRX1YG+tNsE/oNGoWi6muZ4xtvyQay1lREIS5XmgZOTWfUxcvwPyejqYMXLM4QtIUOM4cCpJOuZcSRrxKSYIshzK427qKq7f5Vx/WFRLbNo935gZ+UB9ovcWTBzJOKEquyP+GWi4yqNfc2l4ZnGqhGmXyKiFWt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE997FEC;
	Fri, 28 Mar 2025 11:22:45 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F0D3F694;
	Fri, 28 Mar 2025 11:22:39 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:22:36 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	james.morse@arm.com, conor@kernel.org,
	Yicong Yang <yangyicong@huawei.com>, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>, linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/6] arm64: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <Z-bo7AQ1h6VQr65V@arm.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
 <20250320174118.39173-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320174118.39173-3-Jonathan.Cameron@huawei.com>

On Thu, Mar 20, 2025 at 05:41:14PM +0000, Jonathan Cameron wrote:
> +struct system_cache_flush_method {
> +	int (*invalidate_memregion)(int res_desc,
> +				    phys_addr_t start, size_t len);
> +};
[...]
> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	if (!scfm_data)
> +		return -EOPNOTSUPP;
> +
> +	return scfm_data->invalidate_memregion(res_desc, start, len);
> +}

WBINVD on x86 deals with the CPU caches as well. Even the API naming in
Linux implies CPU caches. IIUC, devices registering to the above on Arm
SoCs can only deal with system caches. Is it sufficient?

-- 
Catalin

