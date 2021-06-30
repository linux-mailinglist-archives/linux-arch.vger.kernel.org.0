Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF573B7C23
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhF3DlC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Jun 2021 23:41:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3330 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233906AbhF3DlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Jun 2021 23:41:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U3Xa7a189228;
        Tue, 29 Jun 2021 23:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YLeau4/G/xDk1KdRLtfKn+qh+YspZIA9rUqM/9Cz+YE=;
 b=XpDTJKRgRySl0D5v4ZUf7Bg48znjyzJRzEn8RfTVFOuQ3H2H+s9Tb8e34IsqoTFbkB7C
 1MEw13yFInEgU+sENQMZZEqZcG8qr8HZj2Vp8vWzgEj+D3/3JopfU5K3pJrBIfN7NKx/
 EWcx/ZNmGkpKKUWOvfcxu2mZc0eg+jg3Qu3zMBTdxtff1RW+Pvawk/lJ9zF0GoCp1FE9
 iPdCJeohVDiRvlb2p/D3MTEEixU0ef6P8HNyzjBWX0phHBwuO7IdCXzMT6mQ2Ej9vQ2X
 RopSt0+qe5wYX0rXUhm4B5SamcFlgBjfyq29TVp7sCMwa8VTYpBbLchfOz5t0os4olBK zA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gfc21ukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 23:38:28 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15U3cQ09018122;
        Wed, 30 Jun 2021 03:38:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 39ft8er8j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 03:38:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15U3cN3a31129912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 03:38:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE9A2A405B;
        Wed, 30 Jun 2021 03:38:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3856BA4051;
        Wed, 30 Jun 2021 03:38:22 +0000 (GMT)
Received: from [9.199.50.145] (unknown [9.199.50.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 03:38:21 +0000 (GMT)
Subject: Re: [to-be-updated]
 mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
 removed from -mm tree
To:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20210616230804.7nsBdkkF4%akpm@linux-foundation.org>
 <202106300416.lys9Wk5a-lkp@intel.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <b8b326db-9461-eece-b6c2-f2d7a6d05286@linux.ibm.com>
Date:   Wed, 30 Jun 2021 09:08:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <202106300416.lys9Wk5a-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tyBflBnd-giub3nPQMAFG3OBETHTePmU
X-Proofpoint-ORIG-GUID: tyBflBnd-giub3nPQMAFG3OBETHTePmU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300023
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/30/21 1:38 AM, kernel test robot wrote:
> Hi,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on tip/x86/mm asm-generic/master linus/master sparc/master v5.13]
> [cannot apply to sparc-next/master next-20210629]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/akpm-linux-foundation-org/mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t-patch-removed-from-mm-tree/20210617-075958
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/490957abd94a7b67576c0029c771c6691dce1878
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review akpm-linux-foundation-org/mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t-patch-removed-from-mm-tree/20210617-075958
>          git checkout 490957abd94a7b67576c0029c771c6691dce1878
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from include/linux/kallsyms.h:12,
>                      from include/linux/ftrace.h:12,
>                      from include/linux/kprobes.h:29,
>                      from include/linux/kgdb.h:19,
>                      from arch/sparc/kernel/kgdb_32.c:7:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from include/linux/pgtable.h:6,
>                      from arch/sparc/kernel/traps_32.c:21:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/kernel/traps_32.c: At top level:
>     arch/sparc/kernel/traps_32.c:368:6: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
>       368 | void trap_init(void)
>           |      ^~~~~~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from arch/sparc/include/asm/viking.h:13,
>                      from arch/sparc/include/asm/mbus.h:12,
>                      from arch/sparc/include/asm/elf_32.h:94,
>                      from arch/sparc/include/asm/elf.h:7,
>                      from include/linux/elf.h:6,
>                      from include/linux/module.h:18,
>                      from include/linux/moduleloader.h:6,
>                      from arch/sparc/kernel/module.c:8:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/kernel/module.c: In function 'module_frob_arch_sections':
>     arch/sparc/kernel/module.c:62:8: error: variable 'strtab' set but not used [-Werror=unused-but-set-variable]
>        62 |  char *strtab;
>           |        ^~~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from include/linux/memblock.h:13,
>                      from arch/sparc/mm/srmmu.c:14:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/mm/srmmu.c: In function 'poke_hypersparc':
>     arch/sparc/mm/srmmu.c:1081:25: error: variable 'clear' set but not used [-Werror=unused-but-set-variable]
>      1081 |  volatile unsigned long clear;
>           |                         ^~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from arch/sparc/mm/leon_mm.c:14:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/mm/leon_mm.c: In function 'leon_swprobe':
>     arch/sparc/mm/leon_mm.c:42:25: error: variable 'paddrbase' set but not used [-Werror=unused-but-set-variable]
>        42 |  unsigned int lvl, pte, paddrbase;
>           |                         ^~~~~~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from arch/sparc/include/asm/viking.h:13,
>                      from arch/sparc/include/asm/mbus.h:12,
>                      from arch/sparc/include/asm/elf_32.h:94,
>                      from arch/sparc/include/asm/elf.h:7,
>                      from include/linux/elf.h:6,
>                      from include/linux/module.h:18,
>                      from arch/sparc/lib/cmpdi2.c:2:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/lib/cmpdi2.c: At top level:
>     arch/sparc/lib/cmpdi2.c:6:11: error: no previous prototype for '__cmpdi2' [-Werror=missing-prototypes]
>         6 | word_type __cmpdi2(long long a, long long b)
>           |           ^~~~~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/sparc/include/asm/pgtable.h:7,
>                      from arch/sparc/include/asm/viking.h:13,
>                      from arch/sparc/include/asm/mbus.h:12,
>                      from arch/sparc/include/asm/elf_32.h:94,
>                      from arch/sparc/include/asm/elf.h:7,
>                      from include/linux/elf.h:6,
>                      from include/linux/module.h:18,
>                      from arch/sparc/lib/ucmpdi2.c:2:
>     arch/sparc/include/asm/pgtable_32.h: In function 'pud_pgtable':
>>> arch/sparc/include/asm/pgtable_32.h:158:10: error: returning 'int' from a function with return type 'pmd_t *' {aka 'long unsigned int *'} makes pointer from integer without a cast [-Werror=int-conversion]
>       158 |   return ~0;
>           |          ^
>     arch/sparc/lib/ucmpdi2.c: At top level:
>     arch/sparc/lib/ucmpdi2.c:5:11: error: no previous prototype for '__ucmpdi2' [-Werror=missing-prototypes]
>         5 | word_type __ucmpdi2(unsigned long long a, unsigned long long b)
>           |           ^~~~~~~~~
>     cc1: all warnings being treated as errors
> 
> 
> vim +158 arch/sparc/include/asm/pgtable_32.h
> 
> 974b9b2c68f3d3 arch/sparc/include/asm/pgtable_32.h Mike Rapoport 2020-06-08  154
> 490957abd94a7b arch/sparc/include/asm/pgtable_32.h Andrew Morton 2021-06-16  155  static inline pmd_t *pud_pgtable(pud_t pud)
> 9701b264d3267b arch/sparc/include/asm/pgtable_32.h Sam Ravnborg  2012-05-13  156  {
> 7235db268a2777 arch/sparc/include/asm/pgtable_32.h Mike Rapoport 2019-12-04  157  	if (srmmu_device_memory(pud_val(pud))) {
> 9701b264d3267b arch/sparc/include/asm/pgtable_32.h Sam Ravnborg  2012-05-13 @158  		return ~0;
> 9701b264d3267b arch/sparc/include/asm/pgtable_32.h Sam Ravnborg  2012-05-13  159  	} else {
> 7235db268a2777 arch/sparc/include/asm/pgtable_32.h Mike Rapoport 2019-12-04  160  		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
> 490957abd94a7b arch/sparc/include/asm/pgtable_32.h Andrew Morton 2021-06-16  161  		return (pmd_t *)__nocache_va(v << 4);
> 9701b264d3267b arch/sparc/include/asm/pgtable_32.h Sam Ravnborg  2012-05-13  162  	}
> 9701b264d3267b arch/sparc/include/asm/pgtable_32.h Sam Ravnborg  2012-05-13  163  }
> f5e706ad886b6a include/asm-sparc/pgtable_32.h      Sam Ravnborg  2008-07-17  164
> 

This patch was updated sometime back and the equivalent series we have 
in -mm tree now can be found at https://ozlabs.org/~akpm/mmots/broken-out/

mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t-fix-2.patch
mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t.patch
mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t-fix.patch
selftest-mremap_test-update-the-test-to-handle-pagesize-other-than-4k.patch
selftest-mremap_test-avoid-crash-with-static-build.patch
mm-mremap-convert-huge-pud-move-to-separate-helper.patch
mm-mremap-convert-huge-pud-move-to-separate-helper-fix.patch
mm-mremap-dont-enable-optimized-pud-move-if-page-table-levels-is-2.patch
mm-mremap-use-pmd-pud_poplulate-to-update-page-table-entries.patch
mm-mremap-hold-the-rmap-lock-in-write-mode-when-moving-page-table-entries.patch
mm-mremap-allow-arch-runtime-override.patch
powerpc-book3s64-mm-update-flush_tlb_range-to-flush-page-walk-cache.patch
powerpc-mm-enable-have_move_pmd-support.patch
mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t-fix-3.patch


-aneesh
