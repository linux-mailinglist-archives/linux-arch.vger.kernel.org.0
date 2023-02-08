Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DCA68E559
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 02:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBHBUD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 20:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBHBUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 20:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49D410B8;
        Tue,  7 Feb 2023 17:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D643B81B3B;
        Wed,  8 Feb 2023 01:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276D7C4339B;
        Wed,  8 Feb 2023 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675819198;
        bh=vcKP/6lk+6iFKLyG7PnZ6fXJSZbcR/D8n5mY/cXC608=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l+iQ8MAVtZfeO9bs1fGqsqDE9EfxDekG7bdD4xyviLAmv7mwLLPKT4Vw184JBmEEJ
         GiuHUiFjl1eFCnUTZyQ5QGGvaCWkH33Czr9BVEhpBUFq1rhSShEDjfSW3fsJ/nmFKz
         p4YinUdXpC+HRrr01ouO0ce43PAFouPc9FZfzWcTKAoDy7mJCHZxK/oW2Ly1hYTBqL
         69Au5QaM4ltrfJUoTPiOGcf5fUtCom7LMZrK4P4rQSPOfdDcoSGUSotYfRY1GvnrR0
         ulvMxb/HXC1CZjFZSiG21Lar78zwfpuoyi0B+tJNQs+cjjm4wevu1WenroUj4u98Gc
         5iURkVKHzQfiw==
Received: by mail-ej1-f47.google.com with SMTP id ud5so47486012ejc.4;
        Tue, 07 Feb 2023 17:19:58 -0800 (PST)
X-Gm-Message-State: AO0yUKXLpMlHcCnessGBoqenxyj4AQ5DRnoqA6soKheLqCptGICtfG93
        XcGcRiTPjGzx/TpJgfe9oyavKZAgK7mgHJLDVQc=
X-Google-Smtp-Source: AK7set9Bzgs2jyIoicoZet6KPBjRaE+8c9h9LHTjOhwD7+nu/bmhPwKn4cdvsApKBqPsmQeNZlFML3aAEBq8p35eYrw=
X-Received: by 2002:a17:906:3e04:b0:884:c19c:7c6 with SMTP id
 k4-20020a1709063e0400b00884c19c07c6mr1216994eji.120.1675819196326; Tue, 07
 Feb 2023 17:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20230205133307.1058814-1-guoren@kernel.org> <Y+KcAiEV5iTG3SyX@spud>
In-Reply-To: <Y+KcAiEV5iTG3SyX@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 8 Feb 2023 09:19:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTThmVU+me_wdt4EesO13ioMM63VSwQV055mCsoqwFw3oQ@mail.gmail.com>
Message-ID: <CAJF2gTThmVU+me_wdt4EesO13ioMM63VSwQV055mCsoqwFw3oQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Cleanup rv32_defconfig
To:     Conor Dooley <conor@kernel.org>
Cc:     palmer@rivosinc.com, arnd@arndb.de, atishp@rivosinc.com,
        rdunlap@infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 8, 2023 at 2:44 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Feb 05, 2023 at 08:33:07AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > Subject: riscv: Cleanup rv32_defconfig
>
> s/cleanup/remove redundant/, cleanup implies that you're doing some
> rework of the file IMO.
Okay

>
> > Remove the unused rv32_defconfig file,
>
> What do you mean by "unused"? (don't answer now, read on)
>
> > which has been replaced by
> > 'commit 72f045d19f25 ("riscv: Fixup difference with defconfig")'.
>
> Replaced how? One shouldn't have to go look up that commit to see what
> "replaced" means. Certainly from the subject it is not immediately
> obvious what that commit actually does.
>
> How about:
> "Remove the rv32_defconfig file, which has been made redundant by commit
> 112233445566 ("blah") which introduced an rv32_defconfig .PHONY target,
> that is prioritised over the file itself."
Thx, that's better.

>
> I would argue that there is still value in having an off-the-shelf 32-bit
> config for people to base things on though, and being ignored by the
> make target does not make it "unused" IMO.
>
> I did check the before/after of running the make target, so:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
Thx

> Although, as you are probably aware, there are significant differences
> between the .config generated by the file and by the rv32_defconfig make
> target!
Two reasons:
 - Our Makefile has ignored the rv32_defconfig file.
 - We shouldn't keep the differences that violate the original design principle.
   See 'commit 1b937e8faa87 ("RISC-V: Add separate defconfig for 32bit
systems")'

commit 1b937e8faa87ccfb4b7d5b230796fa67bc8a183b
Author: Anup Patel <anup@brainfault.org>
Date:   Tue Mar 12 22:08:12 2019 +0000

    RISC-V: Add separate defconfig for 32bit systems

    This patch adds rv32_defconfig for 32bit systems. The only
    difference between rv32_defconfig and defconfig is that
    rv32_defconfig has  CONFIG_ARCH_RV32I=y.

    Signed-off-by: Anup Patel <anup.patel@wdc.com>
    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

>
> Cheers,
> Conor.
>
> > Also,
> > remove CONFIG_32BIT in 32-bit.config, which CONFIG_ARCH_RV32I has
> > selected.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/configs/32-bit.config  |   2 -
> >  arch/riscv/configs/rv32_defconfig | 139 ------------------------------
> >  2 files changed, 141 deletions(-)
> >  delete mode 100644 arch/riscv/configs/rv32_defconfig
> >
> > diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
> > index f6af0f708df4..eb87885c8640 100644
> > --- a/arch/riscv/configs/32-bit.config
> > +++ b/arch/riscv/configs/32-bit.config
> > @@ -1,4 +1,2 @@
> >  CONFIG_ARCH_RV32I=y
> > -CONFIG_32BIT=y
> > -# CONFIG_PORTABLE is not set
> >  CONFIG_NONPORTABLE=y
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > deleted file mode 100644
> > index 38760e4296cf..000000000000
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ /dev/null
> > @@ -1,139 +0,0 @@
> > -CONFIG_SYSVIPC=y
> > -CONFIG_POSIX_MQUEUE=y
> > -CONFIG_NO_HZ_IDLE=y
> > -CONFIG_HIGH_RES_TIMERS=y
> > -CONFIG_BPF_SYSCALL=y
> > -CONFIG_IKCONFIG=y
> > -CONFIG_IKCONFIG_PROC=y
> > -CONFIG_CGROUPS=y
> > -CONFIG_CGROUP_SCHED=y
> > -CONFIG_CFS_BANDWIDTH=y
> > -CONFIG_CGROUP_BPF=y
> > -CONFIG_NAMESPACES=y
> > -CONFIG_USER_NS=y
> > -CONFIG_CHECKPOINT_RESTORE=y
> > -CONFIG_BLK_DEV_INITRD=y
> > -CONFIG_EXPERT=y
> > -# CONFIG_SYSFS_SYSCALL is not set
> > -CONFIG_PROFILING=y
> > -CONFIG_SOC_SIFIVE=y
> > -CONFIG_SOC_VIRT=y
> > -CONFIG_NONPORTABLE=y
> > -CONFIG_ARCH_RV32I=y
> > -CONFIG_SMP=y
> > -CONFIG_HOTPLUG_CPU=y
> > -CONFIG_PM=y
> > -CONFIG_CPU_IDLE=y
> > -CONFIG_VIRTUALIZATION=y
> > -CONFIG_KVM=m
> > -CONFIG_JUMP_LABEL=y
> > -CONFIG_MODULES=y
> > -CONFIG_MODULE_UNLOAD=y
> > -CONFIG_NET=y
> > -CONFIG_PACKET=y
> > -CONFIG_UNIX=y
> > -CONFIG_INET=y
> > -CONFIG_IP_MULTICAST=y
> > -CONFIG_IP_ADVANCED_ROUTER=y
> > -CONFIG_IP_PNP=y
> > -CONFIG_IP_PNP_DHCP=y
> > -CONFIG_IP_PNP_BOOTP=y
> > -CONFIG_IP_PNP_RARP=y
> > -CONFIG_NETLINK_DIAG=y
> > -CONFIG_NET_9P=y
> > -CONFIG_NET_9P_VIRTIO=y
> > -CONFIG_PCI=y
> > -CONFIG_PCIEPORTBUS=y
> > -CONFIG_PCI_HOST_GENERIC=y
> > -CONFIG_PCIE_XILINX=y
> > -CONFIG_DEVTMPFS=y
> > -CONFIG_DEVTMPFS_MOUNT=y
> > -CONFIG_BLK_DEV_LOOP=y
> > -CONFIG_VIRTIO_BLK=y
> > -CONFIG_BLK_DEV_SD=y
> > -CONFIG_BLK_DEV_SR=y
> > -CONFIG_SCSI_VIRTIO=y
> > -CONFIG_ATA=y
> > -CONFIG_SATA_AHCI=y
> > -CONFIG_SATA_AHCI_PLATFORM=y
> > -CONFIG_NETDEVICES=y
> > -CONFIG_VIRTIO_NET=y
> > -CONFIG_MACB=y
> > -CONFIG_E1000E=y
> > -CONFIG_R8169=y
> > -CONFIG_MICROSEMI_PHY=y
> > -CONFIG_INPUT_MOUSEDEV=y
> > -CONFIG_SERIAL_8250=y
> > -CONFIG_SERIAL_8250_CONSOLE=y
> > -CONFIG_SERIAL_OF_PLATFORM=y
> > -CONFIG_VIRTIO_CONSOLE=y
> > -CONFIG_HW_RANDOM=y
> > -CONFIG_HW_RANDOM_VIRTIO=y
> > -CONFIG_SPI=y
> > -CONFIG_SPI_SIFIVE=y
> > -# CONFIG_PTP_1588_CLOCK is not set
> > -CONFIG_DRM=y
> > -CONFIG_DRM_RADEON=y
> > -CONFIG_DRM_VIRTIO_GPU=y
> > -CONFIG_FB=y
> > -CONFIG_FRAMEBUFFER_CONSOLE=y
> > -CONFIG_USB=y
> > -CONFIG_USB_XHCI_HCD=y
> > -CONFIG_USB_XHCI_PLATFORM=y
> > -CONFIG_USB_EHCI_HCD=y
> > -CONFIG_USB_EHCI_HCD_PLATFORM=y
> > -CONFIG_USB_OHCI_HCD=y
> > -CONFIG_USB_OHCI_HCD_PLATFORM=y
> > -CONFIG_USB_STORAGE=y
> > -CONFIG_USB_UAS=y
> > -CONFIG_MMC=y
> > -CONFIG_MMC_SPI=y
> > -CONFIG_RTC_CLASS=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_INPUT=y
> > -CONFIG_VIRTIO_MMIO=y
> > -CONFIG_RPMSG_CHAR=y
> > -CONFIG_RPMSG_CTRL=y
> > -CONFIG_RPMSG_VIRTIO=y
> > -CONFIG_EXT4_FS=y
> > -CONFIG_EXT4_FS_POSIX_ACL=y
> > -CONFIG_AUTOFS4_FS=y
> > -CONFIG_MSDOS_FS=y
> > -CONFIG_VFAT_FS=y
> > -CONFIG_TMPFS=y
> > -CONFIG_TMPFS_POSIX_ACL=y
> > -CONFIG_HUGETLBFS=y
> > -CONFIG_NFS_FS=y
> > -CONFIG_NFS_V4=y
> > -CONFIG_NFS_V4_1=y
> > -CONFIG_NFS_V4_2=y
> > -CONFIG_ROOT_NFS=y
> > -CONFIG_9P_FS=y
> > -CONFIG_CRYPTO_USER_API_HASH=y
> > -CONFIG_CRYPTO_DEV_VIRTIO=y
> > -CONFIG_PRINTK_TIME=y
> > -CONFIG_DEBUG_FS=y
> > -CONFIG_DEBUG_PAGEALLOC=y
> > -CONFIG_SCHED_STACK_END_CHECK=y
> > -CONFIG_DEBUG_VM=y
> > -CONFIG_DEBUG_VM_PGFLAGS=y
> > -CONFIG_DEBUG_MEMORY_INIT=y
> > -CONFIG_DEBUG_PER_CPU_MAPS=y
> > -CONFIG_SOFTLOCKUP_DETECTOR=y
> > -CONFIG_WQ_WATCHDOG=y
> > -CONFIG_DEBUG_TIMEKEEPING=y
> > -CONFIG_DEBUG_RT_MUTEXES=y
> > -CONFIG_DEBUG_SPINLOCK=y
> > -CONFIG_DEBUG_MUTEXES=y
> > -CONFIG_DEBUG_RWSEMS=y
> > -CONFIG_DEBUG_ATOMIC_SLEEP=y
> > -CONFIG_STACKTRACE=y
> > -CONFIG_DEBUG_LIST=y
> > -CONFIG_DEBUG_PLIST=y
> > -CONFIG_DEBUG_SG=y
> > -# CONFIG_RCU_TRACE is not set
> > -CONFIG_RCU_EQS_DEBUG=y
> > -# CONFIG_FTRACE is not set
> > -# CONFIG_RUNTIME_TESTING_MENU is not set
> > -CONFIG_MEMTEST=y
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
