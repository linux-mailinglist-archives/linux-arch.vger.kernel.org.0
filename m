Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5611E31C8BA
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBPKZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 05:25:46 -0500
Received: from z11.mailgun.us ([104.130.96.11]:62898 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhBPKZm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Feb 2021 05:25:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613471115; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EtaXSbm5asCMvhst8Y9o7sTMibimpMRZTlvRciR2ohk=; b=t4ng0cElFKny5QAtJjsTSV7rwZlbGbTaHU4nkU7xXwNEP52Q33sTvJSdw1eeqdozUgVnXI0y
 RAKOdJN5AhYa9g7GqXXnJltuKxjUKKzQyCkLa4lG71EVA/hahQV6h0d0oMmk/ykd0MORoqAE
 gH+OFJuli0Ng3FxIMcdmpaROQlc=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 602b9c0e8e43a988b7c128d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 10:18:54
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA2E7C43469; Tue, 16 Feb 2021 10:18:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pnagar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D33A2C433C6;
        Tue, 16 Feb 2021 10:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D33A2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pnagar@codeaurora.org
From:   Preeti Nagar <pnagar@codeaurora.org>
To:     arnd@arndb.de, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     casey@schaufler-ca.com, ndesaulniers@google.com,
        dhowells@redhat.com, ojeda@kernel.org, psodagud@codeaurora.org,
        nmardana@codeaurora.org, rkavati@codeaurora.org,
        vsekhar@codeaurora.org, mreichar@codeaurora.org, johan@kernel.org,
        joe@perches.com, jeyu@kernel.org, pnagar@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate page
Date:   Tue, 16 Feb 2021 15:47:52 +0530
Message-Id: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The changes introduce a new security feature, RunTime Integrity Check
(RTIC), designed to protect Linux Kernel at runtime. The motivation
behind these changes is:
1. The system protection offered by Security Enhancements(SE) for
Android relies on the assumption of kernel integrity. If the kernel
itself is compromised (by a perhaps as yet unknown future vulnerability),
SE for Android security mechanisms could potentially be disabled and
rendered ineffective.
2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
checks to each stage of the boot-up process, to assert the authenticity
of all secure software images that the device executes.  However, due to
various vulnerabilities in SW modules, the integrity of the system can be
compromised at any time after device boot-up, leading to un-authorized
SW executing.

The feature's idea is to move some sensitive kernel structures to a
separate page and monitor further any unauthorized changes to these,
from higher Exception Levels using stage 2 MMU. Moving these to a
different page will help avoid getting page faults from un-related data.
The mechanism we have been working on removes the write permissions for
HLOS in the stage 2 page tables for the regions to be monitored, such
that any modification attempts to these will lead to faults being
generated and handled by handlers. If the protected assets are moved to
a separate page, faults will be generated corresponding to change attempts
to these assets only. If not moved to a separate page, write attempts to
un-related data present on the monitored pages will also be generated.

Using this feature, some sensitive variables of the kernel which are
initialized after init or are updated rarely can also be protected from
simple overwrites and attacks trying to modify these.

Currently, the change moves selinux_state structure to a separate page.
The page is 2MB aligned not 4K to avoid TLB related performance impact as,
for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to PA)
mappings if the IPA comes from a stage 1 mapping. In future, we plan to
move more security-related kernel assets to this page to enhance
protection.

Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
---
The RFC patch reviewed available at:
https://lore.kernel.org/linux-security-module/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/
---
 include/asm-generic/vmlinux.lds.h | 10 ++++++++++
 include/linux/init.h              |  6 ++++++
 security/Kconfig                  | 11 +++++++++++
 security/selinux/hooks.c          |  2 +-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b97c628..d1a5434 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -770,6 +770,15 @@
 		*(.scommon)						\
 	}
 
+#ifdef CONFIG_SECURITY_RTIC
+#define RTIC_BSS							\
+	. = ALIGN(SZ_2M);						\
+	KEEP(*(.bss.rtic))						\
+	. = ALIGN(SZ_2M);
+#else
+#define RTIC_BSS
+#endif
+
 /*
  * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
  * sections to the front of bss.
@@ -782,6 +791,7 @@
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
+		RTIC_BSS						\
 		. = ALIGN(PAGE_SIZE);					\
 		*(.bss..page_aligned)					\
 		. = ALIGN(PAGE_SIZE);					\
diff --git a/include/linux/init.h b/include/linux/init.h
index e668832..e6d452a 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -300,6 +300,12 @@ void __init parse_early_options(char *cmdline);
 /* Data marked not to be saved by software suspend */
 #define __nosavedata __section(".data..nosave")
 
+#ifdef CONFIG_SECURITY_RTIC
+#define __rticdata  __section(".bss.rtic")
+#else
+#define __rticdata
+#endif
+
 #ifdef MODULE
 #define __exit_p(x) x
 #else
diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f..1af913a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -291,5 +291,16 @@ config LSM
 
 source "security/Kconfig.hardening"
 
+config SECURITY_RTIC
+	bool "RunTime Integrity Check feature"
+	depends on ARM64
+	help
+	  RTIC(RunTime Integrity Check) feature is to protect Linux kernel
+	  at runtime. This relocates some of the security sensitive kernel
+	  structures to a separate RTIC specific page.
+
+	  This is to enable monitoring and protection of these kernel assets
+	  from a higher exception level(EL) against any unauthorized changes.
+
 endmenu
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17e..59d7eee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,7 +104,7 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-struct selinux_state selinux_state;
+struct selinux_state selinux_state __rticdata;
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

