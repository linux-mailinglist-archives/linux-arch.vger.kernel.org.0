Return-Path: <linux-arch+bounces-4833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF2904305
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01811C2099A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63F60BBE;
	Tue, 11 Jun 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XkcZDhng"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AE54F8C
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128819; cv=none; b=RyzIFVHSN/S2es8PRi4KBPDO7AxAUvCL8SjvPE0EqdjyIpmvWx4UIe72ljsfUklv1eFhV0Tn7bF4UVWoaETrkpwJmrAgGQEewjKOtzXTjJ4AP66EjHvZt8r3htmmpVD71H5IfdONjex4UvCDfpAuKFepJLJFw4Ziop5gYB1lkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128819; c=relaxed/simple;
	bh=nwpZTn8pFzGOwf4ZB/VvlBs8EE7Mx/yz85WdIMLghPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGyPP50KKkYKB3sgRRilzuEEK6OE2naZZBOpvEL4m4XD8acLngprXO31BqS2Zb/4zGvS/aL9yLq9/oF4QPAG2THrBib2wIHDfE7qo+W92zdTlNz9P2FdqKZ97S9IKP1EwaENwhllpVWezyTw36PY5vgl1+md8iOFdUBVwuANnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XkcZDhng; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so1954550a12.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718128816; x=1718733616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dfppZ4J9iItfp/zeqA6eCwjM7fUz1YkqRKfl9RCRvzw=;
        b=XkcZDhngnOCcQcYNv7/qF5g/TwEVHzOTAuAr2M+LRJNBaJMjWfRiBsSxwNsO/wLwBo
         SzxzZJR5noXovpBaD/MNO9Zs/iJsgf3EvnIV2GD70jisAojP1P2vVem5LAEmv6IbQKKc
         Fvu7lztCOOVh7iTZo4Pvsma5tXVfPubF6MgpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128816; x=1718733616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfppZ4J9iItfp/zeqA6eCwjM7fUz1YkqRKfl9RCRvzw=;
        b=SHFTPh0Ht/r8y49trXJTYDAtRWvl8L5uJoTmGurHkQXv0XFGUGjvPE9GCjGSMiKedu
         8CDs3P/JdrXs5TQUXfuHuSw5KT40egkLOV2sz2haFMkIhWWD+QbUfTe5ANX1qmBq20AZ
         tY4yVRVJ0GRmns0ezhg/x/rXnwAAwRS/P3u25poAL3JcFI3QXAsYUulV/SnaE5vYnw6S
         MROtXijsVV0NvtnwBwMqtrxZ7TlPa/g2iryEJI4m3D0EPWO5I+eBVFCkF0+ptfiga8b5
         cgMxva6vz+a2b9D2/MeCOssUDMNNzjgqMWKPHPLdMVSmZB/4lyGyQ6AzWIzOZ7JX8TIv
         8Hgw==
X-Forwarded-Encrypted: i=1; AJvYcCX1kTVMpbbbG13XgNQ+5HgtgdF8Hy2/tOzrCe5UP4X1xuVXH8EsVDSBLnl7T9xzINIdlKVOOoFQErxvV47Fi9y3Zv1ozt1m+8R+Vw==
X-Gm-Message-State: AOJu0YxhGBIBV4X/j9Hp/+S/suP55i2Ud+1KRgX99vRbMLPICb5IN3qD
	0vY8wOtiC+8P+7m46KVA3A4QFEoxCrUbZe4tMczQvc9q9DztC3ra1riPAT00NWLPlyywjRdA6EI
	3YMM=
X-Google-Smtp-Source: AGHT+IE69LruOxGFoFo/jAxBZO98ROA6O0fIiZcXOWEcn3/oxPTqcRrNTjjPpDLqWX1roceu678hHg==
X-Received: by 2002:a50:bb03:0:b0:57a:72fc:c515 with SMTP id 4fb4d7f45d1cf-57c50972f4emr10960436a12.29.1718128816179;
        Tue, 11 Jun 2024 11:00:16 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm9659812a12.3.2024.06.11.11.00.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:00:13 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so2218955a12.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 11:00:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXo/qTMHzPz9L2lQsLWIBcqzET4r6pWGg2vqHQXnsDI0eMf2PuoB4wdNiOo7J/MfKZflxdzXDrKq2KJLo18UeVO15bLpkB8ySgQQ==
X-Received: by 2002:a50:d69c:0:b0:57c:5f7e:d0f1 with SMTP id
 4fb4d7f45d1cf-57c5f7ed498mr8641041a12.38.1718128812554; Tue, 11 Jun 2024
 11:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com> <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
In-Reply-To: <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 10:59:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
Message-ID: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 10:48, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Fair enough if that's a pain on x86, but we already have them on arm64, and
> hence using them is a smaller change there. We already have a couple of cases
> which uses MOVZ;MOVK;MOVK;MOVK sequence, e.g.
>
>         // in __invalidate_icache_max_range()
>         asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
>                                     "movk %0, #0, lsl #16\n"
>                                     "movk %0, #0, lsl #32\n"
>                                     "movk %0, #0, lsl #48\n",
>                                     ARM64_ALWAYS_SYSTEM,
>                                     kvm_compute_final_ctr_el0)
>                      : "=r" (ctr));
>
> ... which is patched via the callback:
>
>         void kvm_compute_final_ctr_el0(struct alt_instr *alt,
>                                        __le32 *origptr, __le32 *updptr, int nr_inst)
>         {
>                 generate_mov_q(read_sanitised_ftr_reg(SYS_CTR_EL0),
>                                origptr, updptr, nr_inst);
>         }
>
> ... where the generate_mov_q() helper does the actual instruction generation.
>
> So if we only care about a few specific constants, we could give them their own
> callbacks, like kvm_compute_final_ctr_el0() above.

I'll probably only have another day until my mailbox starts getting
more pull requests (Mon-Tue outside the merge window is typically my
quiet time when I have time to go through old emails and have time for
private projects).

So I'll look at doing this for x86 and see how it works.

I do suspect that even then it's possibly more code with a
site-specific callback for each case, but maybe it would be worth it
just for the flexibility.

                   Linus

