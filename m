Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0030DDB6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhBCPLW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:11:22 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33795 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhBCPFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:05:36 -0500
Received: by mail-wr1-f43.google.com with SMTP id g10so24730190wrx.1;
        Wed, 03 Feb 2021 07:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZiSx8DcXexhF7XidCd/ZpJVY2ebrAncvKdkNoX1KpQ=;
        b=oi7yoNJNvOjtUtgTDe4RlMEXrD6UWks+L1/BTZG9RTiyooJrhusKgrHBLshd28Y9eU
         PaanmxuuCaBJClVhOxlEo79QudTN7x1txupdlh273yeeGW79N0BRANZntwuECqPsbaB5
         Vdcn0y7D3SU6YPzsw9pW0IJEZ41OxNhbqpFKYr6mXVB5+Yr/qAFKeqeWbRoIrogWFWcj
         tIL7QYQIu+ax3DHhQmPktcwGUg/PxBMAblEnauiDfKeEqcPcsu9gb3lbxDHU0Ho0q/g6
         cvOQGm3kQ6ujW2mSIR5ilJMY/UxT49+giJXJpNk7X4SJ4P/7kcOdJHIdQEKCdo8vUpuV
         UWog==
X-Gm-Message-State: AOAM530EqHMzBBq/TWYnNcBDyjMiiWy1aJzHRiksVIMXVGerARe8V4sT
        6DIaRYF5sveCieKWWUtcDggtBEojKho=
X-Google-Smtp-Source: ABdhPJzGCk8bJBbEUgil+OtioDO6HO9BOq7BahXRk4RvE5d2tRldATaDQBoIuLyrpgo1pdoxUyBp2A==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr3867418wru.178.1612364690949;
        Wed, 03 Feb 2021 07:04:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:50 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6 11/16] asm-generic/hyperv: update hv_msi_entry
Date:   Wed,  3 Feb 2021 15:04:30 +0000
Message-Id: <20210203150435.27941-12-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will soon need to access fields inside the MSI address and MSI data
fields. Introduce hv_msi_address_register and hv_msi_data_register.

Fix up one user of hv_msi_entry in mshyperv.h.

No functional change expected.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h   |  4 ++--
 include/asm-generic/hyperv-tlfs.h | 28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4e590a167160..cbee72550a12 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -257,8 +257,8 @@ static inline void hv_apic_init(void) {}
 static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
 					      struct msi_desc *msi_desc)
 {
-	msi_entry->address = msi_desc->msg.address_lo;
-	msi_entry->data = msi_desc->msg.data;
+	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
+	msi_entry->data.as_uint32 = msi_desc->msg.data;
 }
 
 #else /* CONFIG_HYPERV */
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 69de4e3d89d3..4669f9a4e1f1 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -480,12 +480,36 @@ struct hv_create_vp {
 	u64 flags;
 } __packed;
 
+union hv_msi_address_register {
+	u32 as_uint32;
+	struct {
+		u32 reserved1:2;
+		u32 destination_mode:1;
+		u32 redirection_hint:1;
+		u32 reserved2:8;
+		u32 destination_id:8;
+		u32 msi_base:12;
+	};
+} __packed;
+
+union hv_msi_data_register {
+	u32 as_uint32;
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 reserved1:3;
+		u32 level_assert:1;
+		u32 trigger_mode:1;
+		u32 reserved2:16;
+	};
+} __packed;
+
 /* HvRetargetDeviceInterrupt hypercall */
 union hv_msi_entry {
 	u64 as_uint64;
 	struct {
-		u32 address;
-		u32 data;
+		union hv_msi_address_register address;
+		union hv_msi_data_register data;
 	} __packed;
 };
 
-- 
2.20.1

