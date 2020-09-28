Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A31927A7BB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgI1Gjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 02:39:52 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53108 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgI1Gjv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 02:39:51 -0400
Received: from ambrosehua-HP-xw6600-Workstation (unknown [212.102.50.216])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxauQRhXFfKcEYAA--.33386S2;
        Mon, 28 Sep 2020 14:39:25 +0800 (CST)
Date:   Mon, 28 Sep 2020 14:39:12 +0800
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V3] MIPS: make userspace mapping young by default
Message-ID: <20200928063912.5ctr7j2eap4q4jf7@ambrosehua-HP-xw6600-Workstation>
References: <20200919074731.22372-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919074731.22372-1-huangpei@loongson.cn>
User-Agent: NeoMutt/20171215
X-CM-TRANSID: AQAAf9AxauQRhXFfKcEYAA--.33386S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWUuF45ZF4DJFWrCF48WFg_yoW3JF4kpa
        4kC340y3yaqr13AryxZrnrAw1rAwsIqFy0qwnrC3W5X343Z34ktrsxGFZavryDWFZ2kw48
        Z3WDXr4rua9I9rUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 03:47:31PM +0800, Huang Pei wrote:

Ping?
> MIPS page fault path take 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
> the second TLB Invalid exception is just triggered by __update_tlb from
> do_page_fault writing tlb without _PAGE_VALID set. With this patch, it
> only take 1 TLB Miss + 1 TLB Invalid exceptions
> 
> This version removes pte_sw_mkyoung without polluting MM code and makes
> page fault delay of MIPS on par with other architecture and covers both
> no-RIXI and RIXI MIPS CPUS
> 
> [1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
> -maobibo@loongson.cn/
> ---
> V3:
> - reformat with whitespace cleaned up following Thomas's advice
> V2:
> - remove unused asm-generic definition of pte_sw_mkyoung following Mao's
> advice
> ---
> Co-developed-by: Huang Pei <huangpei@loongson.cn>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> Co-developed-by: Bibo Mao <maobibo@loonson.cn>
> ---
>  arch/mips/include/asm/pgtable.h | 10 ++++------
>  arch/mips/mm/cache.c            | 25 +++++++++++++------------
>  include/linux/pgtable.h         |  8 --------
>  mm/memory.c                     |  3 ---
>  4 files changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index dd7a0f552cac..931fb35730f0 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -27,11 +27,11 @@ struct vm_area_struct;
>  
>  #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
>  				 _page_cachable_default)
> -#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> -				 _page_cachable_default)
> +#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> +				 __READABLE | _page_cachable_default)
>  #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
> -				 _page_cachable_default)
> -#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
> +				 __READABLE | _page_cachable_default)
> +#define PAGE_READONLY	__pgprot(_PAGE_PRESENT |  __READABLE | \
>  				 _page_cachable_default)
>  #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
>  				 _PAGE_GLOBAL | _page_cachable_default)
> @@ -414,8 +414,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
>  	return pte;
>  }
>  
> -#define pte_sw_mkyoung	pte_mkyoung
> -
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
>  
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 3e81ba000096..ed75f2871aad 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -159,22 +159,23 @@ static inline void setup_protection_map(void)
>  {
>  	if (cpu_has_rixi) {
>  		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> +		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
>  		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> -		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> +		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
> +		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
> +		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
> +		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
> +		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
>  
>  		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
> +		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
>  		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
> -		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
> -		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
> -		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
> +		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | __READABLE);
> +		protection_map[12]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
> +		protection_map[13]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
> +		protection_map[14]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
> +		protection_map[15]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
> +
>  
>  	} else {
>  		protection_map[0] = PAGE_NONE;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e8cbc2e795d5..ef9c5fa8673e 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -377,14 +377,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>   * To be differentiate with macro pte_mkyoung, this macro is used on platforms
>   * where software maintains page access bit.
>   */
> -#ifndef pte_sw_mkyoung
> -static inline pte_t pte_sw_mkyoung(pte_t pte)
> -{
> -	return pte;
> -}
> -#define pte_sw_mkyoung	pte_sw_mkyoung
> -#endif
> -
>  #ifndef pte_savedwrite
>  #define pte_savedwrite pte_write
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 602f4283122f..5100ab5bcf77 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2705,7 +2705,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> -		entry = pte_sw_mkyoung(entry);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		/*
>  		 * Clear the pte entry and flush it first, before updating the
> @@ -3386,7 +3385,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	__SetPageUptodate(page);
>  
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
>  
> @@ -3661,7 +3659,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>  
>  	flush_icache_page(vma, page);
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  	/* copy-on-write page */
> -- 
> 2.17.1
> 

