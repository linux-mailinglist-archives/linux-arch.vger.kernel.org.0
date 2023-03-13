Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7E6B6D91
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 03:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCMCjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 22:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 22:39:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5437550;
        Sun, 12 Mar 2023 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qp8CqstxohY5gxP49tj1c6sBVZFT/OZgfBNO+WoN3uA=; b=ATe7ilCQjetpUqt8dTUeSeNr5p
        h0y6tirRajOw1ivMTVNI9XyWVQhaT7sV6UJUbkPEbQXO6kuvkPRidaeERkPjrwH/7N3e747JWUUOb
        jxtmX9APdvrAuV81cgFItNeAvBkQni94GQ9kdxPrUNgSW9dXM5PnqL5EueufOFQxytYfVE6eK3p3s
        P5jyb2yuH/59UsD8SyDEFML4DBQceaZTumS4W3eIZBQZC6Q1t4yfBN5QRBBwD3ZAEJhCBzBHUhg9c
        ssx74SQpJ8JY/VYfNJBK1/ofx5PURIZE5z7+UeJCmC2bBRQ99bxKqoA6XoOd51+5j7gqE+n8lHKC0
        PVjLnaGQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbY63-0043sa-S3; Mon, 13 Mar 2023 02:39:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it always on
Date:   Sun, 12 Mar 2023 19:39:35 -0700
Message-Id: <20230313023935.31037-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for dropping the IRQ_DOMAIN Kconfig option (effectively
making it always set/on), first drop IRQ_DOMAIN_HIERARCHY as an option,
making its code always set/on.

This has been built successfully on all ARCHes except hexagon,
both 32-bit and 64-bit where applicable.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
---
v2: add stubs in include/linux/irqdomain.h for the config case of
IRQ_DOMAIN is not set. If these are not added, there will be plenty
of build errors (not so much for modern arches as for older ones).
For functions that return a value, the return values should be reviewed.
All of these stubs can be deleted when CONFIG_IRQ_DOMAIN is always on
(i.e., in some subsequent patch).

 arch/mips/Kconfig                      |    4 
 arch/powerpc/sysdev/xics/xics-common.c |    4 
 arch/powerpc/sysdev/xive/common.c      |    4 
 arch/x86/Kconfig                       |    2 
 drivers/gpio/Kconfig                   |   20 +--
 drivers/gpio/gpiolib.c                 |   18 ---
 drivers/irqchip/Kconfig                |   45 +++----
 drivers/mfd/Kconfig                    |    2 
 drivers/pinctrl/qcom/Kconfig           |    6 -
 drivers/pinctrl/stm32/Kconfig          |    2 
 drivers/soc/tegra/Kconfig              |    2 
 drivers/spmi/Kconfig                   |    4 
 include/linux/gpio/driver.h            |    6 -
 include/linux/irq.h                    |    5 
 include/linux/irqdomain.h              |  136 +++++++++++++++++++----
 kernel/irq/Kconfig                     |    7 -
 kernel/irq/chip.c                      |    6 -
 kernel/irq/debugfs.c                   |    2 
 kernel/irq/internals.h                 |    6 -
 kernel/irq/irqdomain.c                 |   52 --------
 kernel/irq/manage.c                    |   18 ---
 kernel/irq/migration.c                 |    6 -
 kernel/irq/resend.c                    |    4 
 23 files changed, 164 insertions(+), 197 deletions(-)

diff -- a/kernel/irq/Kconfig b/kernel/irq/Kconfig
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -66,11 +66,6 @@ config IRQ_SIM
 	select IRQ_WORK
 	select IRQ_DOMAIN
 
-# Support for hierarchical irq domains
-config IRQ_DOMAIN_HIERARCHY
-	bool
-	select IRQ_DOMAIN
-
 # Support for obsolete non-mapping irq domains
 config IRQ_DOMAIN_NOMAP
 	bool
@@ -84,7 +79,6 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 config GENERIC_IRQ_IPI
 	bool
 	depends on SMP
-	select IRQ_DOMAIN_HIERARCHY
 
 # Generic IRQ IPI Mux support
 config GENERIC_IRQ_IPI_MUX
@@ -94,7 +88,6 @@ config GENERIC_IRQ_IPI_MUX
 # Generic MSI hierarchical interrupt domain support
 config GENERIC_MSI_IRQ
 	bool
-	select IRQ_DOMAIN_HIERARCHY
 
 config IRQ_MSI_IOMMU
 	bool
diff -- a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -687,7 +687,7 @@ config SGI_IP27
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select NR_CPUS_DEFAULT_64
 	select PCI_DRIVERS_GENERIC
 	select PCI_XTALK_BRIDGE
@@ -752,7 +752,7 @@ config SGI_IP30
 	select ZONE_DMA32
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select PCI_DRIVERS_GENERIC
 	select PCI_XTALK_BRIDGE
 	select SYS_HAS_EARLY_PRINTK
diff -- a/arch/x86/Kconfig b/arch/x86/Kconfig
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1109,7 +1109,7 @@ config X86_UP_IOAPIC
 config X86_LOCAL_APIC
 	def_bool y
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 
 config X86_IO_APIC
 	def_bool y
diff -- a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -13,7 +13,7 @@ if SPMI
 
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	depends on HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
@@ -22,7 +22,7 @@ config SPMI_HISI3670
 
 config SPMI_MSM_PMIC_ARB
 	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
 	default ARCH_QCOM
diff -- a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -7,7 +7,7 @@ config IRQCHIP
 
 config ARM_GIC
 	bool
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_PM
@@ -32,7 +32,7 @@ config GIC_NON_BANKED
 
 config ARM_GIC_V3
 	bool
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
@@ -56,7 +56,7 @@ config ARM_GIC_V3_ITS_FSL_MC
 
 config ARM_NVIC
 	bool
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
 
 config ARM_VIC
@@ -144,7 +144,7 @@ config DAVINCI_CP_INTC
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 
 config FARADAY_FTINTC010
 	bool
@@ -232,7 +232,7 @@ config RENESAS_IRQC
 
 config RENESAS_RZA1_IRQC
 	bool "Renesas RZ/A1 IRQC support" if COMPILE_TEST
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
 	  to 8 external interrupts with configurable sense select.
@@ -240,7 +240,7 @@ config RENESAS_RZA1_IRQC
 config RENESAS_RZG2L_IRQC
 	bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
 	  for external devices.
@@ -265,7 +265,7 @@ config SUN4I_INTC
 
 config SUN6I_R_INTC
 	bool
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 
 config SUNXI_NMI_INTC
@@ -326,7 +326,7 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select GENERIC_IRQ_IPI if SMP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select MIPS_CM
 
 config INGENIC_IRQ
@@ -397,7 +397,7 @@ config STM32_EXTI
 config QCOM_IRQ_COMBINER
 	bool "QCOM IRQ combiner support"
 	depends on ARCH_QCOM && ACPI
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Qualcomm Technologies chips.
@@ -406,7 +406,7 @@ config IRQ_UNIPHIER_AIDET
 	bool "UniPhier AIDET support" if COMPILE_TEST
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	default ARCH_UNIPHIER
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
 
@@ -414,7 +414,7 @@ config MESON_IRQ_GPIO
        tristate "Meson GPIO Interrupt Multiplexer"
        depends on ARCH_MESON || COMPILE_TEST
        default ARCH_MESON
-       select IRQ_DOMAIN_HIERARCHY
+       select IRQ_DOMAIN
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
 
@@ -430,7 +430,7 @@ config GOLDFISH_PIC
 config QCOM_PDC
 	tristate "QCOM PDC"
 	depends on ARCH_QCOM
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
@@ -439,7 +439,7 @@ config QCOM_MPM
 	tristate "QCOM MPM"
 	depends on ARCH_QCOM
 	depends on MAILBOX
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  MSM Power Manager driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
@@ -482,7 +482,6 @@ config IMX_MU_MSI
 	depends on ARCH_MXC || COMPILE_TEST
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
@@ -503,7 +502,7 @@ config LS1X_IRQ
 config TI_SCI_INTR_IRQCHIP
 	bool
 	depends on TI_SCI_PROTOCOL
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  This enables the irqchip driver support for K3 Interrupt router
 	  over TI System Control Interface available on some new TI's SoCs.
@@ -513,7 +512,7 @@ config TI_SCI_INTR_IRQCHIP
 config TI_SCI_INTA_IRQCHIP
 	bool
 	depends on TI_SCI_PROTOCOL
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select TI_SCI_INTA_MSI_DOMAIN
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
@@ -539,7 +538,7 @@ config RISCV_INTC
 config SIFIVE_PLIC
 	bool
 	depends on RISCV
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config EXYNOS_IRQ_COMBINER
@@ -579,7 +578,7 @@ config LOONGSON_EIOINTC
 	depends on LOONGARCH
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
 	help
 	  Support for the Loongson3 Extend I/O Interrupt Vector Controller.
@@ -597,7 +596,7 @@ config LOONGSON_HTVEC
 	bool "Loongson HyperTransport Interrupt Vector Controller"
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Support for the Loongson HyperTransport Interrupt Vector Controller.
 
@@ -605,7 +604,7 @@ config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	help
 	  Support for the Loongson PCH PIC Controller.
@@ -615,7 +614,7 @@ config LOONGSON_PCH_MSI
 	depends on MACH_LOONGSON64
 	depends on PCI
 	default MACH_LOONGSON64
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select PCI_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
@@ -625,7 +624,7 @@ config LOONGSON_PCH_LPC
 	depends on LOONGARCH
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Support for the Loongson PCH LPC Controller.
 
@@ -634,7 +633,6 @@ config MST_IRQ
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
 	default ARCH_MEDIATEK
 	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Support MStar Interrupt Controller.
 
@@ -662,7 +660,6 @@ config MCHP_EIC
 	bool "Microchip External Interrupt Controller"
 	depends on ARCH_AT91 || COMPILE_TEST
 	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Support for Microchip External Interrupt Controller.
 
diff -- a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -9,7 +9,7 @@ config PINCTRL_MSM
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 
 config PINCTRL_APQ8064
@@ -236,7 +236,7 @@ config PINCTRL_QCOM_SPMI_PMIC
 	select GENERIC_PINCONF
   select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	 Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
@@ -251,7 +251,7 @@ config PINCTRL_QCOM_SSBI_PMIC
 	select GENERIC_PINCONF
   select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	 Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
diff -- a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_STM32
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select MFD_SYSCON
 
 config PINCTRL_STM32F429
diff -- a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -146,7 +146,7 @@ config SOC_TEGRA_FLOWCTRL
 config SOC_TEGRA_PMC
 	bool
 	select GENERIC_PINCONF
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select PM_OPP
 	select PM_GENERIC_DOMAINS
 	select REGMAP
diff -- a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1066,7 +1066,7 @@ config PCF50633_GPIO
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
 	depends on (ARM || HEXAGON || COMPILE_TEST)
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select MFD_CORE
 	select REGMAP
 	help
diff -- a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -361,7 +361,7 @@ config GPIO_IXP4XX
 	depends on OF
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the GPIO functionality of a number of Intel
 	  IXP4xx series of chips.
@@ -397,7 +397,7 @@ config GPIO_LPC18XX
 	tristate "NXP LPC18XX/43XX GPIO support"
 	default y if ARCH_LPC18XX
 	depends on OF_GPIO && (ARCH_LPC18XX || COMPILE_TEST)
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Select this option to enable GPIO driver for
 	  NXP LPC18XX/43XX devices.
@@ -566,7 +566,7 @@ config GPIO_SAMA5D2_PIOBU
 config GPIO_SIFIVE
 	bool "SiFive GPIO support"
 	depends on OF_GPIO
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	select REGMAP_MMIO
@@ -646,7 +646,7 @@ config GPIO_TEGRA
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support GPIO pins on NVIDIA Tegra SoCs.
 
@@ -656,7 +656,7 @@ config GPIO_TEGRA186
 	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST
 	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support GPIO pins on NVIDIA Tegra186 SoCs.
 
@@ -673,7 +673,7 @@ config GPIO_THUNDERX
 	depends on ARCH_THUNDER || (64BIT && COMPILE_TEST)
 	depends on PCI_MSI
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	help
 	  Say yes here to support the on-chip GPIO lines on the ThunderX
@@ -683,7 +683,7 @@ config GPIO_UNIPHIER
 	tristate "UniPhier GPIO support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF_GPIO
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support UniPhier GPIOs.
 
@@ -700,7 +700,7 @@ config GPIO_VISCONTI
 	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
 	select GPIO_GENERIC
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support GPIO on Tohisba Visconti.
 
@@ -737,7 +737,7 @@ config GPIO_XGENE_SB
 	depends on (ARCH_XGENE || COMPILE_TEST)
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  This driver supports the GPIO block within the APM X-Gene
 	  Standby Domain. Say yes here to enable the GPIO functionality.
@@ -815,7 +815,7 @@ config GPIO_MSC313
 	depends on ARCH_MSTARV7
 	default ARCH_MSTARV7
 	select GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
 	help
 	  Say Y here to support the main GPIO block on MStar/SigmaStar
 	  ARMv7-based SoCs.
diff -- a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -411,7 +411,6 @@ int xics_retrigger(struct irq_data *data
 	return 0;
 }
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 static int xics_host_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 				      unsigned long *hwirq, unsigned int *type)
 {
@@ -445,14 +444,11 @@ static void xics_host_domain_free(struct
 {
 	pr_debug("%s %d #%d\n", __func__, virq, nr_irqs);
 }
-#endif
 
 static const struct irq_domain_ops xics_host_ops = {
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	.alloc	= xics_host_domain_alloc,
 	.free	= xics_host_domain_free,
 	.translate = xics_host_domain_translate,
-#endif
 	.match = xics_host_match,
 	.map = xics_host_map,
 	.xlate = xics_host_xlate,
diff -- a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1388,7 +1388,6 @@ static void xive_irq_domain_debug_show(s
 }
 #endif
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 static int xive_irq_domain_translate(struct irq_domain *d,
 				     struct irq_fwspec *fwspec,
 				     unsigned long *hwirq,
@@ -1445,14 +1444,11 @@ static void xive_irq_domain_free(struct
 	for (i = 0; i < nr_irqs; i++)
 		xive_irq_free_data(virq + i);
 }
-#endif
 
 static const struct irq_domain_ops xive_irq_domain_ops = {
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	.alloc	= xive_irq_domain_alloc,
 	.free	= xive_irq_domain_free,
 	.translate = xive_irq_domain_translate,
-#endif
 	.match = xive_irq_domain_match,
 	.map = xive_irq_domain_map,
 	.unmap = xive_irq_domain_unmap,
diff -- a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1098,8 +1098,6 @@ bool gpiochip_irqchip_irq_valid(const st
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_irq_valid);
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-
 /**
  * gpiochip_set_hierarchical_irqchip() - connects a hierarchical irqchip
  * to a gpiochip
@@ -1362,20 +1360,6 @@ int gpiochip_populate_parent_fwspec_four
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_fourcell);
 
-#else
-
-static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
-{
-	return -EINVAL;
-}
-
-static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
-{
-	return false;
-}
-
-#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
-
 /**
  * gpiochip_irq_map() - maps an IRQ into a GPIO irqchip
  * @d: the irqdomain used by this irqchip
@@ -1503,7 +1487,6 @@ static int gpiochip_to_irq(struct gpio_c
 	if (!gpiochip_irqchip_irq_valid(gc, offset))
 		return -ENXIO;
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (irq_domain_is_hierarchy(domain)) {
 		struct irq_fwspec spec;
 
@@ -1514,7 +1497,6 @@ static int gpiochip_to_irq(struct gpio_c
 
 		return irq_create_fwspec_mapping(&spec);
 	}
-#endif
 
 	return irq_create_mapping(domain, offset);
 }
diff -- a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -68,7 +68,6 @@ struct gpio_irq_chip {
 	 */
 	const struct irq_domain_ops *domain_ops;
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @fwnode:
 	 *
@@ -144,7 +143,6 @@ struct gpio_irq_chip {
 	 * supply their own translate function.
 	 */
 	struct irq_domain_ops child_irq_domain_ops;
-#endif
 
 	/**
 	 * @handler:
@@ -645,8 +643,6 @@ struct bgpio_pdata {
 	int ngpio;
 };
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-
 int gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
 					    union gpio_irq_fwspec *gfwspec,
 					    unsigned int parent_hwirq,
@@ -656,8 +652,6 @@ int gpiochip_populate_parent_fwspec_four
 					     unsigned int parent_hwirq,
 					     unsigned int parent_type);
 
-#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
-
 int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	       unsigned long sz, void __iomem *dat, void __iomem *set,
 	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
diff -- a/include/linux/irq.h b/include/linux/irq.h
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -183,9 +183,7 @@ struct irq_data {
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_data		*parent_data;
-#endif
 	void			*chip_data;
 };
 
@@ -671,7 +669,7 @@ extern void handle_percpu_devid_fasteoi_
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
 extern int irq_chip_pm_put(struct irq_data *data);
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+
 extern void handle_fasteoi_ack_irq(struct irq_desc *desc);
 extern void handle_fasteoi_mask_irq(struct irq_desc *desc);
 extern int irq_chip_set_parent_state(struct irq_data *data,
@@ -697,7 +695,6 @@ extern int irq_chip_set_vcpu_affinity_pa
 extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
 extern int irq_chip_request_resources_parent(struct irq_data *data);
 extern void irq_chip_release_resources_parent(struct irq_data *data);
-#endif
 
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
diff -- a/kernel/irq/chip.c b/kernel/irq/chip.c
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -977,7 +977,7 @@ __irq_do_set_handler(struct irq_desc *de
 		handle = handle_bad_irq;
 	} else {
 		struct irq_data *irq_data = &desc->irq_data;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+
 		/*
 		 * With hierarchical domains we might run into a
 		 * situation where the outermost chip is not yet set
@@ -998,7 +998,6 @@ __irq_do_set_handler(struct irq_desc *de
 			/* Try the parent */
 			irq_data = irq_data->parent_data;
 		}
-#endif
 		if (WARN_ON(!irq_data || irq_data->chip == &no_irq_chip))
 			return;
 	}
@@ -1184,8 +1183,6 @@ void irq_cpu_offline(void)
 }
 #endif
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-
 #ifdef CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS
 /**
  *	handle_fasteoi_ack_irq - irq handler for edge hierarchy
@@ -1534,7 +1531,6 @@ void irq_chip_release_resources_parent(s
 		data->chip->irq_release_resources(data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
-#endif
 
 /**
  * irq_chip_compose_msi_msg - Compose msi message for a irq chip
diff -- a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -89,12 +89,10 @@ irq_debug_show_data(struct seq_file *m,
 	irq_debug_show_chip(m, data, ind + 1);
 	if (data->domain && data->domain->ops && data->domain->ops->debug_show)
 		data->domain->ops->debug_show(m, NULL, data, ind + 1);
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (!data->parent_data)
 		return;
 	seq_printf(m, "%*sparent:\n", ind + 1, "");
 	irq_debug_show_data(m, data->parent_data, ind + 4);
-#endif
 }
 
 static const struct irq_bit_descr irqdata_states[] = {
diff -- a/kernel/irq/internals.h b/kernel/irq/internals.h
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -465,7 +465,7 @@ static inline bool handle_enforce_irqctx
 }
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
-#if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
+#if !defined(CONFIG_IRQ_DOMAIN)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)
 {
 	irqd_set_activated(data);
@@ -479,11 +479,7 @@ static inline void irq_domain_deactivate
 
 static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
 {
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	return irqd->parent_data;
-#else
-	return NULL;
-#endif
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
diff -- a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -763,10 +763,8 @@ static int irq_domain_translate(struct i
 				struct irq_fwspec *fwspec,
 				irq_hw_number_t *hwirq, unsigned int *type)
 {
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (d->ops->translate)
 		return d->ops->translate(d, fwspec, hwirq, type);
-#endif
 	if (d->ops->xlate)
 		return d->ops->xlate(d, to_of_node(fwspec->fwnode),
 				     fwspec->param, fwspec->param_count,
@@ -1116,7 +1114,6 @@ void irq_domain_reset_irq_data(struct ir
 }
 EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
  * @parent:	Parent irq domain to associate with the new domain
@@ -1866,53 +1863,6 @@ static void irq_domain_check_hierarchy(s
 	if (domain->ops->alloc)
 		domain->flags |= IRQ_DOMAIN_FLAG_HIERARCHY;
 }
-#else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
-/**
- * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
- * @domain:	domain to match
- * @virq:	IRQ number to get irq_data
- */
-struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
-					 unsigned int virq)
-{
-	struct irq_data *irq_data = irq_get_irq_data(virq);
-
-	return (irq_data && irq_data->domain == domain) ? irq_data : NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
-
-/**
- * irq_domain_set_info - Set the complete data for a @virq in @domain
- * @domain:		Interrupt domain to match
- * @virq:		IRQ number
- * @hwirq:		The hardware interrupt number
- * @chip:		The associated interrupt chip
- * @chip_data:		The associated interrupt chip data
- * @handler:		The interrupt flow handler
- * @handler_data:	The interrupt flow handler data
- * @handler_name:	The interrupt handler name
- */
-void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq, const struct irq_chip *chip,
-			 void *chip_data, irq_flow_handler_t handler,
-			 void *handler_data, const char *handler_name)
-{
-	irq_set_chip_and_handler_name(virq, chip, handler, handler_name);
-	irq_set_chip_data(virq, chip_data);
-	irq_set_handler_data(virq, handler_data);
-}
-
-static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_base,
-					unsigned int nr_irqs, int node, void *arg,
-					bool realloc, const struct irq_affinity_desc *affinity)
-{
-	return -EINVAL;
-}
-
-static void irq_domain_check_hierarchy(struct irq_domain *domain)
-{
-}
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 static struct dentry *domain_dir;
@@ -1926,12 +1876,10 @@ irq_domain_debug_show_one(struct seq_fil
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
 	if (d->ops && d->ops->debug_show)
 		d->ops->debug_show(m, d, NULL, ind + 1);
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (!d->parent)
 		return;
 	seq_printf(m, "%*sparent: %s\n", ind + 1, "", d->parent->name);
 	irq_domain_debug_show_one(m, d->parent, ind + 4);
-#endif
 }
 
 static int irq_domain_debug_show(struct seq_file *m, void *p)
diff -- a/kernel/irq/manage.c b/kernel/irq/manage.c
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -334,8 +334,7 @@ static bool irq_set_affinity_deactivated
 	 * driver has to make sure anyway that the interrupt is in a
 	 * usable state so startup works.
 	 */
-	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
-	    irqd_is_activated(data) || !irqd_affinity_on_activate(data))
+	if (irqd_is_activated(data) || !irqd_affinity_on_activate(data))
 		return false;
 
 	cpumask_copy(desc->irq_common_data.affinity, mask);
@@ -663,11 +662,7 @@ int irq_set_vcpu_affinity(unsigned int i
 		chip = irq_data_get_irq_chip(data);
 		if (chip && chip->irq_set_vcpu_affinity)
 			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 		data = data->parent_data;
-#else
-		data = NULL;
-#endif
 	} while (data);
 
 	if (data)
@@ -1418,11 +1413,10 @@ static bool irq_supports_nmi(struct irq_
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/* Only IRQs directly managed by the root irqchip can be set as NMI */
 	if (d->parent_data)
 		return false;
-#endif
+
 	/* Don't support NMIs for chips behind a slow bus */
 	if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
 		return false;
@@ -2801,11 +2795,7 @@ int __irq_get_irqchip_state(struct irq_d
 			return -ENODEV;
 		if (chip->irq_get_irqchip_state)
 			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 		data = data->parent_data;
-#else
-		data = NULL;
-#endif
 	} while (data);
 
 	if (data)
@@ -2882,11 +2872,7 @@ int irq_set_irqchip_state(unsigned int i
 		}
 		if (chip->irq_set_irqchip_state)
 			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 		data = data->parent_data;
-#else
-		data = NULL;
-#endif
 	} while (data);
 
 	if (data)
diff -- a/kernel/irq/migration.c b/kernel/irq/migration.c
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -95,11 +95,7 @@ void __irq_move_irq(struct irq_data *ida
 {
 	bool masked;
 
-	/*
-	 * Get top level irq_data when CONFIG_IRQ_DOMAIN_HIERARCHY is enabled,
-	 * and it should be optimized away when CONFIG_IRQ_DOMAIN_HIERARCHY is
-	 * disabled. So we avoid an "#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY" here.
-	 */
+	/* Get top level irq_data */
 	idata = irq_desc_get_irq_data(irq_data_to_desc(idata));
 
 	if (unlikely(irqd_irq_disabled(idata)))
diff -- a/kernel/irq/resend.c b/kernel/irq/resend.c
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -91,11 +91,7 @@ static int try_retrigger(struct irq_desc
 	if (desc->irq_data.chip->irq_retrigger)
 		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
 
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	return irq_chip_retrigger_hierarchy(&desc->irq_data);
-#else
-	return 0;
-#endif
 }
 
 /*
diff -- a/include/linux/irqdomain.h b/include/linux/irqdomain.h
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -95,7 +95,6 @@ struct irq_domain_ops {
 	int (*xlate)(struct irq_domain *d, struct device_node *node,
 		     const u32 *intspec, unsigned int intsize,
 		     unsigned long *out_hwirq, unsigned int *out_type);
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	/* extended V2 interfaces to support hierarchy irq_domains */
 	int (*alloc)(struct irq_domain *d, unsigned int virq,
 		     unsigned int nr_irqs, void *arg);
@@ -105,7 +104,6 @@ struct irq_domain_ops {
 	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
 	int (*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
 			 unsigned long *out_hwirq, unsigned int *out_type);
-#endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	void (*debug_show)(struct seq_file *m, struct irq_domain *d,
 			   struct irq_data *irqd, int ind);
@@ -163,9 +161,7 @@ struct irq_domain {
 	struct irq_domain_chip_generic	*gc;
 	struct device			*dev;
 	struct device			*pm_dev;
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
-#endif
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
@@ -228,16 +224,23 @@ static inline void irq_domain_set_pm_dev
 		d->pm_dev = dev;
 }
 
-#ifdef CONFIG_IRQ_DOMAIN
-struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, phys_addr_t *pa);
-
 enum {
 	IRQCHIP_FWNODE_REAL,
 	IRQCHIP_FWNODE_NAMED,
 	IRQCHIP_FWNODE_NAMED_ID,
 };
 
+extern const struct fwnode_operations irqchip_fwnode_ops;
+
+static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
+}
+
+#ifdef CONFIG_IRQ_DOMAIN
+struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
+						const char *name, phys_addr_t *pa);
+
 static inline
 struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
 {
@@ -291,13 +294,6 @@ static inline struct fwnode_handle *of_n
 	return node ? &node->fwnode : NULL;
 }
 
-extern const struct fwnode_operations irqchip_fwnode_ops;
-
-static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
-{
-	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
-}
-
 extern void irq_domain_update_bus_token(struct irq_domain *domain,
 					enum irq_domain_bus_token bus_token);
 
@@ -475,7 +471,6 @@ extern void irq_domain_set_info(struct i
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
 			struct fwnode_handle *fwnode,
@@ -572,7 +567,7 @@ static inline bool irq_domain_is_msi_dev
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
-#else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
+#else /* CONFIG_IRQ_DOMAIN */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
@@ -617,15 +612,116 @@ static inline bool irq_domain_is_msi_dev
 	return false;
 }
 
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
-
-#else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
+
 static inline struct irq_domain *irq_find_matching_fwnode(
 	struct fwnode_handle *fwnode, enum irq_domain_bus_token bus_token)
 {
 	return NULL;
 }
+
+static inline void irq_set_default_host(struct irq_domain *host) { }
+
+static inline void irq_domain_associate_many(struct irq_domain *domain,
+				      unsigned int irq_base,
+				      irq_hw_number_t hwirq_base, int count)
+{ }
+
+static inline
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data)
+{
+	return NULL;
+}
+
+static inline unsigned int irq_find_mapping(struct irq_domain *domain,
+					    irq_hw_number_t hwirq)
+{
+	return 0;
+}
+
+static inline int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
+					unsigned int irq_base,
+					unsigned int nr_irqs, void *arg)
+{
+	return -ENOSYS;
+}
+
+static inline void irq_domain_free_irqs_top(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs)
+{ }
+
+static inline int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
+					 unsigned int virq,
+					 irq_hw_number_t hwirq,
+					 const struct irq_chip *chip,
+					 void *chip_data)
+{
+	return 0; // or -ENOENT ?
+}
+
+static inline void irq_domain_update_bus_token(struct irq_domain *domain,
+					enum irq_domain_bus_token bus_token)
+{ }
+
+static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
+			unsigned int flags, unsigned int size,
+			struct fwnode_handle *fwnode,
+			const struct irq_domain_ops *ops, void *host_data)
+{
+	return NULL;
+}
+
+static inline void irq_domain_remove(struct irq_domain *host) { }
+
+static inline void irq_domain_free_irqs_common(struct irq_domain *domain,
+					unsigned int virq,
+					unsigned int nr_irqs)
+{ }
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
+{
+	return NULL;
+}
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
+{
+	return NULL;
+}
+
+static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
+{
+	return NULL;
+}
+
+static inline void irq_domain_free_fwnode(struct fwnode_handle *fwnode) { }
+
+static inline int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
+					   unsigned int irq_base,
+					   unsigned int nr_irqs, void *arg)
+{
+	return -ENOSYS;
+}
+
+static inline struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
+						unsigned int virq)
+{
+	return NULL;
+}
+
+static inline int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+				   unsigned int nr_irqs, int node, void *arg,
+				   bool realloc,
+				   const struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
 #endif /* !CONFIG_IRQ_DOMAIN */
 
 #endif /* _LINUX_IRQDOMAIN_H */
