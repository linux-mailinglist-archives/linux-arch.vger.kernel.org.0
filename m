Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B0510463
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353381AbiDZQvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353320AbiDZQvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:25 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B726488A9
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:16 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso9388287ejs.12
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZO+Ar5AUQjZ17sp8HnLfJ3bnZDmnQ4HtehVjR2RSag=;
        b=Pt5+odsaPLVLA+BIkFaOGZ5z3uWJenSne3f73BJt4PbanWkfmtsct7CN0wAO2xN5gU
         Yhaxk8FOCzZhswyeeTNVL8OMhm9c/T3iPCztTqmlZxSpLpgMOs6YXH5MZ/fx+97iCGvz
         zddbne3cp5tk6W6voA6FNsecjeKs0yW1DQ4Tz30W1QM+yA9fVauckWd7D4HpMMiv8n/u
         VNAOuyzoM5s6YO+8DH4/mHKvxm5uilD1LTm5hSJS1BnACQmJdUQmedoVo1JHnrQYqad/
         JlxuIlepoOSV3NlP0UfaMmhcA4Fr+PZ2URCMg+I0v/ZRX2C/u5IO3EAmXGa2X6k+fRQb
         I4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZO+Ar5AUQjZ17sp8HnLfJ3bnZDmnQ4HtehVjR2RSag=;
        b=Z5y14LZizGNk+z7JP3e0R7LyOdw0D20KqxI6H4nzsPVkVIBsKo4xyTBTBAg02Xkq6A
         N1GxTFDLLept0z8+Q6ICvJG66qqwmTdQnnwH/4hNsNNO3iEC1NYNhuwHp0oBKVHqpRR2
         FW3WEG3rNCOMYkbAd8w9I8tiMYPCIQ6+0vy/JX/3I+i4dYLPgqwTIXhQWgGy3nSLO9A3
         O41tUNuCm8VxP/Hu3KbEwUg3q8gq6yoOZ1BEu4sIzPPS+YEFfU5muysYobxlz4tatydH
         0seW/VD5pyXUoHHngoj/lHyucEGoT90cXzA/Plu543QdgjuRA5hwo5sTygdLu22RASm6
         +Ing==
X-Gm-Message-State: AOAM532ihD9Z8mg5MCZQ2+7e5HSiquKHVM6le8zr3TzeXGklPWiGEAge
        PRS64Fo6j7geSIGq0kHHXxXzUFdXkNo=
X-Google-Smtp-Source: ABdhPJwC/1Ho3LFpscyKKysPm+tD7uHD3uvu1NdPCEt5vju65j1NkGkMRTYyimkaio71xSi48PC422JlIc4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr26075746edd.33.1650991574553; Tue, 26
 Apr 2022 09:46:14 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:13 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-45-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 44/46] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
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
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
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

dentry_string_cmp() calls read_word_at_a_time(), which might read
uninitialized bytes to optimize string comparisons.
Disabling CONFIG_DCACHE_WORD_ACCESS should prohibit this optimization,
as well as (probably) similar ones.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I4c0073224ac2897cafb8c037362c49dda9cfa133
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ee5e6fd65bf1d..3209073f96415 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,7 +128,9 @@ config X86
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
-	select DCACHE_WORD_ACCESS
+	# Word-size accesses may read uninitialized data past the trailing \0
+	# in strings and cause false KMSAN reports.
+	select DCACHE_WORD_ACCESS		if !KMSAN
 	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

