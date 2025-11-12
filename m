Return-Path: <linux-arch+bounces-14668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62CC52E93
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED3F34E40D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64E33DEF7;
	Wed, 12 Nov 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="zPH4iuqJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61833F371;
	Wed, 12 Nov 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958941; cv=none; b=Z6Xpw344MksgL94qViptc/rd4chxFP5T/sQY9tFkOILJqKVXkT8XgQwuvPjNfYgDV/2+LR7+b/bRSt2eCZVoXxigMcKvZxELqdgQpchW/AI/hAqOJSkKJ8EHeAVEkcR3kh0P9nCMquWpnLjPGxv1vleRzVJLqP9RR+6u/A0jM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958941; c=relaxed/simple;
	bh=qtnSAalOXMMqjBYnRbllgani0PlQcrFAYRoJzXnRcjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/FVTSI7kVDuqGcaq0VNE5wSIgIxNV3RIZS2lsxgs3RPAgQi5CDATpF5pUV5Of9eFN8PfbeZfVsqRgvcT5lRdbQqxvHUHOh/ShhBNKWba/KtwwT8eQFveeQVBTGSz4F4sRaQYuD+n4Uaby22z+FakN2E5CaKmpEiojH4wfSaLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=zPH4iuqJ; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=Y/TNSDK51KEaNBTo1DMLY4DHz1Ol2XIRRHRNeKhH6vs=; b=zPH4iuqJDw0VV3v+
	PBLlhleuXAl8nce9Lh9Hes0xKWiYiqRKLEL5zxcWj29as152Gv4stb5+hDnC2CjZAsQ2CAtYI98Nn
	u7JbtvAacN7Zag/hZo8vWpgRPr1w5H1ckhz4haUGOtcEynXp0DgwpivTVXYYIwCrQRnS7Lv+faHFF
	eRW/Gd113OvPW681OPDA1LmChdig2M8q9kSFX6nj0D4G9pSWaMd+T8bHUrPsM17bYQed902RtmjQZ
	fB5994qHjw0GmdKAIlJxP/qGOxwYVqcRo55ZoA1Sgn+2xAjCukuA/qLHtt09Ry+gx5ajo+HvRzazc
	YDFebkVPkCi+F0+mjA==;
Received: from [63.135.74.212] (helo=[192.168.1.241])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vJC94-004DRg-5j; Wed, 12 Nov 2025 14:48:26 +0000
Message-ID: <59f8bc30-c1c6-4f07-87dd-cd2893ae87f7@codethink.co.uk>
Date: Wed, 12 Nov 2025 14:48:23 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] io-128-nonatomic: introduce
 io{read|write}128_{lo_hi|hi_lo}
To: Chenghai Huang <huangchenghai2@huawei.com>, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, ryan.roberts@arm.com,
 andriy.shevchenko@linux.intel.com, herbert@gondor.apana.org.au,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org
Cc: fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com,
 qianweili@huawei.com
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
 <20251112015846.1842207-4-huangchenghai2@huawei.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20251112015846.1842207-4-huangchenghai2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 12/11/2025 01:58, Chenghai Huang wrote:
> From: Weili Qian <qianweili@huawei.com>
> 
> In order to provide non-atomic functions for io{read|write}128.
> We define a number of variants of these functions in the generic
> iomap that will do non-atomic operations.
> 
> These functions are only defined if io{read|write}128 are defined.
> If they are not, then the wrappers that always use non-atomic operations
> from include/linux/io-128-nonatomic*.h will be used.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>   include/linux/io-128-nonatomic-hi-lo.h | 35 ++++++++++++++++++++++++++
>   include/linux/io-128-nonatomic-lo-hi.h | 34 +++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>   create mode 100644 include/linux/io-128-nonatomic-hi-lo.h
>   create mode 100644 include/linux/io-128-nonatomic-lo-hi.h
> 
> diff --git a/include/linux/io-128-nonatomic-hi-lo.h b/include/linux/io-128-nonatomic-hi-lo.h
> new file mode 100644
> index 000000000000..b5b083a9e81b
> --- /dev/null
> +++ b/include/linux/io-128-nonatomic-hi-lo.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_IO_128_NONATOMIC_HI_LO_H_
> +#define _LINUX_IO_128_NONATOMIC_HI_LO_H_
> +
> +#include <linux/io.h>
> +#include <asm-generic/int-ll64.h>
> +
> +static inline u128 ioread128_hi_lo(const void __iomem *addr)
> +{
> +	u32 low, high;

did you mean u64 here?

> +	high = ioread64(addr + sizeof(u64));
> +	low = ioread64(addr);
> +
> +	return low + ((u128)high << 64);
> +}
> +
> +static inline void iowrite128_hi_lo(u128 val, void __iomem *addr)
> +{
> +	iowrite64(val >> 64, addr + sizeof(u64));
> +	iowrite64(val, addr);
> +}
> +

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

