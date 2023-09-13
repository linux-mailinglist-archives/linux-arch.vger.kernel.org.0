Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730979EE9B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjIMQkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjIMQjk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B1432106;
        Wed, 13 Sep 2023 09:39:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2C21FB;
        Wed, 13 Sep 2023 09:39:56 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3BD3F5A1;
        Wed, 13 Sep 2023 09:39:17 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 13/35] ACPI: Rename acpi_scan_device_not_present() to be about enumeration
Date:   Wed, 13 Sep 2023 16:38:01 +0000
Message-Id: <20230913163823.7880-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

acpi_scan_device_not_present() is called when a device in the
hierarchy is not available for enumeration. Historically enumeration
was only based on whether the device was present.

To add support for only enumerating devices that are both present
and enabled, this helper should be renamed. It was only ever about
enumeration, rename it acpi_scan_device_not_enumerated().

No change in behaviour is intended.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ed01e19514ef..17ab875a7d4e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -289,10 +289,10 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_scan_device_not_present(struct acpi_device *adev)
+static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
 {
 	if (!acpi_device_enumerated(adev)) {
-		dev_warn(&adev->dev, "Still not present\n");
+		dev_warn(&adev->dev, "Still not enumerated\n");
 		return -EALREADY;
 	}
 	acpi_bus_trim(adev);
@@ -327,7 +327,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 			error = -ENODEV;
 		}
 	} else {
-		error = acpi_scan_device_not_present(adev);
+		error = acpi_scan_device_not_enumerated(adev);
 	}
 	return error;
 }
@@ -339,7 +339,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
 
 	acpi_bus_get_status(adev);
 	if (!acpi_device_is_present(adev)) {
-		acpi_scan_device_not_present(adev);
+		acpi_scan_device_not_enumerated(adev);
 		return 0;
 	}
 	if (handler && handler->hotplug.scan_dependent)
-- 
2.39.2

