Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0FA0C2E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfH1VJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 17:09:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1VJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 17:09:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so1515136wml.0;
        Wed, 28 Aug 2019 14:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6A42lJeJnLJ8M4juk0mvSEa+/hVqH6gniCUyxaWPy0A=;
        b=tbXo7fiiWXcce8idgBc/4Sg0k08FJ+HEl2xGsD4axeBx4LfWmeRy2+O+jpwTbhJEJY
         yF8CQ5Hk2uZiql+tCFT8013RRbqerIIfRy7JKxiGaAnZNCazhlepOxQA3jbTw3VGPMYW
         Rg+9dNnOLUyOamO/18daMwGs0o4LC8sPMxPiT/l48z0NOXEMze4aewz+H/7/ci18hxJW
         TFrnK3brF2BowYScErgGwaGerWRdzmMeNKwMuO0Q5aciOVrYfMUZ2IoXCK2VQCcQDFGy
         lpvIJQ3pxq2rSjClGDMovtKLWbulL5HtUKeR9CovVe0HNIdl3yWIWQCbdusd+PonplVy
         gidg==
X-Gm-Message-State: APjAAAUjPJjy3D9Xsz5Ah9N00rQfwUJpvfP/lN9HlHB9GgdOZu5M6QfP
        92Bjy/RNRvfa2dgTiUCXF6UxkZN6
X-Google-Smtp-Source: APXvYqwc4xHIrq5qKlKgJdoBsf5Q+4XO0/+CNNVNc3mWRpkIp2gWgVpSe5zzuVu6KhJisRzt8ddKXQ==
X-Received: by 2002:a05:600c:144:: with SMTP id w4mr7586256wmm.94.1567026578737;
        Wed, 28 Aug 2019 14:09:38 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id r1sm541838wro.13.2019.08.28.14.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:09:37 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Date:   Thu, 29 Aug 2019 00:09:34 +0300
Message-Id: <20190828210934.17711-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
the define consistent with BUG_ON(x) in CONFIG_BUG.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index aa6c093d9ce9..7357a3c942a0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -185,7 +185,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.21.0

