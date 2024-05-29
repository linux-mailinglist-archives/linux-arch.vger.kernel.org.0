Return-Path: <linux-arch+bounces-4586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9B8D37D2
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772211C23D9A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CC14A8B;
	Wed, 29 May 2024 13:36:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0871C6A0;
	Wed, 29 May 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989813; cv=none; b=BJh/3eqrT2IF7ZYcKal/LBC9wOOb3OypO2/DtnmslxvowxB+CVPSVgvsCHW8qOFPZvlzLzOnih0U1PBJ8lnDCyakX6/C90yNR9IEiJk2K9YT+/0eUYt6XA73skYhAscFfYgoxa4s0rxKySieehmJXjK80qe6kM2Y4Bxkldtq5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989813; c=relaxed/simple;
	bh=FHe3puVLC/fR3A3r9/VgzXc62fLK6dSusZxGJJJmiHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUrAF6wHA4mlD5J4AM4YZeUTGrsV8jvj1cL4bWxJ3MWbhlx56dFBMKqZEBKV8aM3USGopORlJbUKtVLws9enOyFRyuDx/BOhK1AGTVYi6LpVlmTGGQ2CSciaaQe03D14vFDR8KJAeku6EjT/qoRNTX/s3pvEGT7pm1kxH1qMYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq9Pd4VGXz6K8qR;
	Wed, 29 May 2024 21:35:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C3534140D26;
	Wed, 29 May 2024 21:36:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 14:36:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v10 04/19] ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
Date: Wed, 29 May 2024 14:34:31 +0100
Message-ID: <20240529133446.28446-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Rafael observed [1] that returning 0 from processor_add() will result in
acpi_default_enumeration() being called which will attempt to create a
platform device, but that makes little sense when the processor is known
to be not available.  So just return the error code from acpi_processor_get_info()
instead.

Link: https://lore.kernel.org/all/CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com/ [1]
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 161c95c9d60a..5f062806ca40 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -393,7 +393,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 	result = acpi_processor_get_info(device);
 	if (result) /* Processor is not physically present or unavailable */
-		return 0;
+		return result;
 
 	BUG_ON(pr->id >= nr_cpu_ids);
 
-- 
2.39.2


