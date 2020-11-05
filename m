Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7852A8440
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgKEQ7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 11:59:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42114 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgKEQ6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 11:58:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id w14so2583034wrs.9;
        Thu, 05 Nov 2020 08:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkEmO/jnr1aZ14jLzCl4bBmcSUaZTM6KcMG9YSC768M=;
        b=cYlL4XgIJcufnVuDeNa9OJ+njSW3dSpjUXloHpURv9xYUU7wdOCHvyw3IlWQ4nfOJi
         +sBrDaF01aoZFr/hA2DmEchtJZnNF0oLdXXsDODxKWlxIDoqZWDYgeEzTuBFaR0pSdP2
         bOUfs2NTRSK9y9myq4POLCzzLCpQVXWaZTq23PQiiwTSP6zu++R40aPlLXEnTyRxIwxO
         W2RW9Kne8QgJWSv74i1b/wVWndxaYbOdmuyvVxF1nugUDESPVCSu/zw/0ez3/a7r+2Dd
         ZjR+zGSlxA03RqH/h/b46v3m3aNOgNth3+IeeYYeb6Yx1I27Bd4ca8T4+o+J+vSxgC89
         ps9A==
X-Gm-Message-State: AOAM533iC3Qe5Mxcw30/Mtfso0N8q7laMNSdinUhOtMqYEysc4jX54YS
        C4BRmpjPW4jyZNdOe5gyAgWXdGoR9Hw=
X-Google-Smtp-Source: ABdhPJzHjohYNXaRzyfSfjB1zDE0FVmGMGu/h3epC6+lZQHInWGr0ITj2GSLIpDgV6v+KbPqsEwPkA==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr3998070wrg.8.1604595509892;
        Thu, 05 Nov 2020 08:58:29 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:29 -0800 (PST)
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
Subject: [PATCH v2 11/17] asm-generic/hyperv: update hv_msi_entry
Date:   Thu,  5 Nov 2020 16:58:08 +0000
Message-Id: <20201105165814.29233-12-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
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
index b6c74e1a5524..86dff6846278 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -480,12 +480,36 @@ struct hv_create_vp {
 	u64 flags;
 };
 
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

