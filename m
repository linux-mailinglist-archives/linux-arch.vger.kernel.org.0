Return-Path: <linux-arch+bounces-6932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8A7968EF8
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5836B1C22032
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 20:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71B1865E2;
	Mon,  2 Sep 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMkMAQQf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6C1A4E6C;
	Mon,  2 Sep 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310666; cv=none; b=IfSdYVnv0hzijYO8SijkbJVxp3uHmx/N3g+xJEICZvp+thfokaSi+rLwHi3i62GtR0LxvwkFQiNAeWH1VjKK99cT/QLB8vCaSAuhz+0dWSQlOuD5IqUnVrE53b77rqyS/sGy1/bYJtuYv/TWqOCx07Iz/I7oyM+zDXna52X2cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310666; c=relaxed/simple;
	bh=sUiZRUjhLBtW8/wNG0mFQD+PLGXOhO1CknuDEWXqJL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaUF0ma605VjmUoZcBhZHEZdxU0U4vRFp+G7Azlzaisg7mSmb38dlRXbFMt8LCWWs5tn1xKbJaaywnk2EKqXbcRqCJkc9LGzax0BZ+ece/grJzZ/PVXaUULeVgY9o9ZSBbgHFCUbauH4PD7NsrUlcIDIgsJCzUjSfjijFW1gK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMkMAQQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD3C4CECB;
	Mon,  2 Sep 2024 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310666;
	bh=sUiZRUjhLBtW8/wNG0mFQD+PLGXOhO1CknuDEWXqJL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fMkMAQQfCRGOnSP5Nklo0bJBGWDoDHU4KbBwJq78JW1pO8Q0ipi1uHC3Rymm4M2KA
	 tXsFLR+XPFqo75iih+91f6rPEmO/m6Kp88kc83tLYF+ECs3yTJKNhWHZefs+PtNb2t
	 g3+juNx6ZTcmCSLQ9Qb99O/B5VqZGDNXJ8oijc1oxrdd4Vu37F8rE35GyWy+vNShWU
	 c3FdLW539uLTZZoEZctJQ21tdkJZoXtcOD95h5WG3clNYas+ohCF7QpyuuhpYve26N
	 aFrl5+3VO9sO1KN7dsDXL7Bsikrxw6gNu01bC9kEi6SfAV8UUBsmagJqX8N0TE3e1a
	 Z61R36lkCKUHQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533521cd1c3so5305733e87.1;
        Mon, 02 Sep 2024 13:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnDomQwnP2TOnqcTcXH9kWPiXpoLSybxmcaYFGJtcQzIQIMS8MWJj4ufsy+UXTO2Bn2xMo9AnKbtUvxjlS@vger.kernel.org, AJvYcCVVTnE5yRVgEfHC3rDKru+uqi4XsLD91lLgEbN6VVLuAm62RiYd0JpXRuZ+wkv1L1rFj+oRyEZzLoc5UUJz@vger.kernel.org, AJvYcCXx0HqFUIwPVRcQq3DQlViRNNr1BcpcPeuy2dyObbp6mXlMkFrW4zg/8EAkFRZN3+oADafZGtdWtQ6a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tmvj+7yznlxMhbgeiSZ8lEhiyfq5W4dhLif5YlCrQXmDRYp8
	CbfcBTZWGZE/qb+HgTvbELRkb0OQwiiOcHQP7TCZY0Sz8lAWQ/5eN1pNPGYj24ZD7yhVXf44lOH
	m/wlF939vwb6uIoQAB2lQmBekamg=
X-Google-Smtp-Source: AGHT+IHJ4p0worhGswOIFYLV7bIu2jWZ5GSGj9+2fAyp9M6ZhDVhQ+mMD4GzTfXDOxpV03WgUGUVjyv1c/AsxX555Zs=
X-Received: by 2002:a05:6512:10d0:b0:52f:cd03:a823 with SMTP id
 2adb3069b0e04-53546bde481mr10323462e87.45.1725310664710; Mon, 02 Sep 2024
 13:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902161912.2751-1-adhemerval.zanella@linaro.org> <20240902161912.2751-3-adhemerval.zanella@linaro.org>
In-Reply-To: <20240902161912.2751-3-adhemerval.zanella@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 2 Sep 2024 22:57:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGddK5pkVUM0Gx5OZStpOhYEYQteRk-pPtZZZiDAn0wiw@mail.gmail.com>
Message-ID: <CAMj1kXGddK5pkVUM0Gx5OZStpOhYEYQteRk-pPtZZZiDAn0wiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: vdso: wire up getrandom() vDSO implementation
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Adhemerval,

I have just a couple of more points below, on the BE handling in the asm.

On Mon, 2 Sept 2024 at 18:19, Adhemerval Zanella
<adhemerval.zanella@linaro.org> wrote:
>
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data.
>
> The vDSO function requires a ChaCha20 implementation that does not write
> to the stack, and that can do an entire ChaCha20 permutation.  The one
> provided uses NEON on the permute operation, with a fallback to the
> syscall for chips that do not support AdvSIMD.
>
> This also passes the vdso_test_chacha test along with
> vdso_test_getrandom. The vdso_test_getrandom bench-single result on
> Neoverse-N1 shows:
>
>    vdso: 25000000 times in 0.783884250 seconds
>    libc: 25000000 times in 8.780275399 seconds
> syscall: 25000000 times in 8.786581518 seconds
>
> A small fixup to arch/arm64/include/asm/mman.h was required to avoid
> pulling kernel code into the vDSO, similar to what's already done in
> arch/arm64/include/asm/rwonce.h.
>
> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> ---
>  arch/arm64/Kconfig                         |   1 +
>  arch/arm64/include/asm/mman.h              |   6 +-
>  arch/arm64/include/asm/vdso.h              |   6 +
>  arch/arm64/include/asm/vdso/getrandom.h    |  50 ++++++
>  arch/arm64/include/asm/vdso/vsyscall.h     |  10 ++
>  arch/arm64/kernel/vdso.c                   |   6 -
>  arch/arm64/kernel/vdso/Makefile            |  25 ++-
>  arch/arm64/kernel/vdso/vdso                |   1 +
>  arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
>  arch/arm64/kernel/vdso/vgetrandom-chacha.S | 178 +++++++++++++++++++++
>  arch/arm64/kernel/vdso/vgetrandom.c        |  15 ++
>  tools/arch/arm64/vdso                      |   1 +
>  tools/include/linux/compiler.h             |   4 +
>  tools/testing/selftests/vDSO/Makefile      |   3 +-
>  14 files changed, 294 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>  create mode 120000 arch/arm64/kernel/vdso/vdso
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
>  create mode 120000 tools/arch/arm64/vdso
>
...
> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..4e5f9c349522
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/linkage.h>
> +#include <asm/cache.h>
> +#include <asm/assembler.h>
> +
> +       .text
> +
> +#define state0         v0
> +#define state1         v1
> +#define state2         v2
> +#define state3         v3
> +#define copy0          v4
> +#define copy0_q                q4
> +#define copy1          v5
> +#define copy2          v6
> +#define copy3          v7
> +#define copy3_d                d7
> +#define one_d          d16
> +#define one_q          q16
> +#define one_v          v16
> +#define tmp            v17
> +#define rot8           v18
> +
> +/*
> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> + * number of blocks of output with nonce 0, taking an input key and 8-bytes
> + * counter.  Importantly does not spill to the stack.
> + *
> + * This implementation avoids d8-d15 because they are callee-save in user
> + * space.
> + *
> + * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
> + *                                    const uint8_t *key,
> + *                                    uint32_t *counter,
> + *                                    size_t nblocks)
> + *
> + *     x0: output bytes
> + *     x1: 32-byte key input
> + *     x2: 8-byte counter input/output
> + *     x3: number of 64-byte block to write to output
> + */
> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> +
> +       /* copy0 = "expand 32-byte k" */
> +       mov_q           x8, 0x3320646e61707865
> +       mov_q           x9, 0x6b20657479622d32
> +       mov             copy0.d[0], x8
> +       mov             copy0.d[1], x9
> +
> +       /* copy1,copy2 = key */
> +       ld1             { copy1.4s, copy2.4s }, [x1]
> +       /* copy3 = counter || zero nonce  */
> +       ldr             copy3_d, [x2]
> +CPU_BE( rev64          copy3.4s, copy3.4s)
> +

This loads 2 u32s as a single u64, and then swaps them if we are running on BE.
So better to just use

  ld1 {copy3.2s}, [x2]

here, and drop the CPU_BE() special case.

> +       movi            one_v.2s, #1
> +       uzp1            one_v.4s, one_v.4s, one_v.4s
> +
> +.Lblock:
> +       /* copy state to auxiliary vectors for the final add after the permute.  */
> +       mov             state0.16b, copy0.16b
> +       mov             state1.16b, copy1.16b
> +       mov             state2.16b, copy2.16b
> +       mov             state3.16b, copy3.16b
> +
> +       mov             w4, 20
> +.Lpermute:
> +       /*
> +        * Permute one 64-byte block where the state matrix is stored in the four NEON
> +        * registers state0-state3.  It performs matrix operations on four words in parallel,
> +        * but requires shuffling to rearrange the words after each round.
> +        */
> +
> +.Ldoubleround:
> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
> +       add             state0.4s, state0.4s, state1.4s
> +       eor             state3.16b, state3.16b, state0.16b
> +       rev32           state3.8h, state3.8h
> +
> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
> +       add             state2.4s, state2.4s, state3.4s
> +       eor             tmp.16b, state1.16b, state2.16b
> +       shl             state1.4s, tmp.4s, #12
> +       sri             state1.4s, tmp.4s, #20
> +
> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
> +       add             state0.4s, state0.4s, state1.4s
> +       eor             tmp.16b, state3.16b, state0.16b
> +       shl             state3.4s, tmp.4s, #8
> +       sri             state3.4s, tmp.4s, #24
> +
> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
> +       add             state2.4s, state2.4s, state3.4s
> +       eor             tmp.16b, state1.16b, state2.16b
> +       shl             state1.4s, tmp.4s, #7
> +       sri             state1.4s, tmp.4s, #25
> +
> +       /* state1[0,1,2,3] = state1[1,2,3,0] */
> +       ext             state1.16b, state1.16b, state1.16b, #4
> +       /* state2[0,1,2,3] = state2[2,3,0,1] */
> +       ext             state2.16b, state2.16b, state2.16b, #8
> +       /* state3[0,1,2,3] = state3[1,2,3,0] */
> +       ext             state3.16b, state3.16b, state3.16b, #12
> +
> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
> +       add             state0.4s, state0.4s, state1.4s
> +       eor             state3.16b, state3.16b, state0.16b
> +       rev32           state3.8h, state3.8h
> +
> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
> +       add             state2.4s, state2.4s, state3.4s
> +       eor             tmp.16b, state1.16b, state2.16b
> +       shl             state1.4s, tmp.4s, #12
> +       sri             state1.4s, tmp.4s, #20
> +
> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
> +       add             state0.4s, state0.4s, state1.4s
> +       eor             tmp.16b, state3.16b, state0.16b
> +       shl             state3.4s, tmp.4s, #8
> +       sri             state3.4s, tmp.4s, #24
> +
> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
> +       add             state2.4s, state2.4s, state3.4s
> +       eor             tmp.16b, state1.16b, state2.16b
> +       shl             state1.4s, tmp.4s, #7
> +       sri             state1.4s, tmp.4s, #25
> +
> +       /* state1[0,1,2,3] = state1[3,0,1,2] */
> +       ext             state1.16b, state1.16b, state1.16b, #12
> +       /* state2[0,1,2,3] = state2[2,3,0,1] */
> +       ext             state2.16b, state2.16b, state2.16b, #8
> +       /* state3[0,1,2,3] = state3[1,2,3,0] */
> +       ext             state3.16b, state3.16b, state3.16b, #4
> +
> +       subs            w4, w4, #2
> +       b.ne            .Ldoubleround
> +
> +       /* output0 = state0 + state0 */
> +       add             state0.4s, state0.4s, copy0.4s
> +CPU_BE( rev32          state0.16b, state0.16b)
> +       /* output1 = state1 + state1 */
> +       add             state1.4s, state1.4s, copy1.4s
> +CPU_BE( rev32          state1.16b, state1.16b)
> +       /* output2 = state2 + state2 */
> +       add             state2.4s, state2.4s, copy2.4s
> +CPU_BE( rev32          state2.16b, state2.16b)
> +       /* output2 = state3 + state3 */
> +       add             state3.4s, state3.4s, copy3.4s
> +CPU_BE( rev32          state3.16b, state3.16b)
> +       st1             { state0.4s - state3.4s }, [x0]
> +

If the u32s shouldn't be swabbed for BE, you should simply be able to do

st1 {state0.16b - state3.16b}, [x0]

here, and drop the CPU_BE(*).

> +       /*
> +        * ++copy3.counter, the 'add' clears the upper half of the SIMD register
> +        * which is the expected behaviour here.
> +        */
> +       add             copy3_d, copy3_d, one_d
> +
> +       /* output += 64, --nblocks */
> +       add             x0, x0, 64
> +       subs            x3, x3, #1
> +       b.ne            .Lblock
> +
> +       /* counter = copy3.counter */
> +CPU_BE( rev64          copy3.4s, copy3.4s)
> +       str             copy3_d, [x2]
> +

... and this could be

st1 {copy3.2s}, [x2]

> +       /* Zero out the potentially sensitive regs, in case nothing uses these again. */
> +       movi            state0.16b, #0
> +       movi            state1.16b, #0
> +       movi            state2.16b, #0
> +       movi            state3.16b, #0
> +       movi            copy1.16b, #0
> +       movi            copy2.16b, #0
> +       ret
> +SYM_FUNC_END(__arch_chacha20_blocks_nostack)
> +
> +emit_aarch64_feature_1_and

