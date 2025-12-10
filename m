Return-Path: <linux-arch+bounces-15331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABACB419E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 22:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387D43015AA2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC23322B70;
	Wed, 10 Dec 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izwwGKxN"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286852C15BC;
	Wed, 10 Dec 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403644; cv=none; b=I3xNyi9yfJKCXBGl/6a6qDU0MJ/1R1UQLorsbj13kiS0QkhiRGqssL+auQ1DjNEEVBBhDNFaHVh2rBA/FNd7EhY3SVPqXOKT/4bZUahBy3G+IBEOG2pAua1YTG6+r3bhhwLaeA1agKmwwpGhOgtoh0gpdZnEmbyvI8qbNJM3O1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403644; c=relaxed/simple;
	bh=ptwYMEjg7BpKJAqd9Z6iYaCh/2Z3t4miSjw0WHVhb5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGVlwKfBMU9m0kber3tnhb9LJaQrJ6TDqkJLyPvKxvNLHtm8qSvf4Hyf3zfm6PzPPIkRU/RTSuSlDy56NPSIhMQ7WizeCiaDkA+kJn4wryCkNaVTvQCE1uCR6p1CVfQwX6SSI12NhI+0aZUQ+94nu5RER8/PC3xgetaXeUlkIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izwwGKxN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id AEA0E201D7EE; Wed, 10 Dec 2025 13:54:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA0E201D7EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765403642;
	bh=yEvY4/UTNRLDdK0nb983gh614ubbjSjQs4DifhxFlxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izwwGKxNFXChUs0TNEUMWFXF8NNBqnrFn5z++4FvxdeXIC8u3YlmKUp8ls9oF7Ymk
	 q/x3pPDhEak8yqwSYaFUaIy1uX+64Lm2ZB0cFF6CsUwXZ3Er7T5wU0Na6SKnGIcKTp
	 soOWwFJ3If8D0KEH9b/u8OgzsulF2O8VYCqK8el4=
Date: Wed, 10 Dec 2025 13:54:02 -0800
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: wei.liu@kernel.org
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] mshv: Move function prototypes to the generic header
Message-ID: <20251210215402.GA19072@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251210214625.3114545-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210214625.3114545-1-wei.liu@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Dec 10, 2025 at 09:46:24PM +0000, wei.liu@kernel.org wrote:
> From: Wei Liu <wei.liu@kernel.org>
> 
> The same code is built on both x86 and ARM64 architectures. This fixes
> two missing prototype warnings when building on ARM64.
> 
> This only eliminates the warnings. Making things work on ARM64 requires
> more work.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
> Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

