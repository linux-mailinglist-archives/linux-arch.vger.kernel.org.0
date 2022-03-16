Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB54DAB54
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 08:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354191AbiCPHGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354106AbiCPHFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 03:05:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD5240BB;
        Wed, 16 Mar 2022 00:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BAEBB81A1F;
        Wed, 16 Mar 2022 07:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C38C340F2;
        Wed, 16 Mar 2022 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414263;
        bh=MNkJYdoYJVD0cgTwHsZRdZ7qoGS1rN9vx70tcmJUxuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAZ3pnOThrFa3hQvCQWdaOz/7WE6UX4MsBJu9sjSqOyEX2tozq2Do+boe1VhyqY8F
         kZGg8OJEPQc01rpt2KQJTa5+NNvL+MJXJrSUvacpLxaOpvhYvI1BRiug6MC7Ej9Z4q
         Fkouo+XuTqpuVvfn+yPZf70nYeXq9YeyZ31uXKL3gN5HxMq+NQTgy5feeTL0CvsmxU
         EbZcCDS2hN5CfdrkErGuPtybEhkbQEkjm3FvveleD1VPDga9r8alEsKB2/MrY+sVAo
         Y06IzfYrqnD4KXYnvT2G/vv8cPSU3fZpAouavxoVNzH1WHAZmrA1zvq747KKYKTQtn
         x9WQ2LRazbiyg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V8 08/20] riscv: Fixup difference with defconfig
Date:   Wed, 16 Mar 2022 15:03:05 +0800
Message-Id: <20220316070317.1864279-9-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316070317.1864279-1-guoren@kernel.org>
References: <20220316070317.1864279-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Let's follow the origin patch's spirit:

The only difference between rv32_defconfig and defconfig is that
rv32_defconfig has  CONFIG_ARCH_RV32I=y.

This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.

Fixes: 1b937e8faa87ccfb ("RISC-V: Add separate defconfig for 32bit systems")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/Makefile               |   4 +
 arch/riscv/configs/rv32_defconfig | 135 ------------------------------
 2 files changed, 4 insertions(+), 135 deletions(-)
 delete mode 100644 arch/riscv/configs/rv32_defconfig

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..c6ca1b9cbf71 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -154,3 +154,7 @@ PHONY += rv64_randconfig
 rv64_randconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
 		-f $(srctree)/Makefile randconfig
+
+PHONY += rv32_defconfig
+rv32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
deleted file mode 100644
index 8b56a7f1eb06..000000000000
--- a/arch/riscv/configs/rv32_defconfig
+++ /dev/null
@@ -1,135 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BPF_SYSCALL=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_CGROUPS=y
-CONFIG_CGROUP_SCHED=y
-CONFIG_CFS_BANDWIDTH=y
-CONFIG_CGROUP_BPF=y
-CONFIG_NAMESPACES=y
-CONFIG_USER_NS=y
-CONFIG_CHECKPOINT_RESTORE=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-# CONFIG_SYSFS_SYSCALL is not set
-CONFIG_SOC_SIFIVE=y
-CONFIG_SOC_VIRT=y
-CONFIG_ARCH_RV32I=y
-CONFIG_SMP=y
-CONFIG_HOTPLUG_CPU=y
-CONFIG_VIRTUALIZATION=y
-CONFIG_KVM=m
-CONFIG_JUMP_LABEL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NETLINK_DIAG=y
-CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
-CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-CONFIG_PCI_HOST_GENERIC=y
-CONFIG_PCIE_XILINX=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_BLK_DEV_SR=y
-CONFIG_SCSI_VIRTIO=y
-CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
-CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_NETDEVICES=y
-CONFIG_VIRTIO_NET=y
-CONFIG_MACB=y
-CONFIG_E1000E=y
-CONFIG_R8169=y
-CONFIG_MICROSEMI_PHY=y
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
-CONFIG_HVC_RISCV_SBI=y
-CONFIG_VIRTIO_CONSOLE=y
-CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_VIRTIO=y
-CONFIG_SPI=y
-CONFIG_SPI_SIFIVE=y
-# CONFIG_PTP_1588_CLOCK is not set
-CONFIG_DRM=y
-CONFIG_DRM_RADEON=y
-CONFIG_DRM_VIRTIO_GPU=y
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_PLATFORM=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_HCD_PLATFORM=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_HCD_PLATFORM=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_UAS=y
-CONFIG_MMC=y
-CONFIG_MMC_SPI=y
-CONFIG_RTC_CLASS=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_INPUT=y
-CONFIG_VIRTIO_MMIO=y
-CONFIG_RPMSG_CHAR=y
-CONFIG_RPMSG_VIRTIO=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_NFS_V4_1=y
-CONFIG_NFS_V4_2=y
-CONFIG_ROOT_NFS=y
-CONFIG_9P_FS=y
-CONFIG_CRYPTO_USER_API_HASH=y
-CONFIG_CRYPTO_DEV_VIRTIO=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_PAGEALLOC=y
-CONFIG_SCHED_STACK_END_CHECK=y
-CONFIG_DEBUG_VM=y
-CONFIG_DEBUG_VM_PGFLAGS=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_DEBUG_PER_CPU_MAPS=y
-CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_WQ_WATCHDOG=y
-CONFIG_DEBUG_TIMEKEEPING=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_RWSEMS=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_STACKTRACE=y
-CONFIG_DEBUG_LIST=y
-CONFIG_DEBUG_PLIST=y
-CONFIG_DEBUG_SG=y
-# CONFIG_RCU_TRACE is not set
-CONFIG_RCU_EQS_DEBUG=y
-# CONFIG_FTRACE is not set
-# CONFIG_RUNTIME_TESTING_MENU is not set
-CONFIG_MEMTEST=y
-- 
2.25.1

