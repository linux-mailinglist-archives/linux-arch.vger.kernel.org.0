Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD379EEC1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjIMQlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjIMQkk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:40:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53CC12722;
        Wed, 13 Sep 2023 09:39:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5359111FB;
        Wed, 13 Sep 2023 09:40:24 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585FC3F5A1;
        Wed, 13 Sep 2023 09:39:45 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code first?]
Date:   Wed, 13 Sep 2023 16:38:15 +0000
Message-Id: <20230913163823.7880-28-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the new flag field to the MADT's GICC structure.

'Online Capable' indicates a disabled CPU can be enabled later.

Signed-off-by: James Morse <james.morse@arm.com>
---
This patch probably needs to go via the upstream acpica project,
but is included here so the feature can be testd.
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..c433a079d8e1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)	/* 03: CPU is online capable */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
-- 
2.39.2

