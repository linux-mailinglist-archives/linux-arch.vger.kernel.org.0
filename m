Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A2563564
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiGAO1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiGAO0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:31 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950864F1B6
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:29 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hs18-20020a1709073e9200b0072a3e7eb0beso843661ejc.10
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BanD6+8XMfAM/imhDA9kzvs2Y65ZtmV55Antiu9BWiI=;
        b=mRTIF6L84JAlg2BdRm6GzX0JAROwRk/sEAnHEyfcCrrVzpgYQDP4s07FuADnqgr6wB
         ksMNaoreBTcwNzLVqW2CLQ5LB7q3aAIulZLYB9nuQCnWIkiiRq/Q6VQMDSS0zlOVULIz
         Ix5FQ2wgYo7L210aM/fKxFuU2tFPKcIZsO4Bd7Rml1N7o3/Qm7KUm5NB65g2Iem/FeNl
         60bw+n3Gge8W8wvYFmfBqE0m7x4Rd1oXGrEp9Fu06BG/VFY3yN6zDkc7HdcrNddl9RFZ
         bKRR73XyhRvmnmBNBCirP4336bKCGzJJU7II1NZsV//Tb+lcEnJtFA9n/GAdR4WOxrCR
         uhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BanD6+8XMfAM/imhDA9kzvs2Y65ZtmV55Antiu9BWiI=;
        b=SrhzZPHWFNq6ciSQW0wycsnwk9DIBrKi3VXPI1XEUWSfWX5RY23jWT9eTrDhEWmJvi
         mFGs9bYT4sK+OL5N8vpH5FPZ1dbomX8GFL2mUTdhQ8XD0xDIR17d231rgBGpkMmwKccp
         e1jF0gVJcbjt6J+8EkihSdY+Fj0dGtjO0DpGFc9rhJm+VZd6aIrcQ5BRQuYRRVqhIu55
         QJVEw7InBlkEMHxGTBjqstRVPoQOdY4+vfkP+aJyD7A5y0yUTDBwqEjIRrbufD2uCh7y
         sojgugP3QeIxLXk4BQyFE6KY5IkmabbEptpTtnCRBtEL3tWaYPZWKkbDKpGx1wzX+/Dx
         sB2A==
X-Gm-Message-State: AJIora+i4KWyLYlCos1+GXf1vKwLLex/zcIfPKjeT/e3dVdX4g3OkhFq
        cnB8A2xcENeInRlz6ORBU3ogITpjmek=
X-Google-Smtp-Source: AGRyM1siOEbFYB7M2t/Uxp+hgW7r6Fq8QtqzrawcUEK1N9TlhUHD1diimHPgmIHCv/uA9yMN9zjsG0VRP+I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a50:fe0c:0:b0:435:510a:9f1f with SMTP id
 f12-20020a50fe0c000000b00435510a9f1fmr19625057edt.297.1656685468052; Fri, 01
 Jul 2022 07:24:28 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:51 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-27-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 26/45] kmsan: disable strscpy() optimization under KMSAN
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
2.37.0.rc0.161.g10f37bed90-goog

