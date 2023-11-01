Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9D7DE91E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Nov 2023 00:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjKAXvL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 19:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKAXvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 19:51:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B105134;
        Wed,  1 Nov 2023 16:50:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B12B5C024C;
        Wed,  1 Nov 2023 19:50:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1698882651; x=1698969051; bh=D7zorcBiUElQOlIwTxiPEpJ6u
        H3K9QbfXQVg/pSVJjM=; b=a3Lzm0L3R0GiILMySS6weRbqtP4gFvTvRJA0ay+Ul
        OrdG2OGcHcJNgy3Oekdnk7jXbZBGgRcHnVT3TnUJBliALxW1owyGTKK5VTTnX5jc
        7gJS2QukOGmAXP6o0bNPisbRHfdjzS2enQzQFqoK+Je+gWyu16CTatJZ1l3sBfl9
        0uZKnGiN6eqS8ruurV2HrKHZ7q+VUz3sZNJeb6NwvwtzzDnlVZ24HTlvzrXS08+n
        CDHsXe1gPO6Y+A+AKBh67TgI/nHBVP3EOMl3VpG8ocQMNTLTCyT/Epq/qk3EAijU
        4grFEUN4/7jE9mEozSgygDp7T3Gy52nan8POPjpKEJQXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698882651; x=1698969051; bh=D7zorcBiUElQOlIwTxiPEpJ6uH3K9QbfXQV
        g/pSVJjM=; b=QqLUnjGNh8MbvtmUtK8ztNBIebQM1G8L9dfUK9CkAVGIXh0NZf7
        sd4kx5PwR/edNZzqHm0pz0p1F6Sg3LOeUzOqsbJyhyzvsEWINSLW38buguG5aQy6
        cZI9duPq/hbce2Bwpppcn80iIFsB0Cdt7HmebTzHEmuXGdsuveZOtrSQGswMIWKd
        mzd/+OAFnEzlmdBNUHlgCU5ydDxEU01LrXpxq7I1dhDNJfyk/ymf1E7q7UHpV0bx
        U3TyHIOsboqAWEGscKNA/geANxSfYu0jkl70UEL1VskvoOyuB+0czUTleNAQLDqB
        kk7MODZxvwwvk7K21+/vMbrI5FmxLSJ/hQg==
X-ME-Sender: <xms:W-RCZdyiUsR3gQ-9K5w_jZHQ378knZrP4FKaPe91Ijdb9LJUXrAvzg>
    <xme:W-RCZdQbRwgJyrXD5FxMtQiEUvio3J1sjZtl0X5INQ3-eYgzI0XjGpsIv9_TzQyqg
    o_OLOAIlWpGs3rHCaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:W-RCZXWpF-C0wpAiJPIKpbfycwM4JrNE6XeSQ0UeZdlIpP4pPgk91Q>
    <xmx:W-RCZfiwEZ8-QKH4_d3qqFQUAEeOZB8JxBuYPuXgPGzu7xwbDTa9gA>
    <xmx:W-RCZfDtahBmIL9SmKPjHZumSh6mr2hrPft1glkqSpRQj6D73AQoNw>
    <xmx:W-RCZSPJC7hUCqcew4SeX--l9Cf_pPCmVFzANCNlfmr4nPvaU3x3cw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B06CB60089; Wed,  1 Nov 2023 19:50:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <340fc037-c18f-417f-8aaa-9cf88c9052f4@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:50:30 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: [GIT PULL] asm-generic updates for v6.7
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1:

  acpi: Provide ia64 dummy implementation of acpi_proc_quirk_mwait_check() (2023-09-11 08:13:17 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.7

for you to fetch changes up to 550087a0ba91eb001c139f563a193b1e9ef5a8dd:

  hexagon: Remove unusable symbols from the ptrace.h uapi (2023-10-25 15:54:24 +0200)

----------------------------------------------------------------
asm-generic updates for v6.7

The ia64 architecture gets its well-earned retirement as planned,
now that there is one last (mostly) working release that will
be maintained as an LTS kernel.

The architecture specific system call tables are updated for
the added map_shadow_stack() syscall and to remove references
to the long-gone sys_lookup_dcookie() syscall.

----------------------------------------------------------------
Note that the ia64 removal has a number of conflicts against
modified files from other pull requests. It might help to pull
this a few days later, after most of the other ones are already
there.

Andy Shevchenko (1):
      asm-generic: Fix spelling of architecture

Ard Biesheuvel (5):
      arch: Remove Itanium (IA-64) architecture
      kernel: Drop IA64 support from sig_fault handlers
      Documentation: Drop IA64 from feature descriptions
      lib/raid6: Drop IA64 support
      Documentation: Drop or replace remaining mentions of IA64

Arnd Bergmann (1):
      Merge tag 'tag-remove-ia64' of git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux into asm-generic

Sohil Mehta (2):
      syscalls: Cleanup references to sys_lookup_dcookie()
      arch: Reserve map_shadow_stack() syscall number for all architectures

Thomas Huth (1):
      hexagon: Remove unusable symbols from the ptrace.h uapi

 Documentation/ABI/testing/sysfs-devices-system-cpu |    3 -
 .../ABI/testing/sysfs-firmware-dmi-entries         |    2 +-
 Documentation/admin-guide/kdump/kdump.rst          |   37 +-
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   30 -
 Documentation/admin-guide/kernel-parameters.txt    |    8 +-
 Documentation/admin-guide/mm/memory-hotplug.rst    |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |   23 +-
 Documentation/arch/ia64/aliasing.rst               |  246 ---
 Documentation/arch/ia64/efirtc.rst                 |  144 --
 Documentation/arch/ia64/err_inject.rst             | 1067 ---------
 Documentation/arch/ia64/features.rst               |    3 -
 Documentation/arch/ia64/fsys.rst                   |  303 ---
 Documentation/arch/ia64/ia64.rst                   |   49 -
 Documentation/arch/ia64/index.rst                  |   19 -
 Documentation/arch/ia64/irq-redir.rst              |   80 -
 Documentation/arch/ia64/mca.rst                    |  198 --
 Documentation/arch/ia64/serial.rst                 |  165 --
 Documentation/arch/index.rst                       |    1 -
 Documentation/block/ioprio.rst                     |    3 -
 Documentation/core-api/cpu_hotplug.rst             |    6 -
 Documentation/core-api/debugging-via-ohci1394.rst  |    6 +-
 .../features/core/cBPF-JIT/arch-support.txt        |    1 -
 .../features/core/eBPF-JIT/arch-support.txt        |    1 -
 .../core/generic-idle-thread/arch-support.txt      |    1 -
 .../features/core/jump-labels/arch-support.txt     |    1 -
 .../core/thread-info-in-task/arch-support.txt      |    1 -
 .../features/core/tracehook/arch-support.txt       |    1 -
 .../features/debug/KASAN/arch-support.txt          |    1 -
 .../debug/debug-vm-pgtable/arch-support.txt        |    1 -
 .../debug/gcov-profile-all/arch-support.txt        |    1 -
 Documentation/features/debug/kcov/arch-support.txt |    1 -
 Documentation/features/debug/kgdb/arch-support.txt |    1 -
 .../features/debug/kmemleak/arch-support.txt       |    1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |    1 -
 .../features/debug/kprobes/arch-support.txt        |    1 -
 .../features/debug/kretprobes/arch-support.txt     |    1 -
 .../features/debug/optprobes/arch-support.txt      |    1 -
 .../features/debug/stackprotector/arch-support.txt |    1 -
 .../features/debug/uprobes/arch-support.txt        |    1 -
 .../debug/user-ret-profiler/arch-support.txt       |    1 -
 .../features/io/dma-contiguous/arch-support.txt    |    1 -
 .../locking/cmpxchg-local/arch-support.txt         |    1 -
 .../features/locking/lockdep/arch-support.txt      |    1 -
 .../locking/queued-rwlocks/arch-support.txt        |    1 -
 .../locking/queued-spinlocks/arch-support.txt      |    1 -
 .../features/perf/kprobes-event/arch-support.txt   |    1 -
 .../features/perf/perf-regs/arch-support.txt       |    1 -
 .../features/perf/perf-stackdump/arch-support.txt  |    1 -
 .../sched/membarrier-sync-core/arch-support.txt    |    1 -
 .../features/sched/numa-balancing/arch-support.txt |    1 -
 .../seccomp/seccomp-filter/arch-support.txt        |    1 -
 .../time/arch-tick-broadcast/arch-support.txt      |    1 -
 .../features/time/clockevents/arch-support.txt     |    1 -
 .../time/context-tracking/arch-support.txt         |    1 -
 .../features/time/irq-time-acct/arch-support.txt   |    1 -
 .../features/time/virt-cpuacct/arch-support.txt    |    1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |    1 -
 .../features/vm/PG_uncached/arch-support.txt       |    1 -
 Documentation/features/vm/THP/arch-support.txt     |    1 -
 Documentation/features/vm/TLB/arch-support.txt     |    1 -
 .../features/vm/huge-vmap/arch-support.txt         |    1 -
 .../features/vm/ioremap_prot/arch-support.txt      |    1 -
 .../features/vm/pte_special/arch-support.txt       |    1 -
 Documentation/kbuild/makefiles.rst                 |    2 +-
 .../device_drivers/ethernet/neterion/s2io.rst      |    4 +-
 Documentation/scheduler/sched-arch.rst             |    4 +-
 Documentation/trace/kprobes.rst                    |    1 -
 Documentation/translations/zh_CN/arch/index.rst    |    1 -
 .../translations/zh_CN/core-api/cpu_hotplug.rst    |    6 -
 .../translations/zh_CN/scheduler/sched-arch.rst    |    5 +-
 MAINTAINERS                                        |   11 -
 Makefile                                           |    4 +-
 arch/Kconfig                                       |    1 -
 arch/alpha/kernel/syscalls/syscall.tbl             |    3 +-
 arch/arm/tools/syscall.tbl                         |    3 +-
 arch/arm64/include/asm/unistd.h                    |    2 +-
 arch/arm64/include/asm/unistd32.h                  |    6 +-
 arch/hexagon/include/asm/ptrace.h                  |   25 +
 arch/hexagon/include/uapi/asm/ptrace.h             |   13 -
 arch/ia64/Kbuild                                   |    3 -
 arch/ia64/Kconfig                                  |  394 ----
 arch/ia64/Kconfig.debug                            |   55 -
 arch/ia64/Makefile                                 |   82 -
 arch/ia64/configs/bigsur_defconfig                 |  102 -
 arch/ia64/configs/generic_defconfig                |  206 --
 arch/ia64/configs/gensparse_defconfig              |  184 --
 arch/ia64/configs/tiger_defconfig                  |  169 --
 arch/ia64/configs/zx1_defconfig                    |  148 --
 arch/ia64/hp/common/Makefile                       |   10 -
 arch/ia64/hp/common/aml_nfw.c                      |  232 --
 arch/ia64/hp/common/sba_iommu.c                    | 2155 ------------------
 arch/ia64/include/asm/Kbuild                       |    6 -
 arch/ia64/include/asm/acenv.h                      |   49 -
 arch/ia64/include/asm/acpi-ext.h                   |   17 -
 arch/ia64/include/asm/acpi.h                       |  110 -
 arch/ia64/include/asm/asm-offsets.h                |    1 -
 arch/ia64/include/asm/asm-prototypes.h             |   30 -
 arch/ia64/include/asm/asmmacro.h                   |  136 --
 arch/ia64/include/asm/atomic.h                     |  216 --
 arch/ia64/include/asm/barrier.h                    |   79 -
 arch/ia64/include/asm/bitops.h                     |  453 ----
 arch/ia64/include/asm/bug.h                        |   19 -
 arch/ia64/include/asm/cache.h                      |   30 -
 arch/ia64/include/asm/cacheflush.h                 |   39 -
 arch/ia64/include/asm/checksum.h                   |   63 -
 arch/ia64/include/asm/clocksource.h                |   11 -
 arch/ia64/include/asm/cmpxchg.h                    |   33 -
 arch/ia64/include/asm/cpu.h                        |   23 -
 arch/ia64/include/asm/cputime.h                    |   21 -
 arch/ia64/include/asm/current.h                    |   18 -
 arch/ia64/include/asm/cyclone.h                    |   16 -
 arch/ia64/include/asm/delay.h                      |   89 -
 arch/ia64/include/asm/device.h                     |   14 -
 arch/ia64/include/asm/div64.h                      |    1 -
 arch/ia64/include/asm/dma-mapping.h                |   16 -
 arch/ia64/include/asm/dma.h                        |   17 -
 arch/ia64/include/asm/dmi.h                        |   15 -
 arch/ia64/include/asm/early_ioremap.h              |   11 -
 arch/ia64/include/asm/efi.h                        |   13 -
 arch/ia64/include/asm/elf.h                        |  233 --
 arch/ia64/include/asm/emergency-restart.h          |    6 -
 arch/ia64/include/asm/esi.h                        |   30 -
 arch/ia64/include/asm/exception.h                  |   23 -
 arch/ia64/include/asm/extable.h                    |   12 -
 arch/ia64/include/asm/fb.h                         |   43 -
 arch/ia64/include/asm/fpswa.h                      |   74 -
 arch/ia64/include/asm/ftrace.h                     |   28 -
 arch/ia64/include/asm/futex.h                      |  109 -
 arch/ia64/include/asm/gcc_intrin.h                 |   13 -
 arch/ia64/include/asm/hardirq.h                    |   27 -
 arch/ia64/include/asm/hugetlb.h                    |   34 -
 arch/ia64/include/asm/hw_irq.h                     |  167 --
 arch/ia64/include/asm/idle.h                       |    8 -
 arch/ia64/include/asm/intrinsics.h                 |   13 -
 arch/ia64/include/asm/io.h                         |  271 ---
 arch/ia64/include/asm/iommu.h                      |   22 -
 arch/ia64/include/asm/iosapic.h                    |  106 -
 arch/ia64/include/asm/irq.h                        |   37 -
 arch/ia64/include/asm/irq_regs.h                   |    1 -
 arch/ia64/include/asm/irq_remapping.h              |    5 -
 arch/ia64/include/asm/irqflags.h                   |   95 -
 arch/ia64/include/asm/kdebug.h                     |   45 -
 arch/ia64/include/asm/kexec.h                      |   46 -
 arch/ia64/include/asm/kprobes.h                    |  116 -
 arch/ia64/include/asm/kregs.h                      |  166 --
 arch/ia64/include/asm/libata-portmap.h             |    9 -
 arch/ia64/include/asm/linkage.h                    |   19 -
 arch/ia64/include/asm/local.h                      |    1 -
 arch/ia64/include/asm/mca.h                        |  185 --
 arch/ia64/include/asm/mca_asm.h                    |  245 ---
 arch/ia64/include/asm/meminit.h                    |   59 -
 arch/ia64/include/asm/mman.h                       |   18 -
 arch/ia64/include/asm/mmiowb.h                     |   17 -
 arch/ia64/include/asm/mmu.h                        |   14 -
 arch/ia64/include/asm/mmu_context.h                |  194 --
 arch/ia64/include/asm/mmzone.h                     |   35 -
 arch/ia64/include/asm/module.h                     |   35 -
 arch/ia64/include/asm/module.lds.h                 |   14 -
 arch/ia64/include/asm/msidef.h                     |   43 -
 arch/ia64/include/asm/native/inst.h                |  119 -
 arch/ia64/include/asm/native/irq.h                 |   20 -
 arch/ia64/include/asm/native/patchlist.h           |   24 -
 arch/ia64/include/asm/nodedata.h                   |   63 -
 arch/ia64/include/asm/numa.h                       |   83 -
 arch/ia64/include/asm/page.h                       |  208 --
 arch/ia64/include/asm/pal.h                        | 1827 ---------------
 arch/ia64/include/asm/param.h                      |   18 -
 arch/ia64/include/asm/parport.h                    |   20 -
 arch/ia64/include/asm/patch.h                      |   28 -
 arch/ia64/include/asm/pci.h                        |   66 -
 arch/ia64/include/asm/percpu.h                     |   53 -
 arch/ia64/include/asm/pgalloc.h                    |   64 -
 arch/ia64/include/asm/pgtable.h                    |  545 -----
 arch/ia64/include/asm/processor.h                  |  660 ------
 arch/ia64/include/asm/ptrace.h                     |  146 --
 arch/ia64/include/asm/sal.h                        |  919 --------
 arch/ia64/include/asm/sections.h                   |   33 -
 arch/ia64/include/asm/serial.h                     |   17 -
 arch/ia64/include/asm/shmparam.h                   |   13 -
 arch/ia64/include/asm/signal.h                     |   33 -
 arch/ia64/include/asm/smp.h                        |  103 -
 arch/ia64/include/asm/sn/intr.h                    |   15 -
 arch/ia64/include/asm/sn/sn_sal.h                  |  124 --
 arch/ia64/include/asm/sparsemem.h                  |   28 -
 arch/ia64/include/asm/spinlock.h                   |  265 ---
 arch/ia64/include/asm/spinlock_types.h             |   22 -
 arch/ia64/include/asm/string.h                     |   22 -
 arch/ia64/include/asm/switch_to.h                  |   71 -
 arch/ia64/include/asm/syscall.h                    |   65 -
 arch/ia64/include/asm/thread_info.h                |  131 --
 arch/ia64/include/asm/timex.h                      |   47 -
 arch/ia64/include/asm/tlb.h                        |   50 -
 arch/ia64/include/asm/tlbflush.h                   |  128 --
 arch/ia64/include/asm/topology.h                   |   56 -
 arch/ia64/include/asm/types.h                      |   32 -
 arch/ia64/include/asm/uaccess.h                    |  265 ---
 arch/ia64/include/asm/uncached.h                   |    9 -
 arch/ia64/include/asm/unistd.h                     |   38 -
 arch/ia64/include/asm/unwind.h                     |  234 --
 arch/ia64/include/asm/user.h                       |   53 -
 arch/ia64/include/asm/ustack.h                     |   12 -
 arch/ia64/include/asm/uv/uv.h                      |   30 -
 arch/ia64/include/asm/uv/uv_hub.h                  |  315 ---
 arch/ia64/include/asm/uv/uv_mmrs.h                 |  825 -------
 arch/ia64/include/asm/vermagic.h                   |   15 -
 arch/ia64/include/asm/vga.h                        |   26 -
 arch/ia64/include/asm/vmalloc.h                    |    4 -
 arch/ia64/include/asm/xor.h                        |   30 -
 arch/ia64/include/asm/xtp.h                        |   46 -
 arch/ia64/include/uapi/asm/Kbuild                  |    2 -
 arch/ia64/include/uapi/asm/auxvec.h                |   14 -
 arch/ia64/include/uapi/asm/bitsperlong.h           |    9 -
 arch/ia64/include/uapi/asm/break.h                 |   23 -
 arch/ia64/include/uapi/asm/byteorder.h             |    7 -
 arch/ia64/include/uapi/asm/cmpxchg.h               |  138 --
 arch/ia64/include/uapi/asm/fcntl.h                 |   15 -
 arch/ia64/include/uapi/asm/fpu.h                   |   67 -
 arch/ia64/include/uapi/asm/gcc_intrin.h            |  619 ------
 arch/ia64/include/uapi/asm/ia64regs.h              |  101 -
 arch/ia64/include/uapi/asm/intrinsics.h            |   82 -
 arch/ia64/include/uapi/asm/mman.h                  |   17 -
 arch/ia64/include/uapi/asm/param.h                 |   30 -
 arch/ia64/include/uapi/asm/posix_types.h           |    9 -
 arch/ia64/include/uapi/asm/ptrace.h                |  248 ---
 arch/ia64/include/uapi/asm/ptrace_offsets.h        |  269 ---
 arch/ia64/include/uapi/asm/resource.h              |    8 -
 arch/ia64/include/uapi/asm/rse.h                   |   67 -
 arch/ia64/include/uapi/asm/setup.h                 |   25 -
 arch/ia64/include/uapi/asm/sigcontext.h            |   71 -
 arch/ia64/include/uapi/asm/siginfo.h               |   28 -
 arch/ia64/include/uapi/asm/signal.h                |   98 -
 arch/ia64/include/uapi/asm/stat.h                  |   52 -
 arch/ia64/include/uapi/asm/statfs.h                |   21 -
 arch/ia64/include/uapi/asm/swab.h                  |   35 -
 arch/ia64/include/uapi/asm/types.h                 |   32 -
 arch/ia64/include/uapi/asm/ucontext.h              |   13 -
 arch/ia64/include/uapi/asm/unistd.h                |   22 -
 arch/ia64/include/uapi/asm/ustack.h                |   13 -
 arch/ia64/install.sh                               |   30 -
 arch/ia64/kernel/.gitignore                        |    3 -
 arch/ia64/kernel/Makefile                          |   46 -
 arch/ia64/kernel/Makefile.gate                     |   29 -
 arch/ia64/kernel/acpi-ext.c                        |  101 -
 arch/ia64/kernel/acpi.c                            |  913 --------
 arch/ia64/kernel/asm-offsets.c                     |  289 ---
 arch/ia64/kernel/audit.c                           |   63 -
 arch/ia64/kernel/brl_emu.c                         |  217 --
 arch/ia64/kernel/crash.c                           |  257 ---
 arch/ia64/kernel/crash_dump.c                      |   27 -
 arch/ia64/kernel/cyclone.c                         |  125 --
 arch/ia64/kernel/dma-mapping.c                     |    9 -
 arch/ia64/kernel/efi.c                             | 1360 ------------
 arch/ia64/kernel/efi_stub.S                        |   87 -
 arch/ia64/kernel/elfcore.c                         |   77 -
 arch/ia64/kernel/entry.S                           | 1427 ------------
 arch/ia64/kernel/entry.h                           |   83 -
 arch/ia64/kernel/err_inject.c                      |  273 ---
 arch/ia64/kernel/esi.c                             |  193 --
 arch/ia64/kernel/esi_stub.S                        |   99 -
 arch/ia64/kernel/fsys.S                            |  837 -------
 arch/ia64/kernel/fsyscall_gtod_data.h              |   30 -
 arch/ia64/kernel/ftrace.c                          |  196 --
 arch/ia64/kernel/gate-data.S                       |    3 -
 arch/ia64/kernel/gate.S                            |  380 ----
 arch/ia64/kernel/gate.lds.S                        |  108 -
 arch/ia64/kernel/head.S                            | 1167 ----------
 arch/ia64/kernel/iosapic.c                         | 1137 ----------
 arch/ia64/kernel/irq.c                             |  181 --
 arch/ia64/kernel/irq.h                             |    3 -
 arch/ia64/kernel/irq_ia64.c                        |  645 ------
 arch/ia64/kernel/irq_lsapic.c                      |   45 -
 arch/ia64/kernel/ivt.S                             | 1688 --------------
 arch/ia64/kernel/kprobes.c                         |  911 --------
 arch/ia64/kernel/machine_kexec.c                   |  163 --
 arch/ia64/kernel/mca.c                             | 2111 ------------------
 arch/ia64/kernel/mca_asm.S                         | 1123 ----------
 arch/ia64/kernel/mca_drv.c                         |  796 -------
 arch/ia64/kernel/mca_drv.h                         |  123 --
 arch/ia64/kernel/mca_drv_asm.S                     |   56 -
 arch/ia64/kernel/minstate.h                        |  251 ---
 arch/ia64/kernel/module.c                          |  959 --------
 arch/ia64/kernel/msi_ia64.c                        |  198 --
 arch/ia64/kernel/numa.c                            |   73 -
 arch/ia64/kernel/pal.S                             |  306 ---
 arch/ia64/kernel/palinfo.c                         |  942 --------
 arch/ia64/kernel/patch.c                           |  237 --
 arch/ia64/kernel/pci-dma.c                         |   33 -
 arch/ia64/kernel/perfmon_itanium.h                 |  116 -
 arch/ia64/kernel/process.c                         |  611 ------
 arch/ia64/kernel/ptrace.c                          | 2012 -----------------
 arch/ia64/kernel/relocate_kernel.S                 |  321 ---
 arch/ia64/kernel/sal.c                             |  400 ----
 arch/ia64/kernel/salinfo.c                         |  646 ------
 arch/ia64/kernel/setup.c                           | 1081 ---------
 arch/ia64/kernel/sigframe.h                        |   26 -
 arch/ia64/kernel/signal.c                          |  412 ----
 arch/ia64/kernel/smp.c                             |  335 ---
 arch/ia64/kernel/smpboot.c                         |  839 -------
 arch/ia64/kernel/stacktrace.c                      |   40 -
 arch/ia64/kernel/sys_ia64.c                        |  197 --
 arch/ia64/kernel/syscalls/Makefile                 |   32 -
 arch/ia64/kernel/syscalls/syscall.tbl              |  375 ----
 arch/ia64/kernel/time.c                            |  463 ----
 arch/ia64/kernel/topology.c                        |  410 ----
 arch/ia64/kernel/traps.c                           |  612 ------
 arch/ia64/kernel/unaligned.c                       | 1560 -------------
 arch/ia64/kernel/uncached.c                        |  273 ---
 arch/ia64/kernel/unwind.c                          | 2320 --------------------
 arch/ia64/kernel/unwind_decoder.c                  |  460 ----
 arch/ia64/kernel/unwind_i.h                        |  165 --
 arch/ia64/kernel/vmlinux.lds.S                     |  224 --
 arch/ia64/lib/Makefile                             |   48 -
 arch/ia64/lib/checksum.c                           |  102 -
 arch/ia64/lib/clear_page.S                         |   79 -
 arch/ia64/lib/clear_user.S                         |  212 --
 arch/ia64/lib/copy_page.S                          |  101 -
 arch/ia64/lib/copy_page_mck.S                      |  188 --
 arch/ia64/lib/copy_user.S                          |  613 ------
 arch/ia64/lib/csum_partial_copy.c                  |   98 -
 arch/ia64/lib/do_csum.S                            |  324 ---
 arch/ia64/lib/flush.S                              |  119 -
 arch/ia64/lib/idiv32.S                             |   86 -
 arch/ia64/lib/idiv64.S                             |   83 -
 arch/ia64/lib/io.c                                 |   51 -
 arch/ia64/lib/ip_fast_csum.S                       |  148 --
 arch/ia64/lib/memcpy.S                             |  304 ---
 arch/ia64/lib/memcpy_mck.S                         |  659 ------
 arch/ia64/lib/memset.S                             |  365 ---
 arch/ia64/lib/strlen.S                             |  195 --
 arch/ia64/lib/strncpy_from_user.S                  |   47 -
 arch/ia64/lib/strnlen_user.S                       |   48 -
 arch/ia64/lib/xor.S                                |  181 --
 arch/ia64/mm/Makefile                              |   11 -
 arch/ia64/mm/contig.c                              |  208 --
 arch/ia64/mm/discontig.c                           |  635 ------
 arch/ia64/mm/extable.c                             |   24 -
 arch/ia64/mm/fault.c                               |  251 ---
 arch/ia64/mm/hugetlbpage.c                         |  186 --
 arch/ia64/mm/init.c                                |  532 -----
 arch/ia64/mm/ioremap.c                             |   94 -
 arch/ia64/mm/numa.c                                |   80 -
 arch/ia64/mm/tlb.c                                 |  591 -----
 arch/ia64/pci/Makefile                             |    5 -
 arch/ia64/pci/fixup.c                              |   80 -
 arch/ia64/pci/pci.c                                |  576 -----
 arch/ia64/scripts/check-gas                        |   16 -
 arch/ia64/scripts/check-gas-asm.S                  |    2 -
 arch/ia64/scripts/check-model.c                    |    1 -
 arch/ia64/scripts/check-segrel.S                   |    5 -
 arch/ia64/scripts/check-segrel.lds                 |   13 -
 arch/ia64/scripts/check-serialize.S                |    2 -
 arch/ia64/scripts/check-text-align.S               |    7 -
 arch/ia64/scripts/toolchain-flags                  |   54 -
 arch/ia64/scripts/unwcheck.py                      |   65 -
 arch/ia64/uv/Makefile                              |   12 -
 arch/ia64/uv/kernel/Makefile                       |   12 -
 arch/ia64/uv/kernel/setup.c                        |  120 -
 arch/m68k/kernel/syscalls/syscall.tbl              |    3 +-
 arch/microblaze/kernel/syscalls/syscall.tbl        |    3 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    3 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    3 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    3 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |    3 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |    3 +-
 arch/s390/kernel/syscalls/syscall.tbl              |    3 +-
 arch/sh/kernel/syscalls/syscall.tbl                |    3 +-
 arch/sparc/kernel/syscalls/syscall.tbl             |    3 +-
 arch/x86/entry/syscalls/syscall_32.tbl             |    3 +-
 arch/x86/entry/syscalls/syscall_64.tbl             |    2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl            |    3 +-
 drivers/acpi/Kconfig                               |    6 +-
 drivers/acpi/numa/Kconfig                          |    4 +-
 drivers/acpi/osl.c                                 |    2 +-
 drivers/char/Kconfig                               |    4 +-
 drivers/char/Makefile                              |    1 -
 drivers/char/agp/Kconfig                           |   16 +-
 drivers/char/agp/Makefile                          |    2 -
 drivers/char/agp/hp-agp.c                          |  550 -----
 drivers/char/agp/i460-agp.c                        |  659 ------
 drivers/char/hpet.c                                |   30 -
 drivers/char/hw_random/Kconfig                     |    2 +-
 drivers/char/mem.c                                 |   12 -
 drivers/char/mspec.c                               |  295 ---
 drivers/cpufreq/Kconfig                            |   11 -
 drivers/cpufreq/Makefile                           |    1 -
 drivers/cpufreq/ia64-acpi-cpufreq.c                |  353 ---
 drivers/firmware/Kconfig                           |   24 -
 drivers/firmware/Makefile                          |    1 -
 drivers/firmware/efi/Kconfig                       |    6 +-
 drivers/firmware/efi/efi.c                         |   13 +-
 drivers/firmware/pcdp.c                            |  135 --
 drivers/firmware/pcdp.h                            |  108 -
 drivers/gpu/drm/drm_ioc32.c                        |    4 +-
 drivers/input/serio/i8042.h                        |    2 +-
 drivers/iommu/Kconfig                              |    4 +-
 drivers/iommu/intel/Kconfig                        |    2 +-
 drivers/media/cec/platform/Kconfig                 |    2 +-
 drivers/misc/Kconfig                               |    2 +-
 drivers/misc/sgi-gru/gru.h                         |    4 +-
 drivers/misc/sgi-gru/gru_instructions.h            |   12 +-
 drivers/misc/sgi-gru/grufile.c                     |   72 -
 drivers/misc/sgi-gru/gruhandles.c                  |    6 -
 drivers/misc/sgi-gru/grumain.c                     |    4 -
 drivers/misc/sgi-xp/xp.h                           |    2 +-
 drivers/misc/sgi-xp/xp_uv.c                        |   24 -
 drivers/misc/sgi-xp/xpc_main.c                     |   31 -
 drivers/misc/sgi-xp/xpc_uv.c                       |   85 -
 drivers/net/ethernet/broadcom/tg3.c                |    2 +-
 drivers/net/ethernet/brocade/bna/bnad.h            |    1 -
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |    2 -
 drivers/pci/vgaarb.c                               |    2 +-
 drivers/tty/serial/8250/Kconfig                    |    2 +-
 drivers/tty/vt/keyboard.c                          |    2 +-
 drivers/video/fbdev/Kconfig                        |    2 +-
 drivers/watchdog/Kconfig                           |    2 +-
 fs/Kconfig                                         |    2 +-
 fs/afs/main.c                                      |    2 -
 fs/xfs/xfs_ioctl32.h                               |    2 +-
 include/asm-generic/Kbuild                         |    2 +-
 include/linux/acpi.h                               |    9 +-
 include/linux/compat.h                             |    1 -
 include/linux/efi.h                                |    7 -
 include/linux/mm.h                                 |    2 -
 include/linux/moduleparam.h                        |    2 +-
 include/linux/raid/pq.h                            |    2 -
 include/linux/sched/signal.h                       |   17 +-
 include/linux/syscalls.h                           |    1 -
 include/trace/events/mmflags.h                     |    2 +-
 include/uapi/asm-generic/siginfo.h                 |    5 -
 include/uapi/asm-generic/unistd.h                  |    7 +-
 init/Kconfig                                       |    2 +-
 kernel/cpu.c                                       |    3 -
 kernel/fork.c                                      |    2 +-
 kernel/sched/core.c                                |   29 +-
 kernel/signal.c                                    |   25 +-
 kernel/sys_ni.c                                    |    2 -
 kernel/sysctl.c                                    |    9 -
 lib/Kconfig.debug                                  |    2 +-
 lib/decompress_unxz.c                              |    3 -
 lib/raid6/Makefile                                 |    4 +-
 lib/raid6/algos.c                                  |    4 -
 lib/raid6/int.uc                                   |    9 -
 lib/xz/Kconfig                                     |    5 -
 mm/mmap.c                                          |    6 +-
 scripts/headers_install.sh                         |    1 -
 tools/arch/ia64/include/asm/barrier.h              |   59 -
 tools/arch/ia64/include/uapi/asm/bitsperlong.h     |    9 -
 tools/arch/ia64/include/uapi/asm/mman.h            |    7 -
 tools/include/uapi/asm-generic/unistd.h            |    2 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |    2 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    2 +-
 usr/include/Makefile                               |    6 -
 454 files changed, 144 insertions(+), 65220 deletions(-)
 delete mode 100644 Documentation/arch/ia64/aliasing.rst
 delete mode 100644 Documentation/arch/ia64/efirtc.rst
 delete mode 100644 Documentation/arch/ia64/err_inject.rst
 delete mode 100644 Documentation/arch/ia64/features.rst
 delete mode 100644 Documentation/arch/ia64/fsys.rst
 delete mode 100644 Documentation/arch/ia64/ia64.rst
 delete mode 100644 Documentation/arch/ia64/index.rst
 delete mode 100644 Documentation/arch/ia64/irq-redir.rst
 delete mode 100644 Documentation/arch/ia64/mca.rst
 delete mode 100644 Documentation/arch/ia64/serial.rst
 create mode 100644 arch/hexagon/include/asm/ptrace.h
 delete mode 100644 arch/ia64/Kbuild
 delete mode 100644 arch/ia64/Kconfig
 delete mode 100644 arch/ia64/Kconfig.debug
 delete mode 100644 arch/ia64/Makefile
 delete mode 100644 arch/ia64/configs/bigsur_defconfig
 delete mode 100644 arch/ia64/configs/generic_defconfig
 delete mode 100644 arch/ia64/configs/gensparse_defconfig
 delete mode 100644 arch/ia64/configs/tiger_defconfig
 delete mode 100644 arch/ia64/configs/zx1_defconfig
 delete mode 100644 arch/ia64/hp/common/Makefile
 delete mode 100644 arch/ia64/hp/common/aml_nfw.c
 delete mode 100644 arch/ia64/hp/common/sba_iommu.c
 delete mode 100644 arch/ia64/include/asm/Kbuild
 delete mode 100644 arch/ia64/include/asm/acenv.h
 delete mode 100644 arch/ia64/include/asm/acpi-ext.h
 delete mode 100644 arch/ia64/include/asm/acpi.h
 delete mode 100644 arch/ia64/include/asm/asm-offsets.h
 delete mode 100644 arch/ia64/include/asm/asm-prototypes.h
 delete mode 100644 arch/ia64/include/asm/asmmacro.h
 delete mode 100644 arch/ia64/include/asm/atomic.h
 delete mode 100644 arch/ia64/include/asm/barrier.h
 delete mode 100644 arch/ia64/include/asm/bitops.h
 delete mode 100644 arch/ia64/include/asm/bug.h
 delete mode 100644 arch/ia64/include/asm/cache.h
 delete mode 100644 arch/ia64/include/asm/cacheflush.h
 delete mode 100644 arch/ia64/include/asm/checksum.h
 delete mode 100644 arch/ia64/include/asm/clocksource.h
 delete mode 100644 arch/ia64/include/asm/cmpxchg.h
 delete mode 100644 arch/ia64/include/asm/cpu.h
 delete mode 100644 arch/ia64/include/asm/cputime.h
 delete mode 100644 arch/ia64/include/asm/current.h
 delete mode 100644 arch/ia64/include/asm/cyclone.h
 delete mode 100644 arch/ia64/include/asm/delay.h
 delete mode 100644 arch/ia64/include/asm/device.h
 delete mode 100644 arch/ia64/include/asm/div64.h
 delete mode 100644 arch/ia64/include/asm/dma-mapping.h
 delete mode 100644 arch/ia64/include/asm/dma.h
 delete mode 100644 arch/ia64/include/asm/dmi.h
 delete mode 100644 arch/ia64/include/asm/early_ioremap.h
 delete mode 100644 arch/ia64/include/asm/efi.h
 delete mode 100644 arch/ia64/include/asm/elf.h
 delete mode 100644 arch/ia64/include/asm/emergency-restart.h
 delete mode 100644 arch/ia64/include/asm/esi.h
 delete mode 100644 arch/ia64/include/asm/exception.h
 delete mode 100644 arch/ia64/include/asm/extable.h
 delete mode 100644 arch/ia64/include/asm/fb.h
 delete mode 100644 arch/ia64/include/asm/fpswa.h
 delete mode 100644 arch/ia64/include/asm/ftrace.h
 delete mode 100644 arch/ia64/include/asm/futex.h
 delete mode 100644 arch/ia64/include/asm/gcc_intrin.h
 delete mode 100644 arch/ia64/include/asm/hardirq.h
 delete mode 100644 arch/ia64/include/asm/hugetlb.h
 delete mode 100644 arch/ia64/include/asm/hw_irq.h
 delete mode 100644 arch/ia64/include/asm/idle.h
 delete mode 100644 arch/ia64/include/asm/intrinsics.h
 delete mode 100644 arch/ia64/include/asm/io.h
 delete mode 100644 arch/ia64/include/asm/iommu.h
 delete mode 100644 arch/ia64/include/asm/iosapic.h
 delete mode 100644 arch/ia64/include/asm/irq.h
 delete mode 100644 arch/ia64/include/asm/irq_regs.h
 delete mode 100644 arch/ia64/include/asm/irq_remapping.h
 delete mode 100644 arch/ia64/include/asm/irqflags.h
 delete mode 100644 arch/ia64/include/asm/kdebug.h
 delete mode 100644 arch/ia64/include/asm/kexec.h
 delete mode 100644 arch/ia64/include/asm/kprobes.h
 delete mode 100644 arch/ia64/include/asm/kregs.h
 delete mode 100644 arch/ia64/include/asm/libata-portmap.h
 delete mode 100644 arch/ia64/include/asm/linkage.h
 delete mode 100644 arch/ia64/include/asm/local.h
 delete mode 100644 arch/ia64/include/asm/mca.h
 delete mode 100644 arch/ia64/include/asm/mca_asm.h
 delete mode 100644 arch/ia64/include/asm/meminit.h
 delete mode 100644 arch/ia64/include/asm/mman.h
 delete mode 100644 arch/ia64/include/asm/mmiowb.h
 delete mode 100644 arch/ia64/include/asm/mmu.h
 delete mode 100644 arch/ia64/include/asm/mmu_context.h
 delete mode 100644 arch/ia64/include/asm/mmzone.h
 delete mode 100644 arch/ia64/include/asm/module.h
 delete mode 100644 arch/ia64/include/asm/module.lds.h
 delete mode 100644 arch/ia64/include/asm/msidef.h
 delete mode 100644 arch/ia64/include/asm/native/inst.h
 delete mode 100644 arch/ia64/include/asm/native/irq.h
 delete mode 100644 arch/ia64/include/asm/native/patchlist.h
 delete mode 100644 arch/ia64/include/asm/nodedata.h
 delete mode 100644 arch/ia64/include/asm/numa.h
 delete mode 100644 arch/ia64/include/asm/page.h
 delete mode 100644 arch/ia64/include/asm/pal.h
 delete mode 100644 arch/ia64/include/asm/param.h
 delete mode 100644 arch/ia64/include/asm/parport.h
 delete mode 100644 arch/ia64/include/asm/patch.h
 delete mode 100644 arch/ia64/include/asm/pci.h
 delete mode 100644 arch/ia64/include/asm/percpu.h
 delete mode 100644 arch/ia64/include/asm/pgalloc.h
 delete mode 100644 arch/ia64/include/asm/pgtable.h
 delete mode 100644 arch/ia64/include/asm/processor.h
 delete mode 100644 arch/ia64/include/asm/ptrace.h
 delete mode 100644 arch/ia64/include/asm/sal.h
 delete mode 100644 arch/ia64/include/asm/sections.h
 delete mode 100644 arch/ia64/include/asm/serial.h
 delete mode 100644 arch/ia64/include/asm/shmparam.h
 delete mode 100644 arch/ia64/include/asm/signal.h
 delete mode 100644 arch/ia64/include/asm/smp.h
 delete mode 100644 arch/ia64/include/asm/sn/intr.h
 delete mode 100644 arch/ia64/include/asm/sn/sn_sal.h
 delete mode 100644 arch/ia64/include/asm/sparsemem.h
 delete mode 100644 arch/ia64/include/asm/spinlock.h
 delete mode 100644 arch/ia64/include/asm/spinlock_types.h
 delete mode 100644 arch/ia64/include/asm/string.h
 delete mode 100644 arch/ia64/include/asm/switch_to.h
 delete mode 100644 arch/ia64/include/asm/syscall.h
 delete mode 100644 arch/ia64/include/asm/thread_info.h
 delete mode 100644 arch/ia64/include/asm/timex.h
 delete mode 100644 arch/ia64/include/asm/tlb.h
 delete mode 100644 arch/ia64/include/asm/tlbflush.h
 delete mode 100644 arch/ia64/include/asm/topology.h
 delete mode 100644 arch/ia64/include/asm/types.h
 delete mode 100644 arch/ia64/include/asm/uaccess.h
 delete mode 100644 arch/ia64/include/asm/uncached.h
 delete mode 100644 arch/ia64/include/asm/unistd.h
 delete mode 100644 arch/ia64/include/asm/unwind.h
 delete mode 100644 arch/ia64/include/asm/user.h
 delete mode 100644 arch/ia64/include/asm/ustack.h
 delete mode 100644 arch/ia64/include/asm/uv/uv.h
 delete mode 100644 arch/ia64/include/asm/uv/uv_hub.h
 delete mode 100644 arch/ia64/include/asm/uv/uv_mmrs.h
 delete mode 100644 arch/ia64/include/asm/vermagic.h
 delete mode 100644 arch/ia64/include/asm/vga.h
 delete mode 100644 arch/ia64/include/asm/vmalloc.h
 delete mode 100644 arch/ia64/include/asm/xor.h
 delete mode 100644 arch/ia64/include/asm/xtp.h
 delete mode 100644 arch/ia64/include/uapi/asm/Kbuild
 delete mode 100644 arch/ia64/include/uapi/asm/auxvec.h
 delete mode 100644 arch/ia64/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/ia64/include/uapi/asm/break.h
 delete mode 100644 arch/ia64/include/uapi/asm/byteorder.h
 delete mode 100644 arch/ia64/include/uapi/asm/cmpxchg.h
 delete mode 100644 arch/ia64/include/uapi/asm/fcntl.h
 delete mode 100644 arch/ia64/include/uapi/asm/fpu.h
 delete mode 100644 arch/ia64/include/uapi/asm/gcc_intrin.h
 delete mode 100644 arch/ia64/include/uapi/asm/ia64regs.h
 delete mode 100644 arch/ia64/include/uapi/asm/intrinsics.h
 delete mode 100644 arch/ia64/include/uapi/asm/mman.h
 delete mode 100644 arch/ia64/include/uapi/asm/param.h
 delete mode 100644 arch/ia64/include/uapi/asm/posix_types.h
 delete mode 100644 arch/ia64/include/uapi/asm/ptrace.h
 delete mode 100644 arch/ia64/include/uapi/asm/ptrace_offsets.h
 delete mode 100644 arch/ia64/include/uapi/asm/resource.h
 delete mode 100644 arch/ia64/include/uapi/asm/rse.h
 delete mode 100644 arch/ia64/include/uapi/asm/setup.h
 delete mode 100644 arch/ia64/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/ia64/include/uapi/asm/siginfo.h
 delete mode 100644 arch/ia64/include/uapi/asm/signal.h
 delete mode 100644 arch/ia64/include/uapi/asm/stat.h
 delete mode 100644 arch/ia64/include/uapi/asm/statfs.h
 delete mode 100644 arch/ia64/include/uapi/asm/swab.h
 delete mode 100644 arch/ia64/include/uapi/asm/types.h
 delete mode 100644 arch/ia64/include/uapi/asm/ucontext.h
 delete mode 100644 arch/ia64/include/uapi/asm/unistd.h
 delete mode 100644 arch/ia64/include/uapi/asm/ustack.h
 delete mode 100755 arch/ia64/install.sh
 delete mode 100644 arch/ia64/kernel/.gitignore
 delete mode 100644 arch/ia64/kernel/Makefile
 delete mode 100644 arch/ia64/kernel/Makefile.gate
 delete mode 100644 arch/ia64/kernel/acpi-ext.c
 delete mode 100644 arch/ia64/kernel/acpi.c
 delete mode 100644 arch/ia64/kernel/asm-offsets.c
 delete mode 100644 arch/ia64/kernel/audit.c
 delete mode 100644 arch/ia64/kernel/brl_emu.c
 delete mode 100644 arch/ia64/kernel/crash.c
 delete mode 100644 arch/ia64/kernel/crash_dump.c
 delete mode 100644 arch/ia64/kernel/cyclone.c
 delete mode 100644 arch/ia64/kernel/dma-mapping.c
 delete mode 100644 arch/ia64/kernel/efi.c
 delete mode 100644 arch/ia64/kernel/efi_stub.S
 delete mode 100644 arch/ia64/kernel/elfcore.c
 delete mode 100644 arch/ia64/kernel/entry.S
 delete mode 100644 arch/ia64/kernel/entry.h
 delete mode 100644 arch/ia64/kernel/err_inject.c
 delete mode 100644 arch/ia64/kernel/esi.c
 delete mode 100644 arch/ia64/kernel/esi_stub.S
 delete mode 100644 arch/ia64/kernel/fsys.S
 delete mode 100644 arch/ia64/kernel/fsyscall_gtod_data.h
 delete mode 100644 arch/ia64/kernel/ftrace.c
 delete mode 100644 arch/ia64/kernel/gate-data.S
 delete mode 100644 arch/ia64/kernel/gate.S
 delete mode 100644 arch/ia64/kernel/gate.lds.S
 delete mode 100644 arch/ia64/kernel/head.S
 delete mode 100644 arch/ia64/kernel/iosapic.c
 delete mode 100644 arch/ia64/kernel/irq.c
 delete mode 100644 arch/ia64/kernel/irq.h
 delete mode 100644 arch/ia64/kernel/irq_ia64.c
 delete mode 100644 arch/ia64/kernel/irq_lsapic.c
 delete mode 100644 arch/ia64/kernel/ivt.S
 delete mode 100644 arch/ia64/kernel/kprobes.c
 delete mode 100644 arch/ia64/kernel/machine_kexec.c
 delete mode 100644 arch/ia64/kernel/mca.c
 delete mode 100644 arch/ia64/kernel/mca_asm.S
 delete mode 100644 arch/ia64/kernel/mca_drv.c
 delete mode 100644 arch/ia64/kernel/mca_drv.h
 delete mode 100644 arch/ia64/kernel/mca_drv_asm.S
 delete mode 100644 arch/ia64/kernel/minstate.h
 delete mode 100644 arch/ia64/kernel/module.c
 delete mode 100644 arch/ia64/kernel/msi_ia64.c
 delete mode 100644 arch/ia64/kernel/numa.c
 delete mode 100644 arch/ia64/kernel/pal.S
 delete mode 100644 arch/ia64/kernel/palinfo.c
 delete mode 100644 arch/ia64/kernel/patch.c
 delete mode 100644 arch/ia64/kernel/pci-dma.c
 delete mode 100644 arch/ia64/kernel/perfmon_itanium.h
 delete mode 100644 arch/ia64/kernel/process.c
 delete mode 100644 arch/ia64/kernel/ptrace.c
 delete mode 100644 arch/ia64/kernel/relocate_kernel.S
 delete mode 100644 arch/ia64/kernel/sal.c
 delete mode 100644 arch/ia64/kernel/salinfo.c
 delete mode 100644 arch/ia64/kernel/setup.c
 delete mode 100644 arch/ia64/kernel/sigframe.h
 delete mode 100644 arch/ia64/kernel/signal.c
 delete mode 100644 arch/ia64/kernel/smp.c
 delete mode 100644 arch/ia64/kernel/smpboot.c
 delete mode 100644 arch/ia64/kernel/stacktrace.c
 delete mode 100644 arch/ia64/kernel/sys_ia64.c
 delete mode 100644 arch/ia64/kernel/syscalls/Makefile
 delete mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 delete mode 100644 arch/ia64/kernel/time.c
 delete mode 100644 arch/ia64/kernel/topology.c
 delete mode 100644 arch/ia64/kernel/traps.c
 delete mode 100644 arch/ia64/kernel/unaligned.c
 delete mode 100644 arch/ia64/kernel/uncached.c
 delete mode 100644 arch/ia64/kernel/unwind.c
 delete mode 100644 arch/ia64/kernel/unwind_decoder.c
 delete mode 100644 arch/ia64/kernel/unwind_i.h
 delete mode 100644 arch/ia64/kernel/vmlinux.lds.S
 delete mode 100644 arch/ia64/lib/Makefile
 delete mode 100644 arch/ia64/lib/checksum.c
 delete mode 100644 arch/ia64/lib/clear_page.S
 delete mode 100644 arch/ia64/lib/clear_user.S
 delete mode 100644 arch/ia64/lib/copy_page.S
 delete mode 100644 arch/ia64/lib/copy_page_mck.S
 delete mode 100644 arch/ia64/lib/copy_user.S
 delete mode 100644 arch/ia64/lib/csum_partial_copy.c
 delete mode 100644 arch/ia64/lib/do_csum.S
 delete mode 100644 arch/ia64/lib/flush.S
 delete mode 100644 arch/ia64/lib/idiv32.S
 delete mode 100644 arch/ia64/lib/idiv64.S
 delete mode 100644 arch/ia64/lib/io.c
 delete mode 100644 arch/ia64/lib/ip_fast_csum.S
 delete mode 100644 arch/ia64/lib/memcpy.S
 delete mode 100644 arch/ia64/lib/memcpy_mck.S
 delete mode 100644 arch/ia64/lib/memset.S
 delete mode 100644 arch/ia64/lib/strlen.S
 delete mode 100644 arch/ia64/lib/strncpy_from_user.S
 delete mode 100644 arch/ia64/lib/strnlen_user.S
 delete mode 100644 arch/ia64/lib/xor.S
 delete mode 100644 arch/ia64/mm/Makefile
 delete mode 100644 arch/ia64/mm/contig.c
 delete mode 100644 arch/ia64/mm/discontig.c
 delete mode 100644 arch/ia64/mm/extable.c
 delete mode 100644 arch/ia64/mm/fault.c
 delete mode 100644 arch/ia64/mm/hugetlbpage.c
 delete mode 100644 arch/ia64/mm/init.c
 delete mode 100644 arch/ia64/mm/ioremap.c
 delete mode 100644 arch/ia64/mm/numa.c
 delete mode 100644 arch/ia64/mm/tlb.c
 delete mode 100644 arch/ia64/pci/Makefile
 delete mode 100644 arch/ia64/pci/fixup.c
 delete mode 100644 arch/ia64/pci/pci.c
 delete mode 100755 arch/ia64/scripts/check-gas
 delete mode 100644 arch/ia64/scripts/check-gas-asm.S
 delete mode 100644 arch/ia64/scripts/check-model.c
 delete mode 100644 arch/ia64/scripts/check-segrel.S
 delete mode 100644 arch/ia64/scripts/check-segrel.lds
 delete mode 100644 arch/ia64/scripts/check-serialize.S
 delete mode 100644 arch/ia64/scripts/check-text-align.S
 delete mode 100755 arch/ia64/scripts/toolchain-flags
 delete mode 100644 arch/ia64/scripts/unwcheck.py
 delete mode 100644 arch/ia64/uv/Makefile
 delete mode 100644 arch/ia64/uv/kernel/Makefile
 delete mode 100644 arch/ia64/uv/kernel/setup.c
 delete mode 100644 drivers/char/agp/hp-agp.c
 delete mode 100644 drivers/char/agp/i460-agp.c
 delete mode 100644 drivers/char/mspec.c
 delete mode 100644 drivers/cpufreq/ia64-acpi-cpufreq.c
 delete mode 100644 drivers/firmware/pcdp.c
 delete mode 100644 drivers/firmware/pcdp.h
 delete mode 100644 tools/arch/ia64/include/asm/barrier.h
 delete mode 100644 tools/arch/ia64/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/ia64/include/uapi/asm/mman.h
