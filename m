Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A415A2AA0
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbiHZPK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiHZPJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:09:22 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A6DD749
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:42 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso722955ejc.15
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=KyITLg/74GrhViHFJeQt7QU8AnVbkb7jycJ7NufNBUo=;
        b=JGLI1XVMHG2i60SDAlQT0tbexjKijbMvRCyJBm7rqKpNb8F4aYTTCeDzdw3DZRTTY9
         9aBJI5GzvyT5OHahe6P/FLulT47ZG48jaSm51uWVpeEM2anno2pVkr/HWnEaP4dzX2sF
         twstPsWzst1+5uhmUIC538U8YzMDGMv8YPX1agG8mT4BMvYcmTbtHBdrbhp45twT7nWE
         nz3m1f2/FPyxoUBD0WCWPwU+2VcI0cRXIUlw4UKcnV2+HEz4YBqOj5X/pB0YMkzOfjBA
         Gfm4kLyCfYg0BuipDD2uTTZ9O06RAPnTfMpt3Cr9PpAqZlkS4Eal6zCfjZiQC/y2Ypav
         PWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=KyITLg/74GrhViHFJeQt7QU8AnVbkb7jycJ7NufNBUo=;
        b=ERhaYL2MgRnvTgusff2t0mUKB1PXVbYOiYMOJVnduPSz7zJUshFZHLysJGEJEh9PeY
         l584ms9qLVrYxeR/IcWfYNhhjRdhMccV4FekFM1ORUVswJ3+ydB/8ky5v4mAwcS20jV7
         CB2ia4E1T5Xx1kh9L8mjeuPyER/rYqZuimLYkaxO7U69Cgi0gBan9+z5dATVwOzw6NtW
         Pprv/fzg9+14vXUpdHFgCKlIA+/EwqdHLh7PGcbsFvZEiQHmX7/r3rpADtKr/53IQzZk
         xhjWaiXjgK50xQBN3EfWWAgtzT0AioNtk9arUSRENv2eSgUCijh9PTtNwS2QSLVx9BmI
         ijiw==
X-Gm-Message-State: ACgBeo14zc/PG9eR3Zg/pIQ+S/rAWORZFxiKEO9awit3lqN2ETz5CQp5
        8Y3nzTY8ACqxecXsgqDgYJICQVTxYTA=
X-Google-Smtp-Source: AA6agR4pAyh98UW17iINAKOiWgkXvBjhtWUMPuOGGFy1IcJGaEVoMCTj1DvlVljTnjKpWwFAIOs4GvCri44=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:a04e:b0:73d:8419:3d88 with SMTP id
 gz14-20020a170907a04e00b0073d84193d88mr5498703ejc.616.1661526521065; Fri, 26
 Aug 2022 08:08:41 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:33 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-11-glider@google.com>
Subject: [PATCH v5 10/44] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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

KMSAN adds extra metadata fields to struct page, so it does not fit into
64 bytes anymore.

This change leads to increased memory consumption of the nvdimm driver,
regardless of whether the kernel is built with KMSAN or not.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342aa1b63e616fc614f1
---
 drivers/nvdimm/nd.h       | 2 +-
 drivers/nvdimm/pfn_devs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ec5219680092d..85ca5b4da3cf3 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
 		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 /* max struct page size independent of kernel config */
-#define MAX_STRUCT_PAGE_SIZE 64
+#define MAX_STRUCT_PAGE_SIZE 128
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 0e92ab4b32833..61af072ac98f9 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -787,7 +787,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 64. We
+		 * Also make sure size of struct page is less than 128. We
 		 * want to make sure we use large enough size here so that
 		 * we don't have a dynamic reserve space depending on
 		 * struct page size. But we also want to make sure we notice
-- 
2.37.2.672.g94769d06f0-goog

