Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11A8163C3F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSEyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41635 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgBSEye (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so21881225otc.8;
        Tue, 18 Feb 2020 20:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB9HKBd9NE/ic7aLq2Zv7PAn+vedvEO6GTMd/7/cXT8=;
        b=oJcPu03TiqY6QgcSJwosaNcUNgizcMJBajDzA1jPGSOgixPcHSmfe23+opqORZk+vq
         5uEhlpBEZOCyGWUePBMoNwLLLl0IWMPZe+VWpXNaOBx9cZ2zeUJPWQtY0dTiHewXAffD
         4ifNb7wpeVSJ/pu6EVwX48D+XsoqpU25UVo48MKzoIANF1gwZwNgeaclQE8DvLhARL6C
         vHBM4LOnGhOmLrkDNGQWEpeKwKFqTzI1o0YnVyyE2morwLQjSjNMJuiLyIbB5rfpRg8o
         RWSsvGScSkalMGARf0Bb9ufIkNFTU4mFhypytRC2FcYl+1mfsPuZe3rwAIyy4dICfd5R
         Yt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB9HKBd9NE/ic7aLq2Zv7PAn+vedvEO6GTMd/7/cXT8=;
        b=sX/RdFUe0cvKQ0y3DBeLoXTwE6BMnaK8xx8x029edWzhQZCh3muuWgfJqQDgKiB/8i
         gHQXSgcxuxkfk0lwU/P4jcoAVoGWq0H7ojCexzAvjsD8cyGy7r8zyXUjjHdm9dCJOibl
         VymFKNGm9emGzDXNQb+nMc0gCGy3hmpWXeCqrrSN+kK4WMAcXuAGBfEcxSF82plru+LA
         W9GEz+kqUC5vkx9Y/xQzAD61m9sTibJJI9p0pAqLAz2M4q6Mwf1uVfIPuYgrbmoXsn8G
         ePARjrNxgF9q5/G0v4d/nI4C40KRnPWxxQt1BjIR+KYUJlMgMZEmz0wQxNcTQ1CIXV9E
         1VAA==
X-Gm-Message-State: APjAAAXmuhaGNCLtD+JhR0tnFrDQE9SYcvFrsHZdBQ5Me6aPmK4eEnwW
        jGpZXYdJSt4jsmqlcEm35rA=
X-Google-Smtp-Source: APXvYqwdFwp4qn7ny2TvCGnaQaQjscbRAz+omD8OlFFTCu1L1VgwqztyBfFMZgIeIPZS92nhreHqNA==
X-Received: by 2002:a9d:6b12:: with SMTP id g18mr17801067otp.211.1582088073480;
        Tue, 18 Feb 2020 20:54:33 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:32 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/6] kernel/extable: Wrap section comparison in sort_main_extable with COMPARE_SECTIONS
Date:   Tue, 18 Feb 2020 21:54:19 -0700
Message-Id: <20200219045423.54190-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Clang warns:

../kernel/extable.c:37:52: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
                                                          ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/extable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index a0024f27d3a1..17bf4ccb9de9 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -34,7 +34,8 @@ u32 __initdata __visible main_extable_sort_needed = 1;
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
-	if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
+	if (main_extable_sort_needed &&
+	    COMPARE_SECTIONS(__stop___ex_table, >, __start___ex_table)) {
 		pr_notice("Sorting __ex_table...\n");
 		sort_extable(__start___ex_table, __stop___ex_table);
 	}
-- 
2.25.1

