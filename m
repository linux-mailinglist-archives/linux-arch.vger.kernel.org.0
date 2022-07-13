Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29E573248
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jul 2022 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiGMJRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jul 2022 05:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiGMJRt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2022 05:17:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48982E0F4F;
        Wed, 13 Jul 2022 02:17:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VJDOi.B_1657703862;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VJDOi.B_1657703862)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 17:17:43 +0800
Message-ID: <1badee01-b872-8de8-4fe1-83d6dc6b756c@linux.alibaba.com>
Date:   Wed, 13 Jul 2022 17:17:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [mm] 0bf5cdf08f: BUG:Bad_page_state_in_process
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linux-arch@vger.kernel.org, lkp@lists.01.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, willy@infradead.org,
        linux-mm@kvack.org
References: <Ys0P+ssAhAyfdA56@xsang-OptiPlex-9020>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Ys0P+ssAhAyfdA56@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/12/2022 2:08 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257 ("[RFC PATCH v2 3/3] mm: Add kernel PTE level pagetable pages account")
> url: https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051
> base: https://git.kernel.org/cgit/linux/kernel/git/arnd/asm-generic.git master
> patch link: https://lore.kernel.org/linux-mm/7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com
> 
> in testcase: stress-ng
> version: stress-ng-x86_64-0.11-06_20220709
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: xfs
> 	class: filesystem
> 	test: dnotify
> 	cpufreq_governor: performance
> 	ucode: 0xb000280
> 
> 
> 
> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Thanks for reporting. I think I missed the changes in 
pud_free_pmd_page(), which also can free a kernel pte page table.

And I will use pte_free_kernel() instead in new version patch set.

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 20f30762d618..f961578e2a54 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -828,6 +828,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
         for (i = 0; i < PTRS_PER_PMD; i++) {
                 if (!pmd_none(pmd_sv[i])) {
                         pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
+                       pgtable_clear_and_dec(virt_to_page(pte));
                         free_page((unsigned long)pte);
                 }
         }


> 
> 
> [   36.465236][ T1887] BUG: Bad page state in process ucfr  pfn:1ed9a9
> [   36.465238][ T1887] page:00000000c52990fe refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x1ed9a9
> [   36.465244][ T1887] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [   36.465248][ T1887] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
> [   36.465249][ T1887] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
> [   36.465249][ T1887] page dumped because: nonzero mapcount
> [   36.465250][ T1887] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
> [   36.465278][ T1887] CPU: 8 PID: 1887 Comm: ucfr Tainted: G S                5.19.0-rc2-00013-g0bf5cdf08f32 #1
> [   36.465280][ T1887] Call Trace:
> [   36.465283][ T1887]  <TASK>
> [ 36.465285][ T1887] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 36.465292][ T1887] bad_page.cold (mm/page_alloc.c:642)
> [ 36.465296][ T1887] free_pcppages_bulk (mm/page_alloc.c:1526)
> [ 36.465302][ T1887] free_unref_page (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3459)
> [ 36.465304][ T1887] __mmdrop (arch/x86/include/asm/mmu_context.h:125 (discriminator 3) kernel/fork.c:789 (discriminator 3))
> [ 36.465307][ T1887] finish_task_switch+0x200/0x2c0
> [ 36.465312][ T1887] schedule_tail (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:5053)
> [ 36.465315][ T1887] ret_from_fork (arch/x86/entry/entry_64.S:289)
> [   36.465320][ T1887]  </TASK>
> [   36.465320][ T1887] Disabling lock debugging due to kernel taint
> [   37.204107][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067654
> [   37.204114][  T656] page:0000000017c1d009 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067654
> [   37.204120][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
> [   37.204126][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
> [   37.204128][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
> [   37.204128][  T656] page dumped because: nonzero mapcount
> [   37.204129][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
> [   37.204165][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
> [   37.204168][  T656] Workqueue: mm_percpu_wq vmstat_update
> [   37.204181][  T656] Call Trace:
> [   37.204184][  T656]  <TASK>

snip.
