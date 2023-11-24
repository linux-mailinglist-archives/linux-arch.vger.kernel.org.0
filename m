Return-Path: <linux-arch+bounces-445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DAA7F77DE
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46B9B210E1
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66472E82C;
	Fri, 24 Nov 2023 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 068E41735;
	Fri, 24 Nov 2023 07:32:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B57B1063;
	Fri, 24 Nov 2023 07:33:35 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571163F73F;
	Fri, 24 Nov 2023 07:32:47 -0800 (PST)
Message-ID: <5d33d112-32f2-466e-b542-5fd4e43ea31c@arm.com>
Date: Fri, 24 Nov 2023 15:32:46 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <2fccdb30-aad0-4334-89d1-d4c86d17c9fc@arm.com>
 <20231124134501.GD436702@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231124134501.GD436702@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2023 1:45 pm, Jason Gunthorpe wrote:
> On Fri, Nov 24, 2023 at 12:58:11PM +0000, Robin Murphy wrote:
>>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>>> index 3b694511b98f..73ab91913790 100644
>>> --- a/arch/arm64/include/asm/io.h
>>> +++ b/arch/arm64/include/asm/io.h
>>> @@ -135,6 +135,26 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>>>    #define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
>>>    #define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
>>> +static inline void __memcpy_toio_64(volatile void __iomem *to, const void *from)
>>> +{
>>> +	const u64 *from64 = from;
>>> +
>>> +	/*
>>> +	 * Newer ARM core have sensitive write combining buffers, it is
>>> +	 * important that the stores be contiguous blocks of store instructions.
>>> +	 * Normal memcpy does not work reliably.
>>> +	 */
>>> +	asm volatile("stp %x0, %x1, [%8, #16 * 0]\n"
>>> +		     "stp %x2, %x3, [%8, #16 * 1]\n"
>>> +		     "stp %x4, %x5, [%8, #16 * 2]\n"
>>> +		     "stp %x6, %x7, [%8, #16 * 3]\n"
>>> +		     :
>>> +		     : "rZ"(from64[0]), "rZ"(from64[1]), "rZ"(from64[2]),
>>> +		       "rZ"(from64[3]), "rZ"(from64[4]), "rZ"(from64[5]),
>>> +		       "rZ"(from64[6]), "rZ"(from64[7]), "r"(to));
>>
>> Is this correct for big-endian? LDP/STP are kinda tricksy in that regard.
> 
> Uh.. I didn't think about it at all..
> 
> By no means do I have any skill reading the ARM documents, but I think
> it is OK, it says:
> 
> Mem[address, dbytes, AccType_NORMAL] = data1;
> Mem[address+dbytes, dbytes, AccType_NORMAL] = data2;
> 
> So I understand that as
> 
> Mem[%8, #16 * 0, 8, AccType_NORMAL] = from64[0]
> Mem[%8, #16 * 0 + 1 , 8, AccType_NORMAL] = from64[1]
> Mem[%8, #16 * 1, 8, AccType_NORMAL] = from64[2]
> Mem[%8, #16 * 1 + 1, 8, AccType_NORMAL] = from64[3]
> ..
> 
> Which is the same on BE/LE?
> 
> But I don't know the pitfall to watch for here. This is memcpy so we
> don't have to swap, the order of the bits in the register doesn't
> matter.

Indeed you're right - all the way back to Armv7 LDRD/STRD, I always get 
caught out by remembering the path which does an endian-dependent swap 
of the target registers, but forgetting that that's there to 
*counteract* the byteswap in Mem[] itself.

Cheers,
Robin.

