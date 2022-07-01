Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27650563560
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiGAO0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiGAOZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:25:56 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFBD443D3
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:14 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id ne36-20020a1709077ba400b00722d5f547d8so828600ejc.19
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7LZjp1LTGSiY93TRZ3g7FZorW8E9Cp1phv1xqeqiFUY=;
        b=HUp0QjEtL3POjFsPVmW7Lsr6wHh3uP0c3AIGbejYW5WBVEEA51jhGDXufEvS9+1OoF
         4uVyuJc0WeTwbfhCMIs+rmrcOAjTWABoSd8Oaw1teEbFzU0MKdY/z4Slq6iDFA136+6A
         Dq0ghLvrTYYGXMowWhh/7yEVnmXH6kNFujWdairYknULTqhesx4Yk07JTgMa2g03KfDv
         ZrTJqfs2WDDcnPD58XjBPdAHHwnHRzjgo5idM+mqSJrORCqZ/jLttEcLx+95oGm5NNfU
         HQHKB38oaAiXzo52FsKtum2XD5ZN4s5oCz9X6TuacgVJMlaPcY5XhphiQ91hDBCbdhJB
         tKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7LZjp1LTGSiY93TRZ3g7FZorW8E9Cp1phv1xqeqiFUY=;
        b=yBJ3AE1ayICxFRAtWUZHleTT/h3P41UtNVYQJh7gU+/HvRMrhhPxIASmYxA5p7IF3E
         7MGMbK9ayhuJDrf42bG9l+ELxe2yN6NRXf3QhTh8cRRkKYCY08qMHymNU20lbJy36MqI
         YyruXXFCjkuxEqLcUm+kbDJ15DaT9+rVaV21VbvfPrfVXGICA8q/FNcLJ/t70pEqSZp3
         Hs/mHJ/nRmZeMuvY1vpXgINwcKoQFhzrnWO18U0mtwXj9hireAw0AKWw9zjckVt3uyMq
         jDIpfZ/Gmeg+AOhq/ezI2GcdIL1QQWvUggirBVGuBwipJwxKayWpTVd1juPBmJd4G4Un
         GS/w==
X-Gm-Message-State: AJIora+ImGJKdFeLNKKcTLiefnbgKp05nItKrj2DV3SqXZk8utm7IHxH
        XnVV9TyAKkXVhMJDp8lywkTeIXBMdbM=
X-Google-Smtp-Source: AGRyM1sKIpsY5lY7K78S+NlVsi52z6DpTXM615RMvKRvttRlQPej/Daek4sIgXeLlq3X+zfaa9FMqF7k7ig=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:4493:b0:435:8dd5:c951 with SMTP id
 er19-20020a056402449300b004358dd5c951mr18955210edb.289.1656685454405; Fri, 01
 Jul 2022 07:24:14 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:46 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-22-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 21/45] Input: libps2: mark data received in __ps2_command()
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
2.37.0.rc0.161.g10f37bed90-goog

