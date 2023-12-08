Return-Path: <linux-arch+bounces-794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C961809D02
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D9B281BF4
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C65F9F6;
	Fri,  8 Dec 2023 07:17:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102C1728;
	Thu,  7 Dec 2023 23:17:27 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d18c224c7so882527eaf.2;
        Thu, 07 Dec 2023 23:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702019846; x=1702624646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Vin8BT3wpq5T3wEcuxWKKOuHM8AGLU+CBTDMoLXsk=;
        b=ZyMR+sotpzOIOUv2ZmhLN+8Hrp4QmFc1qIqAI8amdgUMpuyoN29wOl/iYnKDyYrA+u
         vYgWjQNDKJCb0/JQE/0ttIVduToJ3wXW0MEwlOiP2U4H0TU7y8BYvGiaPL8va1UGGTh5
         fCo/dxpQVsMOAJw8WNI0B+AoPq/0A/731cHRjYTJ5aKMLuUrioXCSeFPrG2R4hxWLgy4
         sPU21OmoZB26WfopP1fuhq6/YI+mYaG+KvLjP5dze1I7Ul4VCuIO2PIRhgUB3WVPtY+d
         QudgOxOVaBvg431K7uSQp9uUecqdNYiEjRWk9qM0j8Ir8qcLGHLuJCJESwltLr6pVNIR
         oy3A==
X-Gm-Message-State: AOJu0YwoUPYxVQrrCx/AdCqiIPkmKzV80+c5pHFO3Gs62Ejsrwwa6Xqk
	Iqfg3xYSkjINjzwd9DWH218=
X-Google-Smtp-Source: AGHT+IH8OSidPNL0zpguBgIQHis69yqzvsgOqd92TReCneG0LANM00oMabB5MbmHHRItMnFMSTdHNg==
X-Received: by 2002:a05:6358:4327:b0:170:17eb:1ed with SMTP id r39-20020a056358432700b0017017eb01edmr4228974rwc.48.1702019846351;
        Thu, 07 Dec 2023 23:17:26 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id y130-20020a62ce88000000b006ce9d2471c0sm956133pfg.60.2023.12.07.23.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:17:25 -0800 (PST)
Date: Thu, 7 Dec 2023 23:17:23 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Message-ID: <ZXLDA3zObbLybTJB@snowbird>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>

Hello,

On Fri, Nov 10, 2023 at 03:07:19PM +0100, Alexandre Ghiti wrote:
> While working with pcpu variables, I noticed that riscv did not support
> first chunk allocation in the vmalloc area which may be needed as a fallback
> in case of a sparse NUMA configuration.
> 
> patch 1 starts by introducing a new function flush_cache_vmap_early() which
> is needed since a new vmalloc mapping is established and directly accessed:
> on riscv, this would likely fail in case of a reordered access or if the
> uarch caches invalid entries in TLB.
> 
> patch 2 simply enables the page percpu first chunk allocator in riscv.
> 
> Alexandre Ghiti (2):
>   mm: Introduce flush_cache_vmap_early() and its riscv implementation
>   riscv: Enable pcpu page first chunk allocator
> 
>  arch/riscv/Kconfig                  | 2 ++
>  arch/riscv/include/asm/cacheflush.h | 3 ++-
>  arch/riscv/include/asm/tlbflush.h   | 2 ++
>  arch/riscv/mm/kasan_init.c          | 8 ++++++++
>  arch/riscv/mm/tlbflush.c            | 5 +++++
>  include/asm-generic/cacheflush.h    | 6 ++++++
>  mm/percpu.c                         | 8 +-------
>  7 files changed, 26 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.2
> 

I've applied this to percpu#for-6.8.

Thanks,
Dennis

