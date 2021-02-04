Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CF30EB9C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 05:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBDErw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 3 Feb 2021 23:47:52 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35190 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229698AbhBDErw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 23:47:52 -0500
Received: from [127.0.0.1] (unknown [222.209.9.63])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax2dU1fBtgcjoDAA--.1370S2;
        Thu, 04 Feb 2021 12:46:49 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Mailer: BlackBerry Email (10.3.3.3216)
Message-ID: <20210204044648.5763159.1780.9288@loongson.cn>
Date:   Thu, 04 Feb 2021 12:46:48 +0800
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
From:   =?utf-8?b?6buE5rKb?= <huangpei@loongson.cn>
In-Reply-To: <1612409285.q4gi3x2bhk.astroid@bobo.none>
References: <20210204013942.8398-1-huangpei@loongson.cn>
 <1612409285.q4gi3x2bhk.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>, ambrosehua@gmail.com,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, Li Xuefeng <lixuefeng@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>
X-CM-TRANSID: AQAAf9Ax2dU1fBtgcjoDAA--.1370S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry3Jw48JF1kKr1ftF4xWFg_yoW7AF4Upa
        s7Ca4Ik3yaqw13AFyxGwsrAw1ruwsxtF18trnrCF1Uu34fW34kKFnrKFWrZryDCFZ0y3y5
        ZF1DXrs8uay3uFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUb38n5UUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

‎I am ok with it


  Original Message  
From: Nicholas Piggin
Sent: 2021年2月4日星期四 11:55
To: ambrosehua@gmail.com; Huang Pei; Thomas Bogendoerfer
Cc: Andrew Morton; Huacai Chen; Gao Juxin; Jiaxun Yang; linux-arch@vger.kernel.org; linux-mips@vger.kernel.org; linux-mm@kvack.org; Li Xuefeng; Bibo Mao; Paul Burton; Yang Tiezhu; Fuxin Zhang
Subject: Re: [PATCH] MIPS: make userspace mapping young by default

Excerpts from Huang Pei's message of February 4, 2021 11:39 am:
> MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> + 2 TLB Invalid), butthe second TLB Invalid exception is just
> triggered by __update_tlb from do_page_fault writing tlb without
> _PAGE_VALID set. With this patch, user space mapping prot is made
> young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> and it only take 1 TLB Miss + 1 TLB Invalid exception
> 
> Remove pte_sw_mkyoung without polluting MM code and make page fault
> delay of MIPS on par with other architecture
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>

Could we merge this? For the core code,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> arch/mips/mm/cache.c | 30 ++++++++++++++++--------------
> include/linux/pgtable.h | 8 --------
> mm/memory.c | 3 ---
> 3 files changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 23b16bfd97b2..e19cf424bb39 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -156,29 +156,31 @@ unsigned long _page_cachable_default;
> EXPORT_SYMBOL(_page_cachable_default);
> 
> #define PM(p)	__pgprot(_page_cachable_default | (p))
> +#define PVA(p)	PM(_PAGE_VALID | _PAGE_ACCESSED | (p))
> 
> static inline void setup_protection_map(void)
> {
> protection_map[0] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[1] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[2] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[3] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[4] = PM(_PAGE_PRESENT);
> -	protection_map[5] = PM(_PAGE_PRESENT);
> -	protection_map[6] = PM(_PAGE_PRESENT);
> -	protection_map[7] = PM(_PAGE_PRESENT);
> +	protection_map[1] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[2] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> +	protection_map[3] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[4] = PVA(_PAGE_PRESENT);
> +	protection_map[5] = PVA(_PAGE_PRESENT);
> +	protection_map[6] = PVA(_PAGE_PRESENT);
> +	protection_map[7] = PVA(_PAGE_PRESENT);
> 
> protection_map[8] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[9] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[10] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
> +	protection_map[9] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[10] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
> _PAGE_NO_READ);
> -	protection_map[11] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -	protection_map[12] = PM(_PAGE_PRESENT);
> -	protection_map[13] = PM(_PAGE_PRESENT);
> -	protection_map[14] = PM(_PAGE_PRESENT | _PAGE_WRITE);
> -	protection_map[15] = PM(_PAGE_PRESENT | _PAGE_WRITE);
> +	protection_map[11] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> +	protection_map[12] = PVA(_PAGE_PRESENT);
> +	protection_map[13] = PVA(_PAGE_PRESENT);
> +	protection_map[14] = PVA(_PAGE_PRESENT);
> +	protection_map[15] = PVA(_PAGE_PRESENT);
> }
> 
> +#undef _PVA
> #undef PM
> 
> void cpu_cache_init(void)
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8fcdfa52eb4b..8c042627399a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -432,14 +432,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
> * To be differentiate with macro pte_mkyoung, this macro is used on platforms
> * where software maintains page access bit.
> */
> -#ifndef pte_sw_mkyoung
> -static inline pte_t pte_sw_mkyoung(pte_t pte)
> -{
> -	return pte;
> -}
> -#define pte_sw_mkyoung	pte_sw_mkyoung
> -#endif
> -
> #ifndef pte_savedwrite
> #define pte_savedwrite pte_write
> #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index feff48e1465a..95718a623884 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2890,7 +2890,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> }
> flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> entry = mk_pte(new_page, vma->vm_page_prot);
> -	 entry = pte_sw_mkyoung(entry);
> entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 
> /*
> @@ -3548,7 +3547,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> __SetPageUptodate(page);
> 
> entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
> if (vma->vm_flags & VM_WRITE)
> entry = pte_mkwrite(pte_mkdirty(entry));
> 
> @@ -3824,7 +3822,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
> 
> flush_icache_page(vma, page);
> entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
> if (write)
> entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> /* copy-on-write page */
> -- 
> 2.17.1
> 
> 
> 

