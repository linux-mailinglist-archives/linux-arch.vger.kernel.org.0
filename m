Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2566AB255
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCEU6H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCEU5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FA1A971;
        Sun,  5 Mar 2023 12:57:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so30868942edb.3;
        Sun, 05 Mar 2023 12:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOf0dR/RPpY4HJc+yEr00P2lL8nnE6ZdPZ2RnMEV2qQ=;
        b=AzC0MtpS6jzuzYUPFsrIfgSP8aZbYwDqq5a+izUb9a0flhuTk9IJhffPMtswIUk4wO
         sg+KQDUeI1WfTBjEPCVkavJWGZOiRXkonvodFjQekv1AtQJNs5CNYgKk72i8myvpgGVe
         K9+Gcl430QJD9AbzGRenEZ61TH0KIeWK+0iYs+J05wVbAMYgv5sIn3w1+Cwy1JerQSRC
         KH89b71gdC8EcpGw2scdHdGW+tPap0uAwmnq+3aLE3kGWG2fm1xZDaMDvjLA9woC5Ulu
         0/MPaQHFdc8LJgoZ7thFoEH3DKdiynUC63aS/FSnJG4o6I/92Na/lIc5Pd1rCjK+C5wU
         iyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOf0dR/RPpY4HJc+yEr00P2lL8nnE6ZdPZ2RnMEV2qQ=;
        b=lXXC875qzJBk97mWnH3HGiylLgq+dK1ccgC2YUvS5YscCBKJ1fqkUKGGr8Ve6Emvrl
         RvWlYvYSaWxfUIKSZJQs0XTysDdUxCI6gH89XHoDM8Smlfso7ew8+PKny9Kj6MxzKdxO
         zHO0Ws3HXv1AZ/pCxhjUpccl+7U0kBWyA72mTZEIaqnfdAKMJzma3VGd/KyPGAelN1f1
         tPCCiVGGzHHLiNHZzJLFF/0PD8WcHkBXjqWUELq5JOmGJFREOLPUSH7bu/IAUFJpJyN+
         jltkfBOoX1cscW1OvGgiiXbQ+aRgVxQ3HItbXtFgzr73iwzni2wWACyJlMkKN+o56Sm+
         9gRw==
X-Gm-Message-State: AO0yUKX7S5WS6mp0LAgTKbj/sBvr0QGQCl6fdj9U+hImFfPGdUQnwGpQ
        ipDaJdgenH7BHYv6HG8u5KhRzmREgw2I1Lh0
X-Google-Smtp-Source: AK7set89glUReQEBerTf3N2tzQKZj5f2Ne8jws0vz8p+B9w+amQ0mlW3rs5ChgaK3OjP1RYo4BNMlQ==
X-Received: by 2002:a17:906:36d3:b0:8bf:e95c:467b with SMTP id b19-20020a17090636d300b008bfe95c467bmr7987952ejc.63.1678049829092;
        Sun, 05 Mar 2023 12:57:09 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:08 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 10/10] perf/ring_buffer: use local_try_cmpxchg in __perf_output_begin
Date:   Sun,  5 Mar 2023 21:56:28 +0100
Message-Id: <20230305205628.27385-11-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use local_try_cmpxchg instead of local_cmpxchg (*ptr, old, new) == old in
__perf_output_begin.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg.

Also, local_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/events/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 273a0fe7910a..e07c10f4d141 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -191,9 +191,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	perf_output_get_handle(handle);
 
+	offset = local_read(&rb->head);
 	do {
+		head = offset;
 		tail = READ_ONCE(rb->user_page->data_tail);
-		offset = head = local_read(&rb->head);
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

