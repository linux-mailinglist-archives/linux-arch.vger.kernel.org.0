Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBC3FE639
	for <lists+linux-arch@lfdr.de>; Thu,  2 Sep 2021 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbhIAXjD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbhIAXi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 19:38:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CBC0613C1
        for <linux-arch@vger.kernel.org>; Wed,  1 Sep 2021 16:38:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n18so9656pgm.12
        for <linux-arch@vger.kernel.org>; Wed, 01 Sep 2021 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvPvP0nRsxQ3kkX46yakySUL2CaA4lERj2AqfItHK10=;
        b=DwoX6EoLPPfWYs1uWTq18V8HVxBlevpESu8u4ShmR/6zIERDN5mRiVY3osfpafSTuf
         xwTY1WuqT9sGbJG8RMqfCyKnJkFuIpiREO+0P7yznZjqdkamQkvs4eiv59hVUM7tKPpw
         lTOzSQM923igOuXmyStOd8iiJIiT3aVbsMcO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvPvP0nRsxQ3kkX46yakySUL2CaA4lERj2AqfItHK10=;
        b=o/BPqAIgEj6UqrZ5q+FropbPqjnPoCJFhMclsbPfatP7MMPqWW+c0g3xGwfrsoJ0im
         Vk3kQtqqDMMx9hM/BYuoxrgdZreM87SzCZIPFZdVRbcu/qM7xMJUnzUmazP30PhujdpY
         Qsg2IS5hjLRdIJ0oU1XdrAZif1jZE5hQ501gTYbZ5ACUKt88mGt980UJWysqSyd/rNBD
         u26hLkJFyzeA2LPeD8TWamo7dlP3jDbkorFNbWbT4XPqzPg+DdTuCaq/2OwZIpQIpU6A
         y85X/9FRmUa79mnivO6VyESfZaZ3O3MumAe2IOP9vOJGcFA3y/NW2lN5henDFISC+Xsv
         9VXQ==
X-Gm-Message-State: AOAM532rjWkrEfwSYNe1EwC5nipeJxpy8gMFf7/8wJwPpr3ZH4OsJ5Zs
        IZHp0Z5mfZzJgcIROpJ2MsifLA==
X-Google-Smtp-Source: ABdhPJx9VQ87Fi72gnvZ9lzkqt8HoWMcG2PGehz0JFkvV2InNksLBR3JT/5Uy3vn1h2GdcYLwpSd5A==
X-Received: by 2002:a63:b91d:: with SMTP id z29mr207957pge.436.1630539481956;
        Wed, 01 Sep 2021 16:38:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a142sm80572pfd.172.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] module: Use a list of strings for ro_after_init sections
Date:   Wed,  1 Sep 2021 16:37:56 -0700
Message-Id: <20210901233757.2571878-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901233757.2571878-1-keescook@chromium.org>
References: <20210901233757.2571878-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; h=from:subject; bh=Ok3nFwFwt1wHYs8UapY8Q4P5KHfmbREksRDyR3/xqoI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7VgNoX/TyNQu2ZCFYBTWLfvfIumM2gB94VWaFO dyRIIB2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1QAKCRCJcvTf3G3AJvAOD/ wPxMVQA6Vmz9d/0SDtspYT1KR1euVl+8Xff9h/ruugR3+rxx879yMUqBZPSVI3PdxwW99f5QcPqSEx b6O5ZSyJQXu98M1iITlyEN/WFiGSXUngPrnfylUHR3k4iGCJQKyuwmImfCtwanF3SBLJtkyFyrLnQv JwtSOBUR3J7wNVtJdytQitI5RRho2650NunUlCWZ0k5vxdc3QteoDmDuucrInUi83T0a3a/KF7PfPs r+TecNOCliA7TRzSgoUNrek3xZy7DEFWRSdSqA1a7NNzoBXOV0AryDuIozXbSY3FdFMOnN7ByucqK5 tt88/yTrCBkICByhkDons8qyuCsZrI0LxkjjUeV5+yOgB4IXqZKHu/Qw02WymJPXZH+WMg1uHbs7Qi aKBsi+k4keSRr0LrTJ+B7cKef+cph9og0yxzvdkCjSNXE04R48baHJ8WWwddqPmZr2trA2UY8MUUb1 smxYUUdThpmqUfVz4t6txKUG/cuQTBXAYaPekWDFtGgwnJUbfCZbgtkd42ak3Jxn6R6E04xOHpMmW8 fkQUDa1HqwCGSBQojbwo22f1Y4Tx4vT6PTCxdDDFHmgemg8IjGUMZACqwSQhCaSPb3KnUxZEfLvvY2 HbLpZQzbst9yCYNXOsrK8I2bsUaV8Bnvg5AsKLJRknfGCApgdbIeuFfreNjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of open-coding the section names, use a list for the sections that
need to be marked read-only after init. Unfortunately, it seems we can't
do normal section merging with scripts/module.lds.S as ld.bfd doesn't
correctly update symbol tables. For more details, see commit 6a3193cdd5e5
("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG
is enabled").

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h |  4 +++-
 kernel/module.c                   | 28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4781a8154254..d532baadaeae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -418,7 +418,9 @@
 
 /*
  * Allow architectures to handle ro_after_init data on their
- * own by defining an empty RO_AFTER_INIT_DATA.
+ * own by defining an empty RO_AFTER_INIT_DATA. Any sections
+ * added here must be explicitly marked SHF_RO_AFTER_INIT
+ * via module_sections_ro_after_init[] in kernel/module.c.
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
diff --git a/kernel/module.c b/kernel/module.c
index ed13917ea5f3..b0ff82cc48fe 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3514,10 +3514,21 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+/*
+ * List of sections to be marked read-only after init. This should match
+ * the RO_AFTER_INIT_DATA macro in include/asm-generic/vmlinux.lds.h.
+ */
+static const char * const module_sections_ro_after_init[] = {
+	".data..ro_after_init",
+	"__jump_table",
+	NULL
+};
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
 	unsigned int ndx;
+	const char * const *section;
 	int err;
 
 	err = check_modinfo(info->mod, info, flags);
@@ -3543,18 +3554,11 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 * layout_sections() can put it in the right place.
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
-	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	for (section = module_sections_ro_after_init; *section; section++) {
+		ndx = find_sec(info, *section);
+		if (ndx)
+			info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	}
 
 	/*
 	 * Determine total sizes, and put offsets in sh_entsize.  For now
-- 
2.30.2

