Return-Path: <linux-arch+bounces-9182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16C9DBB1E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B858F1641BD
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042211BCA19;
	Thu, 28 Nov 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBGvF6iI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FF3232;
	Thu, 28 Nov 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810778; cv=none; b=aB7438dycMpAkm/nnvD3hLtwZzVaMrcAr0fCp+VHUnLI71pZdCZ7rw+f+uomxZhgr6YF/8IIrSqF7MSPv5xXUUgDu0FZn8p1fXFFD1rIub4E+xoRqAgPLoakMjDFjRmKdx/8wdR+4inim75Tffi2+xSgIoBxxxaHOQaUnxpEDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810778; c=relaxed/simple;
	bh=nEZXX9r4I+3lLA88i41U/AY9TcXT/12vFkdTWOyG4xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaXKnCsMdZ50ziEMUS8v1ATXf9ydH85F3E9qhn1xlamAmsqhQcWQ4WnqitWJBxpgK/28pxo2KWtCrlzjLMrVaLzwRI9SZUuAAgxcy2Haj9yNoWEMdIC9sMH3Jj5vlHChtTuY0IaZg24bgo8dIx9jUySDfaDJd0NHpldFbLvcBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBGvF6iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64C5C4CED8;
	Thu, 28 Nov 2024 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732810778;
	bh=nEZXX9r4I+3lLA88i41U/AY9TcXT/12vFkdTWOyG4xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBGvF6iIzlMfrVCWFfRuqRY68PuACexWLsSIi4vPhKoTAmbWmEgytvUw8NIxdrySo
	 oBbzFDTKzqjkSZmR0VmPqLijIuGewzIjTNtBJg4hOjie3MAnJUNwP333AD7zxke38i
	 zATm7rFx6FUIpMed3FVSLbfc0oujJPn5IV2+SN+P5arIGpg7o2/fD4ZvVjlDeTOSrm
	 navaTPgEmoIBYDTk7lzR/JzWeKr8aZrFrRA52FltjIL6R93aI3PGtNsEdNUQTxM/gV
	 FbhonukyLqiiyCKkW1Z3S7fH/yGUY0gQjYo7n+7AWFyNficWllSK5EnKEIKEsqN/XT
	 lXzLaGMUTerTw==
Date: Thu, 28 Nov 2024 16:19:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Will Deacon <will@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241128-goggles-laundry-d94c23ab39a4@spud>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck>
 <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i1DJKPzC9+fIuycd"
Content-Disposition: inline
In-Reply-To: <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>


--i1DJKPzC9+fIuycd
Content-Type: multipart/mixed; boundary="5ktj1xFXjJv7HfIy"
Content-Disposition: inline


--5ktj1xFXjJv7HfIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> On 28/11/2024 15:14, Conor Dooley wrote:
> > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > > > > In order to produce a generic kernel, a user can select
> > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the tick=
et
> > > > > spinlock implementation if Zabha or Ziccrse are not present.
> > > > >=20
> > > > > Note that we can't use alternatives here because the discovery of
> > > > > extensions is done too late and we need to start with the qspinlo=
ck
> > > > > implementation because the ticket spinlock implementation would p=
ollute
> > > > > the spinlock value, so let's use static keys.
> > > > >=20
> > > > > This is largely based on Guo's work and Leonardo reviews at [1].
> > > > >=20
> > > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-=
1-guoren@kernel.org/ [1]
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > This patch (now commit ab83647fadae2 ("riscv: Add qspinlock support=
"))
> > > > breaks boot on polarfire soc. It dies before outputting anything to=
 the
> > > > console. My .config has:
> > > >=20
> > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > I pointed out some of the fragility during review:
> > >=20
> > > https://lore.kernel.org/all/20241111164259.GA20042@willie-the-truck/
> > >=20
> > > so I'm kinda surprised it got merged tbh :/
> > Maybe it could be reverted rather than having a broken boot with the
> > default settings in -rc1.
>=20
>=20
> No need to rush before we know what's happening,I guess you bisected to t=
his
> commit right?

The symptom is a failure to boot, without any console output, of course
I bisected it before blaming something specific. But I don't think it is
"rushing" as having -rc1 broken with an option's default is a massive pain
in the arse when it comes to testing.

> I don't have this soc, so can you provide $stval/$sepc/$scause, a config,=
 a
> kernel, anything?

I don't have the former cos it died immediately on boot. config is
attached. It reproduces in QEMU so you don't need any hardware.

> Does the polarfire soc provide Ziccrse?

I don't think that is relevant because ziccrse is not listed in the dts,
so the kernel should not be assuming that LR/SC has a forward progress
guarantee. It's not even getting as far as riscv_spinlock_init() given
several things before that should be emitting logs, so it doesn't even
get to make any decisions about Ziccrse.

--5ktj1xFXjJv7HfIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=qspinlocks_config

CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BPF_SYSCALL=y
CONFIG_PREEMPT_RT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_CGROUP_BPF=y
CONFIG_NAMESPACES=y
CONFIG_USER_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXPERT=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_PROFILING=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_MICROCHIP=y
CONFIG_ARCH_RENESAS=y
CONFIG_ARCH_SOPHGO=y
CONFIG_SOC_STARFIVE=y
CONFIG_ARCH_THEAD=y
CONFIG_ARCH_VIRT=y
CONFIG_NONPORTABLE=y
CONFIG_SMP=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_CMDLINE="earlycon keep_bootcon reboot=cold"
CONFIG_HIBERNATION=y
CONFIG_CPU_FREQ=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_ACPI=y
CONFIG_JUMP_LABEL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NETLINK_DIAG=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_PCI=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_MICROCHIP_HOST=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_DEBUG_DRIVER=y
CONFIG_AX45MP_L2_CACHE=y
CONFIG_SIFIVE_CCACHE=y
CONFIG_EFI_ZBOOT=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_SPI_NAND=y
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_OF_OVERLAY=y
CONFIG_ZRAM=y
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_NVME=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_MACB=y
CONFIG_E1000E=y
CONFIG_R8169=y
CONFIG_MICROSEMI_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_SENSEHAT=m
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_POLARFIRE_SOC=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MICROCHIP_CORE=y
CONFIG_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=y
CONFIG_SPI_SIFIVE=y
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_POLARFIRE_SOC=y
CONFIG_GPIO_SIFIVE=y
CONFIG_AUXDISPLAY=y
CONFIG_FB=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_POLARFIRE_SOC=y
CONFIG_USB_INVENTRA_DMA=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SPI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_PWM=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_DMADEVICES=y
CONFIG_SF_PDMA=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_MAILBOX=y
CONFIG_POLARFIRE_SOC_MAILBOX=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_POLARFIRE_SOC_SYS_CTRL=y
CONFIG_IIO=y
CONFIG_ADXL345_SPI=y
CONFIG_MCP320X=y
CONFIG_MCP3564=y
CONFIG_PAC1934=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_HTS221=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_PRESS=m
CONFIG_PWM=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_MICROCHIP_CORE=y
CONFIG_LIBNVDIMM=y
CONFIG_FPGA=y
CONFIG_FPGA_BRIDGE=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_MGR_MICROCHIP_SPI=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_NFS_V4_1_MIGRATION=y
CONFIG_ROOT_NFS=y
CONFIG_9P_FS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_ZSTD=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_PRINTK_TIME=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_WQ_WATCHDOG=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_SAMPLES=y
CONFIG_MEMTEST=y

--5ktj1xFXjJv7HfIy--

--i1DJKPzC9+fIuycd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0iYEwAKCRB4tDGHoIJi
0owsAP4tkPf+mQWb2+8rmLKvlz1xX1WZmn2PVYJPZ9u+xeDFeQD/Za5OsgbFTVE9
S1aLg96XP9AnvFSeUE8vpsoc6aFIHA0=
=1mQX
-----END PGP SIGNATURE-----

--i1DJKPzC9+fIuycd--

