Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5217E2CC15
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE1Qdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 12:33:35 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56758 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1Qdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 12:33:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id q17so28547241qkc.23
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ekpV16BsEuFUmwpAG23aREMsNr/hn6GV4TCSg0P4aJ0=;
        b=U5odcy97XOoX4/hsqlmVKYuwP4/Dzi2ZmyDZP3yoJZB5LDIwVkMgKbI8ma6mqcul7P
         S7sCOi8GdwJXwsybjd88DJ5N1iuOo4iL7LqMF+ZDDxjkiDXLD5cjzCiUiSc3CPBDC69g
         frw6B8ukJA3Rcr9xLlLqsttQzlwul75Ba2rfCB5z8D9DFTQA3Dr+oouto0vigcT4CulR
         wkWx2/Mc9AmOq9w8fdmBR17dncN4Rahlu6uWnN4rh90BYJGsA1ZF1koQUUsuZAq8LO9E
         o6KQc4A1evKB5IcZK+DnSGrbbfk8+fmiNMjt4HIlMyGfJVEy8IFHPE0Ex/Ho92Nz7/8b
         /0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ekpV16BsEuFUmwpAG23aREMsNr/hn6GV4TCSg0P4aJ0=;
        b=er2ai490TIp2imq8w6DC8HUly8kMTMT29TOCKx+Hjoe9W9tWTiG6nzngp056lSfzYL
         JUR8R56nC4bRY0vMrbB+J7Tzn0b7BGMifpJRgZprgQ4VQ8yV8RjkIBwLmgxoS7p8KYg/
         VqzMp7SENVgUE4hkrP/nloQQyseKorXYZD/RECzRUEitAndaUfpLyHjKDaLOhesWymT1
         gS2TFHrr6Y4BTtbLeD1nynFWl0YTOGDO0Cg7M9vJvNUpC5d4F5sMJH41b1oCgPP9ongk
         Df9iZRh3Geppm8C5ky1UHu5oyXkTcrjAk03xJmZhuqD8nVp2XAf/AAnixYFBATsQUXqB
         8toA==
X-Gm-Message-State: APjAAAXMnztoBYKor/M5W9ZIpJRtxL0a2TOYNKHncC+W41Jw0nUgVnqF
        /n2mhIWeEfiKwhGCG2MAhcjs9kJE2w==
X-Google-Smtp-Source: APXvYqz2pdkms74LUkgOHBXXnCSTIO447N3UMEsALJsohwzxqupbdIBQTZSArOjvC/iRjbLMRMYd1FeaAQ==
X-Received: by 2002:a37:ad12:: with SMTP id f18mr5399903qkm.3.1559061214532;
 Tue, 28 May 2019 09:33:34 -0700 (PDT)
Date:   Tue, 28 May 2019 18:32:57 +0200
In-Reply-To: <20190528163258.260144-1-elver@google.com>
Message-Id: <20190528163258.260144-2-elver@google.com>
Mime-Version: 1.0
References: <20190528163258.260144-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a pre-requisite for enabling bitops instrumentation. Some bitops
may safely be used with instrumentation in uaccess regions.

For example, on x86, `test_bit` is used to test a CPU-feature in a
uaccess region:   arch/x86/ia32/ia32_signal.c:361

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..eff0e5209402 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -443,6 +443,8 @@ static void add_ignores(struct objtool_file *file)
 static const char *uaccess_safe_builtin[] = {
 	/* KASAN */
 	"kasan_report",
+	"kasan_check_read",
+	"kasan_check_write",
 	"check_memory_region",
 	/* KASAN out-of-line */
 	"__asan_loadN_noabort",
-- 
2.22.0.rc1.257.g3120a18244-goog

