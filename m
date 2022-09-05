Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70E5AD2F2
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiIEMbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiIEMaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:30:18 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10A606B2
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:31 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id ga33-20020a1709070c2100b0074084f48b12so2253160ejc.7
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=T4yulc1U4RDI/lAlxqlpzG4AIUYO9fQrzg+B84ydySw=;
        b=gykJQm16KBq2G1POc9yawl2YF5uKFWxrq5CWIWwQMtdL8/Y4B0bJfVbxJTszw18YVx
         4E7qTI7rzio5nRVJ1FODUAtp/gLZ4JUBLm7SxRqEGBezrmCDsaRdu10ahEbwyMKOHAnS
         mL4d3XS2YrrbBWzFaHkAc86d82LPVwuZr9FNhGX9lMdqGF26zvlVbpRXEh8qRgLj77Y8
         76yFFAvEbnv46jD2CZU9sNo1Vk3UkvA6lYT1fvAVGXzAfOyNN03DhtVyXZh9WTPSiISL
         CK6qhGXl1pCPNGjaBDhupNrDjetS7nAg6yMvS2fe8SlPKpaw/+edKhLnuNlgtl8KA9cs
         5eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=T4yulc1U4RDI/lAlxqlpzG4AIUYO9fQrzg+B84ydySw=;
        b=S//Q+zdnj5Uwp+k4ziX1hKvxhOvMVxi/RzLNdoZ2N5rAzzRkINAJJvnicduzTN4mwG
         dFvfU1gtmLmp8MbGxeABiew2IRbLGrztGAtVcMQlnR5a4jPnClI883bNfadjlYbezlvT
         EWVtFYlTuQ2cHhTQ5Hi8F3qEDjtZDZREnQSvABe0D40hlboVCgtrv5gkrdfL9Ig+dBX5
         DYC7Lf0ggc1lbUej5Z25c0SaPhQeYF56yH5IYsw7TEnAg0OlQ11m6pL6rKzCH09eGWKB
         vQ23JUUayneV8FqhPFy/gab8wAoxU4Rp3W9HqBQ1wZYLkfeP9OMiY8t8rBgiZ3EPH75J
         c5EQ==
X-Gm-Message-State: ACgBeo3vWrn91idciOwVHBgsY0Ras+rv5S3YqjJUspVHCRkXj/6T/Pyq
        vDhyMa1nElE1GAPUChckJhMOQ/FXQeM=
X-Google-Smtp-Source: AA6agR7Zjm0a6dDy47TgZFwFrLnSH1RBWiJEP1JF2+WzkJzs2a7pahrySQrFD9Id5uBQt5d7er7XAKepdQM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:906:cc13:b0:73d:d22d:63cd with SMTP id
 ml19-20020a170906cc1300b0073dd22d63cdmr36111625ejb.741.1662380774896; Mon, 05
 Sep 2022 05:26:14 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:36 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-29-glider@google.com>
Subject: [PATCH v6 28/44] kmsan: disable physical page merging in biovec
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

KMSAN metadata for adjacent physical pages may not be adjacent,
therefore accessing such pages together may lead to metadata
corruption.
We disable merging pages in biovec to prevent such corruptions.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

Link: https://linux-review.googlesource.com/id/Iece16041be5ee47904fbc98121b105e5be5fea5c
---
 block/blk.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index d7142c4d2fefb..af02b93c1dba5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -88,6 +88,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
 	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
+	/*
+	 * Merging adjacent physical pages may not work correctly under KMSAN
+	 * if their metadata pages aren't adjacent. Just disable merging.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
-- 
2.37.2.789.g6183377224-goog

