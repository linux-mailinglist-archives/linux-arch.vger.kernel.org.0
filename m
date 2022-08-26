Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056D25A2AC1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiHZPNo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiHZPMa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:12:30 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5506DEB69
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:30 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso1248267edd.2
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=78OHj/gzoCKqAY5c+j3k9RRp1IwnWy2nlunSdcq054Y=;
        b=infDBXfaloZqVmGL5DNRFAfhMOqS8NqxfxjZ9dKspnlgueeDAHoYYH+4Gi8exWGIuo
         Nw/AkcesiN61mybTdSO3jhwM5TKCtIZhjXZo1HG7sK+cjrWBUsaf4R/cHM2iBvYj2bOA
         WkeD3rhneP4hNHRSfpfEujFgSGje7KupjxgjkfUMA9MS0vN6o7veSyC7WryDqeiljwvb
         FmhY2QfU0D3vj7dQTHo2CxstSRJlqjkORV6jtBYWg/wZqUdM5bvjWUyfkBV2EDhFtv/1
         Hn+WikD7nGPTrxjpCCiMPssZSlPqnH7OceYjz25N+b1EK3r2roffSRjICRe9X9QMXNjz
         qm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=78OHj/gzoCKqAY5c+j3k9RRp1IwnWy2nlunSdcq054Y=;
        b=auGnyTnBgoYyaxQNUmnGtvxrSukm1ri2XddqdpvWuEUc+d4vr9QF1fJ7jB28Xb1t+A
         VewK73WxEmdGkUH+I+tEuMal6fowXqfpU3BmdWeD1SnXBmqMDGrOEa02M3W1LlgIGino
         m01IEzjkaGRkPzaTwAgC/YMuMrujxwB0+hiubyJvFJCQuyiKMVhzMR9MVWW4rqCGADzT
         gneif81dGfXbkAhh9GkcM7LAfddZeSZDFXMAEmFjYVhHbqa0uHW4Boppim/Pva3+QAGm
         kfqZKVp+pv29QJCE5gQsnsogkAC+A9hN94q098kQH6OrYqaiBIM5IfNtYO5ELF5SiqqU
         hxGg==
X-Gm-Message-State: ACgBeo0Vo4wsvUcFg5PoKGJGP/+d/eBCRscunMWsJQ3FhNltaP0Wwbpu
        2QxhBlP/pdxR8fpH50yWEhYEj+PthHI=
X-Google-Smtp-Source: AA6agR6OeypAkAbsTcwRMz6skRqVX67u6RKiOQC813CDO+HQWRif6q4KXUdIv6HG7IvLOSgOm7Y2kqCqBbc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a50:fc17:0:b0:446:861b:ee10 with SMTP id
 i23-20020a50fc17000000b00446861bee10mr7463262edr.251.1661526565221; Fri, 26
 Aug 2022 08:09:25 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:49 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-27-glider@google.com>
Subject: [PATCH v5 26/44] kmsan: disable strscpy() optimization under KMSAN
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable the efficient 8-byte reading under KMSAN to avoid false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Iffd8336965e88fce915db2e6a9d6524422975f69
---
 lib/string.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 6f334420f6871..3371d26a0e390 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -197,6 +197,14 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 		max = 0;
 #endif
 
+	/*
+	 * read_word_at_a_time() below may read uninitialized bytes after the
+	 * trailing zero and use them in comparisons. Disable this optimization
+	 * under KMSAN to prevent false positive reports.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		max = 0;
+
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-- 
2.37.2.672.g94769d06f0-goog

