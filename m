Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5C5A2ADF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiHZPQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbiHZPOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:14:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C9237EC
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335ff2ef600so29337077b3.18
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=4pDNTP8Rcz1c/6m0qOjb0X1O42ovrN3YaDrJNkQcLng=;
        b=D8g9K+F2VtTbVGCiyA3gHOZ8vWyfLv3kiBVO8NzVmbbuaiAQz5lidowjJcTUnqN9NV
         0M45L50FmJ4PxOKToUEzR27CpoNoU/oyH1Qxm5OUEXk0XU/8/XXprRa1vk5Bi3TeJfkw
         q081N/bHUsn7mQv/yoQ1Ey2nzz9m+S9Fo7PM6zBWmqx38XFTQk025tvKxOEGgVZjqGty
         /9F1JErkTDPulPdl0zxIDtlkVyQUOPBuGPdH9gBMfPQwL19d8No0nlzWwOQohCYKDZm6
         MPulEwsqymX7KjroU/sIuuObTC/BUFlxcZTS2qy9QDHhU8TveQCUg6HprGxaMBW2ev2v
         GJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=4pDNTP8Rcz1c/6m0qOjb0X1O42ovrN3YaDrJNkQcLng=;
        b=E94yQ16zxh26hJo2kGQUdmZVuY0J/5xJHI8uojATAt78G0Qu+3815bUtV7ck1bLXyu
         LFxBrAVHwDYqQDr2GQ/575ChgOvjoBrVoh47kikiFpxePRHaGE2CHOG0FkWFMHsO+5lt
         wdRm0OhSBbiAp+MpoAKDQfIcGZPQaeW6uoT/DrDcNxpkHH2If0DHcQAxlNg2Vcm05rad
         J1Bvn4OXfyGpK447yBJ9h4qZyfAIYqv+yos88qRX/HtEsE3bCcnAyZw9yy4gFapB/7hr
         SXwro48hp7wfBXkZ5X2g0xMjV6CMsF6naW7FjJL8wExRw54wbRDw/06bLHDZ7AOwdWlY
         jWQA==
X-Gm-Message-State: ACgBeo3sF18JsvXK4M3UfuUNIeHFBXv+7MAtkUeqFgohdejoHJZfCDo/
        AnCU6wRL0Rnbkg3aMcyEcb1534Gvr7k=
X-Google-Smtp-Source: AA6agR5vVQmtlhIgTKQ7dnFjHT2Qul1eY6YRiLp6VijdR+cm0ab1oQKWZ6dDBOhtA58d0ZDce6nTKPF8G7g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6902:10ca:b0:671:3616:9147 with SMTP id
 w10-20020a05690210ca00b0067136169147mr92484ybu.105.1661526602616; Fri, 26 Aug
 2022 08:10:02 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:02 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-40-glider@google.com>
Subject: [PATCH v5 39/44] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
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
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 33f4d4baba079..697da8dae1418 100644
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
2.37.2.672.g94769d06f0-goog

