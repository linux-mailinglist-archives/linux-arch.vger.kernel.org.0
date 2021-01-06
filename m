Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908562EC50F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 21:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhAFUfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 15:35:14 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40900 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbhAFUer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 15:34:47 -0500
Received: by mail-wm1-f43.google.com with SMTP id r4so3695269wmh.5;
        Wed, 06 Jan 2021 12:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAKijZroIKQByX8CE0+1w/bE11gheXfs1vD8PWKgeTU=;
        b=hY8mkTWqRm47gOkNso3IHZhnRVK6jter5wnzhvuyzPJEUhoTuur/eMIanT9cxuCCzl
         14ghTpPUKuaBhsl4vId/HO0jnpduAPc+26am1TpOc5wbv/cD6FdKx8NBo+mAsFOHv2OA
         +ruw68zxsj2LDbjadZ7SEIeKtrdm3zMFFOw328bIg/h8KLh+vz19mKRd2NuCXnNiGBxs
         vtj+w3LwdFm18Be+Tn+HrytlzYc6T+Ugp2+R1zpQjHt+plUq+la7XnQd1UKXDT4bZBtw
         UMj6FTbPtnFDKoJ9zse7sVVWVPHbvQAMS0HpwtQDYlC8G3mgdVmOPV4+5nLLlGyPpJDZ
         BP0g==
X-Gm-Message-State: AOAM530HDyKKNk8Us6XCtTRJjKTc5EGFqWQ4tLrE9QpoYDurHQ8qZcXq
        vxUuCunvy85oO+sWSUPz5Jn8zaCkM6s=
X-Google-Smtp-Source: ABdhPJwUgNxMdLUn6hWXgtOGt1egKTevR1W/4hWs3CrSHdK7rUotGUG+2zt6J9yyFSk4mQYZgn3arg==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr5180316wmm.81.1609965245152;
        Wed, 06 Jan 2021 12:34:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:04 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v4 11/17] asm-generic/hyperv: update hv_msi_entry
Date:   Wed,  6 Jan 2021 20:33:44 +0000
Message-Id: <20210106203350.14568-12-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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
index ec53570102f0..7e103be42799 100644
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

