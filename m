Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824785AD2F8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiIEMaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiIEMaQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:30:16 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612C60698
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:28 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w17-20020a056402269100b0043da2189b71so5641103edd.6
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PRETZsLeKtd8er/vGZIvwJ67UbRQnpYPS7VnNd6iitc=;
        b=Rw0JSo2mfA53wv1KbqcCFIJoJCKgB38eiEtze1NtffAs06/flW4T57bbg2dVgmm7vN
         Qgo1uiqbKJaHLIYDDiLsbIbsnOBwXkyph/jL1jJt7c88fQk6BTFd9sFusdBxHhx6dDYE
         u5T3ewW3kKrqDUiYOfyUWYtYPe4wTLLwz6YktJHkCggWgZlXMaXpy8DUIH24zJx2XEu5
         /2ZJizHYM8tdojTqRxVSOKMfWIBfh4BQZl9kEZRZrxqDuXDq6LhgmA36ysx4Fnd4wn/z
         RXSYyqOZGt5AmWmyGx3znX+g0JifZp9ZClGm7haZUkqafRea3A16fYJTpOu+ONa6qpWB
         P9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PRETZsLeKtd8er/vGZIvwJ67UbRQnpYPS7VnNd6iitc=;
        b=k1NdlSAfmUZSlkdc0HGXqleftpQtkluxwfy6f1y6p1eQWSaQQmpqeIGUNTG0zB/hA4
         ZCZUZUVP8KSsOm8J41R/iGiWU5s5oqE6zc1Kr0v5nWCLxtKR3jHM1sDhfJ6zia5eEu6f
         xE9fClKkmx/2yajTAUUDv1d+1LzngniUE7tXGb7QpYfFCDFNBG+6CpSwADv0FU10t4sw
         WBWR8zxS7ahiFU5uApeY3wnkjT2Xp9c+/B2Slsu0x03k+7mtGAKS4Lkzh2Gfz5lNcp+3
         Yk7dUL3VGJFpoIQrsXEfKbBXGEafHYk5fc96Zr1jhW0oKZGf+Rtlq4pZ349IGTbR62pt
         5EvA==
X-Gm-Message-State: ACgBeo0QlCbJoH26ng771rHVEN8fcAT9HwSZtJdU774XM30ZG7Qs87Px
        qnX0NJTFtt1CBz5nZcPBLsgiY71Sb1w=
X-Google-Smtp-Source: AA6agR6H7t7tR3hDwMYsSl5f8ymL7keGAQBGQoCYb8T9aH1rg12oi88mnhysrWMbCn39pKzombeP5qdOg3Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6402:4515:b0:443:7833:3d7b with SMTP id
 ez21-20020a056402451500b0044378333d7bmr18008265edb.151.1662380769211; Mon, 05
 Sep 2022 05:26:09 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:34 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-27-glider@google.com>
Subject: [PATCH v6 26/44] kmsan: disable strscpy() optimization under KMSAN
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
2.37.2.789.g6183377224-goog

