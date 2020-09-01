Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB71258610
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 05:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIADP5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 23:15:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgIADP4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 23:15:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61C630E;
        Mon, 31 Aug 2020 20:15:55 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFB03F68F;
        Mon, 31 Aug 2020 20:15:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 03/13] mm/debug_vm_pgtable/ppc64: Avoid setting top
 bits in radom value
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-4-aneesh.kumar@linux.ibm.com>
Message-ID: <3a0b0101-e6ec-26c5-e104-5b0bb95c3e51@arm.com>
Date:   Tue, 1 Sep 2020 08:45:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-4-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
> random value.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 086309fb9b6f..bbf9df0e64c6 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -44,10 +44,17 @@
>   * entry type. But these bits might affect the ability to clear entries with
>   * pxx_clear() because of how dynamic page table folding works on s390. So
>   * while loading up the entries do not change the lower 4 bits. It does not
> - * have affect any other platform.
> + * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
> + * used to mark a pte entry.
>   */
> -#define S390_MASK_BITS	4
> -#define RANDOM_ORVALUE	GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
> +#define S390_SKIP_MASK		GENMASK(3, 0)
> +#ifdef CONFIG_PPC_BOOK3S_64
> +#define PPC64_SKIP_MASK		GENMASK(62, 62)
> +#else
> +#define PPC64_SKIP_MASK		0x0
> +#endif

Please drop the #ifdef CONFIG_PPC_BOOK3S_64 here. We already accommodate skip
bits for a s390 platform requirement and can also do so for ppc64 as well. As
mentioned before, please avoid adding any platform specific constructs in the
test.

> +#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
> +#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>  #define RANDOM_NZVALUE	GENMASK(7, 0)

Please fix the alignments here. Feel free to consider following changes after
this patch.

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 122416464e0f..f969031152bb 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -48,14 +48,11 @@
  * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
  * used to mark a pte entry.
  */
-#define S390_SKIP_MASK         GENMASK(3, 0)
-#ifdef CONFIG_PPC_BOOK3S_64
-#define PPC64_SKIP_MASK                GENMASK(62, 62)
-#else
-#define PPC64_SKIP_MASK                0x0
-#endif
-#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
-#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
+#define S390_SKIP_MASK GENMASK(3, 0)
+#define PPC64_SKIP_MASK        GENMASK(62, 62)
+#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
+#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
+
 #define RANDOM_NZVALUE GENMASK(7, 0)
 
>  
>  static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
> 

Besides, there is also one checkpatch.pl warning here.

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in

total: 0 errors, 1 warnings, 20 lines checked
