Return-Path: <linux-arch+bounces-3631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7548A30FF
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6261C225E9
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF21422B8;
	Fri, 12 Apr 2024 14:41:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9212BF36;
	Fri, 12 Apr 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932916; cv=none; b=EcE1h00ITV0fLP+guU/DwfdbkyjKr99h94qTv8e5K6r71nqOTkm7I7vEhVR/cJjWCIo8z9+daPXTbr84q75c4xo73jRb70Dv6qiyXpU7Wz2EyX9HuYeeYbxKUQipJJ99uKRm92cKmmYhbiOp8VuXoy+DqgHZCLGHIL8BM7cUXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932916; c=relaxed/simple;
	bh=UZlhSbbgxvmCDpuKqnBh552fwklRGUKBiILYhkwfa80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8BchQsjafNo7V1cg9Wbcg232MgY5Yu93Q3i8kOBs2WHKQPA3iI1hkY6kKVM49wGi+20JjTgGQr7OWS0izOLIwpRXu7BmLctttiVUoe0lgG8/11FnV69O1ZwL+CLLF4cl5GO+18uhunDHiYeZegliibmM2xWLTflfuyutvsQ/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK3W4VpYz6J9bP;
	Fri, 12 Apr 2024 22:40:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 624C81402CD;
	Fri, 12 Apr 2024 22:41:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:41:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v5 09/18] ACPI: Check _STA present bit before making CPUs not present
Date: Fri, 12 Apr 2024 15:37:10 +0100
Message-ID: <20240412143719.11398-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: James Morse <james.morse@arm.com>

When called acpi_processor_post_eject() unconditionally make a CPU
not-present and unregisters it.

To add support for AML events where the CPU has become disabled, but
remains present, the _STA method should be checked before calling
acpi_processor_remove().

Rename acpi_processor_post_eject() acpi_processor_remove_possible(), and
check the _STA before calling.

Adding the function prototype for arch_unregister_cpu() allows the
preprocessor guards to be removed.

After this change CPUs will remain registered and visible to
user-space as offline if buggy firmware triggers an eject-request,
but doesn't clear the corresponding _STA bits after _EJ0 has been
called.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: No change
---
 drivers/acpi/acpi_processor.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 15d89f80857b..0403eddb3f80 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -462,16 +462,13 @@ static int acpi_processor_add(struct acpi_device *device,
 }
 
 /* Removal */
-static void acpi_processor_post_eject(struct acpi_device *device)
+static void acpi_processor_make_not_present(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
 	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
 		return;
 
-	if (!device || !acpi_driver_data(device))
-		return;
-
 	pr = acpi_driver_data(device);
 	if (pr->id >= nr_cpu_ids)
 		goto out;
@@ -508,6 +505,29 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	kfree(pr);
 }
 
+static void acpi_processor_post_eject(struct acpi_device *device)
+{
+	struct acpi_processor *pr;
+	unsigned long long sta;
+	acpi_status status;
+
+	if (!device)
+		return;
+
+	pr = acpi_driver_data(device);
+	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
+		return;
+
+	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
+		acpi_processor_make_not_present(device);
+		return;
+	}
+}
+
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
 {
-- 
2.39.2


