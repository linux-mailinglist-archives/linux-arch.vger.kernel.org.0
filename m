Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77282EEF38
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbhAHJMs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 04:12:48 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:11619 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHJMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 04:12:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610097142; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TwVrvVK1OzG/lArxagrlCuTmDgJ2ODUQJRFSPWgtUOk=; b=NGWjR5e3GvShW/klCX72vvj6p6st6W1VvaJPr6PKH/ekfUVm3YCc9Iw+zMkvfDu/q3oSvjw5
 kINsMAvpd50RNf8EZbQp7k2ZJnN51srvDzkRuQfsTZ+gD8NBO15vPRyCy5Mqd0OEMhU20WmT
 1wVS7CERDFLmb+Ta+cHAMaLwWxY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ff821d50139c41e8921c656 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 09:11:49
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 818E4C43469; Fri,  8 Jan 2021 09:11:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pnagar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 621BEC433CA;
        Fri,  8 Jan 2021 09:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 621BEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pnagar@codeaurora.org
From:   Preeti Nagar <pnagar@codeaurora.org>
To:     arnd@arndb.de, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, pnagar@codeaurora.org,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: ARM64: Move selinux_state to a separate page
Date:   Fri,  8 Jan 2021 14:39:14 +0530
Message-Id: <1610096956-21347-1-git-send-email-pnagar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The changes introduce a new security feature, RunTime Integrity Check
(RTIC), designed to protect Linux Kernel at runtime. The motivation
behind these changes is:
1. The system protection offered by SE for Android relies on the
assumption of kernel integrity. If the kernel itself is compromised (by
a perhaps as yet unknown future vulnerability), SE for Android security
mechanisms could potentially be disabled and rendered ineffective.
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
Using this mechanism, some sensitive variables of the kernel which are
initialized after init or are updated rarely can also be protected from
simple overwrites and attacks trying to modify these.

Currently, the change moves selinux_state structure to a separate page. In
future we plan to move more security-related kernel assets to this page to
enhance protection.

We want to seek your suggestions and comments on the idea and the changes
in the patch.

Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
---
 include/asm-generic/vmlinux.lds.h | 10 ++++++++++
 include/linux/init.h              |  4 ++++
 security/Kconfig                  | 10 ++++++++++
 security/selinux/hooks.c          |  4 ++++
 4 files changed, 28 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81..158dbc2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -770,6 +770,15 @@
 		*(.scommon)						\
 	}
 
+#ifdef CONFIG_SECURITY_RTIC
+#define RTIC_BSS							\
+	. = ALIGN(PAGE_SIZE);						\
+	KEEP(*(.bss.rtic))						\
+	. = ALIGN(PAGE_SIZE);
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
index 7b53cb3..617adcf 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
 /* Data marked not to be saved by software suspend */
 #define __nosavedata __section(".data..nosave")
 
+#ifdef CONFIG_SECURITY_RTIC
+#define __rticdata  __section(".bss.rtic")
+#endif
+
 #ifdef MODULE
 #define __exit_p(x) x
 #else
diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f..66b61b9 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -291,5 +291,15 @@ config LSM
 
 source "security/Kconfig.hardening"
 
+config SECURITY_RTIC
+        bool "RunTime Integrity Check feature"
+        help
+	  RTIC(RunTime Integrity Check) feature is to protect Linux kernel
+	  at runtime. This relocates some of the security sensitive kernel
+	  structures to a separate page aligned special section.
+
+	  This is to enable monitoring and protection of these kernel assets
+	  from a higher exception level(EL) against any unauthorized changes.
+
 endmenu
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826f..7add17c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,7 +104,11 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+#ifdef CONFIG_SECURITY_RTIC
+struct selinux_state selinux_state __rticdata;
+#else
 struct selinux_state selinux_state;
+#endif
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
-- 
2.7.4

