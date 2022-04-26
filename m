Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58571510440
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353269AbiDZQvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353188AbiDZQtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:49:11 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DB3BBD7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:22 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id dk9-20020a0564021d8900b00425a9c3d40cso8109962edb.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A4BOD5bYYCwqT6UysGwaTqw9NZkJge0TWQm9U6+WrG0=;
        b=khSFQmZPrfoPgxGEUABi/FVW8V9rw4+gcS76epQACJKqyg7hkcjwrrNZSEPqT8cKN9
         ONCpTChsOEZ0awUUpbA5x5xayPRdehOMzeg0fmzK8U1O+otCttBP994AhBNpWeRijLhC
         uA0BFEVHSShFszO60gnvZ/g8XEEAvlCsHxSsQtTYtMUoAiTqbiLeIdThYaket6Dbkru7
         YLDTtMsAFMm7WODYFRUO4LbdZSTFrmTAN4yb5OHT1IcBSYVtVTBthQ8DYmMN9xjdT8Y5
         P4oaK9oxiUba69g6lk7NgMT+HmLDsQRoGLtP+vFJRnamxCbKjs/0LNdi6KunA8g68VkO
         EfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A4BOD5bYYCwqT6UysGwaTqw9NZkJge0TWQm9U6+WrG0=;
        b=DAFY6HvASob8QMBaeI5S61UwBEN/KRIw4sgmpMHPlBDbBDla9DphdDIWfx1BMARTVe
         alFEvOzN2eyKN91ZF79egVC6SU4oiA6/d7dyDcMoSHaVzCfyiEpFHQU1igYHvuoPJ5/e
         XpAhDfWLh1GfyV/wpSflVszPS/jhVXALm5juLFPZuusekvaIqQFyWWWsvI2/uk3h4aLP
         PZ1aEp7JAqNiSKoU+fSmbtJefQY/tAQrcj4IqirLvYCCH74n6VuhokJjI2+0O/1bRPxx
         6CqVHNdC5NOknMhgpCPjw2kPYqm6sYdcvGS/hElg8FDC05yL48BOZQ2yyo0LtRjFtYRZ
         doiA==
X-Gm-Message-State: AOAM531J55B8qWZbWARR1dlsMc2Il/SKAB9hELTIXitW8J8Z0QlCKC3F
        FyVmVaVoA9p9AIvVa/3kUee1t5M+FP0=
X-Google-Smtp-Source: ABdhPJxAop9pzi2nkfiGiO4x6mNOPP93/Bjni9kA40EEqg0TirQbaSSuyCXI2m0QfvecUipohdkmvzvyeto=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:254e:b0:424:244:faf with SMTP id
 l14-20020a056402254e00b0042402440fafmr25661420edb.260.1650991520418; Tue, 26
 Apr 2022 09:45:20 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:52 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-24-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 23/46] Input: libps2: mark data received in __ps2_command()
 as initialized
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
2.36.0.rc2.479.g8af0fa9b8e-goog

