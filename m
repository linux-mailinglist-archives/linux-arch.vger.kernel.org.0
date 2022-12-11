Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDF6492B6
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLKGRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiLKGRb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995C12D39
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so8947562pld.7
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw2lBl1FsFeMLJzVkNLD3m+gCDg30pmLyglZrYVzORA=;
        b=fQa8J4z5O4qKsDtySodfbKPdNketzec2+60hqr/JE6LCw17SQOh1dTVr/Oza+7vir0
         sZRhwPyI3ys25qRCLq6204ll/qDm+Jm74NNZDMVlr9zVIkhaucp+dRT0YwqyqUHupn7D
         fsUz/Le7UyHidFZOIF8vJIK+lhgZpGdUxipUsh87u1NsuRJZd30zwJ4G7NJan6KymGhW
         pulUjbd4BT8HtR4kDJFADZ5fUk+sPHVSD27ebZTHvty3YBCKHwM19+iTWyfEE5lfNrHs
         /u4/fhicM7U0sYsdzvbW3jCAk3UU4P63qofT9jfOi5QfhU+SSb7/oZoxaIsZv8jmon2G
         pnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw2lBl1FsFeMLJzVkNLD3m+gCDg30pmLyglZrYVzORA=;
        b=2H240GVqMYSYbPOWz/6ByKobUT22X4RcUYN1wK2fgXLBluxWO1UlFU1Yt4+YO11WE/
         pCTwCR+IDpdfDUrCh7zyHVLP9GdBtJKfBE3fab0qNQxQksDJfWYXFPJAJ0FudONi/u/2
         nm6Fv2S1QOmaxOsgiMSiNeX/3l0eJdoQx7N19HSHrXS2AVpBtKK0Z8ID1T3WzTlYZ4k3
         +lER4jUffhYp4k3huRcz7NhcUnDvAxfnRZrOQLZRsp4usrYQd0pvjag8b66JbELpXtg0
         wsKltIvZTJQmxml9mLIEE2EBSgxDCTevAayc4rJ+gHxIxvkUUxw8KEYZS1LIzHkTXYIy
         sodQ==
X-Gm-Message-State: ANoB5pnLG8QUF4idLBiP0lrnNI/FfKHqUjPltGidQaQm+bqvM6dM4NSN
        gk5IGY6B/ctF57QOzYhvIz0zjQ==
X-Google-Smtp-Source: AA0mqf64cRgQgYJbI6vw3lgox0Y0zQeJU9EfnSOUsxyj5zxvVuY57NisPBozGNZqVx95fXsJuwORJw==
X-Received: by 2002:a17:903:41c5:b0:189:cec6:7ac5 with SMTP id u5-20020a17090341c500b00189cec67ac5mr16799226ple.44.1670739450625;
        Sat, 10 Dec 2022 22:17:30 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b00183e2a96414sm3782118pln.121.2022.12.10.22.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:30 -0800 (PST)
Subject: [PATCH v2 01/24] alpha: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:35 -0800
Message-Id: <20221211061358.28035-2-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/alpha/include/asm/setup.h      | 4 ++--
 arch/alpha/include/uapi/asm/setup.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/setup.h b/arch/alpha/include/asm/setup.h
index 262aab99e391..ea08ca45efa8 100644
--- a/arch/alpha/include/asm/setup.h
+++ b/arch/alpha/include/asm/setup.h
@@ -2,8 +2,6 @@
 #ifndef __ALPHA_SETUP_H
 #define __ALPHA_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 /*
  * We leave one page for the initial stack page, and one page for
  * the initial process structure. Also, the console eats 3 MB for
@@ -14,6 +12,8 @@
 /* Remove when official MILO sources have ELF support: */
 #define BOOT_SIZE	(16*1024)
 
+#define COMMAND_LINE_SIZE	256
+
 #ifdef CONFIG_ALPHA_LEGACY_START_ADDRESS
 #define KERNEL_START_PHYS	0x300000 /* Old bootloaders hardcoded this.  */
 #else
diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/asm/setup.h
index f881ea5947cb..9b3b5ba39b1d 100644
--- a/arch/alpha/include/uapi/asm/setup.h
+++ b/arch/alpha/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _UAPI__ALPHA_SETUP_H
 #define _UAPI__ALPHA_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 #endif /* _UAPI__ALPHA_SETUP_H */
-- 
2.38.1

