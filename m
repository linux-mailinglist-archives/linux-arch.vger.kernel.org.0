Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966D455752
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbhKRIys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:54:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59820 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbhKRIyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:54:46 -0500
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id 9B13C20C63DD; Thu, 18 Nov 2021 00:51:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B13C20C63DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1637225506;
        bh=J9rOJ6jfJ1HltNYB2odhwK1CJrGxLwIZp7w3haTv62Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ad8O9sGRH3y0zJH5so0jJH1CP3UjGR68+cYMifTEHV5tPN5vfBnbZb95P0xdWkseS
         4R8v5P32lFz1+7+xvzy8km65zFGQTzzHxPt06LAVjzgjyxUV7MNNSAsgg9P3lZmaRO
         Tnyr5hTPFZPH3EkThdBQQxkMaGED/TJ9hF4sVImw=
From:   Sunil Muthuswamy <sunilmut@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v6 0/2] PCI: hv: Hyper-V vPCI for arm64
Date:   Thu, 18 Nov 2021 00:51:28 -0800
Message-Id: <1637225490-2213-1-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Current Hyper-V vPCI code only compiles and works for x86. There are some
hardcoded assumptions about the architectural IRQ chip and other arch
defines.

Add support for Hyper-V vPCI for arm64 by first breaking the current hard
coded dependency using a set of new interfaces and implementing those for
x86 first. That is in the first patch. The second patch adds support for
Hyper-V vPCI for arm64 by implementing the above mentioned interfaces. That
is done by introducing a Hyper-V vPCI specific MSI IRQ domain & chip for
allocating SPI vectors.

changes in v1 -> v2:
 - Moved the irqchip implementation to drivers/pci as suggested
   by Marc Zyngier
 - Addressed Multi-MSI handling issues identified by Marc Zyngier
 - Addressed lock/synchronization primitive as suggested by Marc
   Zyngier
 - Addressed other code feedback from Marc Zyngier

changes in v2 -> v3:
 - Addressed comments from Bjorn Helgaas about patch formatting and
   verbiage
 - Using 'git send-email' to ensure that the patch series is correctly
   threaded. Feedback by Bjorn Helgaas
 - Fixed Hyper-V vPCI build break for module build, reported by Boqun Feng

changes in v3 -> v4:
 - Removed the separate file for IRQ chip that was there in previous
   iterations and moved the IRQ chip implementation to pci-hyperv.c.
   Feedback by Michael Kelley and Marc Zyngier.
 - Addressed various comments from Marc Zyngier about structuring and
   layout.
 - Addressed comment from Marc Zyngier about IRQ affinity and other
   miscellaneous comments.

changes in v4 -> v5:
 - Fixed an issue with picking the right cpu for irq affinity, identified
   by Marc Zyngier.

changes in v5 -> v6:
 - Minor comment updates suggested by Michael Kelley.

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral by adding arch specific interfaces
  arm64: PCI: hv: Add support for Hyper-V vPCI

 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 arch/x86/include/asm/hyperv-tlfs.h   |  33 ++++
 arch/x86/include/asm/mshyperv.h      |   7 -
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  | 281 ++++++++++++++++++++++++---
 include/asm-generic/hyperv-tlfs.h    |  33 ----
 7 files changed, 300 insertions(+), 67 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.25.1


