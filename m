Return-Path: <linux-arch+bounces-969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABD810C83
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 09:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C6E1F2118E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9EC18E05;
	Wed, 13 Dec 2023 08:36:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8690EA5;
	Wed, 13 Dec 2023 00:36:29 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20315d10afaso603518fac.0;
        Wed, 13 Dec 2023 00:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702456588; x=1703061388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6anvPPkB7zC5RyRZfp8ATi41Ad4dEiA0WoUIsmcFlew=;
        b=Ld3Jdy0Pr3L8V8IMQkHNsRJLn7b84rDkAz2NZnF2qSfNN3gYzF32owIo7A6N45KNzN
         8z6kBwjy+fzQcjLKZPMmmP36sXlwDA36oyWV5vRfip4rKSWpSS/kV0Ik2y8Y+Bcp9/y0
         tvcd990WfBBRr3EjO+kIom9+YecBnEJ27m/ytgFjIg/QECTrDs3a2BVJXG3wMRPYa+FT
         d17XA9uB/w2/mBi1+5TxphKq0YbhQOL/wHxGr/vXVkR5T07tXtmhHdxpfRHLupIkxZ1Q
         Ww9POD0OeOqQIb89EcpfILLDV6Dw+BnisyvtutUzHviA8lXeWs9kfKRtZqmXHcIED1BS
         baOQ==
X-Gm-Message-State: AOJu0YwwvsI8C6lOcWyRvdcVXD5hsDl9flTQRkbzaccHdqLFkqgcTMis
	YfwdHrswsUfZBn5D8FjzBEZNZ/RcGYc3Eg==
X-Google-Smtp-Source: AGHT+IHy8U2jiA1RoZW55CeO+CoAd8XXb78XS1pnqu6pCoMOuJS9D00xmIov8E7IRMGfZBV6AGanwA==
X-Received: by 2002:a05:6871:5b22:b0:1fb:75a:c442 with SMTP id op34-20020a0568715b2200b001fb075ac442mr7647409oac.107.1702456588549;
        Wed, 13 Dec 2023 00:36:28 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id z6-20020a81c206000000b005ce93212c47sm4406588ywc.134.2023.12.13.00.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 00:36:27 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e2ce5c8f04so547547b3.2;
        Wed, 13 Dec 2023 00:36:27 -0800 (PST)
X-Received: by 2002:a81:a1ce:0:b0:5e2:2917:273d with SMTP id
 y197-20020a81a1ce000000b005e22917273dmr1045743ywg.43.1702456586772; Wed, 13
 Dec 2023 00:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212213457.132605-1-alexghiti@rivosinc.com> <20231212213457.132605-2-alexghiti@rivosinc.com>
In-Reply-To: <20231212213457.132605-2-alexghiti@rivosinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Dec 2023 09:36:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMuSBKHaPGKTf2pGdgsD5dMaxcrZw3Ox3G=ShjnOAKnQ@mail.gmail.com>
Message-ID: <CAMuHMdWMuSBKHaPGKTf2pGdgsD5dMaxcrZw3Ox3G=ShjnOAKnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Introduce flush_cache_vmap_early()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:36=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> The pcpu setup when using the page allocator sets up a new vmalloc
> mapping very early in the boot process, so early that it cannot use the
> flush_cache_vmap() function which may depend on structures not yet
> initialized (for example in riscv, we currently send an IPI to flush
> other cpus TLB).
>
> But on some architectures, we must call flush_cache_vmap(): for example,
> in riscv, some uarchs can cache invalid TLB entries so we need to flush
> the new established mapping to avoid taking an exception.
>
> So fix this by introducing a new function flush_cache_vmap_early() which
> is called right after setting the new page table entry and before
> accessing this new mapping. This new function implements a local flush
> tlb on riscv and is no-op for other architectures (same as today).
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

>  arch/m68k/include/asm/cacheflush_mm.h  | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

