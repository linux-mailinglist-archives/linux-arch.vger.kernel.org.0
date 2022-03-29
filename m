Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678014EAD5F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiC2Mol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiC2Mni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:43:38 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646AB23192F
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:35 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id i22-20020a508716000000b0041908045af3so10873210edb.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lsB3lK0aPu+8HWqdJ6/yM1q11PTSMtec/DSdWJ9paXQ=;
        b=Y2VTXLEBSbXPLu5uhbEKKqB5AO9gIHu9jp/jSny35LuwmGZ+c+hEVtLUWlhSpPVc22
         TxOvlY9Yoi7apyfs9Ow6Y9SD8BcLDmBd8zCFsJWqvD1r8+3P/s4FNpxe3VpbUFeGmI1r
         M2s3smZ8WKAQfLh/zIYUs4yveEnHKHAWaMCHAYZM2EsQtnTEE9sa+vHBJ2c8G01CB99w
         h+wWzCDc56ZhTweuBlI3h1rdzZJaGibE55vpeLcLzYyMpMH4Nsc8X53WytkodgNs2hJR
         4GEA20pYgJcw96lcVe50mTK7DAkc1u2xxRnNcQ3uEduO2cpHhhWmbgpFaG8L9ULcZ04m
         Xtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lsB3lK0aPu+8HWqdJ6/yM1q11PTSMtec/DSdWJ9paXQ=;
        b=gc4e1EqfD8oq9dge8P2u/iHfZOrMFHdLBBCePtcWux8vQBW0tTqjqzMPaf1Z0xHnkX
         g/3vH2qH33MY+50fMDneevTT8WIg5mjNWT/uQv+3VD4WafvZghJTZc2sO77axWen4FkN
         Fa+t0wmQhEvprJC5o3jIK/xR5p2EHF1dXHBqUoWW/r5fMeF63ba1j6vENnpUXjFjREBw
         wz6opHV4MjyBEedYaOLq/urqhOanglvkSyBrRKA24h/g1cEY7uuMLFacim1rYlM6fuZE
         YVslaBqaRsGZ69erfbmyVnZv0+QPf6uVDpnT0KlAn71agc9AG7nWMySj635PpDbpHxdn
         ZxMA==
X-Gm-Message-State: AOAM530uYDVRyBPAOH0p3SDn2DK4++diPjnTZwdXs01wY514CtadXZTm
        q/MjOVV7K1wV7nmZBQ3e8rLkqdYiCRs=
X-Google-Smtp-Source: ABdhPJxMT7rO1P57N71ZmYbIOwRuf4arJokbiW9dyI3uwrKnuskidOOGFTc8VrM1ts4i4n0XHHumgcOFJA8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id
 m3-20020a1709061ec300b006cfd11859e2mr34473282ejj.767.1648557693731; Tue, 29
 Mar 2022 05:41:33 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:53 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-25-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 24/48] Input: libps2: mark data received in __ps2_command()
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.35.1.1021.g381101b075-goog

