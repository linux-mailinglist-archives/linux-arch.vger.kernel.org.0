Return-Path: <linux-arch+bounces-6661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9D960C87
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5D81C20F80
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE31BB6B7;
	Tue, 27 Aug 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK2iYZgL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F658F54;
	Tue, 27 Aug 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766687; cv=none; b=cT9OYWDhKw8csBurfsCuzF5BSdXxSdaDekwFXOQVD+pxBRBMQi0i4atBMrJEr3jQPg6rMTB1sQ/XK6eW23K5f7FGnN0tWZ4l7p9beJkroJPXdNOA1eq1DdIgHzNlRrbJFKHJFP8mOGMTwtx4J8KRCovy+rnUIhDM/8lgAmoMktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766687; c=relaxed/simple;
	bh=i4R3LNWjGGRK9lK5dAlPs8k/3QxcZegbijSLg2LlOdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL7GJWbA4HsIgHBNYpJojZu99ted8p8iXYlLBN5bfNwpcDMoNQ6DdP+2n2/E2vjeBHrc2uc8BSTUEbGSq3ewAcjR03QWLcYIm5wPy72VFRZsfMBttmcEM3uuunSs58gj5Vj8jMMuhxM1PyrmZ27gqZFUlQvS/kq3Nr9AANLaSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK2iYZgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659CC4FE81;
	Tue, 27 Aug 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724766687;
	bh=i4R3LNWjGGRK9lK5dAlPs8k/3QxcZegbijSLg2LlOdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iK2iYZgL5izP9RHqtdic4iCItpd8vaAP6Grm64hiolAmp+qRdk+/NQf3j21+g9d5Y
	 uT0JjARiXbGpIsyhwXxq6FIxTmVru5BhHbK2btzMtwx90WEOe17EQXqm4V8xmimGRk
	 uf21D0zwjsJqRsch1F/kjx1QDkQw//9TSnzqC2yfEgImKvjw0IETpAPPgXXlsVwa88
	 IhY7oTx3nVEUfdD6OtfoYrx4KVZk4jzFCZaj3EuV6cM/k+mC5PIqREdRoy/XMHNrGo
	 jmFZ59gTgmpJ8yc4Fdqi4VAxOXf6Rl3lT52Hibdns9RErUY84J80mSyR7pGqXfPYj+
	 XVhtEN1LT4D/w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53346132365so6477397e87.1;
        Tue, 27 Aug 2024 06:51:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIAxUUZtM3G5k9jeqzNMhIQsieH928CF6JSg1q0VCGv+L73s66rxNC8QgriCGxu8JvCTLfQvRcNkbB/LfC@vger.kernel.org, AJvYcCUlDWhacrMZ/UI0aSzzUKxBvre4OQKZnLvJJHfmfO3fBiY2R/nx4fPPDl5G+Tzsh8L6H20mPp2RniKwfK3P@vger.kernel.org, AJvYcCVznzIbZbSoJ36y3MoMBqRFluWIFAoYau1USUc2ltsL0Kk6r6CVlAvewsvOteWsHbzl4RldUxm9a0Fa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cTWGDNnzuyGOusC2hieUbtUPmLjDo4BOT+MtjUYA9bneQ+85
	CXzSGP84Pp8Uwoq7p84yOgVdnLVDdegl+w6Culp/MyKagIVpAqeFlBHbcQov3Fnpb4n+wQU3Utg
	cdie9GMtJRSTBRge0nwsy4Xj+Kic=
X-Google-Smtp-Source: AGHT+IHN2l4sloAjBg8ujMfn3jI7UbVTMJMQSaQdc5aJM+cNfKIaWp4PsouKm4uFv5oS26zdJ17GDFDP7wkrDmjQIIk=
X-Received: by 2002:a05:6512:1110:b0:533:4689:9750 with SMTP id
 2adb3069b0e04-5344e3dd56bmr1722609e87.26.1724766685571; Tue, 27 Aug 2024
 06:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
In-Reply-To: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 15:51:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFan+yKH_Z8ib=dDBiupRO1SpBn1EbkUC6pQ_k5+bjUvQ@mail.gmail.com>
Message-ID: <CAMj1kXFan+yKH_Z8ib=dDBiupRO1SpBn1EbkUC6pQ_k5+bjUvQ@mail.gmail.com>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Adhemerval,

...

> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..3fb9715dd6f0
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/linkage.h>
> +#include <asm/cache.h>
> +
> +       .text
> +
> +/*
> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
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

Shouldn't we preserve d8-d15 here?

> +       /* v0 = "expand 32-byte k" */
> +       adr_l           x8, CTES
> +       ld1             {v5.4s}, [x8]
> +       /* v1,v2 = key */
> +       ld1             { v6.4s, v7.4s }, [x1]
> +       /* v3 = counter || zero noonce  */
> +       ldr             d8, [x2]
> +
> +       adr_l           x8, ONE
> +       ldr             q13, [x8]
> +
> +       adr_l           x10, ROT8
> +       ld1             {v12.4s}, [x10]
> +.Lblock:
> +       /* copy state to auxiliary vectors for the final add after the permute.  */
> +       mov             v0.16b, v5.16b
> +       mov             v1.16b, v6.16b
> +       mov             v2.16b, v7.16b
> +       mov             v3.16b, v8.16b
> +
> +       mov             w4, 20
> +.Lpermute:
> +       /*
> +        * Permute one 64-byte block where the state matrix is stored in the four NEON
> +        * registers v0-v3.  It performs matrix operations on four words in parallel,
> +        * but requires shuffling to rearrange the words after each round.
> +        */
> +
> +.Ldoubleround:
> +       /* x0 += x1, x3 = rotl32(x3 ^ x0, 16) */
> +       add             v0.4s, v0.4s, v1.4s
> +       eor             v3.16b, v3.16b, v0.16b
> +       rev32           v3.8h, v3.8h
> +
> +       /* x2 += x3, x1 = rotl32(x1 ^ x2, 12) */
> +       add             v2.4s, v2.4s, v3.4s
> +       eor             v4.16b, v1.16b, v2.16b
> +       shl             v1.4s, v4.4s, #12
> +       sri             v1.4s, v4.4s, #20
> +
> +       /* x0 += x1, x3 = rotl32(x3 ^ x0, 8) */
> +       add             v0.4s, v0.4s, v1.4s
> +       eor             v3.16b, v3.16b, v0.16b
> +       tbl             v3.16b, {v3.16b}, v12.16b
> +
> +       /* x2 += x3, x1 = rotl32(x1 ^ x2, 7) */
> +       add             v2.4s, v2.4s, v3.4s
> +       eor             v4.16b, v1.16b, v2.16b
> +       shl             v1.4s, v4.4s, #7
> +       sri             v1.4s, v4.4s, #25
> +
> +       /* x1 = shuffle32(x1, MASK(0, 3, 2, 1)) */
> +       ext             v1.16b, v1.16b, v1.16b, #4
> +       /* x2 = shuffle32(x2, MASK(1, 0, 3, 2)) */
> +       ext             v2.16b, v2.16b, v2.16b, #8
> +       /* x3 = shuffle32(x3, MASK(2, 1, 0, 3)) */
> +       ext             v3.16b, v3.16b, v3.16b, #12
> +
> +       /* x0 += x1, x3 = rotl32(x3 ^ x0, 16) */
> +       add             v0.4s, v0.4s, v1.4s
> +       eor             v3.16b, v3.16b, v0.16b
> +       rev32           v3.8h, v3.8h
> +
> +       /* x2 += x3, x1 = rotl32(x1 ^ x2, 12) */
> +       add             v2.4s, v2.4s, v3.4s
> +       eor             v4.16b, v1.16b, v2.16b
> +       shl             v1.4s, v4.4s, #12
> +       sri             v1.4s, v4.4s, #20
> +
> +       /* x0 += x1, x3 = rotl32(x3 ^ x0, 8) */
> +       add             v0.4s, v0.4s, v1.4s
> +       eor             v3.16b, v3.16b, v0.16b
> +       tbl             v3.16b, {v3.16b}, v12.16b
> +
> +       /* x2 += x3, x1 = rotl32(x1 ^ x2, 7) */
> +       add             v2.4s, v2.4s, v3.4s
> +       eor             v4.16b, v1.16b, v2.16b
> +       shl             v1.4s, v4.4s, #7
> +       sri             v1.4s, v4.4s, #25
> +
> +       /* x1 = shuffle32(x1, MASK(2, 1, 0, 3)) */
> +       ext             v1.16b, v1.16b, v1.16b, #12
> +       /* x2 = shuffle32(x2, MASK(1, 0, 3, 2)) */
> +       ext             v2.16b, v2.16b, v2.16b, #8
> +       /* x3 = shuffle32(x3, MASK(0, 3, 2, 1)) */
> +       ext             v3.16b, v3.16b, v3.16b, #4
> +
> +       subs            w4, w4, #2
> +       b.ne            .Ldoubleround
> +
> +       /* output0 = state0 + v0 */
> +       add             v0.4s, v0.4s, v5.4s
> +       /* output1 = state1 + v1 */
> +       add             v1.4s, v1.4s, v6.4s
> +       /* output2 = state2 + v2 */
> +       add             v2.4s, v2.4s, v7.4s
> +       /* output2 = state3 + v3 */
> +       add             v3.4s, v3.4s, v8.4s
> +       st1             { v0.4s - v3.4s }, [x0]
> +
> +       /* ++copy3.counter */
> +       add             d8, d8, d13
> +
> +       /* output += 64, --nblocks */
> +       add             x0, x0, 64
> +       subs            x3, x3, #1
> +       b.ne            .Lblock
> +
> +       /* counter = copy3.counter */
> +       str             d8, [x2]
> +
> +       /* Zero out the potentially sensitive regs, in case nothing uses these again. */
> +       eor             v0.16b, v0.16b, v0.16b
> +       eor             v1.16b, v1.16b, v1.16b
> +       eor             v2.16b, v2.16b, v2.16b
> +       eor             v3.16b, v3.16b, v3.16b
> +       eor             v6.16b, v6.16b, v6.16b
> +       eor             v7.16b, v7.16b, v7.16b
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

