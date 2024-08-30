Return-Path: <linux-arch+bounces-6860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3080966823
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74D91C23FD9
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62735192D6A;
	Fri, 30 Aug 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ro4/v4Cu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B31B4C2D
	for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039491; cv=none; b=V3MEakv72RwLukkUycMP2yZk5U46w5+srO9Pf1NeMZceTb7nLGqm61DITwcvabZbfiNxNo2qku/qCoeWmmimOe3arPoZOXI5srO4EAJpr23n7wAVu00eiwI34LdAitPzJagRXpnvouGVxLaeR3gX9ezwd48BugB+qynHlz9IOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039491; c=relaxed/simple;
	bh=DIRvJN75BI6ZcDMoN56RkJd770BrPZnL26TYARaCmLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFxd/f25DmAZBCfsLyYCtWI/ZkNB+JMoANQ12zhZilxjh2hKCehFwMIw+JnAXPfTGTTFpWPPmPkk/qzHyq0/lok4AGygeLjYne5Eh4EbBYwQMQtkKf1na9RLdEnsZpuLSrKnnvG3CaPuWrsGO1NuzAx6ZHPnW/mAs6Ding+HxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ro4/v4Cu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021c03c13aso18295425ad.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725039488; x=1725644288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94im9BOaQRR7bOCoTzpbzzJQE0FEOF3V36nzvAWIihA=;
        b=ro4/v4Cu2j2uoZMDWqGQW4e+Wksy09259D7UYPqzv3s0LrTyKf1B2Zhl1aB8Quij85
         rGSzWF7pfS+wMRC29CGr8iHosB1OSyTD6N2V12KIZhhxi8LcSv4QUHODeNckMYUU6LaX
         AZM4R/vXiqJKjfZ+SoN3P4NTAwzRaZzzMDziJ2gfzurXgwCyj9JpXE2eb3eMh1RhmJ5H
         DXmbWqOuMJa/wkqcCtb6s0pY8S/tiwhdXkwG2Ine66JLBaqlBaD5EckW2Y8dmZ0Fld48
         2PMug7MKJKHyiU1xoKf1bh2C3sh3PIiwDcGynbMo6C8tKEckxBJnbxLb/Kh+OldOKzI1
         8rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039488; x=1725644288;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94im9BOaQRR7bOCoTzpbzzJQE0FEOF3V36nzvAWIihA=;
        b=Okj7soBPfm+PptxCkIg1f5Tgid2rE2BEqkAOy6fgibjWWg7XS5hPSmFwxZkqrEAp0M
         WfSuNZclhFaJrHycbckhgufbOvg1UTUgyPGtVAOkMBO6tU+diEfv3nsRRlAQ5m/tsh2j
         xHWEZL1CvzrnqrU6uU6EIlzKTD29O1qblOTyEuN7Zzl9xkZhwwaqLSudAbIvGnXjxnRX
         YLH5gVZOVQxObMY/gaZg4CHWcRTKNVCWd3k+KHtgsD7GmA5/K47leGN5at2RGZbNZOuS
         2sB9w4v+KABuI2U6r2Dq/tSfZJ6KwMwRO9f1reu3pzEa4Bsw0/RlSdlc3Q6YpwCJZpNJ
         YZnw==
X-Forwarded-Encrypted: i=1; AJvYcCUVTuGcMgzu2hqFfzSJf1dqdD0QYDdIIZbduU0lxteZzBs0AnZNNLIfTyOnKiFR5VczRQ3ob6j0Ey7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lqYAHu29RY0nsW+7cIPJr+sJHmm+Uw9QzdpaTH6uVi7slDmp
	N5sHnTl2TLPBk9+vZhXGiN6JJvEQpfrl1e9WRWGAsEMsNRUCtziU79s1fT8JPms=
X-Google-Smtp-Source: AGHT+IG7OtLe0iFlbzoAtEYseXf/s/gcdc6CrXeB4sUmiwH1tdSbqIL80AQ35CS2r2ZSAVwszoA3ew==
X-Received: by 2002:a17:902:e5c2:b0:203:a03c:a4ae with SMTP id d9443c01a7336-205287d5e1amr56017255ad.24.1725039487814;
        Fri, 30 Aug 2024 10:38:07 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:97d:de0:fa17:dbc6? ([2804:1b3:a7c3:4c2c:97d:de0:fa17:dbc6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3122sm29552965ad.9.2024.08.30.10.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 10:38:07 -0700 (PDT)
Message-ID: <723120f6-c2e5-4277-bcd7-daf95984877e@linaro.org>
Date: Fri, 30 Aug 2024 14:38:03 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <CAMj1kXEnYW7ft3e-bSqWRLhickUeOkaWwtVVSxi49jski6T2iQ@mail.gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <CAMj1kXEnYW7ft3e-bSqWRLhickUeOkaWwtVVSxi49jski6T2iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/24 11:11, Ard Biesheuvel wrote:
> On Thu, 29 Aug 2024 at 22:17, Adhemerval Zanella
> <adhemerval.zanella@linaro.org> wrote:
>>
>> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
>> The _vdso_rng_data required data is placed within the _vdso_data vvar
>> page, by using a offset larger than the vdso_data.
>>
>> The vDSO function requires a ChaCha20 implementation that does not
>> write to the stack, and that can do an entire ChaCha20 permutation.
>> The one provided is based on the current chacha-neon-core.S and uses NEON
>> on the permute operation. The fallback for chips that do not support
>> NEON issues the syscall.
>>
>> This also passes the vdso_test_chacha test along with
>> vdso_test_getrandom. The vdso_test_getrandom bench-single result on
>> Neoverse-N1 shows:
>>
>>    vdso: 25000000 times in 0.746506464 seconds
>>    libc: 25000000 times in 8.849179444 seconds
>> syscall: 25000000 times in 8.818726425 seconds
>>
>> Changes from v1:
>> - Fixed style issues and typos.
>> - Added fallback for systems without NEON support.
>> - Avoid use of non-volatile vector registers in neon chacha20.
>> - Use c-getrandom-y for vgetrandom.c.
>> - Fixed TIMENS vdso_rnd_data access.
>>
>> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
>> ---
> ...
>> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
>> new file mode 100644
>> index 000000000000..9ebf12a09c65
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/cache.h>
>> +#include <asm/assembler.h>
>> +
>> +       .text
>> +
>> +#define state0         v0
>> +#define state1         v1
>> +#define state2         v2
>> +#define state3         v3
>> +#define copy0          v4
>> +#define copy1          v5
>> +#define copy2          v6
>> +#define copy3          v7
>> +#define copy3_d                d7
>> +#define one_d          d16
>> +#define one_q          q16
>> +#define tmp            v17
>> +#define rot8           v18
>> +
> 
> Please make a note somewhere around here that you are deliberately
> avoiding d8-d15 because they are callee-save in user space.

Ack.

> 
>> +/*
>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>> + * number of blocks of output with nonce 0, taking an input key and 8-bytes
>> + * counter.  Importantly does not spill to the stack.
>> + *
>> + * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
>> + *                                    const uint8_t *key,
>> + *                                    uint32_t *counter,
>> + *                                    size_t nblocks)
>> + *
>> + *     x0: output bytes
>> + *     x1: 32-byte key input
>> + *     x2: 8-byte counter input/output
>> + *     x3: number of 64-byte block to write to output
>> + */
>> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>> +
>> +       /* copy0 = "expand 32-byte k" */
>> +       adr_l           x8, CTES
>> +       ld1             {copy0.4s}, [x8]
>> +       /* copy1,copy2 = key */
>> +       ld1             { copy1.4s, copy2.4s }, [x1]
>> +       /* copy3 = counter || zero nonce  */
>> +       ldr             copy3_d, [x2]
>> +
>> +       adr_l           x8, ONE
>> +       ldr             one_q, [x8]
>> +
>> +       adr_l           x10, ROT8
>> +       ld1             {rot8.4s}, [x10]
> 
> These immediate loads are forcing the vDSO to have a .rodata section,
> which is best avoided, given that this is mapped into every user space
> program.
> 
> Either use the existing mov_q macro and then move the values into SIMD
> registers, or compose the required vectors in a different way.

Ack, mov_q seems suffice here.

> 
> E.g., with one_v == v16,
> 
> movi one_v.2s, #1
> uzp1 one_v.4s, one_v.4s, one_v.4s
> 
> puts the correct value in one_d, uses 1 instruction and 16 bytes of
> rodata less, and avoids a memory access.

Ack.

> 
> The ROT8 + tbl can be replaced by shl/sri (see below)
> 
>> +.Lblock:
>> +       /* copy state to auxiliary vectors for the final add after the permute.  */
>> +       mov             state0.16b, copy0.16b
>> +       mov             state1.16b, copy1.16b
>> +       mov             state2.16b, copy2.16b
>> +       mov             state3.16b, copy3.16b
>> +
>> +       mov             w4, 20
>> +.Lpermute:
>> +       /*
>> +        * Permute one 64-byte block where the state matrix is stored in the four NEON
>> +        * registers state0-state3.  It performs matrix operations on four words in parallel,
>> +        * but requires shuffling to rearrange the words after each round.
>> +        */
>> +
>> +.Ldoubleround:
>> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
>> +       add             state0.4s, state0.4s, state1.4s
>> +       eor             state3.16b, state3.16b, state0.16b
>> +       rev32           state3.8h, state3.8h
>> +
>> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
>> +       add             state2.4s, state2.4s, state3.4s
>> +       eor             tmp.16b, state1.16b, state2.16b
>> +       shl             state1.4s, tmp.4s, #12
>> +       sri             state1.4s, tmp.4s, #20
>> +
>> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
>> +       add             state0.4s, state0.4s, state1.4s
>> +       eor             state3.16b, state3.16b, state0.16b
>> +       tbl             state3.16b, {state3.16b}, rot8.16b
>> +
> 
> This can be changed to the below, removing the need for the ROT8 vector
> 
> eor   tmp.16b, state3.16b, state0.16b
> shl   state3.4s, tmp.4s, #8
> sri   state3.4s, tmp.4s, #24
> 

Ack.

>> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
>> +       add             state2.4s, state2.4s, state3.4s
>> +       eor             tmp.16b, state1.16b, state2.16b
>> +       shl             state1.4s, tmp.4s, #7
>> +       sri             state1.4s, tmp.4s, #25
>> +
>> +       /* state1[0,1,2,3] = state1[1,2,3,0] */
>> +       ext             state1.16b, state1.16b, state1.16b, #4
>> +       /* state2[0,1,2,3] = state2[2,3,0,1] */
>> +       ext             state2.16b, state2.16b, state2.16b, #8
>> +       /* state3[0,1,2,3] = state3[1,2,3,0] */
>> +       ext             state3.16b, state3.16b, state3.16b, #12
>> +
>> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
>> +       add             state0.4s, state0.4s, state1.4s
>> +       eor             state3.16b, state3.16b, state0.16b
>> +       rev32           state3.8h, state3.8h
>> +
>> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
>> +       add             state2.4s, state2.4s, state3.4s
>> +       eor             tmp.16b, state1.16b, state2.16b
>> +       shl             state1.4s, tmp.4s, #12
>> +       sri             state1.4s, tmp.4s, #20
>> +
>> +       /* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
>> +       add             state0.4s, state0.4s, state1.4s
>> +       eor             state3.16b, state3.16b, state0.16b
>> +       tbl             state3.16b, {state3.16b}, rot8.16b
>> +
>> +       /* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
>> +       add             state2.4s, state2.4s, state3.4s
>> +       eor             tmp.16b, state1.16b, state2.16b
>> +       shl             state1.4s, tmp.4s, #7
>> +       sri             state1.4s, tmp.4s, #25
>> +
>> +       /* state1[0,1,2,3] = state1[3,0,1,2] */
>> +       ext             state1.16b, state1.16b, state1.16b, #12
>> +       /* state2[0,1,2,3] = state2[2,3,0,1] */
>> +       ext             state2.16b, state2.16b, state2.16b, #8
>> +       /* state3[0,1,2,3] = state3[1,2,3,0] */
>> +       ext             state3.16b, state3.16b, state3.16b, #4
>> +
>> +       subs            w4, w4, #2
>> +       b.ne            .Ldoubleround
>> +
>> +       /* output0 = state0 + state0 */
>> +       add             state0.4s, state0.4s, copy0.4s
>> +       /* output1 = state1 + state1 */
>> +       add             state1.4s, state1.4s, copy1.4s
>> +       /* output2 = state2 + state2 */
>> +       add             state2.4s, state2.4s, copy2.4s
>> +       /* output2 = state3 + state3 */
>> +       add             state3.4s, state3.4s, copy3.4s
>> +       st1             { state0.4s - state3.4s }, [x0]
>> +
>> +       /* ++copy3.counter */
>> +       add             copy3_d, copy3_d, one_d
>> +
> 
> This 'add' clears the upper half of the SIMD register, which is where
> the zero nonce lives. So this happens to be correct, but it is not
> very intuitive, so perhaps a comment would be in order here.

Ack, will do.

> 
>> +       /* output += 64, --nblocks */
>> +       add             x0, x0, 64
>> +       subs            x3, x3, #1
>> +       b.ne            .Lblock
>> +
>> +       /* counter = copy3.counter */
>> +       str             copy3_d, [x2]
>> +
>> +       /* Zero out the potentially sensitive regs, in case nothing uses these again. */
>> +       eor             state0.16b, state0.16b, state0.16b
>> +       eor             state1.16b, state1.16b, state1.16b
>> +       eor             state2.16b, state2.16b, state2.16b
>> +       eor             state3.16b, state3.16b, state3.16b
>> +       eor             copy1.16b, copy1.16b, copy1.16b
>> +       eor             copy2.16b, copy2.16b, copy2.16b
> 
> This is not x86 - no need to use XOR to clear registers, you can just
> use 'movi reg.16b, #0' here.

Ack.

> 
>> +       ret
>> +SYM_FUNC_END(__arch_chacha20_blocks_nostack)
>> +
>> +        .section        ".rodata", "a", %progbits
>> +        .align          L1_CACHE_SHIFT
>> +
>> +CTES:  .word           1634760805, 857760878,  2036477234, 1797285236
>> +ONE:    .xword         1, 0
>> +ROT8:  .word           0x02010003, 0x06050407, 0x0a09080b, 0x0e0d0c0f
>> +
>> +emit_aarch64_feature_1_and
> ...

