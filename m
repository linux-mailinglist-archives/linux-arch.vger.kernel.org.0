Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E646B4EAD85
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiC2MrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiC2MqG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:46:06 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9123EC44
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:56 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s9-20020a50d489000000b00418d556edbdso10960896edi.4
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RDAmLqPngdYXKHnjNo9GDMAFOLr0Hdlw9RyMH9Gzg2s=;
        b=FNcO9gUSy3+PyH4e35W5RF6+lKn5SBE99oNAhVPz9pbYEq9m/C8L6ZgtW5ZmHXHd88
         hQHJyPhLbOckmp0EqPMhP2HFzsxaGQxiGxliYPsshxLsXZvRvNDQ3UiI+w2rcId/Pty2
         F64ZcwqpBt31uCBn0TdlaFTImU9JlBg1RYV2VHIqSgThEHMQahV/qTUZD+t5uPqd7ue6
         fH/tn196F1PiJHLimD7A+gQDUww4aLBtiNt+XEamDrdfD269XRiydzui+vDM+yTJPgEp
         rF70JXIzeqHaym/T57YbYOQSbgbJ7VSdFIY7t07gue+zb/IWNfau8QfmJWCRW+7p6THF
         iMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDAmLqPngdYXKHnjNo9GDMAFOLr0Hdlw9RyMH9Gzg2s=;
        b=ehk7B8lTYFL1IeEZAmcYAWY5eTjE+FhQKvAPiGYoaSsykfjTJ3/HcQV8qpCHs0rVFp
         AHDmEvbl3qgz7p/ne7jlGnhNRbSeLwJGa6gjul9CrnuGXqPJ28BKfwlarNKQKvM+o/Op
         AdcRbUthHFxutnCCBhpClGmPQpa/AFIfFB4pqyNADla3mWUjJEH7HIygbz59nJg4KvLR
         IuLt7Z3s2XHAFhm+moxwqflTvrUEziMaUkyqB6lmO+SawruoK/eayuSsTfGb+9XfSt6v
         s0A19mbu4eN+IZ9/8V6HQ2+aLXpiW/5q+IJ2WVIl7bLxebU37/1FXGAlPHygig+ILijz
         Js5A==
X-Gm-Message-State: AOAM5313IPUCMuFCLcZiouHFzZTapNF4wcs94+o5qf7qxSLTTVxq3G1r
        vt3SG9A4Pl7jM4m8y72oEiyHni5TL1w=
X-Google-Smtp-Source: ABdhPJzvRP1sTqhryqj6ueAWd65Bk5TF0Xd1dq7WPSkbBowXyk0DvSiadnoCaN6qak+2HIZ7cYi2Zk2fLDo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:af6b:b0:6df:83a9:67db with SMTP id
 os11-20020a170906af6b00b006df83a967dbmr34685899ejb.222.1648557715258; Tue, 29
 Mar 2022 05:41:55 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:01 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-33-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 32/48] kmsan: disable strscpy() optimization under KMSAN
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

Disable the efficient 8-byte reading under KMSAN to avoid false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Iffd8336965e88fce915db2e6a9d6524422975f69
---
 lib/string.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 485777c9da832..4ece4c7e7831b 100644
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
2.35.1.1021.g381101b075-goog

