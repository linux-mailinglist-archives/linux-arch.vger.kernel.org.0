Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC916492B9
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLKGRk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLKGRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E9413CC2
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso9048462pjh.1
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwyYiFcRsjmX6zCX8NLBJ5b8ChthtpnvjsyMaVpr40U=;
        b=Ltz5b/ttpkf0F/fmmQs4lgqoncjlikqfqixnebILoI0nGAu8o0Dk2BvoOSMNY3zAAa
         hSuF16fMwsfhyQ5Fqg4BxO8IAOMY0gjFReVmPXhDQpC6NMQLTYLmW3/uldpK97kb3lH3
         28ZrSAX43FIPIgfv8iRS+AJNDBVxgPlVoDtj92Z8+yOo8gpvaixsR5g1uU28DdR/s9F3
         ndMMZbdAWlpb7I2bY3SX2nQCfVEPVCIySJSc+O9H0ZVMyPDoONuL8nZ9vN+SpRVNjZxZ
         Qdi1D4q1oz/V6t2nzVDIrzIhR/dlDculHPJ1XWu5+P7B3lULyRnuzxdOel27wQPLLf8z
         lOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwyYiFcRsjmX6zCX8NLBJ5b8ChthtpnvjsyMaVpr40U=;
        b=hRZF+fk4ZtEXexC/dUEmy5ghLtOeb5lrPGgPEyeDjxun0BZZxr6R+TRzmzIAfYrQKX
         VFaNbR350slLWzifvqdDS2qGM65TgVhc/9lWJuqn8Ev6EGwSp8SjKQp1U7MwSjJs1+T5
         8LIyizaD7Euj7oEjl+afXiD601OWps7XrpPZtV+pFPr7RtpKMgWCS/lMIOrL6HQjBlXO
         kQ4KhZcDNMsUp7/zbXGGg2yrxGfM+0Nux5BSrAwU/+33S60Hv/lpOsJ5ESVGXp7AqZZf
         HveZEDnarggd23IxaWa9B8Rk5QViC6q0K1KJkbjmDtFZ0rTkHOB1c3XPmRvn60Utqqqc
         eeyw==
X-Gm-Message-State: ANoB5pmlYpVhC+aT/7LRpoKWAGW8Ayd1o69wm4VIqZ58XRTXNtN6IYVl
        moQu/TjA4o9r+/xHwd8Flw1Q2kWAchYv6TgF
X-Google-Smtp-Source: AA0mqf5ieqzOjEVSZd3sKLcQkNQyEBa4YxDWUVuioCdshPhv+YJR6fEbkPsUKg8QyKn0R/3ssTkadQ==
X-Received: by 2002:a17:90a:d347:b0:219:9676:fef5 with SMTP id i7-20020a17090ad34700b002199676fef5mr11448796pjx.12.1670739454184;
        Sat, 10 Dec 2022 22:17:34 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm3257566pjb.32.2022.12.10.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:33 -0800 (PST)
Subject: [PATCH v2 04/24] ia64: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:38 -0800
Message-Id: <20221211061358.28035-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/ia64/include/asm/setup.h      | 8 ++++++++
 arch/ia64/include/uapi/asm/setup.h | 6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 arch/ia64/include/asm/setup.h

diff --git a/arch/ia64/include/asm/setup.h b/arch/ia64/include/asm/setup.h
new file mode 100644
index 000000000000..5625a17ddbe4
--- /dev/null
+++ b/arch/ia64/include/asm/setup.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __IA64_SETUP_H
+#define __IA64_SETUP_H
+
+#define COMMAND_LINE_SIZE	2048
+
+#endif
diff --git a/arch/ia64/include/uapi/asm/setup.h b/arch/ia64/include/uapi/asm/setup.h
index 8d13ce8fb03a..bcbb2b242ded 100644
--- a/arch/ia64/include/uapi/asm/setup.h
+++ b/arch/ia64/include/uapi/asm/setup.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __IA64_SETUP_H
-#define __IA64_SETUP_H
-
-#define COMMAND_LINE_SIZE	2048
+#ifndef __UAPI_IA64_SETUP_H
+#define __UAPI_IA64_SETUP_H
 
 extern struct ia64_boot_param {
 	__u64 command_line;		/* physical address of command line arguments */
-- 
2.38.1

