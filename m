Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1B485935
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 20:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiAETdO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 14:33:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59718 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbiAETdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 14:33:13 -0500
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id 801E420B7179; Wed,  5 Jan 2022 11:33:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 801E420B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641411192;
        bh=Ds6qN9XWU7pzxnOlmUa+21pDMQsIdaGkMh8jEkjhJeM=;
        h=From:To:Cc:Subject:Date:From;
        b=jSiFFn6GYREfT5jZt0Z79vaGBNh7PDZ4I1nPYQ0RfAx31XQhK8zdZ2EqP2BsTk0cX
         IjZMsNRyw5PU4aHdXTzHdcxE+8Km7Rda0WB9czN8heqI5lyvuZ7vlt4TLX+VwrK3tn
         Itb6fMJppjUn/lzQauXBl6T1IhQe+rDTmspRnIEE=
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
Subject: [PATCH v8 0/2] PCI: hv: Hyper-V vPCI for arm64
Date:   Wed,  5 Jan 2022 11:32:34 -0800
Message-Id: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
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

changes in v6 -> v7:
 - Addressed feedback from Marc Zyngier about IRQ cleanup in the error path
   and explicitly setting the IRQ trigger type.
 - Address feedback from Bjorn Helgaas about subject line format.

changes in v7 -> v8:
 - Addressed feedback from Michael Kelley about the cpu mask to use for the
   initial interrupt affinity and IRQ cleanup in the error path.

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral by adding arch specific interfaces
  PCI: hv: Add arm64 Hyper-V vPCI support

 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 arch/x86/include/asm/hyperv-tlfs.h   |  33 +++
 arch/x86/include/asm/mshyperv.h      |   7 -
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  | 312 ++++++++++++++++++++++++---
 include/asm-generic/hyperv-tlfs.h    |  33 ---
 7 files changed, 331 insertions(+), 67 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.25.1


