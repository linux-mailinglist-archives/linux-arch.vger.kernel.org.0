Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38D5AD2AF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiIEM3X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiIEM16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:27:58 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B85F232
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:55 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso5751986ede.15
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ZKRhstpgJFHnwQb7wa4PSp1fP2zpnAEklrA/+6U+C6A=;
        b=Xc6WWErxpVXx0dCndHy1SI9nJ2RkUM6KWSlEnHkZMNXjYMj3eWyaFlYc5HV6uVWOSB
         E83ahvzmgbb6ZUoBwYvIRsiXbOFt2hZ4fjxwXWmDqsk+RsSu6VyKEnzpdKQoVAg3Pqq0
         0CxCR4RVmo8KuqoAF4wGXJy4Xn+lesRq/0h9FAPZBz35/v9WUgk/GXkMNXrt1nuA+y/O
         IEkkGPOOeNrH3Y57s/Cr5M6o3FEDG8QCVpwR8LkyrdXQzfpKPiEHtVDv3ICpVu9P0YS7
         QddzXczkcNwySoyi832F6DuKvJMX2sDo+04A5YYlbMaf1CZbSK6nIYaRflozv//mECLU
         eOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZKRhstpgJFHnwQb7wa4PSp1fP2zpnAEklrA/+6U+C6A=;
        b=Um4dtnk5six8+5Cbz0LLVv+NgAZCJWz+cibyELJN/bblEnm+Xcbw5z3IKwHyvwKVy7
         ZPOixU2UXn7QzymbHAcSub2ZGYZiQAjUerSxxoWO/PZVRLZoA/OZmbdqakQ6u2Y9Tzhq
         EPhOeAmrxjMjgQteB5HAQCIvWwHKKqSmPIHRv8Z/j/nY91du3ybFCct/8etMhxaJz8Fq
         FE9Rz1aD2pVJY4p0Jn9ywuqfrrfr3zh/RtCnYlV9tFMqG18frgWuKWEeze8sIIPvDdgS
         YYZVolAnJ28SJQuKpmibCyd079ka2UpH3nLwYjdjF3iAKUe0ctI6GRStpWvhB7yTnlpU
         oxtw==
X-Gm-Message-State: ACgBeo1j21GBAbzTHjqLLteDTHZTOmOtzP5ZdcXzQBIcZkmiRtgfgCqY
        hQQJayxVlisKODLvDCdpwvzsntDAa9I=
X-Google-Smtp-Source: AA6agR5TErPcIF0hILDHYnMq9LaM3xtffYaYn+vk0P64I6LKeQp+A0rabHx9IAlhRIbYZD3eWmQ7V5DKx/g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:b15:b0:741:8ae4:f79d with SMTP id
 h21-20020a1709070b1500b007418ae4f79dmr25370696ejl.247.1662380755352; Mon, 05
 Sep 2022 05:25:55 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:29 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-22-glider@google.com>
Subject: [PATCH v6 21/44] Input: libps2: mark data received in __ps2_command()
 as initialized
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN does not know that the device initializes certain bytes in
ps2dev->cmdbuf. Call kmsan_unpoison_memory() to explicitly mark them as
initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I2d26f6baa45271d37320d3f4a528c39cb7e545f0
---
 drivers/input/serio/libps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 250e213cc80c6..3e19344eda93c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/kmsan-checks.h>
 #include <linux/serio.h>
 #include <linux/i8042.h>
 #include <linux/libps2.h>
@@ -294,9 +295,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 
 	serio_pause_rx(ps2dev->serio);
 
-	if (param)
+	if (param) {
 		for (i = 0; i < receive; i++)
 			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
+		kmsan_unpoison_memory(param, receive);
+	}
 
 	if (ps2dev->cmdcnt &&
 	    (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1)) {
-- 
2.37.2.789.g6183377224-goog

