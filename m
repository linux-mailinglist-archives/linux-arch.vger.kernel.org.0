Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F31AB18D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgDOT1L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:27:11 -0400
Received: from foss.arm.com ([217.140.110.172]:51634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404592AbgDOT0s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 15:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2A3C14;
        Wed, 15 Apr 2020 12:26:47 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDBA73F73D;
        Wed, 15 Apr 2020 12:26:44 -0700 (PDT)
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4d31aca5-56dd-2ca5-d1b8-f754ad184b04@arm.com>
Date:   Wed, 15 Apr 2020 20:26:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415165218.20251-6-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-04-15 5:52 pm, Will Deacon wrote:
> do_csum() over-reads the source buffer and therefore abuses
> READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> and fall back to normal loads.

FWIW with most compilers I played with, the read-once-ness *was* also 
important to ensure the uint128_t accesses compose to nice efficient 
LDPs rather than being split into a motley mess of individual LDRs.

The buffer loads that aren't the first or potentially the last didn't 
strictly need to be nocheck, however since the whole range gets 
explicitly checked up-front they may as well avoid further unnecessary 
KASAN penalty, plus it made things look nice and consistent :)

Robin.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/lib/csum.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
> index 60eccae2abad..78b87a64ca0a 100644
> --- a/arch/arm64/lib/csum.c
> +++ b/arch/arm64/lib/csum.c
> @@ -14,7 +14,11 @@ static u64 accumulate(u64 sum, u64 data)
>   	return tmp + (tmp >> 64);
>   }
>   
> -unsigned int do_csum(const unsigned char *buff, int len)
> +/*
> + * We over-read the buffer and this makes KASAN unhappy. Instead, disable
> + * instrumentation and call kasan explicitly.
> + */
> +unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
>   {
>   	unsigned int offset, shift, sum;
>   	const u64 *ptr;
> @@ -42,7 +46,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>   	 * odd/even alignment, and means we can ignore it until the very end.
>   	 */
>   	shift = offset * 8;
> -	data = READ_ONCE_NOCHECK(*ptr++);
> +	data = *ptr++;
>   #ifdef __LITTLE_ENDIAN
>   	data = (data >> shift) << shift;
>   #else
> @@ -58,10 +62,10 @@ unsigned int do_csum(const unsigned char *buff, int len)
>   	while (unlikely(len > 64)) {
>   		__uint128_t tmp1, tmp2, tmp3, tmp4;
>   
> -		tmp1 = READ_ONCE_NOCHECK(*(__uint128_t *)ptr);
> -		tmp2 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 2));
> -		tmp3 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 4));
> -		tmp4 = READ_ONCE_NOCHECK(*(__uint128_t *)(ptr + 6));
> +		tmp1 = *(__uint128_t *)ptr;
> +		tmp2 = *(__uint128_t *)(ptr + 2);
> +		tmp3 = *(__uint128_t *)(ptr + 4);
> +		tmp4 = *(__uint128_t *)(ptr + 6);
>   
>   		len -= 64;
>   		ptr += 8;
> @@ -85,7 +89,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>   		__uint128_t tmp;
>   
>   		sum64 = accumulate(sum64, data);
> -		tmp = READ_ONCE_NOCHECK(*(__uint128_t *)ptr);
> +		tmp = *(__uint128_t *)ptr;
>   
>   		len -= 16;
>   		ptr += 2;
> @@ -100,7 +104,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>   	}
>   	if (len > 0) {
>   		sum64 = accumulate(sum64, data);
> -		data = READ_ONCE_NOCHECK(*ptr);
> +		data = *ptr;
>   		len -= 8;
>   	}
>   	/*
> 
