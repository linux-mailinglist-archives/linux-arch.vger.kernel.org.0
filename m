Return-Path: <linux-arch+bounces-6851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E29663DB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA77B21A70
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E51B250F;
	Fri, 30 Aug 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhKSJIgV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1C1B2506;
	Fri, 30 Aug 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027103; cv=none; b=PYzvv8G/zsOI/hf/OjizDX00p5w+ZjV+4bVttYSSopwietN+4V6q/NVZtd4f6F14y4bc+4OJTDNQmpt7K0ANwVSwsNU4Z+NXikgpcb1EQITAQWQYjDh3dOzirX5vl1GxFgbPUp4/vkccee828yJseNv/0Jhg9UW/Z/3+Huonxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027103; c=relaxed/simple;
	bh=ch8Utom+56+XDFDbn3FU+sYc1K0Xb7UEZ5WQPpM5Tb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf5YPC0yNP9X8TwCd9jm7eFFjphpR8jsIkhfVZPR9tVgGgsjVlMw3r5auaioOz2DEuXrqmTGZXFmMSFNr38VCB2FffwVDlYXigx7B3SeBnQDW754ba5QyKwjZ/VlITX6GUwgtr/MOv3/lgjz/zYObhVsNVPx08XjXaONEPwbZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhKSJIgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3A2C4AF09;
	Fri, 30 Aug 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725027102;
	bh=ch8Utom+56+XDFDbn3FU+sYc1K0Xb7UEZ5WQPpM5Tb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rhKSJIgVXAJcIIBKVQ5S1zArqjnbThz3xFzHl3wZqv7dZwkMs0KBYXHgGey+Xwv4r
	 f3FBXvxVxG5IVKWJv68qPBLfVZJs3rUhMfeMijPEkkmveKCrmwtKh8qLNtzBZUTovg
	 gcbPl3ZbsiAOxnxjnX6/btcO4Qk0nBZC4tco/aiZWsBoM6dL4BMp3gpFATOLF3VIJZ
	 YPA+SVyMCTIbOcCcJbdVUr2e33DEcvlTcacmDRbmo6mMCCQmh6kog1VIBlQeIpXmzb
	 d0WKmSMOg50ck5bHPl4uGYo22k7oviuqmj/ILIWxWdzLueAibKKTH53GwebvsRX/zb
	 yhG/M1H698JoA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f401b2347dso17140791fa.1;
        Fri, 30 Aug 2024 07:11:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfChxQe/Z3H8kNZwu69USPdBJh50aIVGhDv8rq4/7qA/2hgKDPbKEfWrnXh0fEpb42jvCksomLFtnakg0Z@vger.kernel.org, AJvYcCXOAU3yKalcrQerhU63tTAqlQMeRCdVaK2Ie/aQWtBDW8sZDYCmZHX9ev602pFSGV6orp668HYnF4Ze/Yyl@vger.kernel.org, AJvYcCXdsuo04eef1Dg8XceqXdKQG6slnRfAFa1TXpCq+tM7skjHgIwvxDqD+/X1TySGbaem2DNvRlXFuCny@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXN7xR8U4ToGDUiKeMfwBDbOg0p/vGX7KRCF9bV6O2MerJhBt
	b0lz9cwNDvuVBO0ZaP/n7x1fvFm1lr+ekQTBrJhdInerBSyOEEdzf/ImF6/UlaOOH9Lj4ZjQtiQ
	GC/u1vPJTE1O9u/pWlkPVe3NHORA=
X-Google-Smtp-Source: AGHT+IGiNNIe4grFCSjxYEqSnqQsOiH7XwhNWIjK0meKiNuL/INJUoIL0DANP+RT2C1dTcJ4zfatNi8NnI5TRaXEni0=
X-Received: by 2002:a05:651c:504:b0:2f1:59d5:ac01 with SMTP id
 38308e7fff4ca-2f61e06f834mr10448761fa.14.1725027100557; Fri, 30 Aug 2024
 07:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Aug 2024 16:11:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEnYW7ft3e-bSqWRLhickUeOkaWwtVVSxi49jski6T2iQ@mail.gmail.com>
Message-ID: <CAMj1kXEnYW7ft3e-bSqWRLhickUeOkaWwtVVSxi49jski6T2iQ@mail.gmail.com>
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 22:17, Adhemerval Zanella
<adhemerval.zanella@linaro.org> wrote:
>
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data.
>
> The vDSO function requires a ChaCha20 implementation that does not
> write to the stack, and that can do an entire ChaCha20 permutation.
> The one provided is based on the current chacha-neon-core.S and uses NEON
> on the permute operation. The fallback for chips that do not support
> NEON issues the syscall.
>
> This also passes the vdso_test_chacha test along with
> vdso_test_getrandom. The vdso_test_getrandom bench-single result on
> Neoverse-N1 shows:
>
>    vdso: 25000000 times in 0.746506464 seconds
>    libc: 25000000 times in 8.849179444 seconds
> syscall: 25000000 times in 8.818726425 seconds
>
> Changes from v1:
> - Fixed style issues and typos.
> - Added fallback for systems without NEON support.
> - Avoid use of non-volatile vector registers in neon chacha20.
> - Use c-getrandom-y for vgetrandom.c.
> - Fixed TIMENS vdso_rnd_data access.
>
> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> ---
...
> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..9ebf12a09c65
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,168 @@
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
> +#define copy1          v5
> +#define copy2          v6
> +#define copy3          v7
> +#define copy3_d                d7
> +#define one_d          d16
> +#define one_q          q16
> +#define tmp            v17
> +#define rot8           v18
> +

Please make a note somewhere around here that you are deliberately
avoiding d8-d15 because they are callee-save in user space.

> +/*
> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> + * number of blocks of output with nonce 0, taking an input key and 8-bytes
> + * counter.  Importantly does not spill to the stack.
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
> +       adr_l           x8, CTES
> +       ld1             {copy0.4s}, [x8]
> +       /* copy1,copy2 = key */
> +       ld1             { copy1.4s, copy2.4s }, [x1]
> +       /* copy3 = counter || zero nonce  */
> +       ldr             copy3_d, [x2]
> +
> +       adr_l           x8, ONE
> +       ldr             one_q, [x8]
> +
> +       adr_l           x10, ROT8
> +       ld1             {rot8.4s}, [x10]

These immediate loads are forcing the vDSO to have a .rodata section,
which is best avoided, given that this is mapped into every user space
program.

Either use the existing mov_q macro and then move the values into SIMD
registers, or compose the required vectors in a different way.

E.g., with one_v == v16,

movi one_v.2s, #1
uzp1 one_v.4s, one_v.4s, one_v.4s

puts the correct value in one_d, uses 1 instruction and 16 bytes of
rodata less, and avoids a memory access.

The ROT8 + tbl can be replaced by shl/sri (see below)

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
> +       eor             state3.16b, state3.16b, state0.16b
> +       tbl             state3.16b, {state3.16b}, rot8.16b
> +

This can be changed to the below, removing the need for the ROT8 vector

eor   tmp.16b, state3.16b, state0.16b
shl   state3.4s, tmp.4s, #8
sri   state3.4s, tmp.4s, #24

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
> +       eor             state3.16b, state3.16b, state0.16b
> +       tbl             state3.16b, {state3.16b}, rot8.16b
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
> +       /* output1 = state1 + state1 */
> +       add             state1.4s, state1.4s, copy1.4s
> +       /* output2 = state2 + state2 */
> +       add             state2.4s, state2.4s, copy2.4s
> +       /* output2 = state3 + state3 */
> +       add             state3.4s, state3.4s, copy3.4s
> +       st1             { state0.4s - state3.4s }, [x0]
> +
> +       /* ++copy3.counter */
> +       add             copy3_d, copy3_d, one_d
> +

This 'add' clears the upper half of the SIMD register, which is where
the zero nonce lives. So this happens to be correct, but it is not
very intuitive, so perhaps a comment would be in order here.

> +       /* output += 64, --nblocks */
> +       add             x0, x0, 64
> +       subs            x3, x3, #1
> +       b.ne            .Lblock
> +
> +       /* counter = copy3.counter */
> +       str             copy3_d, [x2]
> +
> +       /* Zero out the potentially sensitive regs, in case nothing uses these again. */
> +       eor             state0.16b, state0.16b, state0.16b
> +       eor             state1.16b, state1.16b, state1.16b
> +       eor             state2.16b, state2.16b, state2.16b
> +       eor             state3.16b, state3.16b, state3.16b
> +       eor             copy1.16b, copy1.16b, copy1.16b
> +       eor             copy2.16b, copy2.16b, copy2.16b

This is not x86 - no need to use XOR to clear registers, you can just
use 'movi reg.16b, #0' here.

> +       ret
> +SYM_FUNC_END(__arch_chacha20_blocks_nostack)
> +
> +        .section        ".rodata", "a", %progbits
> +        .align          L1_CACHE_SHIFT
> +
> +CTES:  .word           1634760805, 857760878,  2036477234, 1797285236
> +ONE:    .xword         1, 0
> +ROT8:  .word           0x02010003, 0x06050407, 0x0a09080b, 0x0e0d0c0f
> +
> +emit_aarch64_feature_1_and
...

