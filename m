Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D086FC490
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjEILIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjEILIA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 07:08:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C42100D9;
        Tue,  9 May 2023 04:07:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaea43def7so39203755ad.2;
        Tue, 09 May 2023 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630476; x=1686222476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R6iz7vhNREjSraKI/ERJgnxMAZcQTBbYu48OeVh6tw=;
        b=peVOlXy+wgj4HtoPCAT8un5A1/kZe5GQNZp5Py1YiLolNO8uvCN8ROt7huW5c1SfBe
         73FCmGFWKK/Lv1ENnxDgNuy7J0vza2RSumYaR4iEJPMAPmhCy3676qRS5CTmqas2lRsu
         Z5LrZ+/fUzpEg+2cqSlILioI5sFDhaqjIkEDB4LCiihPr96cPPSvjBS8akNOb+2Z6dZJ
         JMXHk+St8pzc1HAO/moeIN0t8zaBPCVYtqJievRo8+Y8g8Ag0r2B+2TYKXgaAcRYIdzc
         Gj8FRQb6GfsNFcK6b92dGs1qtnoStT6b5Ot62ylkU/JTsMucZUh5uttNPyPXmQ2Dt8/Z
         0TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630476; x=1686222476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R6iz7vhNREjSraKI/ERJgnxMAZcQTBbYu48OeVh6tw=;
        b=fMNHz/cZQY9yfA8AMD6uU3v4E1GTEXZWSIw4do/CmQGDGavkVLHdfcNtTjpWIwH3AX
         zqG5Iv2WV9HY00P+s4AbHycP4TextXCpZJSBk6Iu9R98uqdlze6cm8rhRTpF5GNo+XZJ
         PkRJmiaDzCxpVTiZr70P3UTQ/74OseDEaVzESLM8jb4JufrAJdTsGw9e3UqD/SVugJ4Y
         MIsujIhiKueUSn8+Bcw5eGKPrW7SL/g/gZmYKTor94QTnYtW7a6jF3o9/RtbVbPNi1MC
         qDXU9Bz5qyNr73LFFTivKVQj+BB7iNJWxka5CaPob2FGrHEyDpdrNlA94PZmicGA9QNq
         6esA==
X-Gm-Message-State: AC+VfDyHorbRHhf26xFXDUpjgXzUEZ7t7r9eTfY/GJ6BE7AuT9v6TzOp
        XXnOj2o82IVTVUiO7ZiueO4mN++4id8=
X-Google-Smtp-Source: ACHHUZ5JEHERN5ui0LUZt148z9utSOlWeGFhOmEZVh6IvZdMVJUDECIQ9PzvYAEPIFoJ8zak3UvyzQ==
X-Received: by 2002:a17:903:1ce:b0:1ac:a02f:c9a4 with SMTP id e14-20020a17090301ce00b001aca02fc9a4mr1435118plh.4.1683630476067;
        Tue, 09 May 2023 04:07:56 -0700 (PDT)
Received: from wheely.local0.net ([118.208.131.108])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090270c500b001a641ea111fsm1269923plt.112.2023.05.09.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:07:55 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 2/3] init: Require archs call start_kernel with arch irqs disabled
Date:   Tue,  9 May 2023 21:07:38 +1000
Message-Id: <20230509110739.241735-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509110739.241735-1-npiggin@gmail.com>
References: <20230509110739.241735-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's require start_kernel() is called with arch_irqs_disabled. For now,
just correct that condition and print a warning if CONFIG_DEBUG_IRQFLAGS
is set.

This prevents core code from disabling irqs when they are already
disabled, in aid of eventually adding a debug check to catch that
condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 init/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index af50044deed5..f3979628943e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -889,7 +889,11 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 
 	cgroup_init_early();
 
-	local_irq_disable();
+	if (!raw_irqs_disabled()) {
+		raw_local_irq_disable();
+		if (IS_ENABLED(CONFIG_DEBUG_IRQFLAGS))
+			WARN_ONCE(1, "arch should call start_kernel with arch_irqs_disabled\n");
+	}
 	early_boot_irqs_disabled = true;
 
 	/*
-- 
2.40.1

