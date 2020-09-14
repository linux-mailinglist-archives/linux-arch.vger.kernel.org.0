Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818592693F2
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINMDw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 08:03:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINMDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 08:03:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so18430414wrm.2;
        Mon, 14 Sep 2020 04:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lt7oJ0RYkp7GOEh6jTuKHSPMhemyBNu8hytTPWvgNCo=;
        b=i2gtmeGeY3nrsm3fVGYPnfgA5gSO89w1IYivRt4SSaJQp2G2bLLm3hP0L/U62VSV8N
         Z38swQyWhPWqjlOWn9/feb1CkbiNTe2PGTkL6aeePSx/Kxd1DtvTtQwH8Zhi4rX0uSVD
         cl+FM+ovmfgjvSQ59qBD1lTKKF9GnVCFF8ep0vBrwnvapVszGVEU+kQLnfEq/682vS6d
         pCBEro1WRdcvI+ZsZPGIAXv3PNNk3bWLSt0Nd+udhZ6+CBoeaBWF5yPpUaASDJtduOCg
         eVx/f4pQFe5xoQps/DEb/u/7QMRqekk5rrWsdCm/q4LLawPwz5f7beAe/9CZPUo/zIlG
         l4nQ==
X-Gm-Message-State: AOAM532jc4QvcbixHVI9dxFsUBX6OfrO36Se6T3L6Mw9RkyN1cLzCL8z
        ydH39n+sQXtMeBn5MZwRubKf1gKSooI=
X-Google-Smtp-Source: ABdhPJzbvIbAfLdh+pFghaYzDSsWI0Hfx/m0A44A95Dhb1oNGzFvSLAWCzgQL/qblUPvk8qT4FL0Xw==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr16432588wro.178.1600084778613;
        Mon, 14 Sep 2020 04:59:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:38 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 12/18] asm-generic/hyperv: update hv_interrupt_entry
Date:   Mon, 14 Sep 2020 11:59:21 +0000
Message-Id: <20200914115928.83184-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will soon use the same structure to handle IO-APIC interrupts as
well. Introduce an enum to identify the source and a data structure for
IO-APIC RTE.

While at it, update pci-hyperv.c to use the enum.

No functional change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c |  2 +-
 include/asm-generic/hyperv-tlfs.h   | 36 +++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bf40ff09c99d..b38faa04234b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1215,7 +1215,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params = &hbus->retarget_msi_interrupt_params;
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
-	params->int_entry.source = 1; /* MSI(-X) */
+	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
 	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
 			   (hbus->hdev->dev_instance.b[4] << 16) |
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e7e80a27777b..83945ada5a50 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -469,6 +469,11 @@ struct hv_create_vp {
 	u64 flags;
 };
 
+enum hv_interrupt_source {
+	HV_INTERRUPT_SOURCE_MSI = 1, /* MSI and MSI-X */
+	HV_INTERRUPT_SOURCE_IOAPIC,
+};
+
 union hv_msi_address_register {
 	u32 as_uint32;
 	struct {
@@ -502,10 +507,37 @@ union hv_msi_entry {
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

