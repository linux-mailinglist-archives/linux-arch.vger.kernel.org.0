Return-Path: <linux-arch+bounces-709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5E806B4F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 11:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CE51F2103A
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C028E0E;
	Wed,  6 Dec 2023 10:08:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDED62;
	Wed,  6 Dec 2023 02:08:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AB216000A;
	Wed,  6 Dec 2023 10:08:21 +0000 (UTC)
Message-ID: <f259088f-a590-454e-b322-397e63071155@ghiti.fr>
Date: Wed, 6 Dec 2023 11:08:20 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Tejun,

On 10/11/2023 15:07, Alexandre Ghiti wrote:
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
>    mm: Introduce flush_cache_vmap_early() and its riscv implementation
>    riscv: Enable pcpu page first chunk allocator
>
>   arch/riscv/Kconfig                  | 2 ++
>   arch/riscv/include/asm/cacheflush.h | 3 ++-
>   arch/riscv/include/asm/tlbflush.h   | 2 ++
>   arch/riscv/mm/kasan_init.c          | 8 ++++++++
>   arch/riscv/mm/tlbflush.c            | 5 +++++
>   include/asm-generic/cacheflush.h    | 6 ++++++
>   mm/percpu.c                         | 8 +-------
>   7 files changed, 26 insertions(+), 8 deletions(-)
>

Any feedback regarding this?

Thanks,

Alex


