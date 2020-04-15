Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1273C1AAFAC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411072AbgDOR2c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 13:28:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410994AbgDOR2X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 13:28:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC66F1FB;
        Wed, 15 Apr 2020 10:28:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8143F68F;
        Wed, 15 Apr 2020 10:28:20 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:28:14 +0100
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
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200415172813.GA2272@lakrids.cambridge.arm.com>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415165218.20251-6-will@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

On Wed, Apr 15, 2020 at 05:52:11PM +0100, Will Deacon wrote:
> do_csum() over-reads the source buffer and therefore abuses
> READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> and fall back to normal loads.

I'm confused by this. The whole point of READ_ONCE_NOCHECK() is that it
isn't checked by KASAN, so if that semantic is removed it has no reason
to exist.

Changing that will break the unwind/stacktrace code across multiple
architectures. IIRC they use READ_ONCE_NOCHECK() for two reasons:

1. Races with concurrent modification, as might happen when a thread's
   stack is corrupted. Allowing the unwinder to bail out after a sanity
   check means the resulting report is more useful than a KASAN splat in
   the unwinder. I made the arm64 unwinder robust to this case.

2. I believe that the frame record itself /might/ be poisoned by KASAN,
   since it's not meant to be an accessible object at the C langauge
   level. I could be wrong about this, and would have to check.
 
I would like to keep the unwinding robust in the first case, even if the
second case doesn't apply, and I'd prefer to not mark the entirety of
the unwinding code as unchecked as that's sufficiently large an subtle
that it could have nasty bugs.

Is there any way we keep something like READ_ONCE_NOCHECK() around even
if we have to give it reduced functionality relative to READ_ONCE()?

I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
particular pain point I'm happy to take a look.

Thanks,
Mark.

> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
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
> 2.26.0.110.g2183baf09c-goog
> 
