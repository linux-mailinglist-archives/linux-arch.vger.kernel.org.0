Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0F650B1F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLSMHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 07:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSMGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 07:06:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC32A187;
        Mon, 19 Dec 2022 04:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6912560F38;
        Mon, 19 Dec 2022 12:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA71C433D2;
        Mon, 19 Dec 2022 12:06:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.2
Date:   Mon, 19 Dec 2022 20:06:12 +0800
Message-Id: <20221219120612.1637267-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.2

for you to fetch changes up to 5535f4f70cfc15ef55b6ea7c7e17337b17337cb6:

  LoongArch: Update Loongson-3 default config file (2022-12-14 08:41:54 +0800)

----------------------------------------------------------------
LoongArch changes for v6.2

1, Switch to relative exception tables;
2, Add unaligned access support;
3, Add alternative runtime patching mechanism;
4, Add FDT booting support from efi system table;
5, Add suspend/hibernation (ACPI S3/S4) support;
6, Add basic STACKPROTECTOR support;
7, Add ftrace (function tracer) support;
8, Update the default config file.

----------------------------------------------------------------
Binbin Zhou (2):
      LoongArch: Add FDT booting support from efi system table
      LoongArch: Add processing ISA Node in DeviceTree

Huacai Chen (9):
      Merge tags 'acpi-6.2-rc1' and 'irq-core-2022-12-10' into loongarch-next
      LoongArch: Add unaligned access support
      LoongArch: Add alternative runtime patching mechanism
      LoongArch: Use alternative to optimize libraries
      LoongArch: Add suspend (ACPI S3) support
      LoongArch: Add hibernation (ACPI S4) support
      LoongArch: Add basic STACKPROTECTOR support
      LoongArch: module: Use got/plt section indices for relocations
      LoongArch: Update Loongson-3 default config file

Qing Zhang (8):
      LoongArch/ftrace: Add basic support
      LoongArch/ftrace: Add recordmcount support
      LoongArch/ftrace: Add dynamic function tracer support
      LoongArch/ftrace: Add dynamic function graph tracer support
      LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_REGS support
      LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
      LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
      LoongArch: modules/ftrace: Initialize PLT at load time

Youling Tang (6):
      LoongArch: Consolidate __ex_table construction
      LoongArch: Switch to relative exception tables
      LoongArch: extable: Add `type` and `data` fields
      LoongArch: extable: Add a dedicated uaccess handler
      LoongArch: Remove the .fixup section usage
      LoongArch: BPF: Add BPF exception tables

 Documentation/PCI/msi-howto.rst                    |   10 +
 Documentation/admin-guide/sysctl/kernel.rst        |    8 +-
 .../loongarch,cpu-interrupt-controller.yaml        |   34 +
 .../interrupt-controller/mediatek,cirq.txt         |   33 -
 .../interrupt-controller/mediatek,mtk-cirq.yaml    |   68 ++
 arch/arm64/kernel/acpi.c                           |  106 ++
 arch/ia64/hp/common/aml_nfw.c                      |    4 +-
 arch/loongarch/Kconfig                             |   20 +
 arch/loongarch/Makefile                            |    8 +
 arch/loongarch/configs/loongson3_defconfig         |   56 +-
 arch/loongarch/include/asm/acpi.h                  |  152 +--
 arch/loongarch/include/asm/alternative-asm.h       |   82 ++
 arch/loongarch/include/asm/alternative.h           |  111 ++
 arch/loongarch/include/asm/asm-extable.h           |   65 ++
 arch/loongarch/include/asm/bootinfo.h              |    1 +
 arch/loongarch/include/asm/bugs.h                  |   15 +
 arch/loongarch/include/asm/efi.h                   |    1 +
 arch/loongarch/include/asm/extable.h               |   47 +
 arch/loongarch/include/asm/ftrace.h                |   68 ++
 arch/loongarch/include/asm/futex.h                 |   27 +-
 arch/loongarch/include/asm/gpr-num.h               |   22 +
 arch/loongarch/include/asm/inst.h                  |   46 +
 arch/loongarch/include/asm/irq.h                   |    2 +-
 arch/loongarch/include/asm/loongson.h              |    3 +
 arch/loongarch/include/asm/module.h                |   27 +-
 arch/loongarch/include/asm/module.lds.h            |    1 +
 arch/loongarch/include/asm/setup.h                 |    1 +
 arch/loongarch/include/asm/stackprotector.h        |   38 +
 arch/loongarch/include/asm/string.h                |    5 +
 arch/loongarch/include/asm/thread_info.h           |    2 +-
 arch/loongarch/include/asm/time.h                  |    1 +
 arch/loongarch/include/asm/uaccess.h               |   24 +-
 arch/loongarch/include/asm/unwind.h                |    3 +-
 arch/loongarch/kernel/Makefile                     |   16 +-
 arch/loongarch/kernel/acpi.c                       |   17 +-
 arch/loongarch/kernel/alternative.c                |  246 +++++
 arch/loongarch/kernel/asm-offsets.c                |   15 +
 arch/loongarch/kernel/efi.c                        |   15 +-
 arch/loongarch/kernel/env.c                        |    2 +
 arch/loongarch/kernel/fpu.S                        |    5 +-
 arch/loongarch/kernel/ftrace.c                     |   73 ++
 arch/loongarch/kernel/ftrace_dyn.c                 |  273 +++++
 arch/loongarch/kernel/inst.c                       |  127 +++
 arch/loongarch/kernel/mcount.S                     |   96 ++
 arch/loongarch/kernel/mcount_dyn.S                 |  149 +++
 arch/loongarch/kernel/module-sections.c            |   64 +-
 arch/loongarch/kernel/module.c                     |   75 +-
 arch/loongarch/kernel/numa.c                       |   17 +-
 arch/loongarch/kernel/process.c                    |    6 +
 arch/loongarch/kernel/reset.c                      |    5 +
 arch/loongarch/kernel/setup.c                      |  149 ++-
 arch/loongarch/kernel/smp.c                        |   35 +
 arch/loongarch/kernel/switch.S                     |    5 +
 arch/loongarch/kernel/time.c                       |   11 +-
 arch/loongarch/kernel/traps.c                      |   27 +
 arch/loongarch/kernel/unaligned.c                  |  499 +++++++++
 arch/loongarch/kernel/unwind_guess.c               |    4 +-
 arch/loongarch/kernel/unwind_prologue.c            |   50 +-
 arch/loongarch/kernel/vmlinux.lds.S                |   13 +-
 arch/loongarch/lib/Makefile                        |    3 +-
 arch/loongarch/lib/clear_user.S                    |   85 +-
 arch/loongarch/lib/copy_user.S                     |  108 +-
 arch/loongarch/lib/memcpy.S                        |   95 ++
 arch/loongarch/lib/memmove.S                       |  121 +++
 arch/loongarch/lib/memset.S                        |   91 ++
 arch/loongarch/lib/unaligned.S                     |   84 ++
 arch/loongarch/mm/extable.c                        |   59 +-
 arch/loongarch/net/bpf_jit.c                       |   86 +-
 arch/loongarch/net/bpf_jit.h                       |    2 +
 arch/loongarch/pci/acpi.c                          |    7 +-
 arch/loongarch/power/Makefile                      |    4 +
 arch/loongarch/power/hibernate.c                   |   62 ++
 arch/loongarch/power/hibernate_asm.S               |   66 ++
 arch/loongarch/power/platform.c                    |   57 +
 arch/loongarch/power/suspend.c                     |   73 ++
 arch/loongarch/power/suspend_asm.S                 |   89 ++
 arch/powerpc/platforms/pseries/msi.c               |    7 +-
 arch/um/drivers/Kconfig                            |    1 -
 arch/um/include/asm/pci.h                          |    2 +-
 arch/x86/Kconfig                                   |    1 -
 arch/x86/include/asm/hyperv_timer.h                |    9 +
 arch/x86/include/asm/irq_remapping.h               |    4 -
 arch/x86/include/asm/irqdomain.h                   |    4 +-
 arch/x86/include/asm/mshyperv.h                    |    2 -
 arch/x86/include/asm/msi.h                         |    6 +
 arch/x86/include/asm/pci.h                         |    5 +-
 arch/x86/kernel/apic/msi.c                         |  211 ++--
 arch/x86/kernel/apic/vector.c                      |    4 -
 arch/x86/platform/olpc/olpc-xo15-sci.c             |    3 +-
 drivers/acpi/Kconfig                               |   10 +
 drivers/acpi/Makefile                              |    1 +
 drivers/acpi/ac.c                                  |    8 +-
 drivers/acpi/acpi_ffh.c                            |   55 +
 drivers/acpi/acpi_pad.c                            |    7 +-
 drivers/acpi/acpi_pcc.c                            |   47 +-
 drivers/acpi/acpi_video.c                          |    8 +-
 drivers/acpi/acpica/Makefile                       |    1 +
 drivers/acpi/acpica/acglobal.h                     |    1 +
 drivers/acpi/acpica/actables.h                     |    5 -
 drivers/acpi/acpica/acutils.h                      |   13 +
 drivers/acpi/acpica/dsmethod.c                     |   10 +-
 drivers/acpi/acpica/evevent.c                      |   11 +
 drivers/acpi/acpica/evregion.c                     |    9 +
 drivers/acpi/acpica/exconfig.c                     |    4 +-
 drivers/acpi/acpica/exfield.c                      |    8 +-
 drivers/acpi/acpica/exserial.c                     |    6 +
 drivers/acpi/acpica/hwsleep.c                      |   14 +
 drivers/acpi/acpica/tbdata.c                       |    2 +-
 drivers/acpi/acpica/tbfadt.c                       |    2 +-
 drivers/acpi/acpica/tbprint.c                      |   77 +-
 drivers/acpi/acpica/tbutils.c                      |    2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   32 +-
 drivers/acpi/acpica/utcksum.c                      |  170 +++
 drivers/acpi/acpica/utcopy.c                       |    7 -
 drivers/acpi/acpica/utglobal.c                     |    4 +
 drivers/acpi/acpica/utstring.c                     |   10 +-
 drivers/acpi/apei/apei-base.c                      |    2 +-
 drivers/acpi/apei/einj.c                           |   56 +-
 drivers/acpi/apei/ghes.c                           |   62 +-
 drivers/acpi/battery.c                             |   10 +-
 drivers/acpi/bus.c                                 |    3 +
 drivers/acpi/button.c                              |    5 +-
 drivers/acpi/cppc_acpi.c                           |    4 +-
 drivers/acpi/ec.c                                  |   15 +-
 drivers/acpi/fan_attr.c                            |   16 +-
 drivers/acpi/fan_core.c                            |    1 +
 drivers/acpi/hed.c                                 |    3 +-
 drivers/acpi/irq.c                                 |    5 +-
 drivers/acpi/nfit/core.c                           |    3 +-
 drivers/acpi/pci_irq.c                             |    6 +-
 drivers/acpi/pfr_telemetry.c                       |    6 +-
 drivers/acpi/pfr_update.c                          |    6 +-
 drivers/acpi/power.c                               |    2 +-
 drivers/acpi/processor_idle.c                      |    9 +-
 drivers/acpi/processor_perflib.c                   |  100 +-
 drivers/acpi/processor_throttling.c                |    4 +-
 drivers/acpi/sbs.c                                 |    9 +-
 drivers/acpi/sbshc.c                               |    7 +-
 drivers/acpi/scan.c                                |    2 +-
 drivers/acpi/sysfs.c                               |    5 +-
 drivers/acpi/tables.c                              |   17 +-
 drivers/acpi/thermal.c                             |    9 +-
 drivers/acpi/tiny-power-button.c                   |   10 +-
 drivers/acpi/video_detect.c                        |  110 +-
 drivers/acpi/x86/utils.c                           |   24 +-
 drivers/base/Makefile                              |    2 +-
 drivers/base/platform-msi.c                        |    6 +-
 drivers/bus/fsl-mc/Kconfig                         |    2 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |    1 -
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |    1 -
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |   25 +-
 drivers/char/sonypi.c                              |    3 +-
 drivers/char/tpm/tpm_crb.c                         |    4 +-
 drivers/dma/Kconfig                                |    2 +-
 drivers/dma/qcom/hidma.c                           |    8 +-
 drivers/hv/vmbus_drv.c                             |    5 +-
 drivers/hwmon/acpi_power_meter.c                   |    5 +-
 drivers/hwmon/asus_atk0110.c                       |    6 +-
 drivers/input/misc/atlas_btns.c                    |    4 +-
 drivers/iommu/Kconfig                              |    2 +-
 drivers/iommu/amd/amd_iommu_types.h                |    1 -
 drivers/iommu/amd/iommu.c                          |   44 +-
 drivers/iommu/intel/iommu.h                        |    1 -
 drivers/iommu/intel/irq_remapping.c                |   52 +-
 drivers/iommu/of_iommu.c                           |    1 -
 drivers/irqchip/Kconfig                            |    9 +-
 drivers/irqchip/irq-apple-aic.c                    |    6 +-
 drivers/irqchip/irq-gic-pm.c                       |    2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   11 +-
 drivers/irqchip/irq-gic-v3.c                       |    3 +-
 drivers/irqchip/irq-gic.c                          |    7 +-
 drivers/irqchip/irq-loongarch-cpu.c                |   48 +-
 drivers/irqchip/irq-loongson-eiointc.c             |   63 +-
 drivers/irqchip/irq-loongson-htvec.c               |  176 +++-
 drivers/irqchip/irq-loongson-liointc.c             |   37 +-
 drivers/irqchip/irq-loongson-pch-lpc.c             |   25 +
 drivers/irqchip/irq-loongson-pch-pic.c             |   76 +-
 drivers/irqchip/irq-ls-extirq.c                    |    2 +-
 drivers/irqchip/irq-mips-gic.c                     |    2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   95 +-
 drivers/irqchip/irq-mvebu-icu.c                    |    4 +-
 drivers/irqchip/irq-sifive-plic.c                  |    6 +-
 drivers/irqchip/irq-sl28cpld.c                     |    3 +-
 drivers/irqchip/irq-st.c                           |    7 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |    2 +-
 drivers/irqchip/irq-wpcm450-aic.c                  |    1 +
 drivers/mailbox/Kconfig                            |    2 +-
 drivers/mailbox/pcc.c                              |    1 +
 drivers/net/fjes/fjes_main.c                       |    4 +-
 drivers/pci/Kconfig                                |    7 +-
 drivers/pci/controller/Kconfig                     |   30 +-
 drivers/pci/controller/dwc/Kconfig                 |   48 +-
 drivers/pci/controller/mobiveil/Kconfig            |    6 +-
 drivers/pci/controller/pci-hyperv.c                |   15 +-
 drivers/pci/msi/Makefile                           |    3 +-
 drivers/pci/msi/api.c                              |  458 ++++++++
 drivers/pci/msi/irqdomain.c                        |  369 +++++--
 drivers/pci/msi/msi.c                              | 1100 ++++++++------------
 drivers/pci/msi/msi.h                              |  114 +-
 drivers/pci/probe.c                                |    2 -
 drivers/perf/Kconfig                               |    2 +-
 drivers/platform/chrome/chromeos_privacy_screen.c  |    3 +-
 drivers/platform/chrome/wilco_ec/event.c           |    4 +-
 drivers/platform/surface/surfacepro3_button.c      |    3 +-
 drivers/platform/x86/asus-laptop.c                 |    3 +-
 drivers/platform/x86/asus-wireless.c               |    3 +-
 drivers/platform/x86/classmate-laptop.c            |   20 +-
 drivers/platform/x86/dell/dell-rbtn.c              |    6 +-
 drivers/platform/x86/eeepc-laptop.c                |    3 +-
 drivers/platform/x86/fujitsu-laptop.c              |    4 +-
 drivers/platform/x86/fujitsu-tablet.c              |    3 +-
 drivers/platform/x86/intel/rst.c                   |    4 +-
 drivers/platform/x86/lg-laptop.c                   |    4 +-
 drivers/platform/x86/panasonic-laptop.c            |    8 +-
 drivers/platform/x86/sony-laptop.c                 |    9 +-
 drivers/platform/x86/system76_acpi.c               |    4 +-
 drivers/platform/x86/topstar-laptop.c              |    3 +-
 drivers/platform/x86/toshiba_acpi.c                |    4 +-
 drivers/platform/x86/toshiba_bluetooth.c           |    6 +-
 drivers/platform/x86/toshiba_haps.c                |    4 +-
 drivers/platform/x86/wireless-hotkey.c             |    3 +-
 drivers/platform/x86/xo15-ebook.c                  |    3 +-
 drivers/pnp/core.c                                 |    4 +-
 drivers/pnp/driver.c                               |    3 +-
 drivers/ptp/ptp_vmw.c                              |    3 +-
 drivers/soc/fsl/dpio/dpio-driver.c                 |    1 -
 drivers/soc/ti/Kconfig                             |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c                   |   12 +-
 drivers/thermal/intel/intel_menlow.c               |    8 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |    1 -
 drivers/video/backlight/apple_bl.c                 |    3 +-
 drivers/watchdog/ni903x_wdt.c                      |    4 +-
 drivers/xen/xen-acpi-pad.c                         |    3 +-
 include/acpi/acconfig.h                            |    2 +
 include/acpi/acpi_bus.h                            |    2 +-
 include/acpi/acpixf.h                              |    2 +-
 include/acpi/actbl1.h                              |  151 ++-
 include/acpi/actbl2.h                              |  162 ++-
 include/acpi/actypes.h                             |   10 +-
 include/acpi/acuuid.h                              |    3 +-
 include/acpi/processor.h                           |   10 +
 include/asm-generic/msi.h                          |    4 +-
 include/clocksource/hyperv_timer.h                 |    4 +-
 include/linux/acpi.h                               |   13 +
 include/linux/device.h                             |    8 +-
 include/linux/gpio/driver.h                        |    2 +-
 include/linux/irqdomain.h                          |  143 +--
 include/linux/irqdomain_defs.h                     |   31 +
 include/linux/irqreturn.h                          |    8 +-
 include/linux/msi.h                                |  357 +++++--
 include/linux/msi_api.h                            |   73 ++
 include/linux/pci.h                                |   29 +-
 kernel/irq/Kconfig                                 |    7 +-
 kernel/irq/chip.c                                  |    8 +-
 kernel/irq/internals.h                             |    2 +
 kernel/irq/irqdesc.c                               |   15 +-
 kernel/irq/manage.c                                |    4 +-
 kernel/irq/msi.c                                   |  914 +++++++++++++---
 scripts/mod/modpost.c                              |   13 +
 scripts/recordmcount.c                             |   39 +
 scripts/sorttable.c                                |    2 +-
 tools/power/acpi/tools/acpidump/Makefile           |    1 +
 tools/power/acpi/tools/acpidump/apdump.c           |    4 +-
 263 files changed, 8205 insertions(+), 2358 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
 create mode 100644 arch/loongarch/include/asm/alternative-asm.h
 create mode 100644 arch/loongarch/include/asm/alternative.h
 create mode 100644 arch/loongarch/include/asm/asm-extable.h
 create mode 100644 arch/loongarch/include/asm/bugs.h
 create mode 100644 arch/loongarch/include/asm/extable.h
 create mode 100644 arch/loongarch/include/asm/ftrace.h
 create mode 100644 arch/loongarch/include/asm/gpr-num.h
 create mode 100644 arch/loongarch/include/asm/stackprotector.h
 create mode 100644 arch/loongarch/kernel/alternative.c
 create mode 100644 arch/loongarch/kernel/ftrace.c
 create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
 create mode 100644 arch/loongarch/kernel/mcount.S
 create mode 100644 arch/loongarch/kernel/mcount_dyn.S
 create mode 100644 arch/loongarch/kernel/unaligned.c
 create mode 100644 arch/loongarch/lib/memcpy.S
 create mode 100644 arch/loongarch/lib/memmove.S
 create mode 100644 arch/loongarch/lib/memset.S
 create mode 100644 arch/loongarch/lib/unaligned.S
 create mode 100644 arch/loongarch/power/Makefile
 create mode 100644 arch/loongarch/power/hibernate.c
 create mode 100644 arch/loongarch/power/hibernate_asm.S
 create mode 100644 arch/loongarch/power/platform.c
 create mode 100644 arch/loongarch/power/suspend.c
 create mode 100644 arch/loongarch/power/suspend_asm.S
 create mode 100644 arch/x86/include/asm/hyperv_timer.h
 create mode 100644 drivers/acpi/acpi_ffh.c
 create mode 100644 drivers/acpi/acpica/utcksum.c
 create mode 100644 drivers/pci/msi/api.c
 create mode 100644 include/linux/irqdomain_defs.h
 create mode 100644 include/linux/msi_api.h
