Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CB4632DF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhK3Lsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbhK3Lsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:38 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483FC061746
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so12709339wmr.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K7olqGN/TGjGn55ZVkEX4B3oA8fATuBzpoXYDPWo+s8=;
        b=clBdSB1KsdaD9LhF3VuIZRE5qDbZm9VUy7Jmjj5Uln7EAmbx9/EVEhCZVIjKZMPCK+
         qVPPdLDGmjPahXUB+7UHlvMJZMoPvtMBSVaYAWCfkloYps+FrLrtPD/MSZq6V5qCVz9F
         HLMEG9qAzvEkT52Tvk9GFZWjZEpBWUwzTzdkavD1KWL9RmtktroFJZ7Egs8clPbPBHwn
         wN7uOQ716yPwwUBgmjReM4uHwoUeb55jkQFwgYZRDRcrW/uO9L1BglBLfcp2U6lDrDpx
         FloEFIIraKR1zTwfjZbLjFAUKKD+8XROZdOh1bjkVCNAV7lpb1p+AtLZAWaWo2nZkkq5
         egZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K7olqGN/TGjGn55ZVkEX4B3oA8fATuBzpoXYDPWo+s8=;
        b=NYzpCekyG5WKi+4MF3uiuBXM510xg3AwOc9bhBBd+rYcdBkiLDv5lsHEapf4VPoAiI
         IEOaWNIdHBrXrXr1s9nCfhFojQN0FQsBf+LmvX+otjiSy6LidQuVDeXsFVT3kBzGLPgp
         eXdpmyBuaEfm6/95QOCz19V/8Rz0NZQY2DzgJczq9Dtwj4sVZB8AkCHK7oGUqESVitFc
         IFVsvBQrmIE25sUWEKLHhQWdyGsexcaQAemvtERNEZA5+BB0joFtUEqbLqg4XbhoMXxr
         3bPdfOShkOn4//XfHA90CSVHzcORAJX0lwJ4g46yYZbFX0vz2srddull3pyYQZkaTtiJ
         Jjtw==
X-Gm-Message-State: AOAM532KSMq4VOer4Wo8DZDZ7UieDL7dlG+42O9CtQNzz5q3yROM1g+J
        CW/heAivApwbldEyJpGaNI8aCyup9A==
X-Google-Smtp-Source: ABdhPJwldFqpTbfajaFXWNrJX3ZXShEvmpEyVyn9WWq1XUdWN/HHO/Y9FjyIOfXlhbvUoQlQcowRnYznoQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:4f0b:: with SMTP id
 l11mr625490wmq.0.1638272717644; Tue, 30 Nov 2021 03:45:17 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:14 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-7-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 06/25] kcsan, kbuild: Add option for barrier
 instrumentation only
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Source files that disable KCSAN via KCSAN_SANITIZE := n, remove all
instrumentation, including explicit barrier instrumentation. With
instrumentation for memory barriers, in few places it is required to
enable just the explicit instrumentation for memory barriers to avoid
false positives.

Providing the Makefile variable KCSAN_INSTRUMENT_BARRIERS_obj.o or
KCSAN_INSTRUMENT_BARRIERS (for all files) set to 'y' only enables the
explicit barrier instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.lib | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d1f865b8c0cb..ab17f7b2e33c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -182,6 +182,11 @@ ifeq ($(CONFIG_KCSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
 	$(CFLAGS_KCSAN))
+# Some uninstrumented files provide implied barriers required to avoid false
+# positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_INSTRUMENT_BARRIERS_$(basetarget).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
+	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
 # $(srctree)/$(src) for including checkin headers from generated source files
-- 
2.34.0.rc2.393.gf8c9666880-goog

