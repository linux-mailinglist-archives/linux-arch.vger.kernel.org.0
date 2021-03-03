Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E232B4EA
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450179AbhCCFbG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244513AbhCCDFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 22:05:48 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACBC06178B;
        Tue,  2 Mar 2021 19:05:03 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u18so7044746plc.12;
        Tue, 02 Mar 2021 19:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcDXOeJl1Bem2ZtS8JCfREQKUq+Fi3Bp1vnSda8faiw=;
        b=SBm0DGdw0c5Aso4p80+GkGzC46UmVgpV5tv689DfZENQGtp1Nut5gDBjTGmYcIXF2I
         6IZm1hUJIf/rsfHwxTC+HeIKoENFy0AHf98QN8mDnG/ziVBNUt5QtTth/9bZtNOsjNus
         jS3eEiiXFBmpdAWCOllNSCeJhMPrPkKDOFIyJb4Zm3k3AmQEhsU+0hmVgLS1Q9WSbuwW
         l0+NzGFMvxrDxkrjmmYX/gxWjpEEaej+YkwQkyyiRHdc3WWCDPVczRFZoGhXnx6MRzWE
         fGtMtMaAx5ZNmnUhYsshCA6iku+21kxPqo6N6ab5PU7GIJzL07egyawZ7p9Ip55JFUEg
         mczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcDXOeJl1Bem2ZtS8JCfREQKUq+Fi3Bp1vnSda8faiw=;
        b=h3STmQ2LTCfyl/lNb+ta5DhpzpJgf+0/cR4zHxtTz3zJHtEvCPipxp2d98rinjpeZB
         V9dTa+hKDsORTDY3FyEc5tnhm5f20o1lq5RTbf/ME0GKcki5RrfYUrcLZKW77+fPbfeM
         AfyA/Hz1oRcScrjEWepca1b+eW8upm5mW2ME/luowm8IktLfy5THBQ0TuUXOiaChOxv5
         7dtZ8MkeyjHlYlM/DM50B5VYMbuhUHhI0zjnIrX1kJBwfh0W2VG7TJBmjh067dY9hYm/
         EU12YfF5mekyECm9k3Nyz4t2RBpZJ29QDyo5tlRLV+GJqTRTFm1Cnsfg88KZkwRhyLEC
         QLQQ==
X-Gm-Message-State: AOAM531gkNuAIUAEfqhj6oHKjLe6sWOuyKh6UmjQ6uxxdrwcfsgltmiB
        +Mb4uaBBKnikgRHdOdCdhYEXalpZyOM=
X-Google-Smtp-Source: ABdhPJxxD/KqODJAIA/VkE1x16bXwlrSpU7lyw9Oeo2QP8aL54Mx96MCiKf+qws6xmxeDc04TxgNWQ==
X-Received: by 2002:a17:90a:7d05:: with SMTP id g5mr7231132pjl.173.1614740702798;
        Tue, 02 Mar 2021 19:05:02 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id s27sm20599135pgk.77.2021.03.02.19.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 19:05:02 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     will@kernel.org
Cc:     aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] module: remove extra spaces in include/asm-generic/tlb.h
Date:   Tue,  2 Mar 2021 19:04:43 -0800
Message-Id: <20210303030443.176174-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Some typos are found out by codespell tool:

"# define" should be "#define".

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/asm-generic/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..5be89d9ba362 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -23,7 +23,7 @@
  * the loaded mm.
  */
 #ifndef nmi_uaccess_okay
-# define nmi_uaccess_okay() true
+#define nmi_uaccess_okay() true
 #endif
 
 #ifdef CONFIG_MMU
-- 
2.25.1

