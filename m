Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9068E059
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 19:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjBGSob (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjBGSo1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 13:44:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885EA28865;
        Tue,  7 Feb 2023 10:44:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C44B81AB2;
        Tue,  7 Feb 2023 18:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA75C433EF;
        Tue,  7 Feb 2023 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675795462;
        bh=RaD8bOb2fte5qBe2JPxiOX9a3nwNRlSBAu75aieyJBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPfly4QymoPJqqYUJBd3OTt/+C5rQ5OT4HODlrCRp4bNyv+h6vrIxXngGEC/d4kZI
         lU2FD6isJPRCxtJ4YwuxsbADO8KuZTimWt5hJj/D4Msj85nS8lbXmpWN3rBVB7+OoG
         sWU6XCoZXWLS8GyHUdNfj2MXLeJZtfotVJojAY3rBiIwZU4h08+FfNXDNdWXr2Y023
         pdnSQ8/JReHKySMun53eADNPsIpxEpUUDDRv5XuWUVbRIBmdijlephs32wKD3khgTo
         z8jCHMMeB4/gaq8j2X25YBihc2iWO0UQdKvrAppY3cmYGpaO6pwfR47YDxY/v1HPK9
         O4kNshwCy3ayA==
Date:   Tue, 7 Feb 2023 18:44:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, arnd@arndb.de, atishp@rivosinc.com,
        rdunlap@infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: Cleanup rv32_defconfig
Message-ID: <Y+KcAiEV5iTG3SyX@spud>
References: <20230205133307.1058814-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTE+h999HcA9Enua"
Content-Disposition: inline
In-Reply-To: <20230205133307.1058814-1-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--gTE+h999HcA9Enua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 05, 2023 at 08:33:07AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> Subject: riscv: Cleanup rv32_defconfig

s/cleanup/remove redundant/, cleanup implies that you're doing some
rework of the file IMO.

> Remove the unused rv32_defconfig file,

What do you mean by "unused"? (don't answer now, read on)

> which has been replaced by
> 'commit 72f045d19f25 ("riscv: Fixup difference with defconfig")'.

Replaced how? One shouldn't have to go look up that commit to see what
"replaced" means. Certainly from the subject it is not immediately
obvious what that commit actually does.

How about:
"Remove the rv32_defconfig file, which has been made redundant by commit
112233445566 ("blah") which introduced an rv32_defconfig .PHONY target,
that is prioritised over the file itself."

I would argue that there is still value in having an off-the-shelf 32-bit
config for people to base things on though, and being ignored by the
make target does not make it "unused" IMO.

I did check the before/after of running the make target, so:
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Although, as you are probably aware, there are significant differences
between the .config generated by the file and by the rv32_defconfig make
target!

Cheers,
Conor.

> Also,
> remove CONFIG_32BIT in 32-bit.config, which CONFIG_ARCH_RV32I has
> selected.
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/configs/32-bit.config  |   2 -
>  arch/riscv/configs/rv32_defconfig | 139 ------------------------------
>  2 files changed, 141 deletions(-)
>  delete mode 100644 arch/riscv/configs/rv32_defconfig
>=20
> diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit=
=2Econfig
> index f6af0f708df4..eb87885c8640 100644
> --- a/arch/riscv/configs/32-bit.config
> +++ b/arch/riscv/configs/32-bit.config
> @@ -1,4 +1,2 @@
>  CONFIG_ARCH_RV32I=3Dy
> -CONFIG_32BIT=3Dy
> -# CONFIG_PORTABLE is not set
>  CONFIG_NONPORTABLE=3Dy
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_=
defconfig
> deleted file mode 100644
> index 38760e4296cf..000000000000
> --- a/arch/riscv/configs/rv32_defconfig
> +++ /dev/null
> @@ -1,139 +0,0 @@
> -CONFIG_SYSVIPC=3Dy
> -CONFIG_POSIX_MQUEUE=3Dy
> -CONFIG_NO_HZ_IDLE=3Dy
> -CONFIG_HIGH_RES_TIMERS=3Dy
> -CONFIG_BPF_SYSCALL=3Dy
> -CONFIG_IKCONFIG=3Dy
> -CONFIG_IKCONFIG_PROC=3Dy
> -CONFIG_CGROUPS=3Dy
> -CONFIG_CGROUP_SCHED=3Dy
> -CONFIG_CFS_BANDWIDTH=3Dy
> -CONFIG_CGROUP_BPF=3Dy
> -CONFIG_NAMESPACES=3Dy
> -CONFIG_USER_NS=3Dy
> -CONFIG_CHECKPOINT_RESTORE=3Dy
> -CONFIG_BLK_DEV_INITRD=3Dy
> -CONFIG_EXPERT=3Dy
> -# CONFIG_SYSFS_SYSCALL is not set
> -CONFIG_PROFILING=3Dy
> -CONFIG_SOC_SIFIVE=3Dy
> -CONFIG_SOC_VIRT=3Dy
> -CONFIG_NONPORTABLE=3Dy
> -CONFIG_ARCH_RV32I=3Dy
> -CONFIG_SMP=3Dy
> -CONFIG_HOTPLUG_CPU=3Dy
> -CONFIG_PM=3Dy
> -CONFIG_CPU_IDLE=3Dy
> -CONFIG_VIRTUALIZATION=3Dy
> -CONFIG_KVM=3Dm
> -CONFIG_JUMP_LABEL=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -CONFIG_NET=3Dy
> -CONFIG_PACKET=3Dy
> -CONFIG_UNIX=3Dy
> -CONFIG_INET=3Dy
> -CONFIG_IP_MULTICAST=3Dy
> -CONFIG_IP_ADVANCED_ROUTER=3Dy
> -CONFIG_IP_PNP=3Dy
> -CONFIG_IP_PNP_DHCP=3Dy
> -CONFIG_IP_PNP_BOOTP=3Dy
> -CONFIG_IP_PNP_RARP=3Dy
> -CONFIG_NETLINK_DIAG=3Dy
> -CONFIG_NET_9P=3Dy
> -CONFIG_NET_9P_VIRTIO=3Dy
> -CONFIG_PCI=3Dy
> -CONFIG_PCIEPORTBUS=3Dy
> -CONFIG_PCI_HOST_GENERIC=3Dy
> -CONFIG_PCIE_XILINX=3Dy
> -CONFIG_DEVTMPFS=3Dy
> -CONFIG_DEVTMPFS_MOUNT=3Dy
> -CONFIG_BLK_DEV_LOOP=3Dy
> -CONFIG_VIRTIO_BLK=3Dy
> -CONFIG_BLK_DEV_SD=3Dy
> -CONFIG_BLK_DEV_SR=3Dy
> -CONFIG_SCSI_VIRTIO=3Dy
> -CONFIG_ATA=3Dy
> -CONFIG_SATA_AHCI=3Dy
> -CONFIG_SATA_AHCI_PLATFORM=3Dy
> -CONFIG_NETDEVICES=3Dy
> -CONFIG_VIRTIO_NET=3Dy
> -CONFIG_MACB=3Dy
> -CONFIG_E1000E=3Dy
> -CONFIG_R8169=3Dy
> -CONFIG_MICROSEMI_PHY=3Dy
> -CONFIG_INPUT_MOUSEDEV=3Dy
> -CONFIG_SERIAL_8250=3Dy
> -CONFIG_SERIAL_8250_CONSOLE=3Dy
> -CONFIG_SERIAL_OF_PLATFORM=3Dy
> -CONFIG_VIRTIO_CONSOLE=3Dy
> -CONFIG_HW_RANDOM=3Dy
> -CONFIG_HW_RANDOM_VIRTIO=3Dy
> -CONFIG_SPI=3Dy
> -CONFIG_SPI_SIFIVE=3Dy
> -# CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_DRM=3Dy
> -CONFIG_DRM_RADEON=3Dy
> -CONFIG_DRM_VIRTIO_GPU=3Dy
> -CONFIG_FB=3Dy
> -CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> -CONFIG_USB=3Dy
> -CONFIG_USB_XHCI_HCD=3Dy
> -CONFIG_USB_XHCI_PLATFORM=3Dy
> -CONFIG_USB_EHCI_HCD=3Dy
> -CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
> -CONFIG_USB_OHCI_HCD=3Dy
> -CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> -CONFIG_USB_STORAGE=3Dy
> -CONFIG_USB_UAS=3Dy
> -CONFIG_MMC=3Dy
> -CONFIG_MMC_SPI=3Dy
> -CONFIG_RTC_CLASS=3Dy
> -CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VIRTIO_BALLOON=3Dy
> -CONFIG_VIRTIO_INPUT=3Dy
> -CONFIG_VIRTIO_MMIO=3Dy
> -CONFIG_RPMSG_CHAR=3Dy
> -CONFIG_RPMSG_CTRL=3Dy
> -CONFIG_RPMSG_VIRTIO=3Dy
> -CONFIG_EXT4_FS=3Dy
> -CONFIG_EXT4_FS_POSIX_ACL=3Dy
> -CONFIG_AUTOFS4_FS=3Dy
> -CONFIG_MSDOS_FS=3Dy
> -CONFIG_VFAT_FS=3Dy
> -CONFIG_TMPFS=3Dy
> -CONFIG_TMPFS_POSIX_ACL=3Dy
> -CONFIG_HUGETLBFS=3Dy
> -CONFIG_NFS_FS=3Dy
> -CONFIG_NFS_V4=3Dy
> -CONFIG_NFS_V4_1=3Dy
> -CONFIG_NFS_V4_2=3Dy
> -CONFIG_ROOT_NFS=3Dy
> -CONFIG_9P_FS=3Dy
> -CONFIG_CRYPTO_USER_API_HASH=3Dy
> -CONFIG_CRYPTO_DEV_VIRTIO=3Dy
> -CONFIG_PRINTK_TIME=3Dy
> -CONFIG_DEBUG_FS=3Dy
> -CONFIG_DEBUG_PAGEALLOC=3Dy
> -CONFIG_SCHED_STACK_END_CHECK=3Dy
> -CONFIG_DEBUG_VM=3Dy
> -CONFIG_DEBUG_VM_PGFLAGS=3Dy
> -CONFIG_DEBUG_MEMORY_INIT=3Dy
> -CONFIG_DEBUG_PER_CPU_MAPS=3Dy
> -CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> -CONFIG_WQ_WATCHDOG=3Dy
> -CONFIG_DEBUG_TIMEKEEPING=3Dy
> -CONFIG_DEBUG_RT_MUTEXES=3Dy
> -CONFIG_DEBUG_SPINLOCK=3Dy
> -CONFIG_DEBUG_MUTEXES=3Dy
> -CONFIG_DEBUG_RWSEMS=3Dy
> -CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> -CONFIG_STACKTRACE=3Dy
> -CONFIG_DEBUG_LIST=3Dy
> -CONFIG_DEBUG_PLIST=3Dy
> -CONFIG_DEBUG_SG=3Dy
> -# CONFIG_RCU_TRACE is not set
> -CONFIG_RCU_EQS_DEBUG=3Dy
> -# CONFIG_FTRACE is not set
> -# CONFIG_RUNTIME_TESTING_MENU is not set
> -CONFIG_MEMTEST=3Dy
> --=20
> 2.36.1
>=20

--gTE+h999HcA9Enua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+KcAgAKCRB4tDGHoIJi
0nFKAP9F+tE91zDrdwwNriyfwg5wRazXYpqr5Mb3kEuCyu639AD+Pwo99Rc22IXR
qNTlczwuPZ1R5nRjspo5RxI1y8IM9AU=
=/929
-----END PGP SIGNATURE-----

--gTE+h999HcA9Enua--
