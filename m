Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B41B3BBA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDVJuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 05:50:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgDVJuC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 05:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE50731B;
        Wed, 22 Apr 2020 02:50:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F134D3F68F;
        Wed, 22 Apr 2020 02:49:59 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:49:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200422094951.GA54428@lakrids.cambridge.arm.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421151537.19241-6-will@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 04:15:31PM +0100, Will Deacon wrote:
> do_csum() over-reads the source buffer and therefore abuses
> READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> and fall back to normal loads.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>

From a functional perspective:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I know that Robin had a concern w.r.t. how this would affect the
codegen, but I think we can follow that up after the series as a whole
is merged.

Thanks,
Mark.


> ---
>  arch/arm64/lib/csum.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
> index 60eccae2abad..78b87a64ca0a 100644
> --- a/arch/arm64/lib/csum.c
> +++ b/arch/arm64/lib/csum.c
> @@ -14,7 +14,11 @@ static u64 accumulate(u64 sum, u64 data)
>  	return tmp + (tmp >> 64);
>  }
>  
> -unsigned int do_csum(const unsigned char *buff, int len)
> +/*
> + * We over-read the buffer and this makes KASAN unhappy. Instead, disable
> + * instrumentation and call kasan explicitly.
> + */
> +unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
>  {
>  	unsigned int offset, shift, sum;
>  	const u64 *ptr;
> @@ -42,7 +46,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>  	 * odd/even alignment, and means we can ignore it until the very end.
>  	 */
>  	shift = offset * 8;
> -	data = READ_ONCE_NOCHECK(*ptr++);
> +	data = *ptr++;
>  #ifdef __LITTLE_ENDIAN
>  	data = (data >> shift) << shift;
>  #else
> @@ -58,10 +62,10 @@ unsigned int do_csum(const unsigned char *buff, int len)
>  	while (unlikely(len > 64)) {
>  		__uint128_t tmp1, tmp2, tmp3, tmp4;
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
>  		len -= 64;
>  		ptr += 8;
> @@ -85,7 +89,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>  		__uint128_t tmp;
>  
>  		sum64 = accumulate(sum64, data);
> -		tmp = READ_ONCE_NOCHECK(*(__uint128_t *)ptr);
> +		tmp = *(__uint128_t *)ptr;
>  
>  		len -= 16;
>  		ptr += 2;
> @@ -100,7 +104,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
>  	}
>  	if (len > 0) {
>  		sum64 = accumulate(sum64, data);
> -		data = READ_ONCE_NOCHECK(*ptr);
> +		data = *ptr;
>  		len -= 8;
>  	}
>  	/*
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
