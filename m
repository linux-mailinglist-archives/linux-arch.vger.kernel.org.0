Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7F163C35
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBSEyh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46808 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgBSEyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so21892975otb.13;
        Tue, 18 Feb 2020 20:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5UFOi8jLMJhZKfbS1bLXcN2MTOzPVzspy8Ufb+K/+9A=;
        b=CGR/0y06bDux3uipIKmL2A6gq/Cjwnfz6TpotKAct40JBSC1dCgyK/xpIMrUuQqODG
         ndabVlZXu3nu5sDRXd5T6gc+0Z5fnGquP6EpnNzE86kWuGTBiNeWK9EQAry7s3uaNTb6
         eGn2yiX29eXa/P82eFd5E4QAdhju0gshmPP1AuAgAxgIEllQg0iQsrb+ECFDI2+AvB9r
         +fQurI2f1KQsm6vtGkq+TCmq4jlPB/gWa1h33C20pXb5fZ5KIAZ4UcmMoGzUaiHRI5mH
         kog8lhdtN1kfcA5LAqLn0c6uFsltFxkqPIXvqql6Pzi81xN5aIMqpQ4LObP47x/z4Yhq
         yUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5UFOi8jLMJhZKfbS1bLXcN2MTOzPVzspy8Ufb+K/+9A=;
        b=I5lWT6yeXZnoJWyqH+18K+FMJI3J4vUtIX+F6gplLa8tw/c2dvmCGO1VMz/cRu1nTn
         7A5cRIeivj0UyvMmptDb0YrqYbJhjurFcmamhTlppTbqWU8a1H2Q9X6lK0bxt/mqBHQH
         kB/ALpZFDqTWWUwwjr4bgwYs/hhOLS1Hq30r1bbI86Ou/UC8ZMuBjVrmCyR6qXrv/z/f
         prS5EWc4RWVEyH6SEUaFNwsF0skWXs6y1oTf3XbIX6KTUXzQ2fNBP6h8xT9z32RRfA75
         yLJtdrIzqSzQnEX3v6cz4Ke/qWY+m92hQr0zF8NbPldLwShP8xAbvztyBOmCQMcs3RQO
         9BuQ==
X-Gm-Message-State: APjAAAW4KuUPEk19NYNPi5QjTJ70GWSGDUDtyQYDu3eblVBHv9sohit4
        L++8Vy31Ga1+l9vxGnD1+6M=
X-Google-Smtp-Source: APXvYqyYvjiYUbVKqo1foePiJ1LRz3yob4g25LDX4h9uBovWKx7QdkcX8t6eDUmuVpPdUDin0haoFw==
X-Received: by 2002:a9d:7dc9:: with SMTP id k9mr18133478otn.117.1582088075110;
        Tue, 18 Feb 2020 20:54:35 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:34 -0800 (PST)
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
Subject: [PATCH 4/6] dynamic_debug: Wrap section comparison in dynamic_debug_init with COMPARE_SECTIONS
Date:   Tue, 18 Feb 2020 21:54:21 -0700
Message-Id: <20200219045423.54190-5-natechancellor@gmail.com>
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

../lib/dynamic_debug.c:1016:24: warning: array comparison always
evaluates to false [-Wtautological-compare]
        if (__start___verbose == __stop___verbose) {
                              ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index aae17d9522e5..c7350aa6e853 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1031,7 +1031,7 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
+	if (COMPARE_SECTIONS(__start___verbose, ==, __stop___verbose)) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}
-- 
2.25.1

