Return-Path: <linux-arch+bounces-14664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E173C52431
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 13:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54BF3AC1F0
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2C30BB86;
	Wed, 12 Nov 2025 12:28:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BCE56A;
	Wed, 12 Nov 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950488; cv=none; b=nptcYIAeZlKfIo2ARzziS2+n+kLJvuPmKbytHkQVFRJmn8TJfyVSLqbcHQ6ME7CLBWdG8eWhzqiPrDcSRSxKD83GWvZPFgDKaO4N0NO4noXqhMrRYX+rrKxXbkzeDcr5853eNaXsPQE5AlTNJyqdfCE9mmah9RD2Mqs+ejH2MQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950488; c=relaxed/simple;
	bh=wtzMEfXCodIG5gxOfIQOctDhukEtgbIWw6S53RhWJ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBnroPDyUM3vQh64fkGkrCOYzMjgP+1HGYPDvpy9seYohdTqBHJJ0WGf6E2c8R6x552EA4+KA2DD+y4VkwWiJ2sR2UTYMH9AK/lR5iq4E/dUmNzQ/MlZVPoIkCxVUj5rsrR13DbLI/5IWbYoGuqcrNyDX9FkMwU+sZQKb2dfyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7391D1515;
	Wed, 12 Nov 2025 04:27:58 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F9FE3F5A1;
	Wed, 12 Nov 2025 04:28:03 -0800 (PST)
Date: Wed, 12 Nov 2025 12:28:01 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	ryan.roberts@arm.com, andriy.shevchenko@linux.intel.com,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com,
	qianweili@huawei.com
Subject: Re: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128 support
Message-ID: <aRR9UesvUCFLdVoW@J2N7QTR9R3>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
 <20251112015846.1842207-5-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112015846.1842207-5-huangchenghai2@huawei.com>

On Wed, Nov 12, 2025 at 09:58:46AM +0800, Chenghai Huang wrote:
> From: Weili Qian <qianweili@huawei.com>
> 
> Starting from ARMv8.4, stp and ldp instructions become atomic.

That's not true for accesses to Device memory types.

Per ARM DDI 0487, L.b, section B2.2.1.1 ("Changes to single-copy atomicity in
Armv8.4"):

  If FEAT_LSE2 is implemented, LDP, LDNP, and STP instructions that load
  or store two 64-bit registers are single-copy atomic when all of the
  following conditions are true:
  • The overall memory access is aligned to 16 bytes.
  • Accesses are to Inner Write-Back, Outer Write-Back Normal cacheable memory.

IIUC when used for Device memory types, those can be split, and a part
of the access could be replayed multiple times (e.g. due to an
intetrupt).

I don't think we can add this generally. It is not atomic, and not
generally safe.

Mark.

> Currently, device drivers depend on 128-bit atomic memory IO access,
> but these are implemented within the drivers. Therefore, this introduces
> generic {__raw_read|__raw_write}128 function for 128-bit memory access.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  arch/arm64/include/asm/io.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 83e03abbb2ca..80430750a28c 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -50,6 +50,17 @@ static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
>  	asm volatile("str %x0, %1" : : "rZ" (val), "Qo" (*ptr));
>  }
>  
> +#define __raw_write128 __raw_write128
> +static __always_inline void __raw_write128(u128 val, volatile void __iomem *addr)
> +{
> +	u64 low, high;
> +
> +	low = val;
> +	high = (u64)(val >> 64);
> +
> +	asm volatile ("stp %x0, %x1, [%2]\n" :: "rZ"(low), "rZ"(high), "r"(addr));
> +}
> +
>  #define __raw_readb __raw_readb
>  static __always_inline u8 __raw_readb(const volatile void __iomem *addr)
>  {
> @@ -95,6 +106,16 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
>  	return val;
>  }
>  
> +#define __raw_read128 __raw_read128
> +static __always_inline u128 __raw_read128(const volatile void __iomem *addr)
> +{
> +	u64 high, low;
> +
> +	asm volatile("ldp %0, %1, [%2]" : "=r" (low), "=r" (high) : "r" (addr));
> +
> +	return (((u128)high << 64) | (u128)low);
> +}
> +
>  /* IO barriers */
>  #define __io_ar(v)							\
>  ({									\
> -- 
> 2.33.0
> 
> 

