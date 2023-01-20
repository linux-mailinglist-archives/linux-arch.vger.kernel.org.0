Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5567576D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjATOgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjATOgD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:36:03 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C2D05D1
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:22 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id 0C4B235CE67
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:46 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 9582C35CD72; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 21C5235CD0C; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 9769527E0465; Fri, 20 Jan 2023
 15:10:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 807A927E0456; Fri, 20 Jan 2023 15:10:37 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 jR-SNzcBpINi; Fri, 20 Jan 2023 15:10:37 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1C6A727E0458; Fri, 20 Jan 2023
 15:10:37 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1035.63caa33d.1d517.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 807A927E0456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223837;
 bh=hCXuqd/Le9iT4FAC9E5Y/iYkTg6Ipsgz39vkI/jYJ6E=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=d0H3rQM+qImcDnObPenUoBefyEzmnq190byge1ZFC/qL2bWg8k4nnIuIikgl7XZDc
 fbaEx4Uyp7pzRNsTIh/9Yf6mcfd2SFEb9m+VO/GbWj8naVs6UrcjtE/E6ppNgfaWaU
 eNpGDhaaNyqtF03qNdt9fBQg6exSSj2xAJXMDC3o=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 27/31] kvx: Add kvx default config file
Date:   Fri, 20 Jan 2023 15:09:58 +0100
Message-ID: <20230120141002.2442-28-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a default config file for kvx based Coolidge SoC.

Co-developed-by: Ashley Lesdalons <alesdalons@kalray.eu>
Signed-off-by: Ashley Lesdalons <alesdalons@kalray.eu>
Co-developed-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Signed-off-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Samuel Jones <sjones@kalray.eu>
Signed-off-by: Samuel Jones <sjones@kalray.eu>
Co-developed-by: Thomas Costis <tcostis@kalray.eu>
Signed-off-by: Thomas Costis <tcostis@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: default_defconfig renamed to defconfig

 arch/kvx/configs/defconfig | 127 +++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 arch/kvx/configs/defconfig

diff --git a/arch/kvx/configs/defconfig b/arch/kvx/configs/defconfig
new file mode 100644
index 000000000000..960784da0b1b
--- /dev/null
+++ b/arch/kvx/configs/defconfig
@@ -0,0 +1,127 @@
+CONFIG_DEFAULT_HOSTNAME="KVXlinux"
+CONFIG_SERIAL_KVX_SCALL_COMM=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_PRINTK_TIME=y
+CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
+CONFIG_PANIC_TIMEOUT=-1
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_FRAME_POINTER=y
+CONFIG_HZ_100=y
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_HOTPLUG_PCI_PCIE=y
+CONFIG_PCIEAER=y
+CONFIG_PCIE_DPC=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_RUNTIME_UARTS=8
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_RESET_KVX_SCALL_POWEROFF=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_KVX_NWL=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCIEAER_INJECT=y
+CONFIG_TMPFS=y
+CONFIG_DMADEVICES=y
+CONFIG_KVX_DMA_NOC=m
+CONFIG_KVX_IOMMU=y
+CONFIG_KVX_OTP_NV=y
+CONFIG_PACKET=y
+CONFIG_NET=y
+# CONFIG_WLAN is not set
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+CONFIG_E1000E=y
+CONFIG_BLK_DEV_NVME=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_WATCHDOG=y
+CONFIG_KVX_WATCHDOG=y
+CONFIG_HUGETLBFS=y
+CONFIG_MAILBOX=y
+CONFIG_KVX_MBOX=y
+CONFIG_REMOTEPROC=y
+CONFIG_KVX_REMOTEPROC=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_USE_FOR_EXT2=y
+CONFIG_SYSVIPC=y
+CONFIG_UNIX=y
+CONFIG_NET_VENDOR_KALRAY=y
+CONFIG_NET_KVX_SOC=m
+CONFIG_STACKPROTECTOR=y
+CONFIG_GPIO_DWAPB=y
+CONFIG_I2C=y
+CONFIG_I2C_SLAVE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_DESIGNWARE_SLAVE=y
+CONFIG_I2C_SLAVE_USPACE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_SPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_SPI_DW_KVX=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
+CONFIG_SQUASHFS=m
+CONFIG_USB=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_DWC2_DUAL_ROLE=y
+CONFIG_USB_GADGET=y
+CONFIG_U_SERIAL_CONSOLE=y
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_SMSC95XX=m
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_USB_PHY=y
+CONFIG_GENERIC_PHY=y
+CONFIG_GENERIC_PHY_USB=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MDIO_BITBANG=m
+CONFIG_MDIO_GPIO=m
+CONFIG_MARVELL_PHY=m
+CONFIG_GPIO_PCA953X=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_NAT=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_NAT=m
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_NETDEV=y
+CONFIG_LEDS_TRIGGER_PATTERN=y
+CONFIG_DCB=y
-- 
2.37.2





