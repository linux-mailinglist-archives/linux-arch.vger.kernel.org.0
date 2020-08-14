Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF09244F9B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHNVse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25018 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHNVsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441713; x=1628977713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0l8UMU0Nf80nnOcPq6fS4BA8LVPERcrIfgcS5BiLKhg=;
  b=dYHzppwKZRNTqari1W/+UMbO1/OuYaJ5tqoDuJlAlNhGU+ivBs6Lx1E3
   gj5/6jmerslw6dx1BQeOSLaPoZwFSG24rraiDo8WwANP+f08mUYrgilOr
   I1LW707eXGiRzYX39GKQX/Js7eqlxUAe/poaJy3Ogaqf3qoin9Qw9YbV4
   k24ktGJtypItrvhYx5zEt76ltXGbVWv/pTNneeeYwp6XbsMAVkn7PrghT
   ieOdp7PxtD+T97DJQFeo9LcXtmxngvd3aii7C2Df0uVksO4Wre+kpCoPG
   d60jt0TYgLYA/PVhibwXKuiOZaSU5Z1IfXzVMtdLPW5oIgYDl+6hm1//8
   Q==;
IronPort-SDR: VwYyg6F1ke1Py5joIZ+lZDC5Y2pDV90V3saqeMvOvHBO4lF11omuG7WKZt3Yr/np+r3HcNqCUd
 D/ZYxrBwXAWE0vORUGhcm6VgTrttfP3el03PuLX1F3WUACFAhb9LYQMAE1Y0BE1QOP9QO1Iynj
 hkvMgPoBCIfxOWoTEZXquFqiuvGFppH9qSm2tldXEep6lqYxgs5jPm1GZBOvBCiVayIP5Uq38p
 FazsOmhjkH83DLJOCLKuma6IEVU4MdEgQlHHvZkCsp2PqFvH8r471HhsVAHuVfOGredPsIVRRU
 Ct8=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217649"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:31 +0800
IronPort-SDR: qpMXf9ctH+Z+c+fDGINFi55bB0pVWl41a3DJ4yGioPw0WYslR0uBVXF8QhVq6c+2XZMI0FL+zU
 8ot+CJW2r57Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:36 -0700
IronPort-SDR: GdemDOqwgj4kCAjq3L57gKGOb0BWT3gQzwEH1J+zYbKEVIRvsWAvkgfPVY9GgvZMY4uY0At5b4
 uSyUDwfD8Rkg==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC/RFT PATCH 3/6] arm64, numa: Move pcibus_to_node definition to generic numa code
Date:   Fri, 14 Aug 2020 14:47:22 -0700
Message-Id: <20200814214725.28818-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200814214725.28818-1-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

pcibus_to_node is used only when numa is enabled and does not depend
on ISA. Thus, it can be moved the generic numa implementation.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm64/kernel/pci.c  | 10 ----------
 drivers/base/arch_numa.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..07c122946c11 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -54,16 +54,6 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 	return b->ops->write(b, devfn, reg, len, val);
 }
 
-#ifdef CONFIG_NUMA
-
-int pcibus_to_node(struct pci_bus *bus)
-{
-	return dev_to_node(&bus->dev);
-}
-EXPORT_SYMBOL(pcibus_to_node);
-
-#endif
-
 #ifdef CONFIG_ACPI
 
 struct acpi_pci_generic_root_info {
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 83341c807240..4ab1b20a615d 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/memblock.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/of.h>
 
 #ifdef CONFIG_ARM64
@@ -60,6 +61,16 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif
 
+#ifdef CONFIG_PCI
+
+int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+EXPORT_SYMBOL(pcibus_to_node);
+
+#endif
+
 static void numa_update_cpu(unsigned int cpu, bool remove)
 {
 	int nid = cpu_to_node(cpu);
-- 
2.24.0

