Return-Path: <linux-arch+bounces-438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299D7F746D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 13:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41611C20CE6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782D1EB3D;
	Fri, 24 Nov 2023 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB1A310E4;
	Fri, 24 Nov 2023 04:58:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54BF31063;
	Fri, 24 Nov 2023 04:59:01 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BDAF3F6C4;
	Fri, 24 Nov 2023 04:58:13 -0800 (PST)
Message-ID: <2fccdb30-aad0-4334-89d1-d4c86d17c9fc@arm.com>
Date: Fri, 24 Nov 2023 12:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Michael Guralnik <michaelgur@mellanox.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2023 7:04 pm, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The kernel supports write combining IO memory which is commonly used to
> generate 64 byte TLPs in a PCIe environment. On many CPUs this mechanism
> is pretty tolerant and a simple C loop will suffice to generate a 64 byte
> TLP.
> 
> However modern ARM64 CPUs are quite sensitive and a compiler generated
> loop is not enough to reliably generate a 64 byte TLP. Especially given
> the ARM64 issue that writel() does not codegen anything other than "[xN]"
> as the address calculation.
> 
> These newer CPUs require an orderly consecutive block of stores to work
> reliably. This is best done with four STP integer instructions (perhaps
> ST64B in future), or a single ST4 vector instruction.
> 
> Provide a new generic function memcpy_toio_64() which should reliably
> generate the needed instructions for the architecture, assuming address
> alignment. As the usual need for this operation is performance sensitive a
> fast inline implementation is preferred.
> 
> Implement an optimized version on ARM that is a block of 4 STP
> instructions.
> 
> The generic implementation is just a simple loop. x86-64 (clang 16)
> compiles this into an unrolled loop of 16 movq pairs.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   arch/arm64/include/asm/io.h | 20 ++++++++++++++++++++
>   include/asm-generic/io.h    | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 3b694511b98f..73ab91913790 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -135,6 +135,26 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>   #define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
>   #define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
>   
> +static inline void __memcpy_toio_64(volatile void __iomem *to, const void *from)
> +{
> +	const u64 *from64 = from;
> +
> +	/*
> +	 * Newer ARM core have sensitive write combining buffers, it is
> +	 * important that the stores be contiguous blocks of store instructions.
> +	 * Normal memcpy does not work reliably.
> +	 */
> +	asm volatile("stp %x0, %x1, [%8, #16 * 0]\n"
> +		     "stp %x2, %x3, [%8, #16 * 1]\n"
> +		     "stp %x4, %x5, [%8, #16 * 2]\n"
> +		     "stp %x6, %x7, [%8, #16 * 3]\n"
> +		     :
> +		     : "rZ"(from64[0]), "rZ"(from64[1]), "rZ"(from64[2]),
> +		       "rZ"(from64[3]), "rZ"(from64[4]), "rZ"(from64[5]),
> +		       "rZ"(from64[6]), "rZ"(from64[7]), "r"(to));

Is this correct for big-endian? LDP/STP are kinda tricksy in that regard.

Thanks,
Robin.

> +}
> +#define memcpy_toio_64(to, from) __memcpy_toio_64(to, from)
> +
>   /*
>    * I/O memory mapping functions.
>    */
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index bac63e874c7b..2d6d60ed2128 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1202,6 +1202,36 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
>   }
>   #endif
>   
> +#ifndef memcpy_toio_64
> +#define memcpy_toio_64 memcpy_toio_64
> +/**
> + * memcpy_toio_64	Copy 64 bytes of data into I/O memory
> + * @dst:		The (I/O memory) destination for the copy
> + * @src:		The (RAM) source for the data
> + * @count:		The number of bytes to copy
> + *
> + * dst and src must be aligned to 8 bytes. This operation copies exactly 64
> + * bytes. It is intended to be used for write combining IO memory. The
> + * architecture should provide an implementation that has a high chance of
> + * generating a single combined transaction.
> + */
> +static inline void memcpy_toio_64(volatile void __iomem *addr,
> +				  const void *buffer)
> +{
> +	unsigned int i = 0;
> +
> +#if BITS_PER_LONG == 64
> +	for (; i != 8; i++)
> +		__raw_writeq(((const u64 *)buffer)[i],
> +			     ((u64 __iomem *)addr) + i);
> +#else
> +	for (; i != 16; i++)
> +		__raw_writel(((const u32 *)buffer)[i],
> +			     ((u32 __iomem *)addr) + i);
> +#endif
> +}
> +#endif
> +
>   extern int devmem_is_allowed(unsigned long pfn);
>   
>   #endif /* __KERNEL__ */

