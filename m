Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5E2FD198
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbhATM6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 07:58:43 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53482 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389146AbhATMPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 07:15:00 -0500
Received: by mail-wm1-f49.google.com with SMTP id j18so2660041wmi.3;
        Wed, 20 Jan 2021 04:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgoWHWZJp95oZbUGT1gHoY/N870o7iAvx/CdWeU6WPw=;
        b=ClGBYmkD9kwavZYkOsP9rQlPhxO5hLl7ddbt9mKjCodeUnprXhO5YCxmVjkqoBZTcH
         QuJsR6KOHC9sqkYnUzuqh/ZCKioZtfYt0c+DGyCzJJppDe6NxSHUyTNkomFz69068gV2
         8uQXNCIR8rOn5RpiqZzGgEKofoA5HuPGqUItrobPXN1ukx8U25s6TwQzZBUKYpYdX6db
         Dy8FlPInTlPMatfEfQrkna1NvMLAPWoKHdE4VpkxodNHGjuQEWEBUnp+s2lX7hILyWVT
         Qxldr8iC7HrTorFjCkShQWb/ZkMQ9E4uAHbBwjRnsxGka+J7K/Y9o/bLDuv+jov1ymQ8
         4hVQ==
X-Gm-Message-State: AOAM532aGgyHTU86NzGtIsGx0ki4Db7UKzWZBsOl0cN3eHwsLa0tZoFp
        thZY/EfW+tDZOC0wDwrGjirUyi6QHUo=
X-Google-Smtp-Source: ABdhPJwXXybGJuDqcgkz3mLUi9tCTNLF/blBEclrZWKQbzm75DdiePexF9OjweaYsGHB49KCS5zuKg==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr4081518wml.186.1611144075582;
        Wed, 20 Jan 2021 04:01:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:15 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v5 12/16] asm-generic/hyperv: update hv_interrupt_entry
Date:   Wed, 20 Jan 2021 12:00:54 +0000
Message-Id: <20210120120058.29138-13-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will soon use the same structure to handle IO-APIC interrupts as
well. Introduce an enum to identify the source and a data structure for
IO-APIC RTE.

While at it, update pci-hyperv.c to use the enum.

No functional change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c |  2 +-
 include/asm-generic/hyperv-tlfs.h   | 36 +++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6db8d96a78eb..87aa62ee0368 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1216,7 +1216,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params = &hbus->retarget_msi_interrupt_params;
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
-	params->int_entry.source = 1; /* MSI(-X) */
+	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
 	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
 			   (hbus->hdev->dev_instance.b[4] << 16) |
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 7e103be42799..8423bf53c237 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -480,6 +480,11 @@ struct hv_create_vp {
 	u64 flags;
 } __packed;
 
+enum hv_interrupt_source {
+	HV_INTERRUPT_SOURCE_MSI = 1, /* MSI and MSI-X */
+	HV_INTERRUPT_SOURCE_IOAPIC,
+};
+
 union hv_msi_address_register {
 	u32 as_uint32;
 	struct {
@@ -513,10 +518,37 @@ union hv_msi_entry {
 	} __packed;
 };
 
+union hv_ioapic_rte {
+	u64 as_uint64;
+
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 destination_mode:1;
+		u32 delivery_status:1;
+		u32 interrupt_polarity:1;
+		u32 remote_irr:1;
+		u32 trigger_mode:1;
+		u32 interrupt_mask:1;
+		u32 reserved1:15;
+
+		u32 reserved2:24;
+		u32 destination_id:8;
+	};
+
+	struct {
+		u32 low_uint32;
+		u32 high_uint32;
+	};
+} __packed;
+
 struct hv_interrupt_entry {
-	u32 source;			/* 1 for MSI(-X) */
+	u32 source;
 	u32 reserved1;
-	union hv_msi_entry msi_entry;
+	union {
+		union hv_msi_entry msi_entry;
+		union hv_ioapic_rte ioapic_rte;
+	};
 } __packed;
 
 /*
-- 
2.20.1

