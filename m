Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FA41B56B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 19:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbhI1RxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 13:53:00 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46167 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241839AbhI1RxA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 13:53:00 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HJn9y27bXz9sYs;
        Tue, 28 Sep 2021 19:51:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c04mfwE5ynrM; Tue, 28 Sep 2021 19:51:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HJn9y0sFSz9sYp;
        Tue, 28 Sep 2021 19:51:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 018928B770;
        Tue, 28 Sep 2021 19:51:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GxfLnuQLUmuq; Tue, 28 Sep 2021 19:51:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.48])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 09A688B763;
        Tue, 28 Sep 2021 19:51:16 +0200 (CEST)
Subject: Re: [PATCH v3 9/9] powerpc/mm: Use is_kernel_text() and
 is_kernel_inittext() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org,
        mingo@redhat.com, davem@davemloft.net, ast@kernel.org,
        ryabinin.a.a@gmail.com, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, paulus@samba.org
References: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
 <20210926072048.190336-10-wangkefeng.wang@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c5895fa8-ed3d-74c7-1d71-4d90dee9ea4b@csgroup.eu>
Date:   Tue, 28 Sep 2021 19:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926072048.190336-10-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/09/2021 à 09:20, Kefeng Wang a écrit :
> Use is_kernel_text() and is_kernel_inittext() helper to simplify code,
> also drop etext, _stext, _sinittext, _einittext declaration which
> already declared in section.h.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/powerpc/mm/pgtable_32.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index dcf5ecca19d9..13c798308c2e 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -33,8 +33,6 @@
>   
>   #include <mm/mmu_decl.h>
>   
> -extern char etext[], _stext[], _sinittext[], _einittext[];
> -
>   static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
>   
>   notrace void __init early_ioremap_init(void)
> @@ -104,14 +102,13 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>   {
>   	unsigned long v, s;
>   	phys_addr_t p;
> -	int ktext;
> +	bool ktext;
>   
>   	s = offset;
>   	v = PAGE_OFFSET + s;
>   	p = memstart_addr + s;
>   	for (; s < top; s += PAGE_SIZE) {
> -		ktext = ((char *)v >= _stext && (char *)v < etext) ||
> -			((char *)v >= _sinittext && (char *)v < _einittext);
> +		ktext = (is_kernel_text(v) || is_kernel_inittext(v));

I think we could use core_kernel_next() instead.


>   		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
>   		v += PAGE_SIZE;
>   		p += PAGE_SIZE;
> 




Build failure on mpc885_ads_defconfig

arch/powerpc/mm/pgtable_32.c: In function '__mapin_ram_chunk':
arch/powerpc/mm/pgtable_32.c:111:26: error: implicit declaration of 
function 'is_kernel_text'; did you mean 'is_kernel_inittext'? 
[-Werror=implicit-function-declaration]
   111 |                 ktext = (is_kernel_text(v) || 
is_kernel_inittext(v));
       |                          ^~~~~~~~~~~~~~
       |                          is_kernel_inittext
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:277: arch/powerpc/mm/pgtable_32.o] 
Error 1
make[1]: *** [scripts/Makefile.build:540: arch/powerpc/mm] Error 2
make: *** [Makefile:1868: arch/powerpc] Error 2


