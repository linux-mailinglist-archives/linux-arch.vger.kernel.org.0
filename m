Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C86563551
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiGAOYz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGAOYN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:24:13 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DD3C4A6
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:45 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso838639ejb.14
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AkHvx6ZxtZ0IjsJvZfH9AmZNAyLy9uG4lwf6iPpek9Y=;
        b=rHudIZCMEvVcL0J/tpORMCU1TSzScrZ6kJnwi8au7+a6JF30h8PGv5ybkos7NSpKVF
         l8ItJ4ldc7rg9EUkrGxk8hBljzCbzYjQgUwA1nGDUYpjSYBpSv1cZheZLHTOEc3UGcpz
         GN3MhPn5PyMEGYWYnmCKoNlKEkO4c/obwSOro9mv0hP92gHSxiMzcqtoWoMzuEAzed2q
         wII50gyDZqPcOzaGsoh2O4Imju9tw8/pg9ZgJAzo8hKdBhlLYoNWrG5KLaa/L/jFhzEF
         QS0SOmwTV1hAlRt1ITxae7Jk30DIUPW7GuCpXSA6Yvjsk9qUvcwrEZ8Tfb30DarFex/+
         W40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AkHvx6ZxtZ0IjsJvZfH9AmZNAyLy9uG4lwf6iPpek9Y=;
        b=nE/ZUhC/8kSGiOvU4o0np1T9VbFsXRSNcm4+R0GsZqCmnpppPg2CVUJbLxC60VSg94
         kNFfzxAxTc08BnJOlHo9oGyQ0VR5PGFf3QqH5gmHOjksESC3m0tzHuYY0J6zBUcsH96N
         XeX/YAmh/Kvl3eneEgWTIX99I3Kw4N/H1xDtgfVXa4Yu2VjyudRYujN/S/dHG60oSZAY
         /A6nLBbHvxgHSm1WLZYnKNmgVgjmadRvIAvIamO7fLo5ptuqmfz5hCF57WrXOwhSI+5T
         HaWmZKIi+muulcvmed/SXDEFSGM/uGQRR9xAxJU0NITHNhVv9Xmr+qdXUUl5231AKIrZ
         OFLg==
X-Gm-Message-State: AJIora/w+JInCltp9bA7rHqFiMQYIz5aNukb61AAFRgf11ak/SN0TLt0
        ABNiH6VdnbDSsaA4FSEFLqAJNTnklPU=
X-Google-Smtp-Source: AGRyM1s+kuVh9fols3fC269jhlEDP/Rp/CRoJ+oGxYSY9r03d5HAcg3xOh5GvCrJCoCJuu3kbfRaEWJ10XY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a50:fe83:0:b0:437:9c60:12f3 with SMTP id
 d3-20020a50fe83000000b004379c6012f3mr19071968edt.120.1656685423650; Fri, 01
 Jul 2022 07:23:43 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:35 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-11-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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

Signed-off-by: Alexander Potapenko <glider@google.com>
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
2.37.0.rc0.161.g10f37bed90-goog

