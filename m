Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3A6BBEAF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 22:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjCOVQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 17:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCOVP6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 17:15:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BD94F63;
        Wed, 15 Mar 2023 14:15:52 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id C43E67F9;
        Wed, 15 Mar 2023 21:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C43E67F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678914952; bh=aCOZcaci5Yzhgy/Zskr1rdSlPS1inPqn80GYkAWKzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV5MoAixgfMIyJvjhnHZhXaSdS5Mj08uaBsiWkrR7Q7ZHR8HPp+PxIroviiaBY31y
         DRXhLb9IqS36g1DkTfZp4pVMcNj6AnELkRQVzOUNfkuJlOVifAqz6LGFQzdX2GMDdZ
         EsLGYuGionHISFg+FFLwXerAU3jsQ7spHNPgzEIn9BNn5TdPRXC7HaQHdw+VDXPgy2
         iNETnX7lho6OToi8sxtAnjqgK2+c6ZMvkgEf75kJxXPONniEY7LShIt2AjUUGpn2M3
         tNgLJV1NmsnfrVA0oHoTVGlNQstw9R3DbpMdrhTCCt4JeRaWSqgmRql1kWLAoByOGZ
         3RlABmbOUpm4Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/2] docs: move x86 documentation into Documentation/arch/
Date:   Wed, 15 Mar 2023 15:15:23 -0600
Message-Id: <20230315211523.108836-3-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315211523.108836-1-corbet@lwn.net>
References: <20230315211523.108836-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the x86 documentation under Documentation/arch/ as a way of cleaning
up the top-level directory and making the structure of our docs more
closely match the structure of the source directories it describes.

All in-kernel references to the old paths have been updated.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/hw-vuln/mds.rst            |  2 +-
 .../admin-guide/hw-vuln/tsx_async_abort.rst          |  2 +-
 Documentation/admin-guide/kernel-parameters.rst      |  6 +++---
 Documentation/admin-guide/kernel-parameters.txt      |  8 ++++----
 Documentation/admin-guide/ras.rst                    |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst          |  4 ++--
 Documentation/arch/index.rst                         |  2 +-
 .../{ => arch}/x86/amd-memory-encryption.rst         |  0
 Documentation/{ => arch}/x86/amd_hsmp.rst            |  0
 Documentation/{ => arch}/x86/boot.rst                |  4 ++--
 Documentation/{ => arch}/x86/booting-dt.rst          |  2 +-
 Documentation/{ => arch}/x86/buslock.rst             |  0
 Documentation/{ => arch}/x86/cpuinfo.rst             |  0
 Documentation/{ => arch}/x86/earlyprintk.rst         |  0
 Documentation/{ => arch}/x86/elf_auxvec.rst          |  0
 Documentation/{ => arch}/x86/entry_64.rst            |  0
 Documentation/{ => arch}/x86/exception-tables.rst    |  0
 Documentation/{ => arch}/x86/features.rst            |  0
 Documentation/{ => arch}/x86/i386/IO-APIC.rst        |  0
 Documentation/{ => arch}/x86/i386/index.rst          |  0
 Documentation/{ => arch}/x86/ifs.rst                 |  0
 Documentation/{ => arch}/x86/index.rst               |  0
 Documentation/{ => arch}/x86/intel-hfi.rst           |  0
 Documentation/{ => arch}/x86/intel_txt.rst           |  0
 Documentation/{ => arch}/x86/iommu.rst               |  0
 Documentation/{ => arch}/x86/kernel-stacks.rst       |  0
 Documentation/{ => arch}/x86/mds.rst                 |  0
 Documentation/{ => arch}/x86/microcode.rst           |  0
 Documentation/{ => arch}/x86/mtrr.rst                |  2 +-
 Documentation/{ => arch}/x86/orc-unwinder.rst        |  0
 Documentation/{ => arch}/x86/pat.rst                 |  0
 Documentation/{ => arch}/x86/pti.rst                 |  0
 Documentation/{ => arch}/x86/resctrl.rst             |  0
 Documentation/{ => arch}/x86/sgx.rst                 |  0
 Documentation/{ => arch}/x86/sva.rst                 |  0
 Documentation/{ => arch}/x86/tdx.rst                 |  0
 Documentation/{ => arch}/x86/tlb.rst                 |  0
 Documentation/{ => arch}/x86/topology.rst            |  0
 Documentation/{ => arch}/x86/tsx_async_abort.rst     |  0
 Documentation/{ => arch}/x86/usb-legacy-support.rst  |  0
 .../{ => arch}/x86/x86_64/5level-paging.rst          |  2 +-
 Documentation/{ => arch}/x86/x86_64/boot-options.rst |  4 ++--
 .../{ => arch}/x86/x86_64/cpu-hotplug-spec.rst       |  0
 .../{ => arch}/x86/x86_64/fake-numa-for-cpusets.rst  |  2 +-
 Documentation/{ => arch}/x86/x86_64/fsgs.rst         |  0
 Documentation/{ => arch}/x86/x86_64/index.rst        |  0
 Documentation/{ => arch}/x86/x86_64/machinecheck.rst |  0
 Documentation/{ => arch}/x86/x86_64/mm.rst           |  0
 Documentation/{ => arch}/x86/x86_64/uefi.rst         |  0
 Documentation/{ => arch}/x86/xstate.rst              |  0
 Documentation/{ => arch}/x86/zero-page.rst           |  0
 Documentation/core-api/asm-annotations.rst           |  2 +-
 Documentation/driver-api/device-io.rst               |  2 +-
 Documentation/virt/kvm/api.rst                       |  2 +-
 MAINTAINERS                                          | 12 ++++++------
 arch/arm/Kconfig                                     |  2 +-
 arch/x86/Kconfig                                     | 10 +++++-----
 arch/x86/Kconfig.debug                               |  2 +-
 arch/x86/boot/header.S                               |  2 +-
 arch/x86/entry/entry_64.S                            |  2 +-
 arch/x86/include/asm/bootparam_utils.h               |  2 +-
 arch/x86/include/asm/page_64_types.h                 |  2 +-
 arch/x86/include/asm/pgtable_64_types.h              |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                  |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c                |  2 +-
 arch/x86/kernel/cpu/sgx/sgx.h                        |  2 +-
 arch/x86/kernel/kexec-bzimage64.c                    |  2 +-
 arch/x86/kernel/pci-dma.c                            |  2 +-
 arch/x86/mm/pat/set_memory.c                         |  2 +-
 arch/x86/mm/tlb.c                                    |  2 +-
 arch/x86/platform/pvh/enlighten.c                    |  2 +-
 drivers/vhost/vhost.c                                |  2 +-
 security/Kconfig                                     |  2 +-
 tools/include/linux/err.h                            |  2 +-
 tools/objtool/Documentation/objtool.txt              |  2 +-
 75 files changed, 54 insertions(+), 54 deletions(-)
 rename Documentation/{ => arch}/x86/amd-memory-encryption.rst (100%)
 rename Documentation/{ => arch}/x86/amd_hsmp.rst (100%)
 rename Documentation/{ => arch}/x86/boot.rst (99%)
 rename Documentation/{ => arch}/x86/booting-dt.rst (96%)
 rename Documentation/{ => arch}/x86/buslock.rst (100%)
 rename Documentation/{ => arch}/x86/cpuinfo.rst (100%)
 rename Documentation/{ => arch}/x86/earlyprintk.rst (100%)
 rename Documentation/{ => arch}/x86/elf_auxvec.rst (100%)
 rename Documentation/{ => arch}/x86/entry_64.rst (100%)
 rename Documentation/{ => arch}/x86/exception-tables.rst (100%)
 rename Documentation/{ => arch}/x86/features.rst (100%)
 rename Documentation/{ => arch}/x86/i386/IO-APIC.rst (100%)
 rename Documentation/{ => arch}/x86/i386/index.rst (100%)
 rename Documentation/{ => arch}/x86/ifs.rst (100%)
 rename Documentation/{ => arch}/x86/index.rst (100%)
 rename Documentation/{ => arch}/x86/intel-hfi.rst (100%)
 rename Documentation/{ => arch}/x86/intel_txt.rst (100%)
 rename Documentation/{ => arch}/x86/iommu.rst (100%)
 rename Documentation/{ => arch}/x86/kernel-stacks.rst (100%)
 rename Documentation/{ => arch}/x86/mds.rst (100%)
 rename Documentation/{ => arch}/x86/microcode.rst (100%)
 rename Documentation/{ => arch}/x86/mtrr.rst (99%)
 rename Documentation/{ => arch}/x86/orc-unwinder.rst (100%)
 rename Documentation/{ => arch}/x86/pat.rst (100%)
 rename Documentation/{ => arch}/x86/pti.rst (100%)
 rename Documentation/{ => arch}/x86/resctrl.rst (100%)
 rename Documentation/{ => arch}/x86/sgx.rst (100%)
 rename Documentation/{ => arch}/x86/sva.rst (100%)
 rename Documentation/{ => arch}/x86/tdx.rst (100%)
 rename Documentation/{ => arch}/x86/tlb.rst (100%)
 rename Documentation/{ => arch}/x86/topology.rst (100%)
 rename Documentation/{ => arch}/x86/tsx_async_abort.rst (100%)
 rename Documentation/{ => arch}/x86/usb-legacy-support.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/5level-paging.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/boot-options.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/cpu-hotplug-spec.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/fake-numa-for-cpusets.rst (97%)
 rename Documentation/{ => arch}/x86/x86_64/fsgs.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/index.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/machinecheck.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/mm.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/uefi.rst (100%)
 rename Documentation/{ => arch}/x86/xstate.rst (100%)
 rename Documentation/{ => arch}/x86/zero-page.rst (100%)

diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index f491de74ea79..48ca0bd85604 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -58,7 +58,7 @@ Because the buffers are potentially shared between Hyper-Threads cross
 Hyper-Thread attacks are possible.
 
 Deeper technical information is available in the MDS specific x86
-architecture section: :ref:`Documentation/x86/mds.rst <mds>`.
+architecture section: :ref:`Documentation/arch/x86/mds.rst <mds>`.
 
 
 Attack scenarios
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
index 76673affd917..014167ef8dd1 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -63,7 +63,7 @@ attacker needs to begin a TSX transaction and raise an asynchronous abort
 which in turn potentially leaks data stored in the buffers.
 
 More detailed technical information is available in the TAA specific x86
-architecture section: :ref:`Documentation/x86/tsx_async_abort.rst <tsx_async_abort>`.
+architecture section: :ref:`Documentation/arch/x86/tsx_async_abort.rst <tsx_async_abort>`.
 
 
 Attack scenarios
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 19600c50277b..c833eac3fe59 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -177,7 +177,7 @@ parameter is applicable::
 	X86-32	X86-32, aka i386 architecture is enabled.
 	X86-64	X86-64 architecture is enabled.
 			More X86-64 boot options can be found in
-			Documentation/x86/x86_64/boot-options.rst.
+			Documentation/arch/x86/x86_64/boot-options.rst.
 	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
 	X86_UV	SGI UV support is enabled.
 	XEN	Xen support is enabled
@@ -192,10 +192,10 @@ In addition, the following text indicates that the option::
 Parameters denoted with BOOT are actually interpreted by the boot
 loader, and have no meaning to the kernel directly.
 Do not modify the syntax of boot loader parameters without extreme
-need or coordination with <Documentation/x86/boot.rst>.
+need or coordination with <Documentation/arch/x86/boot.rst>.
 
 There are also arch-specific kernel-parameters not documented here.
-See for example <Documentation/x86/x86_64/boot-options.rst>.
+See for example <Documentation/arch/x86/x86_64/boot-options.rst>.
 
 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
 a trailing = on the name of any parameter states that that parameter will
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..92650680371a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2976,7 +2976,7 @@
 
 	mce		[X86-32] Machine Check Exception
 
-	mce=option	[X86-64] See Documentation/x86/x86_64/boot-options.rst
+	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
 
 	md=		[HW] RAID subsystems devices and level
 			See Documentation/admin-guide/md.rst.
@@ -4410,7 +4410,7 @@
 			and performance comparison.
 
 	pirq=		[SMP,APIC] Manual mp-table setup
-			See Documentation/x86/i386/IO-APIC.rst.
+			See Documentation/arch/x86/i386/IO-APIC.rst.
 
 	plip=		[PPT,NET] Parallel port network link
 			Format: { parport<nr> | timid | 0 }
@@ -5591,7 +5591,7 @@
 
 	serialnumber	[BUGS=X86-32]
 
-	sev=option[,option...] [X86-64] See Documentation/x86/x86_64/boot-options.rst
+	sev=option[,option...] [X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
 
 	shapers=	[NET]
 			Maximal number of shapers.
@@ -6770,7 +6770,7 @@
 			Can be used multiple times for multiple devices.
 
 	vga=		[BOOT,X86-32] Select a particular video mode
-			See Documentation/x86/boot.rst and
+			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
 			Use vga=ask for menu.
 			This is actually a boot loader parameter; the value is
diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 7b481b2a368e..8e03751d126d 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -199,7 +199,7 @@ Architecture (MCA)\ [#f3]_.
   mode).
 
 .. [#f3] For more details about the Machine Check Architecture (MCA),
-  please read Documentation/x86/x86_64/machinecheck.rst at the Kernel tree.
+  please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
 
 EDAC - Error Detection And Correction
 *************************************
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 4b7bfea28cd7..d85d90f5d000 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -95,7 +95,7 @@ is 0x15 and the full version number is 0x234, this file will contain
 the value 340 = 0x154.
 
 See the ``type_of_loader`` and ``ext_loader_type`` fields in
-Documentation/x86/boot.rst for additional information.
+Documentation/arch/x86/boot.rst for additional information.
 
 
 bootloader_version (x86 only)
@@ -105,7 +105,7 @@ The complete bootloader version number.  In the example above, this
 file will contain the value 564 = 0x234.
 
 See the ``type_of_loader`` and ``ext_loader_ver`` fields in
-Documentation/x86/boot.rst for additional information.
+Documentation/arch/x86/boot.rst for additional information.
 
 
 bpf_stats_enabled
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 5f494e001eb4..64a5de81c425 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -24,5 +24,5 @@ implementation.
    ../s390/index
    ../sh/index
    ../sparc/index
-   ../x86/index
+   x86/index
    ../xtensa/index
diff --git a/Documentation/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
similarity index 100%
rename from Documentation/x86/amd-memory-encryption.rst
rename to Documentation/arch/x86/amd-memory-encryption.rst
diff --git a/Documentation/x86/amd_hsmp.rst b/Documentation/arch/x86/amd_hsmp.rst
similarity index 100%
rename from Documentation/x86/amd_hsmp.rst
rename to Documentation/arch/x86/amd_hsmp.rst
diff --git a/Documentation/x86/boot.rst b/Documentation/arch/x86/boot.rst
similarity index 99%
rename from Documentation/x86/boot.rst
rename to Documentation/arch/x86/boot.rst
index 240d084782a6..33520ecdb37a 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1344,7 +1344,7 @@ follow::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as
-described in chapter Documentation/x86/zero-page.rst.
+described in chapter Documentation/arch/x86/zero-page.rst.
 
 After setting up the struct boot_params, the boot loader can load the
 32/64-bit kernel in the same way as that of 16-bit boot protocol.
@@ -1380,7 +1380,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in chapter Documentation/x86/zero-page.rst.
+in chapter Documentation/arch/x86/zero-page.rst.
 
 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
diff --git a/Documentation/x86/booting-dt.rst b/Documentation/arch/x86/booting-dt.rst
similarity index 96%
rename from Documentation/x86/booting-dt.rst
rename to Documentation/arch/x86/booting-dt.rst
index 965a374071ab..b089ffd56e6e 100644
--- a/Documentation/x86/booting-dt.rst
+++ b/Documentation/arch/x86/booting-dt.rst
@@ -7,7 +7,7 @@ DeviceTree Booting
   the decompressor (the real mode entry point goes to the same  32bit
   entry point once it switched into protected mode). That entry point
   supports one calling convention which is documented in
-  Documentation/x86/boot.rst
+  Documentation/arch/x86/boot.rst
   The physical pointer to the device-tree block is passed via setup_data
   which requires at least boot protocol 2.09.
   The type filed is defined as
diff --git a/Documentation/x86/buslock.rst b/Documentation/arch/x86/buslock.rst
similarity index 100%
rename from Documentation/x86/buslock.rst
rename to Documentation/arch/x86/buslock.rst
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
similarity index 100%
rename from Documentation/x86/cpuinfo.rst
rename to Documentation/arch/x86/cpuinfo.rst
diff --git a/Documentation/x86/earlyprintk.rst b/Documentation/arch/x86/earlyprintk.rst
similarity index 100%
rename from Documentation/x86/earlyprintk.rst
rename to Documentation/arch/x86/earlyprintk.rst
diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/arch/x86/elf_auxvec.rst
similarity index 100%
rename from Documentation/x86/elf_auxvec.rst
rename to Documentation/arch/x86/elf_auxvec.rst
diff --git a/Documentation/x86/entry_64.rst b/Documentation/arch/x86/entry_64.rst
similarity index 100%
rename from Documentation/x86/entry_64.rst
rename to Documentation/arch/x86/entry_64.rst
diff --git a/Documentation/x86/exception-tables.rst b/Documentation/arch/x86/exception-tables.rst
similarity index 100%
rename from Documentation/x86/exception-tables.rst
rename to Documentation/arch/x86/exception-tables.rst
diff --git a/Documentation/x86/features.rst b/Documentation/arch/x86/features.rst
similarity index 100%
rename from Documentation/x86/features.rst
rename to Documentation/arch/x86/features.rst
diff --git a/Documentation/x86/i386/IO-APIC.rst b/Documentation/arch/x86/i386/IO-APIC.rst
similarity index 100%
rename from Documentation/x86/i386/IO-APIC.rst
rename to Documentation/arch/x86/i386/IO-APIC.rst
diff --git a/Documentation/x86/i386/index.rst b/Documentation/arch/x86/i386/index.rst
similarity index 100%
rename from Documentation/x86/i386/index.rst
rename to Documentation/arch/x86/i386/index.rst
diff --git a/Documentation/x86/ifs.rst b/Documentation/arch/x86/ifs.rst
similarity index 100%
rename from Documentation/x86/ifs.rst
rename to Documentation/arch/x86/ifs.rst
diff --git a/Documentation/x86/index.rst b/Documentation/arch/x86/index.rst
similarity index 100%
rename from Documentation/x86/index.rst
rename to Documentation/arch/x86/index.rst
diff --git a/Documentation/x86/intel-hfi.rst b/Documentation/arch/x86/intel-hfi.rst
similarity index 100%
rename from Documentation/x86/intel-hfi.rst
rename to Documentation/arch/x86/intel-hfi.rst
diff --git a/Documentation/x86/intel_txt.rst b/Documentation/arch/x86/intel_txt.rst
similarity index 100%
rename from Documentation/x86/intel_txt.rst
rename to Documentation/arch/x86/intel_txt.rst
diff --git a/Documentation/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
similarity index 100%
rename from Documentation/x86/iommu.rst
rename to Documentation/arch/x86/iommu.rst
diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/arch/x86/kernel-stacks.rst
similarity index 100%
rename from Documentation/x86/kernel-stacks.rst
rename to Documentation/arch/x86/kernel-stacks.rst
diff --git a/Documentation/x86/mds.rst b/Documentation/arch/x86/mds.rst
similarity index 100%
rename from Documentation/x86/mds.rst
rename to Documentation/arch/x86/mds.rst
diff --git a/Documentation/x86/microcode.rst b/Documentation/arch/x86/microcode.rst
similarity index 100%
rename from Documentation/x86/microcode.rst
rename to Documentation/arch/x86/microcode.rst
diff --git a/Documentation/x86/mtrr.rst b/Documentation/arch/x86/mtrr.rst
similarity index 99%
rename from Documentation/x86/mtrr.rst
rename to Documentation/arch/x86/mtrr.rst
index 9f0b1851771a..f65ef034da7a 100644
--- a/Documentation/x86/mtrr.rst
+++ b/Documentation/arch/x86/mtrr.rst
@@ -28,7 +28,7 @@ are aligned with platform MTRR setup. If MTRRs are only set up by the platform
 firmware code though and the OS does not make any specific MTRR mapping
 requests mtrr_type_lookup() should always return MTRR_TYPE_INVALID.
 
-For details refer to Documentation/x86/pat.rst.
+For details refer to Documentation/arch/x86/pat.rst.
 
 .. tip::
   On Intel P6 family processors (Pentium Pro, Pentium II and later)
diff --git a/Documentation/x86/orc-unwinder.rst b/Documentation/arch/x86/orc-unwinder.rst
similarity index 100%
rename from Documentation/x86/orc-unwinder.rst
rename to Documentation/arch/x86/orc-unwinder.rst
diff --git a/Documentation/x86/pat.rst b/Documentation/arch/x86/pat.rst
similarity index 100%
rename from Documentation/x86/pat.rst
rename to Documentation/arch/x86/pat.rst
diff --git a/Documentation/x86/pti.rst b/Documentation/arch/x86/pti.rst
similarity index 100%
rename from Documentation/x86/pti.rst
rename to Documentation/arch/x86/pti.rst
diff --git a/Documentation/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
similarity index 100%
rename from Documentation/x86/resctrl.rst
rename to Documentation/arch/x86/resctrl.rst
diff --git a/Documentation/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
similarity index 100%
rename from Documentation/x86/sgx.rst
rename to Documentation/arch/x86/sgx.rst
diff --git a/Documentation/x86/sva.rst b/Documentation/arch/x86/sva.rst
similarity index 100%
rename from Documentation/x86/sva.rst
rename to Documentation/arch/x86/sva.rst
diff --git a/Documentation/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
similarity index 100%
rename from Documentation/x86/tdx.rst
rename to Documentation/arch/x86/tdx.rst
diff --git a/Documentation/x86/tlb.rst b/Documentation/arch/x86/tlb.rst
similarity index 100%
rename from Documentation/x86/tlb.rst
rename to Documentation/arch/x86/tlb.rst
diff --git a/Documentation/x86/topology.rst b/Documentation/arch/x86/topology.rst
similarity index 100%
rename from Documentation/x86/topology.rst
rename to Documentation/arch/x86/topology.rst
diff --git a/Documentation/x86/tsx_async_abort.rst b/Documentation/arch/x86/tsx_async_abort.rst
similarity index 100%
rename from Documentation/x86/tsx_async_abort.rst
rename to Documentation/arch/x86/tsx_async_abort.rst
diff --git a/Documentation/x86/usb-legacy-support.rst b/Documentation/arch/x86/usb-legacy-support.rst
similarity index 100%
rename from Documentation/x86/usb-legacy-support.rst
rename to Documentation/arch/x86/usb-legacy-support.rst
diff --git a/Documentation/x86/x86_64/5level-paging.rst b/Documentation/arch/x86/x86_64/5level-paging.rst
similarity index 98%
rename from Documentation/x86/x86_64/5level-paging.rst
rename to Documentation/arch/x86/x86_64/5level-paging.rst
index b792bbdc0b01..71f882f4a173 100644
--- a/Documentation/x86/x86_64/5level-paging.rst
+++ b/Documentation/arch/x86/x86_64/5level-paging.rst
@@ -20,7 +20,7 @@ physical address space. This "ought to be enough for anybody" ©.
 QEMU 2.9 and later support 5-level paging.
 
 Virtual memory layout for 5-level paging is described in
-Documentation/x86/x86_64/mm.rst
+Documentation/arch/x86/x86_64/mm.rst
 
 
 Enabling 5-level paging
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
similarity index 98%
rename from Documentation/x86/x86_64/boot-options.rst
rename to Documentation/arch/x86/x86_64/boot-options.rst
index cbd14124a667..137432d34109 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -9,7 +9,7 @@ only the AMD64 specific ones are listed here.
 
 Machine check
 =============
-Please see Documentation/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
+Please see Documentation/arch/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
 
    mce=off
 		Disable machine check
@@ -82,7 +82,7 @@ APICs
      Don't use the local APIC (alias for i386 compatibility)
 
    pirq=...
-	See Documentation/x86/i386/IO-APIC.rst
+	See Documentation/arch/x86/i386/IO-APIC.rst
 
    noapictimer
 	Don't set up the APIC timer
diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec.rst b/Documentation/arch/x86/x86_64/cpu-hotplug-spec.rst
similarity index 100%
rename from Documentation/x86/x86_64/cpu-hotplug-spec.rst
rename to Documentation/arch/x86/x86_64/cpu-hotplug-spec.rst
diff --git a/Documentation/x86/x86_64/fake-numa-for-cpusets.rst b/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
similarity index 97%
rename from Documentation/x86/x86_64/fake-numa-for-cpusets.rst
rename to Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
index ff9bcfd2cc14..ba74617d4999 100644
--- a/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
+++ b/Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst
@@ -18,7 +18,7 @@ For more information on the features of cpusets, see
 Documentation/admin-guide/cgroup-v1/cpusets.rst.
 There are a number of different configurations you can use for your needs.  For
 more information on the numa=fake command line option and its various ways of
-configuring fake nodes, see Documentation/x86/x86_64/boot-options.rst.
+configuring fake nodes, see Documentation/arch/x86/x86_64/boot-options.rst.
 
 For the purposes of this introduction, we'll assume a very primitive NUMA
 emulation setup of "numa=fake=4*512,".  This will split our system memory into
diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/arch/x86/x86_64/fsgs.rst
similarity index 100%
rename from Documentation/x86/x86_64/fsgs.rst
rename to Documentation/arch/x86/x86_64/fsgs.rst
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/arch/x86/x86_64/index.rst
similarity index 100%
rename from Documentation/x86/x86_64/index.rst
rename to Documentation/arch/x86/x86_64/index.rst
diff --git a/Documentation/x86/x86_64/machinecheck.rst b/Documentation/arch/x86/x86_64/machinecheck.rst
similarity index 100%
rename from Documentation/x86/x86_64/machinecheck.rst
rename to Documentation/arch/x86/x86_64/machinecheck.rst
diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
similarity index 100%
rename from Documentation/x86/x86_64/mm.rst
rename to Documentation/arch/x86/x86_64/mm.rst
diff --git a/Documentation/x86/x86_64/uefi.rst b/Documentation/arch/x86/x86_64/uefi.rst
similarity index 100%
rename from Documentation/x86/x86_64/uefi.rst
rename to Documentation/arch/x86/x86_64/uefi.rst
diff --git a/Documentation/x86/xstate.rst b/Documentation/arch/x86/xstate.rst
similarity index 100%
rename from Documentation/x86/xstate.rst
rename to Documentation/arch/x86/xstate.rst
diff --git a/Documentation/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
similarity index 100%
rename from Documentation/x86/zero-page.rst
rename to Documentation/arch/x86/zero-page.rst
diff --git a/Documentation/core-api/asm-annotations.rst b/Documentation/core-api/asm-annotations.rst
index bc514ed59887..11c96d3f9ad6 100644
--- a/Documentation/core-api/asm-annotations.rst
+++ b/Documentation/core-api/asm-annotations.rst
@@ -44,7 +44,7 @@ information. In particular, on properly annotated objects, ``objtool`` can be
 run to check and fix the object if needed. Currently, ``objtool`` can report
 missing frame pointer setup/destruction in functions. It can also
 automatically generate annotations for the ORC unwinder
-(Documentation/x86/orc-unwinder.rst)
+(Documentation/arch/x86/orc-unwinder.rst)
 for most code. Both of these are especially important to support reliable
 stack traces which are in turn necessary for kernel live patching
 (Documentation/livepatch/livepatch.rst).
diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 4d2baac0311c..2c7abd234f4e 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -410,7 +410,7 @@ ioremap_uc()
 
 ioremap_uc() behaves like ioremap() except that on the x86 architecture without
 'PAT' mode, it marks memory as uncached even when the MTRR has designated
-it as cacheable, see Documentation/x86/pat.rst.
+it as cacheable, see Documentation/arch/x86/pat.rst.
 
 Portable drivers should avoid the use of ioremap_uc().
 
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 62de0768d6aa..53623e84c20e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7456,7 +7456,7 @@ system fingerprint.  To prevent userspace from circumventing such restrictions
 by running an enclave in a VM, KVM prevents access to privileged attributes by
 default.
 
-See Documentation/x86/sgx.rst for more details.
+See Documentation/arch/x86/sgx.rst for more details.
 
 7.26 KVM_CAP_PPC_RPT_INVALIDATE
 -------------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..ada3e9e4284b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1071,7 +1071,7 @@ M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
 R:	Carlos Bilbao <carlos.bilbao@amd.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	Documentation/x86/amd_hsmp.rst
+F:	Documentation/arch/x86/amd_hsmp.rst
 F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp.c
@@ -10647,7 +10647,7 @@ L:	tboot-devel@lists.sourceforge.net
 S:	Supported
 W:	http://tboot.sourceforge.net
 T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
-F:	Documentation/x86/intel_txt.rst
+F:	Documentation/arch/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h
 
@@ -10658,7 +10658,7 @@ L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
-F:	Documentation/x86/sgx.rst
+F:	Documentation/arch/x86/sgx.rst
 F:	arch/x86/entry/vdso/vsgx.S
 F:	arch/x86/include/asm/sgx.h
 F:	arch/x86/include/uapi/asm/sgx.h
@@ -17629,7 +17629,7 @@ M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/x86/resctrl*
+F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
 F:	tools/testing/selftests/resctrl/
@@ -22644,7 +22644,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/devicetree/bindings/x86/
-F:	Documentation/x86/
+F:	Documentation/arch/x86/
 F:	arch/x86/
 
 X86 ENTRY CODE
@@ -22660,7 +22660,7 @@ M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-mce
-F:	Documentation/x86/x86_64/machinecheck.rst
+F:	Documentation/arch/x86/x86_64/machinecheck.rst
 F:	arch/x86/kernel/cpu/mce/*
 
 X86 MICROCODE UPDATE SUPPORT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..d64ad0fe6c0c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -986,7 +986,7 @@ config SMP
 	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  See also <file:Documentation/x86/i386/IO-APIC.rst>,
+	  See also <file:Documentation/arch/x86/i386/IO-APIC.rst>,
 	  <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO available at
 	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..1720eabc31ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -434,7 +434,7 @@ config SMP
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
-	  See also <file:Documentation/x86/i386/IO-APIC.rst>,
+	  See also <file:Documentation/arch/x86/i386/IO-APIC.rst>,
 	  <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO available at
 	  <http://www.tldp.org/docs.html#howto>.
 
@@ -1324,7 +1324,7 @@ config MICROCODE
 	  the Linux kernel.
 
 	  The preferred method to load microcode from a detached initrd is described
-	  in Documentation/x86/microcode.rst. For that you need to enable
+	  in Documentation/arch/x86/microcode.rst. For that you need to enable
 	  CONFIG_BLK_DEV_INITRD in order for the loader to be able to scan the
 	  initrd for microcode blobs.
 
@@ -1510,7 +1510,7 @@ config X86_5LEVEL
 	  A kernel with the option enabled can be booted on machines that
 	  support 4- or 5-level paging.
 
-	  See Documentation/x86/x86_64/5level-paging.rst for more
+	  See Documentation/arch/x86/x86_64/5level-paging.rst for more
 	  information.
 
 	  Say N if unsure.
@@ -1774,7 +1774,7 @@ config MTRR
 	  You can safely say Y even if your machine doesn't have MTRRs, you'll
 	  just add about 9 KB to your kernel.
 
-	  See <file:Documentation/x86/mtrr.rst> for more information.
+	  See <file:Documentation/arch/x86/mtrr.rst> for more information.
 
 config MTRR_SANITIZER
 	def_bool y
@@ -2551,7 +2551,7 @@ config PAGE_TABLE_ISOLATION
 	  ensuring that the majority of kernel addresses are not mapped
 	  into userspace.
 
-	  See Documentation/x86/pti.rst for more details.
+	  See Documentation/arch/x86/pti.rst for more details.
 
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bdfe08f1a930..c5d614d28a75 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -97,7 +97,7 @@ config IOMMU_DEBUG
 	  code. When you use it make sure you have a big enough
 	  IOMMU/AGP aperture.  Most of the options enabled by this can
 	  be set more finegrained using the iommu= command line
-	  options. See Documentation/x86/x86_64/boot-options.rst for more
+	  options. See Documentation/arch/x86/x86_64/boot-options.rst for more
 	  details.
 
 config IOMMU_LEAK
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9338c68e7413..b04ca8e2b213 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -321,7 +321,7 @@ start_sys_seg:	.word	SYSSEG		# obsolete and meaningless, but just
 
 type_of_loader:	.byte	0		# 0 means ancient bootloader, newer
 					# bootloaders know to change this.
-					# See Documentation/x86/boot.rst for
+					# See Documentation/arch/x86/boot.rst for
 					# assigned ids
 
 # flags, unused bits must be zero (RFU) bit within loadflags
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index eccc3431e515..d94d361f506f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -8,7 +8,7 @@
  *
  * entry.S contains the system-call and fault low-level handling routines.
  *
- * Some of this is documented in Documentation/x86/entry_64.rst
+ * Some of this is documented in Documentation/arch/x86/entry_64.rst
  *
  * A note on terminology:
  * - iret frame:	Architecture defined interrupt frame from SS to RIP
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 53e9b0620d96..d90ae472fb76 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -38,7 +38,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 * IMPORTANT NOTE TO BOOTLOADER AUTHORS: do not simply clear
 	 * this field.  The purpose of this field is to guarantee
 	 * compliance with the x86 boot spec located in
-	 * Documentation/x86/boot.rst .  That spec says that the
+	 * Documentation/arch/x86/boot.rst .  That spec says that the
 	 * *whole* structure should be cleared, after which only the
 	 * portion defined by struct setup_header (boot_params->hdr)
 	 * should be copied in.
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e9e2c3ba5923..06ef25411d62 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -49,7 +49,7 @@
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
-/* See Documentation/x86/x86_64/mm.rst for a description of the memory map. */
+/* See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map. */
 
 #define __PHYSICAL_MASK_SHIFT	52
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38bf837e3554..38b54b992f32 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -104,7 +104,7 @@ extern unsigned int ptrs_per_p4d;
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
 
 /*
- * See Documentation/x86/x86_64/mm.rst for a description of the memory map.
+ * See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map.
  *
  * Be very careful vs. KASLR when changing anything here. The KASLR address
  * range must not overlap with anything except the KASAN shadow area, which
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9eb457b10341..f5fdeb1e3606 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -61,7 +61,7 @@ static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];
 
 /*
  * Microcode patch container file is prepended to the initrd in cpio
- * format. See Documentation/x86/microcode.rst
+ * format. See Documentation/arch/x86/microcode.rst
  */
 static const char
 ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7fe51488e136..0e7b6afe2fa6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -76,7 +76,7 @@ unsigned int resctrl_rmid_realloc_limit;
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 /*
- * The correction factor table is documented in Documentation/x86/resctrl.rst.
+ * The correction factor table is documented in Documentation/arch/x86/resctrl.rst.
  * If rmid > rmid threshold, MBM total and local values should be multiplied
  * by the correction factor.
  *
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f2020653fba..d2dad21259a8 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -15,7 +15,7 @@
 
 #define EREMOVE_ERROR_MESSAGE \
 	"EREMOVE returned %d (0x%x) and an EPC page was leaked. SGX may become unusable. " \
-	"Refer to Documentation/x86/sgx.rst for more information."
+	"Refer to Documentation/arch/x86/sgx.rst for more information."
 
 #define SGX_MAX_EPC_SECTIONS		8
 #define SGX_EEXTEND_BLOCK_SIZE		256
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 6b58610a1552..a61c12c01270 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -476,7 +476,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	efi_map_offset = params_cmdline_sz;
 	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
 
-	/* Copy setup header onto bootparams. Documentation/x86/boot.rst */
+	/* Copy setup header onto bootparams. Documentation/arch/x86/boot.rst */
 	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
 
 	/* Is there a limit on setup header size? */
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 30bbe4abb5d6..de6be0a3965e 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -124,7 +124,7 @@ void __init pci_iommu_alloc(void)
 }
 
 /*
- * See <Documentation/x86/x86_64/boot-options.rst> for the iommu kernel
+ * See <Documentation/arch/x86/x86_64/boot-options.rst> for the iommu kernel
  * parameter documentation.
  */
 static __init int iommu_setup(char *p)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 356758b7d4b4..f0099ee70e02 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -234,7 +234,7 @@ within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
  * take full advantage of the the limited (s32) immediate addressing range (2G)
  * of x86_64.
  *
- * See Documentation/x86/x86_64/mm.rst for more detail.
+ * See Documentation/arch/x86/x86_64/mm.rst for more detail.
  */
 
 static inline unsigned long highmap_start_pfn(void)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 92d73ccede70..16c5292d227d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -925,7 +925,7 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 }
 
 /*
- * See Documentation/x86/tlb.rst for details.  We choose 33
+ * See Documentation/arch/x86/tlb.rst for details.  We choose 33
  * because it is large enough to cover the vast majority (at
  * least 95%) of allocations, and is small enough that we are
  * confident it will not cause too much overhead.  Each single
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index ed0442e35434..00a92cb2c814 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -86,7 +86,7 @@ static void __init init_pvh_bootparams(bool xen_guest)
 	}
 
 	/*
-	 * See Documentation/x86/boot.rst.
+	 * See Documentation/arch/x86/boot.rst.
 	 *
 	 * Version 2.12 supports Xen entry point but we will use default x86/PC
 	 * environment (i.e. hardware_subarch 0).
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f11bdbe4c2c5..b0dcf1f39050 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1831,7 +1831,7 @@ EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
 /* TODO: This is really inefficient.  We need something like get_user()
  * (instruction directly accesses the data, with an exception table entry
- * returning -EFAULT). See Documentation/x86/exception-tables.rst.
+ * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
  */
 static int set_bit_to_user(int nr, void __user *addr)
 {
diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..b288d9d105d4 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -110,7 +110,7 @@ config INTEL_TXT
 	  See <https://www.intel.com/technology/security/> for more information
 	  about Intel(R) TXT.
 	  See <http://tboot.sourceforge.net> for more information about tboot.
-	  See Documentation/x86/intel_txt.rst for a description of how to enable
+	  See Documentation/arch/x86/intel_txt.rst for a description of how to enable
 	  Intel TXT support in a kernel boot.
 
 	  If you are unsure as to whether this is required, answer N.
diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 25f2bb3a991d..332b983ead1e 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -20,7 +20,7 @@
  * Userspace note:
  * The same principle works for userspace, because 'error' pointers
  * fall down to the unused hole far from user space, as described
- * in Documentation/x86/x86_64/mm.rst for x86_64 arch:
+ * in Documentation/arch/x86/x86_64/mm.rst for x86_64 arch:
  *
  * 0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm hole caused by [48:63] sign extension
  * ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8e53fc6735ef..744db4218e7a 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -181,7 +181,7 @@ b) ORC (Oops Rewind Capability) unwind table generation
    band.  So it doesn't affect runtime performance and it can be
    reliable even when interrupts or exceptions are involved.
 
-   For more details, see Documentation/x86/orc-unwinder.rst.
+   For more details, see Documentation/arch/x86/orc-unwinder.rst.
 
 c) Higher live patching compatibility rate
 
-- 
2.39.2

