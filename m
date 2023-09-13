Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C879EEAE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjIMQkj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIMQjx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53D51213D;
        Wed, 13 Sep 2023 09:39:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54724FEC;
        Wed, 13 Sep 2023 09:40:08 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596EB3F5A1;
        Wed, 13 Sep 2023 09:39:29 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 19/35] ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
Date:   Wed, 13 Sep 2023 16:38:07 +0000
Message-Id: <20230913163823.7880-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A subsequent patch will change acpi_scan_hot_remove() to call
acpi_bus_trim_one() instead of acpi_bus_trim(), meaning it can no longer
rely on the prototype in the header file.

Move these functions further up the file.
No change in behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/scan.c | 76 ++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f898591ce05f..a675333618ae 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -244,6 +244,44 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
+static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
+{
+	struct acpi_scan_handler *handler = adev->handler;
+
+	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
+
+	adev->flags.match_driver = false;
+	if (handler) {
+		if (handler->detach)
+			handler->detach(adev);
+
+		adev->handler = NULL;
+	} else {
+		device_release_driver(&adev->dev);
+	}
+	/*
+	 * Most likely, the device is going away, so put it into D3cold before
+	 * that.
+	 */
+	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+	adev->flags.initialized = false;
+	acpi_device_clear_enumerated(adev);
+
+	return 0;
+}
+
+/**
+ * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
+ * @adev: Root of the ACPI namespace scope to walk.
+ *
+ * Must be called under acpi_scan_lock.
+ */
+void acpi_bus_trim(struct acpi_device *adev)
+{
+	acpi_bus_trim_one(adev, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_bus_trim);
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
@@ -2506,44 +2544,6 @@ int acpi_bus_scan(acpi_handle handle)
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 
-static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
-{
-	struct acpi_scan_handler *handler = adev->handler;
-
-	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
-
-	adev->flags.match_driver = false;
-	if (handler) {
-		if (handler->detach)
-			handler->detach(adev);
-
-		adev->handler = NULL;
-	} else {
-		device_release_driver(&adev->dev);
-	}
-	/*
-	 * Most likely, the device is going away, so put it into D3cold before
-	 * that.
-	 */
-	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
-	adev->flags.initialized = false;
-	acpi_device_clear_enumerated(adev);
-
-	return 0;
-}
-
-/**
- * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
- * @adev: Root of the ACPI namespace scope to walk.
- *
- * Must be called under acpi_scan_lock.
- */
-void acpi_bus_trim(struct acpi_device *adev)
-{
-	acpi_bus_trim_one(adev, NULL);
-}
-EXPORT_SYMBOL_GPL(acpi_bus_trim);
-
 int acpi_bus_register_early_device(int type)
 {
 	struct acpi_device *device = NULL;
-- 
2.39.2

