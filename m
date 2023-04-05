Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34B6D7F22
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjDEOTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjDEOSe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 10:18:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25A30D4;
        Wed,  5 Apr 2023 07:18:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so141537725edb.6;
        Wed, 05 Apr 2023 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680704276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX2Wz3EA82OevW9OfamI7/Kvuo0JRd1kfWWZWf7tBPI=;
        b=dcJpf62STM2t7wBeMFWRHA65D4e8ki42FaDdkuuO3agKqVH6m85Cy4lQ8Jc6WqjxoF
         fnnlug9El9w16kuSLGTsPbq74oNaQ+P8JDxMAcNUZHQhE8u+5jySMEVYMmtE4egR+MrD
         Yo63AeJfrWzh2LWw4CUsO/Jz8F4pDt2KwqewSmosxEslt2xhDsBYXNkotYBZ0u2SUb3b
         bY44Ptodk1vZVbJl1WFw1p9lD7pDptPbaK3ykNtKWYarwScxbwyxAFGsy3vIZ++4+u08
         7sJWtj5rpBofs9g4DRnm1uwhZ6aYf1PTSfC6VMfZ4+8IxgDtdbMLLd8hp6MXeYVptMAQ
         HEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tX2Wz3EA82OevW9OfamI7/Kvuo0JRd1kfWWZWf7tBPI=;
        b=8Fv0C2oIfqzNYT5EW+Tebedn6a1Ldu9NM/vBrhRq7CyNBY4FmBYj1uhTF7Su/c3M3U
         +bWh7mJFhOE1/scfDX5mvoD2CZ82P908e80ZyKPVSrvtDNI0hj6ymAgzKJtKhUOsfWM7
         l4bIzBj8JybWExmvd3VaHc4+N3Q2mB6iGELdrq6QJtXWqQbpwDMytWmQIJE6PKpcS3QU
         FH5U+nl3f7O99ZIKoNUQ1OKdMilAhOAthnIAGECaiYW3qwT1bHmpzmRRPNfY4QfG19iO
         UL42ezOQuqlON9jKxv5jXBDSzRDbK5/JHopJXBGB/ozSxj3r7tiUU6mbWVcLO6yATzST
         F9tg==
X-Gm-Message-State: AAQBX9fc0h4azbPJSz0jkkBg6V292q7RU6RF1kS7yKIg9+57Iup0iB2W
        bmLvBV9umLIo0SrmmU0i+mQ7yrs+Fs0vyMyw
X-Google-Smtp-Source: AKy350ZbYZNSgst5kJdLcblY6mgsM4CglBWBhr5I5xeGEgTa/9eOQOFET04v+j0TrQ94wu4NswT8dQ==
X-Received: by 2002:a17:906:53c3:b0:947:791b:fdcb with SMTP id p3-20020a17090653c300b00947791bfdcbmr2772881ejo.21.1680704276052;
        Wed, 05 Apr 2023 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b009334219656dsm7381246ejb.56.2023.04.05.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:17:55 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH v2 5/5] events: Illustrate the transition to local{,64}_try_cmpxchg
Date:   Wed,  5 Apr 2023 16:17:10 +0200
Message-Id: <20230405141710.3551-6-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405141710.3551-1-ubizjak@gmail.com>
References: <20230405141710.3551-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch illustrates the transition to local{,64}_try_cmpxchg.
It is not intended to be merged as-is.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/events/core.c      | 9 ++++-----
 kernel/events/ring_buffer.c | 5 +++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..d9310e9363f1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -129,13 +129,12 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 * exchange a new raw count - then add that new-prev delta
 	 * count to the generic event atomically:
 	 */
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
 
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev_raw_count,
+				      new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 273a0fe7910a..111ab85ee97d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -191,9 +191,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	perf_output_get_handle(handle);
 
+	offset = local_read(&rb->head);
 	do {
 		tail = READ_ONCE(rb->user_page->data_tail);
-		offset = head = local_read(&rb->head);
+		head = offset;
 		if (!rb->overwrite) {
 			if (unlikely(!ring_buffer_has_space(head, tail,
 							    perf_data_size(rb),
@@ -217,7 +218,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 			head += size;
 		else
 			head -= size;
-	} while (local_cmpxchg(&rb->head, offset, head) != offset);
+	} while (!local_try_cmpxchg(&rb->head, &offset, head));
 
 	if (backward) {
 		offset = head;
-- 
2.39.2

