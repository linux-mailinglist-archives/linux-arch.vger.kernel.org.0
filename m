Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78B510413
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbiDZQsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353187AbiDZQs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:28 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4081942E9
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:50 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id mp18-20020a1709071b1200b006e7f314ecb3so9373194ejc.23
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SEm8RFoD3mzqXjcHWM9Z/XfNnVTnRxEBaTJIwFUC6FI=;
        b=V1UPpoK10uyPLSVeGxmKmWLpz7MVRMo+4uiBOQTE+btQjeiF7bX14i8xIN4hWxvfsI
         BKp6ezW66yD/fgl4XMpuBdON6QxtTZCTto768iFnXFc2LH7l5QwZpTox8pUyK0cZZMcU
         9diZqYTWDNczn8waY+ysJcw4lWMp4tfA90aPMraK8ja0L3fYlvQlBZsap+cS3cIoYkUy
         i+K1sOjum2D1Snfi9ezBpkT3FqJQbpZ1ZkJb010JMdv/VFlzNAOneWXO4NmYGXJdCYB8
         LxjKRUcmGqytLknAlHvn7Ijdu7TEekTSbAaIp3JV0enFaH8f7pcQ4jDbiUGAEReAXkN8
         4fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SEm8RFoD3mzqXjcHWM9Z/XfNnVTnRxEBaTJIwFUC6FI=;
        b=3k48vb8mP/GBzZBo/V8ITEvQKXTx2o6YN4r8PqI1SMFD/EUvLbm9p84RPynb+MVjdc
         XnvvqMi80t7MAYpk5s6MypnoGY2AFGIfoiYkyrGsONdlMJhBbWhrK5DeVXdFLDbg6fIT
         bz0VBmdODRlRl+zf7T/4CQZ+7hsWX5/LchkJRpof7Cg4U8allkIKQs1DOkMU8edDF6/3
         iiyazhx5gOO6pzyBffIdtigNfgcXRSvOVG16cBTeD7NhjUIJ1UA+DV6f1hxlK+VDPRCo
         wD8tWmG/rufifi2VzsmqmsJkj0EwGlNPnXlu3LW8SH683Do9tMuggXuuP9e47GC7x4i+
         mk8A==
X-Gm-Message-State: AOAM531hYPFUKHdWBG1XWmfUQIOKwERBXNXrqF3L+u980DfVFsa++LF+
        72nXcN5YMiFiWg3nBJEgsCjrDVJeH5M=
X-Google-Smtp-Source: ABdhPJzlxnxEzq09x8VRCHG67jl1BT+tZuNt6ukFhmOsg7s6+uxFS5/FlyCj/NdcpcGzVA6sRk/t/wnlBr4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:35d2:b0:424:1eb0:45c2 with SMTP id
 z18-20020a05640235d200b004241eb045c2mr25704880edc.152.1650991488637; Tue, 26
 Apr 2022 09:44:48 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:40 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-12-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 11/46] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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
        linux-kernel@vger.kernel.org
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
index c31e184bfa45e..d51a3cd6581b1 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -784,7 +784,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 64. We
+		 * Also make sure size of struct page is less than 128. We
 		 * want to make sure we use large enough size here so that
 		 * we don't have a dynamic reserve space depending on
 		 * struct page size. But we also want to make sure we notice
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

