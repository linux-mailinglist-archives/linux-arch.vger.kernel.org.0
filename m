Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB9227D17
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgGUKbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgGUKai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF8C0619DA
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s5so13499710qkj.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vVlSyEcdwOQNKSx6Cnzx1nFD8CBubHuBwhuu4avdOuU=;
        b=vXrgbBZMeSjvDTESYkIbwmgjhHej1P9NPmtoI0jh82pgDLABLiJRVX4pp9/coI4VJR
         3OMaP53Sv9UFXLEOuyFlQ6LVm/IjXFe4BMvCzcgjNy/cDGZAfG4IYUrch2FwpM/va84U
         ZpbW3fDwwIPzU7/jN4c+KatCCX0HNHvXo48p7z9qckD7p8LscgFUMNf5iej+xYoar1h7
         mtB3W8wrurFcIwNEq703YUbX3QPhQzjMVB15yuF+fxwz3JFjvQ+48BeZDSMwTa1+2pos
         W2/Z1ShXiVoiRd78daIZJfsCNNYhNc+Whbprbm83B8mkONow9+d2FxLOF5l602RByaqu
         8R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vVlSyEcdwOQNKSx6Cnzx1nFD8CBubHuBwhuu4avdOuU=;
        b=s6OVqBx/La5nwwygHkmem7UXuwNfi0EgJPx0MCdbrie2/6jdyLpYXKPZhDOmx10liY
         p91v7OO+fRZbIf4YTrGYVDXYiGKMz6wb2zpJoTVzQcRT6pI4WFaxeIbwwCKS+jAkeJaK
         VkINsxWtn6JzLglixa3bkpPQ0TUq8e3n0Jb3KPfNBs5n7ualtXheksftedDTmyyxXHj0
         m64f/UDlB/20uCVRYq9+MFKrSb0XdvHL+ky/F3f6mXVYizZ/aU5vg5AkDeCNXFewDNOI
         qx4ZxSljgYSLwuySbb8xvV/oCT43ztxc2IHpZHURUI8tyZvSjCZwI0Om4JTFZz+A5Sr5
         oROQ==
X-Gm-Message-State: AOAM532Ip+3u9QRtvj6BG05xTjHlRYzx3oTdSxJrWqAJJLEdLd8kiV8j
        U8vBs9fq5JIKsYs1xny+DFMnjymz5A==
X-Google-Smtp-Source: ABdhPJw9AZJ6/Sq8gRuvn69c50PCI7j/zYVvTftn2YQFr3SnFEinKaitleRuJAZKsRV6Dc9/Ltu56y9PYg==
X-Received: by 2002:a0c:b48e:: with SMTP id c14mr26052857qve.47.1595327437707;
 Tue, 21 Jul 2020 03:30:37 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:11 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-4-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 3/8] kcsan: Skew delay to be longer for certain access types
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

For compound instrumentation and assert accesses, skew the watchpoint
delay to be longer. We still shouldn't exceed the maximum delays, but it
is safe to skew the delay for these accesses.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index fb52de2facf3..4633baebf84e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -283,11 +283,15 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(void)
+static inline unsigned int get_delay(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
+	/* For certain access types, skew the random delay to be longer. */
+	unsigned int skew_delay_order =
+		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
+
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay) :
+				prandom_u32_max(delay >> skew_delay_order) :
 				0);
 }
 
@@ -449,7 +453,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay());
+	udelay(get_delay(type));
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
-- 
2.28.0.rc0.105.gf9edc3c819-goog

