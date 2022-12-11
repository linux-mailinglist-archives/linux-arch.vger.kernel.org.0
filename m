Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D96492C9
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiLKGTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLKGSZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689AC2703
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t17so8848175pjo.3
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H1j7yEEYxAuL7dBwqyTi2h+3A0JkohjOfLxjR4WPTE=;
        b=yFFP81RE41Dqi0BWHphi9cJ5CpPR5g51Ll34YffwvLS4H7Mq/+VjLlxkBto/uOpLsD
         E1Vy1i0qswS7oyLOZTIHdvjJRtfs403QmPIv148G6yuGuOMBzyqKtB+7qkg4eOBemf3C
         3PUmYJiNOaEIYaRQbb2r2nLhImc5C3wJWHoaEAUwn2STPQXDOZUAnAeVNwNhkQEoeTXf
         KRQ73LRLQsNOvRJcrP5h8o0ZUGBXLwWweXl4ADMpi9GR4J2RSdO+LubSPo9Kj5heteT3
         sRKonX/MLmRiSeIEw+vzWtF7p4x6ExNvwFjgBaWbFoiurkLUSEtZo2c95BTLWkPD12ng
         QtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H1j7yEEYxAuL7dBwqyTi2h+3A0JkohjOfLxjR4WPTE=;
        b=i7kLWuBAbasojI52UGxNFt/pb7qMb2NNLFiYzvG1gvQiPq37J7iQSFRmsK/Wgqa1pr
         lZnWXfTzNlUg/Qx/uDkD8TuPX5sPk830GHjsqo4Z5EsXiAW/9RT71tLov6Bi0ZfYDfmS
         TR5pQ2r1pFqVkX0qTGxAhyj1DZVpzWj7PGyNa4952mhWwvinCJxf5EzsxjtGoAM9Dxq0
         njkFNr/KIIxMFTIID9Yb7I/2NTu0nufz1wgcx2LhZ4ZqemDhZSIlw1bYJdW4pf3iOL7b
         WxMV7pqzjkFm2Jv8HL2C8d8fB2JU6iq8FQPpuuie4ViFRls/ekF/i18kR347aJw+HnGA
         E2bg==
X-Gm-Message-State: ANoB5pkpTeKgOTdxsIZu5rDcLoifa4cmvAwZdQwaDOruyJSPw9rISHdj
        FMNKexguHu2FrP2PHAdQCKXThA==
X-Google-Smtp-Source: AA0mqf7vKmF7wf83h3HRfWIM2zZara2ziRO0eC4DJEU/4MiALydb9N4nMR2Czh1j8F+3fLqyD34gCw==
X-Received: by 2002:a05:6a21:c087:b0:ac:1ead:8cd8 with SMTP id bn7-20020a056a21c08700b000ac1ead8cd8mr13544632pzc.9.1670739462907;
        Sat, 10 Dec 2022 22:17:42 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001897e2fd65dsm3813011plj.9.2022.12.10.22.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:42 -0800 (PST)
Subject: [PATCH v2 11/24] xtensa: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:45 -0800
Message-Id: <20221211061358.28035-12-palmer@rivosinc.com>
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
This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
---
 arch/xtensa/include/asm/setup.h      | 17 +++++++++++++++++
 arch/xtensa/include/uapi/asm/setup.h |  2 --
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/xtensa/include/asm/setup.h

diff --git a/arch/xtensa/include/asm/setup.h b/arch/xtensa/include/asm/setup.h
new file mode 100644
index 000000000000..5356a5fd4d17
--- /dev/null
+++ b/arch/xtensa/include/asm/setup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * include/asm-xtensa/setup.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2005 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_SETUP_H
+#define _XTENSA_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
+#endif
diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uapi/asm/setup.h
index 5356a5fd4d17..6f982394684a 100644
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ b/arch/xtensa/include/uapi/asm/setup.h
@@ -12,6 +12,4 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 #endif
-- 
2.38.1

