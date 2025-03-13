Return-Path: <linux-arch+bounces-10737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F90A5F99F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B353218884C5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BE268C7A;
	Thu, 13 Mar 2025 15:19:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E194269836;
	Thu, 13 Mar 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879190; cv=none; b=eoe4bbbVUc/WERR15QC1ltST4AFG4D4pNK2cVPjRPpetb84uamnlRU66jAWDhXcCm7HiBDSJ3EFmupgqu5ISoQ2rX3xpelBEY67h4uEyJGx/LEnnBi9BCqpoUa/OoLhiUOzatl7sUKfFy52cEZZ66LW1pyBovG3rxyCghAv+Lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879190; c=relaxed/simple;
	bh=FrNrmRF03ghmNEwfL8ovFyb6iLc0RrAEOh0F/ghf4Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHx+3nwO1Csdo6lEFQurksrFtX4kTQY4VahVX/GdQutEeR9xn/Zvn2+OTk47Afx94BKv6zBbOIBC0tzJWby+oTYlq1h6BiQ2PtHYMTy+XvvF5pt7E7md2OpOcajRO8Van9ysRjdObu3ZX8SGU7yQJLtjoOBdnWWGZh/XH/qNjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2aeada833so212336066b.0;
        Thu, 13 Mar 2025 08:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879182; x=1742483982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ii1IFZdoC6n5uv3UgvYeObshpXYt3dV3HzZ5zG8DvA=;
        b=W9QnCpy2z7liragH1HUm59BOqp43q4CXnuBtJa7okYrXzLfXUlfSgWiABJIxYvhGiR
         JDH9uTWn8ku5l/Y/e5+YblHYEOMLXsElHDQhGQqCcpFgFpPPAWZakGArIezsj4hfPFLq
         L4hWqC6TznU1DNQtdeqFAW3Kk/7H3omf3p8L+JW3IY1JYATE9WkIoeIOLbhnDFQKahMY
         FV55avgG6TQ12qjouSdszV1Vcxi5VvxIE3JIMOLnlTaE7UQJyDBtVGqB7Ev/Fc7lRbLq
         54sMGtCfZV1dnrV6HgfqAPtlbdUO+tXyHKf/4nIBfLYJj3i62gexXYqvvmcnew5cgtKz
         j/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU5KISh44rRVg8UeI6m4/3hBF0JYbNXFKeu6+haEDWi8dzZBNwUAQKSTBTW0t+X4RMIcFx7CnnVEKI=@vger.kernel.org, AJvYcCUCTOSCFLz/UafS4n+JBbfZrAYIKIj4978EmzSxmm1xXhpK8f4sNzPQSDmsl0uVibexvsxJxBzb38e+Q8DD@vger.kernel.org, AJvYcCUSVTeERoHO1QDUxjh8OxFLp58pJ1h6+RDMByONIyp6O6bM8WxKqz+yyOYPV7rAsuRSrK+a5dJV2vxF7Q==@vger.kernel.org, AJvYcCUUer8DlcV9SyIIDL2BQBAG0LjFkZbiUppILBrRki4BFJa74s18ryL7+pbzIQWByznxlhZyinpq3QxxvA==@vger.kernel.org, AJvYcCUsnuDHkVnSa1jrh+le0TH38X5bvX84A1Bxqsij10cpvKG0TruQUjwcRYPHg4bFM/9OkQas45vByml+/w==@vger.kernel.org, AJvYcCVA4Q17TsHc/kkGSlRe83bt62PV4InrJ9JbF+S+Te7w5q2D0XHEJ90misbFY5jJruYjVLcOZwsZyehhgw==@vger.kernel.org, AJvYcCVf2InVGrMmUV6z/T7I/PUyn4ZM45IlafnQzdrp0CqIfIvEg9tAtDwXXrJDrBuXa9w7z4hdmjdusLFBUQ==@vger.kernel.org, AJvYcCWCag+GOpZrhTDyGYXWJXgQ2wB2ORnsk/515EpbxGmJTJQUSNaSov3AhaQBfo25zujhzJDxOIoO3S16ErN9CA==@vger.kernel.org, AJvYcCWnmbojDHfoYQvJDTvB9FNwFDsQHqvI2DCZVsWfCjgd+OQ3xgNOyJSj7wRxz8dtoN9Fv1RBh3LUrHRVhZWl@vger.kernel.org, AJvYcCWz1UjUx3EM
 LE2Ki9ktZBfQu1JASJTmaagQPPDvz1sU3luAjcSXlRCEW0F9bgqm26SxAS9NGd+u6ILnHL/+3cA=@vger.kernel.org, AJvYcCXGGmh8kNblbmBL2c/6G2Hy3/XwcN6kCPje3VqVAz62+GVb5f1bZVLoc4Qi5exsY9iPmbywvgNlQ4S1Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgYO7kOiIyaHyYhoeez+j4V7J4n0AMZUxyPsOpN/P0fchA1ZK
	s8Sv3Tk3mwgD4RehXuYomk5fz+RFpGTqbotExG0JwqtthcgGZdEqtrj5vpfNHmU=
X-Gm-Gg: ASbGncvob5uLOdgDL0EXb9DJotu8lp9EnGkcTNBIOSz4pHdW4zg7MFnSA9RogX6meSy
	56hfA9NY8JWUUifjlXIjieieYCp+pNLxN7sLxDlAjWC3XwhSRvJ0Qn/tHhcTOlJbvncXRUb3iJb
	Yoc8Mt1R6Bm1HxshBqmOGxYdswMk+TjJfJreEQZYaCY+/2RnXMcEISN5RxbQCyuX9831b73mGMa
	65/V9SJM1VFKUTCPlFpMnLZ3oin5tJEg2eewn9hN4oAkdOltIh41nrCIyHlfXtfHTpBNPCgjeOU
	Fj84hUBEdS5cvsKl0DcOBPEZyPH7umN3jH4pvFacrfsCY8Ns0raEt+qFiOkQcn0IH80fBC9kxcQ
	GMUzXh7k=
X-Google-Smtp-Source: AGHT+IHgUEYjZ5BxZpsdAQFv31ablvhsNIXVzxerwIOsXj5v3VRn4dXHs2aiKu8KzFwyZ0I5/MFw7w==
X-Received: by 2002:a17:907:3892:b0:ac3:88a:a001 with SMTP id a640c23a62f3a-ac3124b2393mr309962466b.19.1741879182378;
        Thu, 13 Mar 2025 08:19:42 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0b4csm90825166b.122.2025.03.13.08.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:19:39 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab771575040so412917966b.1;
        Thu, 13 Mar 2025 08:19:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDXUI9Mv0FgHhvu8zT2V8jovCBZO7GjNbjJhKEHzMRM8uSKH5KdUitsEaFYi/PjvzNcAn2w13xfzw=@vger.kernel.org,
 AJvYcCUIix75VQkA4SJjDdNlrsTJg2tFphfjFdUD1+TlkKdZmL9ATUIQ4gbapZ0KDJCEcwfVWxAkNIVajVTNOw==@vger.kernel.org,
 AJvYcCUJeX9i2PoaO2fU5F6WcSNnlBqkTE/xOIE4ZooanzOFrfmncX2PAQr3m/Q6Y75uMlTL8rHnVXN8HTC0zqpX9x8=@vger.kernel.org,
 AJvYcCUJlYg8baevhE/vOvW+4ZUwTL2nzDS8UvVHMnhcO506WvBL15F3HnY2XU/Z4y5nGDowESywSZNXawx8Gw==@vger.kernel.org,
 AJvYcCV0X9mYYXYjLh5d2UXvAOBoytkeYTnGx48WR38tSZbjmP/mjlXsjbyKtT+IvavEmfCHIcJLje/CBeEs8w==@vger.kernel.org,
 AJvYcCW9ZE/0EY2DOHLyRU+GBk33IUUI3pbuV90Nx73NIxCIjsYEIEMPfWCWXVFO+NOtgjEGIaeAWIZORLZenA==@vger.kernel.org,
 AJvYcCWbn7rIRqOxikUEVs9Y4fvK6mPfsnGln+kzM8xvEcM7W6Y8xIAfdM/qdssBObn0LN1fcSuzV46sHhVDuuTz@vger.kernel.org,
 AJvYcCXAL/Ni4VKzNJIx5AkpjhIVaPqGHkqXYv7y2WAWhLfZA6wjW1VfA1Tuk+O3s+SIslXPD4k6dp/gP01oP+l5@vger.kernel.org,
 AJvYcCXVzsHh2J+jN++qaY23k/lZG48se5SzkiynXhJ234WGLuhNUO5qzr9KwL3t6IQDIZDcxHz8Lq26bJHN+Q==@vger.kernel.org,
 AJvYcCXWRO5LIF5na9KQPeoqZHIB8RyP1UTUspe6Ar4TJ49UTNNhkDceg0P2uWd+0ytgV71PLw+9m9nxBWfNOw==@vger.kernel.org,
 AJvYcCXdG3gS9GiFIi3gM3+YyPr/9+f8OREqJFmSIVMQK60d7cbWq4LZJ8bzZF3MwVDhDC3RnrTQ1AK884zY7s0SoQ==@vger.kernel.org
X-Received: by 2002:a17:907:9626:b0:ac3:d1c:89ce with SMTP id
 a640c23a62f3a-ac312305664mr252326866b.9.1741879178133; Thu, 13 Mar 2025
 08:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313135003.836600-1-rppt@kernel.org> <20250313135003.836600-14-rppt@kernel.org>
In-Reply-To: <20250313135003.836600-14-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2025 16:19:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWCBL_cg1NgbHCA3e9GTob_P9mTuN_Tepvigci6rxDmbg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr9qHWq5jtnIT3-BmFGhQQ_nRM0uVNr9PeQK5Y9eEomJSZyndfwbc1wpbs
Message-ID: <CAMuHMdWCBL_cg1NgbHCA3e9GTob_P9mTuN_Tepvigci6rxDmbg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] arch, mm: make releasing of memory to page
 allocator more explicit
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 14:53, Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The point where the memory is released from memblock to the buddy allocator
> is hidden inside arch-specific mem_init()s and the call to
> memblock_free_all() is needlessly duplicated in every artiste cure and
> after introduction of arch_mm_preinit() hook, mem_init() implementation on
> many architecture only contains the call to memblock_free_all().
>
> Pull memblock_free_all() call into mm_core_init() and drop mem_init() on
> relevant architectures to make it more explicit where the free memory is
> released from memblock to the buddy allocator and to reduce code
> duplication in architecture specific code.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>     # x86
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/m68k/mm/init.c          |  2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

