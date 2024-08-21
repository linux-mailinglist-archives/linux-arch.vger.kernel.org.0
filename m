Return-Path: <linux-arch+bounces-6426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0095A2AE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B060C1C20863
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72714F135;
	Wed, 21 Aug 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WFrLkvr/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298E14EC40;
	Wed, 21 Aug 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257280; cv=none; b=hIzTLQaXS2LXc9YAPTbSl7+u9ZfdKAL3lnVmLdLsvnbPdfkEdTBAActubSF7gnDqhU98/sepQwuuIo5f6kUsZJC+mpwJeR9LN/ccd1+CJyMhLQFd+L5b/vvCRw5TI3qpVH5HQaCA6GPPkfMP1qMIruwk9JiFduPXQFOZ6rPioMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257280; c=relaxed/simple;
	bh=WSNTxvENkaUwv/MtlmKHPomyHr3M30QWfBgUd9jcdU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cx0uLIk6sxfKhFDmWkqdGkArPI2+EQJnlTmzjaS391EpsT3a6ugAe4M5AD+91R8TMNMec+hK+2gfQwv4S0ntywXZM4TFTswshP47TwjKufj/Wdi/Qy3d9q+qNmC8lUF5pcjsnEz3ZYx7waW76B31im+rnvrsnZNySP4IWmv04HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WFrLkvr/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724257233; x=1724862033; i=wahrenst@gmx.net;
	bh=hcMKEKCvj3yhhpqzvY8lldRWJ18yX/9Hs46prU2gu98=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WFrLkvr/+l2+A+WLbk6Xi7kPeK8weJZhCuiq8Eq4JIpC6EMe3gDng4OkDzrswQOo
	 qARoFNVCIO1/Lr3qiq0J4uZI/A3q4jd5KptCD2xZ7fy87c8YzeNq9llZw84AYGh5b
	 wfqP0ReFcQ5WJeMmfzr7eVTXCgPMzGDMz6iwlFMvfE8Hb5cCHGBxbVXp6hgbPuveG
	 DiFgf7UC2EvbPT+OCGV4GUkpmbXj/bi7WbT0PlRYhHC/9ALpZhVRqnXX5b/GsnGC4
	 ZlyyhEUnYl6kLuUTQhvbZlHJ5NDmu8fORYeF5NkapxkXIdX3/6Tw2cNNCoCsRPVXg
	 xP9UHuUiB/tklvRY/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1sFU4y403A-00iQ6h; Wed, 21
 Aug 2024 18:20:33 +0200
Message-ID: <98c570cb-c2ca-4816-9ca4-94033f7fb3fb@gmx.net>
Date: Wed, 21 Aug 2024 18:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A+26Y6OIDgsuPusfh5SgyURT4mRJKf49noWvY0l48TREQz8uusn
 U2AYfsBrAOWkSTbKchcltG11FhaM2JYj1qGHqGQ3b/s+MAI2FgGYksdDZMGUgW6aUbFI47/
 qO1mb6mEMjc9KBCwLCv+uUQjgQ1ab1iyBC/u8vx0PnIUK92juhme9yTS+s8VqgEX8gRdfY6
 pyUX7w48K+qHfoR7eBZ2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CGTAmXXvkmE=;csipc15JN1oFPyVZgW7dQls7Mkt
 Rdd6x4xWeoVhf7E/fOZl0wybZj1tGfbU3/vRaOXmaQerBQg+eU49R4sYUAuQ/q39C92Y+ppqG
 DVnrPGR3xZQAdh8w0No6RKI3lTTabD+hmCNjM2nn325JouRzdzU2ePVn49LiL9YHJ4eWjAtdG
 F5UIW1756TKbFGc4TBpv7o65cP9AkWBMxmaFn6Ph3zMiz44OO26+NJuF5i5cvJIMwzIXVdyBG
 RCy1v5LZUhhcJC2TEJTO/EgGmyJ50s1m4Q7dn849+o1RLpxOWBuTEIgPGIP0XRDv4lQ7YoCSQ
 bUjNRcZKwX4oUeiAGESZU59L7KI7WPg7xnpkPPpfBFqYjrjN/ygS3mjG839rBYa22fHTKP0er
 YVISpeceUkDoDtMvaSjg5Yd3jNsE3YX3cTgKgDTb5uYpK6nYdsQig3JG3OpChi5idXh0iLgc3
 uybSlg3kJLn1taYwBzLINx5XWzxhLzh0NOoz5WwM+nX+awRzqbII8MWuUv5D1VsZkch/RUnYr
 L6kXYC2/RpeslWio3aKnqfTNuFdlR9ONKTuZS4LDOIps1MtVQcVB9f0DkZZamiR0YQ2s2E//G
 cnszR6e/mA6C9TO4sFAXke/loZfmI/wn3TuJ14rVUK5/gv8cKTYJ4vlg5JJGotDfEPJtiIw3l
 ggfW/B1W9RSeRGmbu3wPq82jnspSfgpU/Aq87DAN/XoLBQw5wh6la1FUYlb0xwQlnwZR44yjH
 zhW3hI6yMdgavOoCHrCp6vsDu59JYgEg/VhY+Fuydl/+6MPRA1i4aT4OzSZ0TVgYL4pZeFyz9
 K40P+YN2yOVHw4JrAJ4jhjCA==

Hi Andrea,

Am 20.08.24 um 16:36 schrieb Andrea della Porta:
> The RaspberryPi RP1 is ia PCI multi function device containing
> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.
sorry, i cannot provide you a code review, but just some comments. multi
function device suggests "mfd" subsystem or at least "soc" . I won't
recommend misc driver here.
> Implement a bare minimum driver to operate the RP1, leveraging
> actual OF based driver implementations for the on-borad peripherals
> by loading a devicetree overlay during driver probe.
Can you please explain why this should be a DT overlay? The RP1 is
assembled on the Raspberry Pi 5 PCB. DT overlays are typically for loose
connections like displays or HATs. I think a DTSI just for the RP1 would
fit better and is easier to read.
> The peripherals are accessed by mapping MMIO registers starting
> from PCI BAR1 region.
> As a minimum driver, the peripherals will not be added to the
> dtbo here, but in following patches.
>
> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   MAINTAINERS                           |   2 +
>   arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
>   drivers/misc/Kconfig                  |   1 +
>   drivers/misc/Makefile                 |   1 +
>   drivers/misc/rp1/Kconfig              |  20 ++
>   drivers/misc/rp1/Makefile             |   3 +
>   drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
>   drivers/misc/rp1/rp1-pci.dtso         |   8 +
>   drivers/pci/quirks.c                  |   1 +
>   include/linux/pci_ids.h               |   3 +
>   10 files changed, 524 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>   create mode 100644 drivers/misc/rp1/Kconfig
>   create mode 100644 drivers/misc/rp1/Makefile
>   create mode 100644 drivers/misc/rp1/rp1-pci.c
>   create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>
...
> +
> +				rp1_clocks: clocks@c040018000 {
> +					compatible =3D "raspberrypi,rp1-clocks";
> +					#clock-cells =3D <1>;
> +					reg =3D <0xc0 0x40018000 0x0 0x10038>;
> +					clocks =3D <&clk_xosc>;
> +					clock-names =3D "xosc";
> +
> +					assigned-clocks =3D <&rp1_clocks RP1_PLL_SYS_CORE>,
> +							  <&rp1_clocks RP1_PLL_AUDIO_CORE>,
> +							  // RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI =
drivers
> +							  <&rp1_clocks RP1_PLL_SYS>,
> +							  <&rp1_clocks RP1_PLL_SYS_SEC>,
> +							  <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
> +							  <&rp1_clocks RP1_CLK_ETH_TSU>;
> +
> +					assigned-clock-rates =3D <1000000000>, // RP1_PLL_SYS_CORE
> +							       <1536000000>, // RP1_PLL_AUDIO_CORE
> +							       <200000000>,  // RP1_PLL_SYS
> +							       <125000000>,  // RP1_PLL_SYS_SEC
> +							       <100000000>,  // RP1_PLL_SYS_PRI_PH
> +							       <50000000>;   // RP1_CLK_ETH_TSU
> +				};
> +
> +				rp1_gpio: pinctrl@c0400d0000 {
> +					reg =3D <0xc0 0x400d0000  0x0 0xc000>,
> +					      <0xc0 0x400e0000  0x0 0xc000>,
> +					      <0xc0 0x400f0000  0x0 0xc000>;
> +					compatible =3D "raspberrypi,rp1-gpio";
> +					gpio-controller;
> +					#gpio-cells =3D <2>;
> +					interrupt-controller;
> +					#interrupt-cells =3D <2>;
> +					interrupts =3D <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
> +						     <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
> +						     <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
> +					gpio-line-names =3D
> +						"ID_SDA", // GPIO0
> +						"ID_SCL", // GPIO1
> +						"GPIO2", // GPIO2
> +						"GPIO3", // GPIO3
> +						"GPIO4", // GPIO4
> +						"GPIO5", // GPIO5
> +						"GPIO6", // GPIO6
> +						"GPIO7", // GPIO7
> +						"GPIO8", // GPIO8
> +						"GPIO9", // GPIO9
> +						"GPIO10", // GPIO10
> +						"GPIO11", // GPIO11
> +						"GPIO12", // GPIO12
> +						"GPIO13", // GPIO13
> +						"GPIO14", // GPIO14
> +						"GPIO15", // GPIO15
> +						"GPIO16", // GPIO16
> +						"GPIO17", // GPIO17
> +						"GPIO18", // GPIO18
> +						"GPIO19", // GPIO19
> +						"GPIO20", // GPIO20
> +						"GPIO21", // GPIO21
> +						"GPIO22", // GPIO22
> +						"GPIO23", // GPIO23
> +						"GPIO24", // GPIO24
> +						"GPIO25", // GPIO25
> +						"GPIO26", // GPIO26
> +						"GPIO27", // GPIO27
> +						"PCIE_RP1_WAKE", // GPIO28
> +						"FAN_TACH", // GPIO29
> +						"HOST_SDA", // GPIO30
> +						"HOST_SCL", // GPIO31
> +						"ETH_RST_N", // GPIO32
> +						"", // GPIO33
> +						"CD0_IO0_MICCLK", // GPIO34
> +						"CD0_IO0_MICDAT0", // GPIO35
> +						"RP1_PCIE_CLKREQ_N", // GPIO36
> +						"", // GPIO37
> +						"CD0_SDA", // GPIO38
> +						"CD0_SCL", // GPIO39
> +						"CD1_SDA", // GPIO40
> +						"CD1_SCL", // GPIO41
> +						"USB_VBUS_EN", // GPIO42
> +						"USB_OC_N", // GPIO43
> +						"RP1_STAT_LED", // GPIO44
> +						"FAN_PWM", // GPIO45
> +						"CD1_IO0_MICCLK", // GPIO46
> +						"2712_WAKE", // GPIO47
> +						"CD1_IO1_MICDAT1", // GPIO48
> +						"EN_MAX_USB_CUR", // GPIO49
> +						"", // GPIO50
> +						"", // GPIO51
> +						"", // GPIO52
> +						""; // GPIO53
GPIO line names are board specific, so this should go to the Raspberry
Pi 5 file.
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41c3d2821a78..02405209e6c4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -618,4 +618,5 @@ source "drivers/misc/uacce/Kconfig"
>   source "drivers/misc/pvpanic/Kconfig"
>   source "drivers/misc/mchp_pci1xxxx/Kconfig"
>   source "drivers/misc/keba/Kconfig"
> +source "drivers/misc/rp1/Kconfig"
>   endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c2f990862d2b..84bfa866fbee 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -71,3 +71,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
>   obj-$(CONFIG_NSM)		+=3D nsm.o
>   obj-$(CONFIG_MARVELL_CN10K_DPI)	+=3D mrvl_cn10k_dpi.o
>   obj-y				+=3D keba/
> +obj-$(CONFIG_MISC_RP1)		+=3D rp1/
> diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
> new file mode 100644
> index 000000000000..050417ee09ae
> --- /dev/null
> +++ b/drivers/misc/rp1/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RaspberryPi RP1 misc device
> +#
> +
> +config MISC_RP1
> +        tristate "RaspberryPi RP1 PCIe support"
> +        depends on PCI && PCI_QUIRKS
> +        select OF
> +        select OF_OVERLAY
> +        select IRQ_DOMAIN
> +        select PCI_DYNAMIC_OF_NODES
> +        help
> +          Support for the RP1 peripheral chip found on Raspberry Pi 5 b=
oard.
> +          This device supports several sub-devices including e.g. Ether=
net controller,
> +          USB controller, I2C, SPI and UART.
> +          The driver is responsible for enabling the DT node once the P=
CIe endpoint
> +          has been configured, and handling interrupts.
> +          This driver uses an overlay to load other drivers to support =
for RP1
> +          internal sub-devices.
> diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> new file mode 100644
> index 000000000000..e83854b4ed2c
> --- /dev/null
> +++ b/drivers/misc/rp1/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +rp1-pci-objs			:=3D rp1-pci.o rp1-pci.dtbo.o
> +obj-$(CONFIG_MISC_RP1)		+=3D rp1-pci.o
> diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
> new file mode 100644
> index 000000000000..a6093ba7e19a
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1-pci.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-22 Raspberry Pi Ltd.
> + * All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include <dt-bindings/misc/rp1.h>
> +
> +#define RP1_B0_CHIP_ID		0x10001927
> +#define RP1_C0_CHIP_ID		0x20001927
> +
> +#define RP1_PLATFORM_ASIC	BIT(1)
> +#define RP1_PLATFORM_FPGA	BIT(0)
> +
> +#define RP1_DRIVER_NAME		"rp1"
> +
> +#define RP1_ACTUAL_IRQS		RP1_INT_END
> +#define RP1_IRQS		RP1_ACTUAL_IRQS
> +#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
> +
> +#define RP1_SYSCLK_RATE		200000000
> +#define RP1_SYSCLK_FPGA_RATE	60000000
> +
> +enum {
> +	SYSINFO_CHIP_ID_OFFSET	=3D 0,
> +	SYSINFO_PLATFORM_OFFSET	=3D 4,
> +};
> +
> +#define REG_SET			0x800
> +#define REG_CLR			0xc00
> +
> +/* MSIX CFG registers start at 0x8 */
> +#define MSIX_CFG(x) (0x8 + (4 * (x)))
> +
> +#define MSIX_CFG_IACK_EN        BIT(3)
> +#define MSIX_CFG_IACK           BIT(2)
> +#define MSIX_CFG_TEST           BIT(1)
> +#define MSIX_CFG_ENABLE         BIT(0)
> +
> +#define INTSTATL		0x108
> +#define INTSTATH		0x10c
> +
> +extern char __dtbo_rp1_pci_begin[];
> +extern char __dtbo_rp1_pci_end[];
> +
> +struct rp1_dev {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	struct clk *sys_clk;
> +	struct irq_domain *domain;
> +	struct irq_data *pcie_irqds[64];
> +	void __iomem *bar1;
> +	int ovcs_id;
> +	bool level_triggered_irq[RP1_ACTUAL_IRQS];
> +};
> +
> +
...
> +
> +static const struct pci_device_id dev_id_table[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0), },
> +	{ 0, }
> +};
> +
> +static struct pci_driver rp1_driver =3D {
> +	.name		=3D RP1_DRIVER_NAME,
> +	.id_table	=3D dev_id_table,
> +	.probe		=3D rp1_probe,
> +	.remove		=3D rp1_remove,
> +};
> +
> +module_pci_driver(rp1_driver);
> +
> +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
Module author & Copyright doesn't seem to match with this patch author.
Please clarify/fix

