Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E917E22BE81
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGXHAb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGXHAa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C746C0619E4
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l12so5216257qvu.21
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ROSpznE7uIV54LbFh2Cka7vTr1SComFhGsjc+g8qPz8=;
        b=utBhLhz3IuEbZPYCAASa4TiiCIGcqNyvrjQPgTsEQoR+sdOQGOenTw19TlehFH6aT0
         Vx0rBn3h2JjlTCyGiL+BEYfmeZ4ZrMO4jcgljXFe1jXOAMA9tPhPOqa0JkkgBfduX6/l
         aUdhpxcmuhjquy3qFiW3odpSvS3kPuUgq8ur914YAhVEzbmwHo1NAj1+tVa6llDAJbwQ
         6udGxxqa8kXqdnxs6IxifD7BbRli256RNYwgqPSFO7x5x89RN10V5vgfvb9TmJWrXdUC
         2muznV/iYpADkWSwqFqNVn9Q+Nw6wbJDbRkpesxMiqUyfXDTpj9nyzavmIG39MURM4q3
         COkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ROSpznE7uIV54LbFh2Cka7vTr1SComFhGsjc+g8qPz8=;
        b=ZMqP4Lwrhhiq9LFctYXZZXoK41EMnwWZHCesc8KBHzbd/s0tfxQuijnr1wtRyvwebS
         iVz1jN+CDBkkKuJT4FxLjmLLLrq5szHl1HoHmxPBIdPg+jidJ+Row3NMOZmniivQLwz0
         H3AvQZHyfL/WC+n44STfy/L6oGG4LjXCVab9ICnie7k3aKAfC0pcosRLKuRuaTEcSQEt
         PI152l2YkqQdIxZqZHGyvQ6sdlqfpUlxHYYshjtwQxQy+kZB0ZJnUC39EgLQNj3SdmNR
         wZJ1t2ANcXcKSRzsszJVE5tRygZb1rpYBlg4BmkPvqHLKBth8iJZ2CYr6c0N9KMUACI2
         8gZA==
X-Gm-Message-State: AOAM531tXpsAjP6gR9JYTZQJS0vmSaCcp4YwkkIpaRO+VQRl/VQeOrQ2
        E4F5ri5CIoAxPf8nui3ytfcPgkHtnQ==
X-Google-Smtp-Source: ABdhPJwdYVXI7+3Acs6ndY94bwhL8oxL71978la2lM/pJ7Xv0Lh37oWJb9SLOcZDQOKXWK3Mr5bT6RFKYg==
X-Received: by 2002:a0c:e78e:: with SMTP id x14mr8617576qvn.65.1595574029293;
 Fri, 24 Jul 2020 00:00:29 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:03 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-4-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 3/8] kcsan: Skew delay to be longer for certain access types
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
delay to be longer if randomized. This is useful to improve race
detection for such accesses.

For compound accesses we should increase the delay as we've aggregated
both read and write instrumentation. By giving up 1 call into the
runtime, we're less likely to set up a watchpoint and thus less likely
to detect a race. We can balance this by increasing the watchpoint
delay.

For assert accesses, we know these are of increased interest, and we
wish to increase our chances of detecting races for such checks.

Note that, kcsan_udelay_{task,interrupt} define the upper bound delays.
When randomized, delays are uniformly distributed between [0, delay].
Skewing the delay does not break this promise as long as the defined
upper bounds are still adhered to. The current skew results in delays
uniformly distributed between [delay/2, delay].

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Commit message rewording.
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
2.28.0.rc0.142.g3c755180ce-goog

