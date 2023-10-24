Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B077D5520
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjJXPQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjJXPQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:16:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E053DE;
        Tue, 24 Oct 2023 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4gqJUFEuje3fCbnl8mzHmlzSgskUoFHmtCeNWR/xAOg=; b=pXRu/zrS/dM6ClNwUhatLM+tl7
        JuF0cN93+EPgQNTCgK7I+R4kUezGWGlCR9kOPU/4+hNgzfQ6ZOm0PWZ2Zx1kUZadMSsRDUQ+kR3eI
        FwcxR+d06Bzs2MxjEmyjPvOnkah+I5WdsTSplkONSrI1sEQj8YOc1Tl9WV0eJ4RZs6c9BtJVUKouJ
        u1YOTdFsgTyuldtOdpSGW/9qNMJ2xfLA7x7XgVvvgJeTuBrk6NNdnyYayN24mc8/8NDzUqtTlI26f
        LYwHHpo8RBHZtEGBnKsoH2GUElaGo+p4MvORDwSn19oR7cJq/9JHOuAtD3gCKDzw0TvE3wAzTreRc
        sfIx2URg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43858 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ8p-0004Ll-0n;
        Tue, 24 Oct 2023 16:16:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ8q-00AqP4-NY; Tue, 24 Oct 2023 16:16:24 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 03/39] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ8q-00AqP4-NY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:16:24 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

acpi_scan_device_not_present() is called when a device in the
hierarchy is not available for enumeration. Historically enumeration
was only based on whether the device was present.

To add support for only enumerating devices that are both present
and enabled, this helper should be renamed. It was only ever about
enumeration, rename it acpi_scan_device_not_enumerated().

No change in behaviour is intended.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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
2.30.2

