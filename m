Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD215AD275
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiIEM0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiIEMZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:25:52 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942501DA7F
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:26 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m18-20020a056402511200b0044862412596so5714453edd.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vmKBMF2McNFVJqtG6TmpI3MAJxV0RMGeKyj0ZsE0Fyg=;
        b=O96bjuI/kcNtVyq3944Z7ueCIaa9yuEsYJRsRqgSlHKcEXxmakhKDnaYm8bTJp/2Ie
         Y8UpnSRc1QETrs4Y8CaN2D+hdalbChXjb/iF/mgeJ2k74SyqLXaXBPgwOkNVKFXuAPnY
         ObphBlLVgrXRSkLKMQJGEtkwN+0KhcNeyBefvXOuILKIWJt/BEXyYI12bQA0Tlj44WO5
         jxvyzRsqVQanRBcQxBYdjMDiO9F+YgLL1c8yza+3/ejeeXcU2k1NELaQsYeqOb0rYH3V
         N0CpyqXMVX3sGSh37mJH/qGJ8lKdXml50RvZ8I9e4hWM3iSgRSretp8awq1gK/fuIu3m
         Y1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vmKBMF2McNFVJqtG6TmpI3MAJxV0RMGeKyj0ZsE0Fyg=;
        b=0yXYFVfxEZKFgvTHT+yn+i4mXA7MSlz8jWk9/a5DYDA89aCwSGfZk+RYiCHvZfxX5P
         Dr8NgiYh0O8f25+YZYvTn6MkPVh92SXSTk5PFzSYJHraHSevob0HZalMbcABp/zkhDob
         DijKyK9o+we+JjUAC0WIGyYgFVeWkO1xsSJ9njMxHQqRwasSTDqNTVMIlsZchbOfkvAH
         9QStmgGJh3uXSI9QVywOmJ/2oBUfgZl0vY5VRAIg+Uib82CQCCItsk1eYr90UdeN4Abz
         Br9AD7zW0CptsXGRmMAFVrfmhOqVKf5pQrcdDADhPpMcrwIwW8NjyH+2hbZC/LwEq6ZL
         ituw==
X-Gm-Message-State: ACgBeo0hYTuqv0NZ1nds1voNlqb2MjFIvniBBTHzYZ+CAJk3sSdNL01Y
        E6TGbnOXyBP1p7uabXG0AfjO5/d+QOs=
X-Google-Smtp-Source: AA6agR66RFT7ULInIZdaLxzEB+W3njrb9ZsrwOKlCCrjmsBFRCEDn3xMmeOMxizX3qE5C/AOVlfkrTghefs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:b13:b0:73f:d86a:6e3c with SMTP id
 h19-20020a1709070b1300b0073fd86a6e3cmr31127618ejl.132.1662380725053; Mon, 05
 Sep 2022 05:25:25 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:18 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-11-glider@google.com>
Subject: [PATCH v6 10/44] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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
2.37.2.789.g6183377224-goog

