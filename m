Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41135442B2
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 06:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiFIEmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 00:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFIEmO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 00:42:14 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B021D0BE4;
        Wed,  8 Jun 2022 21:42:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VFr3AZ6_1654749725;
Received: from 30.97.48.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFr3AZ6_1654749725)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 12:42:06 +0800
Message-ID: <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 12:42:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linux-arch@vger.kernel.org, lkp@lists.01.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
References: <20220608143819.GA31193@xsang-OptiPlex-9020>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220608143819.GA31193@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/8/2022 10:38 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 9b12e49e9b02bbaca8041f236a6b2fd4586d45c8 ("[RFC PATCH 3/3] mm: Add kernel PTE level pagetable pages account")
> url: https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220606-014812
> base: https://git.kernel.org/cgit/linux/kernel/git/arnd/asm-generic.git master
> patch link: https://lore.kernel.org/linux-mm/d35f42f7b598f629437940f941826e2cc49a97f6.1654271618.git.baolin.wang@linux.alibaba.com
> 
> in testcase: xfstests
> version: xfstests-x86_64-64f2596-1_20220518
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-44
> 	ucode: 0x21
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Thanks for reporting. It looks I missed calling pgtable_clear_and_dec() 
to clear PG_table when freeing a kernel pagetable. Changes as below can 
fix this issue I think.

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 6cccf52e156a..cae74e972426 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -858,6 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
         /* INVLPG to clear all paging-structure caches */
         flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);

+       pgtable_clear_and_dec(virt_to_page(pte));
         free_page((unsigned long)pte);

         return 1;

> 
> [   73.259828][ T4628] XFS (sdc4): WARNING: Reset corrupted AGFL on AG 0. 4 blocks leaked. Please unmount and run xfs_repair.
> [   73.384284][ T4634] XFS (sdc4): Unmounting Filesystem
> [   73.955637][ T4821] XFS (sdc4): Mounting V5 Filesystem
> [   73.981482][ T4821] XFS (sdc4): Ending clean mount
> [   73.984141][ T4821] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> [   74.144420][ T4843] XFS (sdc4): Unmounting Filesystem
> [   75.338681][ T4873] BUG: Bad page state in process 444  pfn:20b066
> [   75.338840][ T4873] page:0000000016cf0259 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20b066
> [   75.339041][ T4873] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [   75.339190][ T4873] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
> [   75.339350][ T4873] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
> [   75.339508][ T4873] page dumped because: nonzero mapcount
> [   75.339620][ T4873] Modules linked in: xfs dm_mod netconsole btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr intel_rapl_common sd_mod t10_pi crc64_rocksoft_generic x86_pkg_temp_thermal intel_powerclamp crc64_rocksoft crc64 sg coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl intel_cstate i915 intel_uncore usb_storage intel_gtt ahci mei_me drm_buddy drm_dp_helper libahci ttm drm_kms_helper mei ipmi_devintf ipmi_msghandler libata syscopyarea sysfillrect sysimgblt fb_sys_fops video drm fuse ip_tables
> [   75.340684][ T4873] CPU: 0 PID: 4873 Comm: 444 Tainted: G    B             5.18.0-rc1-00021-g9b12e49e9b02 #1
> [   75.340865][ T4873] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> [   75.341013][ T4873] Call Trace:
> [   75.341080][ T4873]  <TASK>
> [ 75.341142][ T4873] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 75.341236][ T4873] bad_page.cold (mm/page_alloc.c:637)
> [ 75.341326][ T4873] free_pcppages_bulk (mm/page_alloc.c:1511)
> [ 75.341428][ T4873] free_unref_page (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3444)
> [ 75.341524][ T4873] __mmdrop (arch/x86/include/asm/mmu_context.h:125 (discriminator 3) kernel/fork.c:791 (discriminator 3))
> [ 75.341608][ T4873] ? __mmput (arch/x86/include/asm/atomic.h:123 include/linux/atomic/atomic-instrumented.h:576 include/linux/sched/mm.h:49 kernel/fork.c:1194)
> [ 75.341889][ T4873] exec_mmap (fs/exec.c:1035)
> [ 75.341977][ T4873] begin_new_exec (fs/exec.c:1293)
> [ 75.342071][ T4873] ? kernel_read (fs/read_write.c:455)
> [ 75.342160][ T4873] load_elf_binary (fs/binfmt_elf.c:1002)
> [ 75.342258][ T4873] ? __x64_sys_sendfile (fs/read_write.c:417)
> [ 75.342360][ T4873] ? find_idlest_cpu (kernel/sched/fair.c:6151)
> [ 75.342458][ T4873] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
> [ 75.342575][ T4873] ? load_elf_interp+0xa80/0xa80
> [ 75.342691][ T4873] ? kernel_read (fs/read_write.c:455)
> [ 75.342781][ T4873] search_binary_handler (fs/exec.c:1728)
> [ 75.342887][ T4873] ? open_exec (fs/exec.c:1705)
> [ 75.342973][ T4873] ? nr_iowait (kernel/sched/core.c:5184)
> [ 75.343062][ T4873] exec_binprm (fs/exec.c:1768)
> [ 75.343151][ T4873] bprm_execve (fs/exec.c:990)
> [ 75.343250][ T4873] ? bprm_execve (fs/exec.c:1472 fs/exec.c:1804)
> [ 75.343340][ T4873] do_execveat_common+0x4c7/0x680
> [ 75.343451][ T4873] ? getname_flags (fs/namei.c:204)
> [ 75.343555][ T4873] __x64_sys_execve (fs/exec.c:2082)
> [ 75.343649][ T4873] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 75.343740][ T4873] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
> [   75.343861][ T4873] RIP: 0033:0x7f27e71636c7
> [ 75.343962][ T4873] Code: Unable to access opcode bytes at RIP 0x7f27e716369d.
> 
> Code starting with the faulting instruction
> ===========================================
> [   75.344113][ T4873] RSP: 002b:00007ffd24549988 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> [   75.344285][ T4873] RAX: ffffffffffffffda RBX: 00005635efbbce40 RCX: 00007f27e71636c7
> [   75.344446][ T4873] RDX: 00005635ef8ac120 RSI: 00005635ef908200 RDI: 00005635efbd9bf0
> [   75.344591][ T4873] RBP: 00005635efbd9bf0 R08: 00005635ef908200 R09: 0000000000000000
> [   75.344735][ T4873] R10: fffffffffffff286 R11: 0000000000000206 R12: 00005635efbd9bf0
> [   75.344880][ T4873] R13: 00005635ef908200 R14: 00005635ef8ac120 R15: 0000000000000020
> [   75.345028][ T4873]  </TASK>
> [   75.345560][ T4873] BUG: Bad page state in process 444  pfn:20b0d0
> [   75.345679][ T4873] page:000000000a4cf7b0 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20b0d0
> [   75.345867][ T4873] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [   75.346008][ T4873] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
> [   75.346164][ T4873] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
> [   75.346320][ T4873] page dumped because: nonzero mapcount
> [   75.346425][ T4873] Modules linked in: xfs dm_mod netconsole btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr intel_rapl_common sd_mod t10_pi crc64_rocksoft_generic x86_pkg_temp_thermal intel_powerclamp crc64_rocksoft crc64 sg coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl intel_cstate i915 intel_uncore usb_storage intel_gtt ahci mei_me drm_buddy drm_dp_helper libahci ttm drm_kms_helper mei ipmi_devintf ipmi_msghandler libata syscopyarea sysfillrect sysimgblt fb_sys_fops video drm fuse ip_tables
> [   75.347340][ T4873] CPU: 0 PID: 4873 Comm: 444 Tainted: G    B             5.18.0-rc1-00021-g9b12e49e9b02 #1
> [   75.347521][ T4873] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> [   75.347667][ T4873] Call Trace:
> [   75.347734][ T4873]  <TASK>
> [ 75.347796][ T4873] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 75.347888][ T4873] bad_page.cold (mm/page_alloc.c:637)
> [ 75.347977][ T4873] free_pcppages_bulk (mm/page_alloc.c:1511)
> [ 75.348077][ T4873] free_unref_page (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3444)
> [ 75.348173][ T4873] __mmdrop (arch/x86/include/asm/mmu_context.h:125 (discriminator 3) kernel/fork.c:791 (discriminator 3))
> [ 75.348256][ T4873] ? __mmput (arch/x86/include/asm/atomic.h:123 include/linux/atomic/atomic-instrumented.h:576 include/linux/sched/mm.h:49 kernel/fork.c:1194)
> [ 75.348341][ T4873] exec_mmap (fs/exec.c:1035)
> [ 75.348428][ T4873] begin_new_exec (fs/exec.c:1293)
> [ 75.348522][ T4873] ? kernel_read (fs/read_write.c:455)
> [ 75.348613][ T4873] load_elf_binary (fs/binfmt_elf.c:1002)
> [ 75.348709][ T4873] ? __x64_sys_sendfile (fs/read_write.c:417)
> [ 75.348812][ T4873] ? find_idlest_cpu (kernel/sched/fair.c:6151)
> [ 75.348910][ T4873] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
> [ 75.349026][ T4873] ? load_elf_interp+0xa80/0xa80
> [ 75.349141][ T4873] ? kernel_read (fs/read_write.c:455)
> [ 75.349232][ T4873] search_binary_handler (fs/exec.c:1728)
> [ 75.349335][ T4873] ? open_exec (fs/exec.c:1705)
> [ 75.349420][ T4873] ? nr_iowait (kernel/sched/core.c:5184)
> [ 75.349510][ T4873] exec_binprm (fs/exec.c:1768)
> [ 75.349597][ T4873] bprm_execve (fs/exec.c:990)
> [ 75.349696][ T4873] ? bprm_execve (fs/exec.c:1472 fs/exec.c:1804)
> [ 75.349786][ T4873] do_execveat_common+0x4c7/0x680
> [ 75.349897][ T4873] ? getname_flags (fs/namei.c:204)
> [ 75.350000][ T4873] __x64_sys_execve (fs/exec.c:2082)
> [ 75.350094][ T4873] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 75.350183][ T4873] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
> [   75.350296][ T4873] RIP: 0033:0x7f27e71636c7
> [ 75.350387][ T4873] Code: Unable to access opcode bytes at RIP 0x7f27e716369d.
> 
> Code starting with the faulting instruction
> ===========================================
> [   75.350522][ T4873] RSP: 002b:00007ffd24549988 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> [   75.350676][ T4873] RAX: ffffffffffffffda RBX: 00005635efbbce40 RCX: 00007f27e71636c7
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
