Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44722BE80
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGXHAb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgGXHA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D0C0619D3
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a185so7297316ybg.8
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0nD1NJT1E7A4DlzwAlOASLTDllp8VUp9XPKXYyHjpfM=;
        b=czFkbnvrkhD76NHSws41sMDCTxgzqF4NUtYqvOal9OiJFngYtr/ek7QpXttpY7ERlE
         na7VNX2J8BeOixv6OeudGf79msfYeIrQbEZvnm0Zt1gUs5w8dNkw9fexIadvhC/zIBKU
         /2u9enStJuiVh9a0//GeLOG1ql4bBbjS0nGdBVbNP6ERD+BIzgO2t7km+oLLcrjrDQBT
         /yx+tAprubS17VmMI+ZPRjjB/U1Arso81ZXnDpuIE9M6mayhhmRkbxfhhumGzYop6T8E
         kgG9A17jLBXAe9sV3damrIOeyvVmL0a4n7pa6n3/iB30SjvELYXZQnWSU8GajaiG6J2K
         QKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0nD1NJT1E7A4DlzwAlOASLTDllp8VUp9XPKXYyHjpfM=;
        b=FKHTZz95rgjB8TPy+0K+8ocMUIZGqEPmQfTdQYtVV2NdMvlz6WrVDSIg55iv0Gy9Ee
         IxjBSno3FReYo4s68Ep7lOZ6zhkoa2dgy1plDguHrEbT9oJsHLbEibTrVnJYh8ObpYXX
         Tn4MgiTRccImIj8ObkHRN/XsVsY4tTyTD7ybjlBV6Gq/2vaiPFcbJO+7ODDdZa4af2Dl
         BiYv9kEUKyxNsGYaRxHuUMbQoV+AznLuWf36bkFu0gJkEnSaIDZmmxJ9Yg/RNq4w6zkH
         5/SwZmom5IoC2ifvGtycGix4cgQmLDNPsN2AxHk4CJu9eqBw3oRaKJCP0SHt+/c3fr8N
         avFw==
X-Gm-Message-State: AOAM533RMUVq8gP/7lzZEOl60e2Vh8mScaetY7nBV+jfQKDdrq38jX6A
        J5opqJjR0eQRpz4LgGKKVN5lfvICAA==
X-Google-Smtp-Source: ABdhPJzDxJEzx4Y+FCLzY4PFc4lU72XMxtkcxi6vvnclrqEX93bbRRECahnQzMVJw3WrrzZJ8ux651pF2Q==
X-Received: by 2002:a25:9c06:: with SMTP id c6mr12958040ybo.403.1595574026740;
 Fri, 24 Jul 2020 00:00:26 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:02 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-3-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 2/8] objtool, kcsan: Add __tsan_read_write to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adds the new __tsan_read_write compound instrumentation to objtool's
uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d8b630c67a..38d82e705c93 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_read_write1",
+	"__tsan_read_write2",
+	"__tsan_read_write4",
+	"__tsan_read_write8",
+	"__tsan_read_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.28.0.rc0.142.g3c755180ce-goog

