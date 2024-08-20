Return-Path: <linux-arch+bounces-6369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8095897E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135681C211B0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198A191F73;
	Tue, 20 Aug 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KKXDE6+V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF10155C80
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164576; cv=none; b=Q8khbPBehzRHVqMWQExOoNusl+RDdYVXA7w52RmmqoJAIXTiDVPjezNJu7RbVhBhmaTi/95GKKcXsZFFxi9UfdFqlgLvJ9fr8qg4A+dzQSxA5G4J0y+5hJApZWfhbzGwl+BtukjXOQ7fz437WH0EcX3gAgs+QrJJ09mKz20cMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164576; c=relaxed/simple;
	bh=nbes6SGqdEbR+eyIYqDvar9JyRtfpfTelp/Kn/mm0qE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E1XTuqBr2p3MwxE7GZBa/z+3y1wW2UolhD0/uU6NxYhMSIylE0C138F9fcCFnaPnoHZPzIeZId9da/9y/oN7/l0KJR/qwbgZQrV5cETdNSUjSwLGqb8M4Bosupy+hwEzDNu79IKSzvjhToNN72D5ZL0hxg3lKQ+eVc4lBhlWbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KKXDE6+V; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-52efdf02d13so7406980e87.2
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164572; x=1724769372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfyTQeSSkPZ+QzWWZU+FNyyT4+itZMzr8DmOygd/33U=;
        b=KKXDE6+VlWxMwU68/tuVqlu9RQlRNHMaF6Z34J4PJ43FtC60HeUzBrXTUP7Q4DIfeS
         PWxXfLORCxZm0LrljfFDH5dyMGxyQTOL/SVSxyfYROYqimYM7f4F1eWtgXa3Fbiaxelw
         8Y40wOmM+3QUMM5gVacy+l5unwQ5urO4uvVAniDP81If5tIfVU00Fw+X6GDF2nxALs4O
         9c15gcz4VvGTG+a8mv3n2xTM73n9H0v73rwnNhKVZB+gE1snnUKU6iEtX3A8y5Ujenxj
         zgdWfDihJHN8JpMj/C3S8WhSZ99tTeJcP/ry6D4+0WIb4YdiGbG1JdCnDK6TWgtahFyz
         ecAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164572; x=1724769372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfyTQeSSkPZ+QzWWZU+FNyyT4+itZMzr8DmOygd/33U=;
        b=OtOq/EdSfam6dxLgj8PbDO7rILiXBp6eq0rdeTgLq749YZQR1rHEw1xDyORtxFgqns
         RVCvycRACE4zXnDnbF2+eCbxWymovitrrKr6b5N05BnrdrF0efWXG/tkAYgJkb/utd2p
         QzNoAaeOucmJY8CAERkvrB/8Ssx2StrAKYyjgIEbBBoT/e1gT8uOC2mZd6KjUWf28bDi
         Ko4dpIOU8F3svNr46LXaFTv/w7E7zGHhroHAbecvMKhCVxR3yrt/pN0roHw6NU4jGYsc
         IN2h9yb9ko+QaIkSfSb16EvpyHwmxkC/xy+j38q46izaECRpVX3Br0+0qWEAonjHTg/2
         b7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXMHXKoxjefU/GGmJfK6Yb+rqs6tsrjXU9TJUoNhi3AK8agQoEkJ0+U1uGQo4Y1CInkFo1be7TmCwDA8u+2zTybwYZmuyIH2r7uQA==
X-Gm-Message-State: AOJu0Yx8kqiZVCSj0fQpaVbxVaNlBhWQa8b2TuIjWannluSkWbPhsJFj
	1oWm0Y6IiEbeZ7jedT2GdZGAlAeJf5DzvymYisd7zBK9p6twpB5otpeDrFRdF5M=
X-Google-Smtp-Source: AGHT+IFLUQVFBJiZPnU1UIStc9VMSRLEpQuaGd1PxEKJ/fpKdzW6906wlGxbUZmW87C0ek7drDgHNg==
X-Received: by 2002:a05:6512:3b8b:b0:52e:fa5f:b6a7 with SMTP id 2adb3069b0e04-5331c6a0569mr10710062e87.13.1724164571458;
        Tue, 20 Aug 2024 07:36:11 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396940fsm772692466b.189.2024.08.20.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:11 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a DT overlay
Date: Tue, 20 Aug 2024 16:36:02 +0200
Message-ID: <cover.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, 
etc.) whose registers are all reachable starting from an offset from the
BAR address.  The main point here is that while the RP1 as an endpoint
itself is discoverable via usual PCI enumeraiton, the devices it contains
are not discoverable and must be declared e.g. via the devicetree.

This patchset is an attempt to provide a minimum infrastructure to allow
the RP1 chipset to be discovered and perpherals it contains to be added
from a devictree overlay loaded during RP1 PCI endpoint enumeration.
Followup patches should add support for the several peripherals contained
in RP1.

This work is based upon dowstream drivers code and the proposal from RH
et al. (see [1] and [2]). A similar approach is also pursued in [3].

The patches are ordered as follows:

-PATCHES 1 and 2: add binding schemas for clock and gpio peripherals 
 found in RP1. They are needed to support the other peripherals, e.g.
 the ethernet mac depends on a clock generated by RP1 and the phy is
 reset though the on-board gpio controller.

-PATCHES 3, 4 and 5: preparatory patches that fix the address mapping
 translation (especially wrt dma-ranges) and permit to place the dtbo
 binary blob to be put in non transient section.

-PATCH 6 and 7: add clock and gpio device drivers.

-PATCH 8: this is the main patch to support RP1 chipset and peripherals
 enabling through dtb overlay. It contains the dtso since its intimately
 coupled with the driver and will be linked in as binary blob in the driver
 obj, but of course it can be easily split in a separate patch if the
 maintainer feels it so. The real dtso is in devicetree folder while
 the dtso in driver folder is just a placeholder to include the real dtso.
 In this way it is possible to check the dtso against dt-bindings.

-PATCH 9: add the relevant kernel CONFIG_ options to defconfig.

-PATCHES 10 and 11: these (still unpolished) patches are not intended to
 be upstreamed (yet), they serve just as a test reference to be able to
 use the ethernet MAC contained in RP1.

This patchset is also a first attempt to be more agnostic wrt hardware
description standards such as OF devicetree and ACPI, where 'agnostic'
means "using DT in coexistence with ACPI", as been alredy promoted
by e.g. AL (see [4]). Although there's currently no evidence it will also
run out of the box on purely ACPI system, it is a first step towards
that direction.

Please note that albeit this patchset has no prerequisites in order to
be applied cleanly, it still depends on Stanimir's WIP patchset for BCM2712
PCIe controller (see [5]) in order to work at runtime.

Many thanks,
Andrea della Porta

Link:
- [1]: https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
- [2]: https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.org/t/
- [3]: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/#t
- [4]: https://lore.kernel.org/all/73e05c77-6d53-4aae-95ac-415456ff0ae4@lunn.ch/
- [5]: https://lore.kernel.org/all/20240626104544.14233-1-svarbanov@suse.de/

Andrea della Porta (11):
  dt-bindings: clock: Add RaspberryPi RP1 clock bindings
  dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
  PCI: of_property: Sanitize 32 bit PCI address parsed from DT
  of: address: Preserve the flags portion on 1:1 dma-ranges mapping
  vmlinux.lds.h: Preserve DTB sections from being discarded after init
  clk: rp1: Add support for clocks provided by RP1
  pinctrl: rp1: Implement RaspberryPi RP1 gpio support
  misc: rp1: RaspberryPi RP1 misc driver
  arm64: defconfig: Enable RP1 misc/clock/gpio drivers as built-in
  net: macb: Add support for RP1's MACB variant
  arm64: dts: rp1: Add support for MACB contained in RP1

 .../clock/raspberrypi,rp1-clocks.yaml         |   87 +
 .../pinctrl/raspberrypi,rp1-gpio.yaml         |  177 ++
 MAINTAINERS                                   |   12 +
 arch/arm64/boot/dts/broadcom/rp1.dtso         |  175 ++
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rp1.c                         | 1655 +++++++++++++++++
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/rp1/Kconfig                      |   20 +
 drivers/misc/rp1/Makefile                     |    3 +
 drivers/misc/rp1/rp1-pci.c                    |  333 ++++
 drivers/misc/rp1/rp1-pci.dtso                 |    8 +
 drivers/net/ethernet/cadence/macb.h           |   25 +
 drivers/net/ethernet/cadence/macb_main.c      |  152 +-
 drivers/of/address.c                          |    3 +-
 drivers/pci/of_property.c                     |    5 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pinctrl/Kconfig                       |   10 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-rp1.c                 |  719 +++++++
 include/asm-generic/vmlinux.lds.h             |    2 +-
 include/dt-bindings/clock/rp1.h               |   56 +
 include/dt-bindings/misc/rp1.h                |  235 +++
 include/linux/pci_ids.h                       |    3 +
 26 files changed, 3692 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 create mode 100644 drivers/clk/clk-rp1.c
 create mode 100644 drivers/misc/rp1/Kconfig
 create mode 100644 drivers/misc/rp1/Makefile
 create mode 100644 drivers/misc/rp1/rp1-pci.c
 create mode 100644 drivers/misc/rp1/rp1-pci.dtso
 create mode 100644 drivers/pinctrl/pinctrl-rp1.c
 create mode 100644 include/dt-bindings/clock/rp1.h
 create mode 100644 include/dt-bindings/misc/rp1.h

-- 
2.35.3


