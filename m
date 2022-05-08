Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581A951EDB0
	for <lists+linux-arch@lfdr.de>; Sun,  8 May 2022 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiEHNRF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 May 2022 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiEHNRE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 09:17:04 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23356E0CE;
        Sun,  8 May 2022 06:13:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0VCaT1jO_1652015583;
Received: from 30.15.195.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCaT1jO_1652015583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 21:13:05 +0800
Message-ID: <474b8548-4e17-a6e7-a0f7-8f248aabe462@linux.alibaba.com>
Date:   Sun, 8 May 2022 21:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 migration
To:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, catalin.marinas@arm.com, will@kernel.org
Cc:     kbuild-all@lists.01.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <1ec8a987be1a5400e077260a300d0079564b1472.1652002221.git.baolin.wang@linux.alibaba.com>
 <202205081910.mStoC5rj-lkp@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202205081910.mStoC5rj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/8/2022 8:01 PM, kernel test robot wrote:
> Hi Baolin,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on next-20220506]
> [cannot apply to hnaz-mm/master arm64/for-next/core linus/master v5.18-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220508-174036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220508/202205081910.mStoC5rj-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/907981b27213707fdb2f8a24c107d6752a09a773
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220508-174036
>          git checkout 907981b27213707fdb2f8a24c107d6752a09a773
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     mm/rmap.c: In function 'try_to_migrate_one':
>>> mm/rmap.c:1931:34: error: implicit declaration of function 'huge_ptep_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
>      1931 |                         pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>           |                                  ^~~~~~~~~~~~~~~~~~~~~
>           |                                  ptep_clear_flush
>>> mm/rmap.c:1931:34: error: incompatible types when assigning to type 'pte_t' from type 'int'
>>> mm/rmap.c:2023:41: error: implicit declaration of function 'set_huge_pte_at'; did you mean 'set_huge_swap_pte_at'? [-Werror=implicit-function-declaration]
>      2023 |                                         set_huge_pte_at(mm, address, pvmw.pte, pteval);
>           |                                         ^~~~~~~~~~~~~~~
>           |                                         set_huge_swap_pte_at
>     cc1: some warnings being treated as errors

Thanks for reporting. I think I should add some dummy functions in 
hugetlb.h file if the CONFIG_HUGETLB_PAGE is not selected. I can pass 
the building with below changes and your config file.

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 306d6ef..9f71043 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1093,6 +1093,17 @@ static inline void set_huge_swap_pte_at(struct 
mm_struct *mm, unsigned long addr
                                         pte_t *ptep, pte_t pte, 
unsigned long sz)
  {
  }
+
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+                                         unsigned long addr, pte_t *ptep)
+{
+       return ptep_get(ptep);
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long 
addr,
+                                  pte_t *ptep, pte_t pte)
+{
+}
  #endif /* CONFIG_HUGETLB_PAGE */
