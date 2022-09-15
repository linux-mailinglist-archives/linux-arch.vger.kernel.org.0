Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A65B9E3E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiIOPHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiIOPFx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:05:53 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4992857ED
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:15 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qb30-20020a1709077e9e00b0077d1271283eso5522449ejc.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=DrXJVgAnGikXdoBfgSCi3xOinuzD72ruDjEjRoFoD7o=;
        b=pMDlMog1n3F76mKq0Orm26ggqAgcZbz8ZhleQGMqnTGR3RrhwhLXdNfNfQod5q7tsT
         FYabKAANZgyG+nKyYkX65poam5NydHvovkMw0I2y3KtNmNQdCevvAAlTdLEol2bZpy5p
         GwqekvuKQGjMGpceoNj67qDwmgnm6UC/gsqBZrB/xU68bigz0RWY3aVTdtDLhE6TSVY9
         XrWLuEZmPoiE7vrQBFB3RlGK6SsYCNEAClW4Z+Oa3/pDIZLwYpyE8A35YjbxVNkGcUQh
         rQnEz8a6w1PRa2LwaF7jtwdwJsI811xbzxgcNqy5MsCW5f1GaPwCtVWuuunmQhqqg3jg
         lkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=DrXJVgAnGikXdoBfgSCi3xOinuzD72ruDjEjRoFoD7o=;
        b=wlWPVI8dHAllZ2r+HdUppQESXMs/LIiORHhxG8R0dvABYM/UibZQQ+bOScBGIAh07K
         Sq9wBv9IFk4/w79Wp+jvYHfQ+gpMen4RfPlL7Z10q+uKr3TNjqKwcRU+Jw77wbQ1qH3a
         1EtmharZXGo/9xGu8kw5Z4a+cdU7h874SlcFfcoD23MGapZexs5J9jh+3AX4GozGHi9V
         aeNTIy8yJpsBjHNZIRxGXNMAUE9pIb4DkEtFqXxfvMBLxluCUBdDeyFV92wyV5gwJpgE
         DQNyl/c80jMkXPYPW/cSTiicJeCty5fPmz3K8Yv3qWbhFG28df5RwX7XLvHxh9sTGxmh
         9AJg==
X-Gm-Message-State: ACrzQf1kVktXOR5AQhZAm5zkg1x5DVV5IQOcpY7/r+5WNXJFrqGA2T7C
        EkvJ7BUfv6c6YwxRsgf7rMbU5ywbUww=
X-Google-Smtp-Source: AMsMyM723C0Ra0d6HWWOT8eZXf9pV5FKMgmRbixWPt5RD6cCVjGI7xNel4VbZv8orCGK014FpZn9G1mzW64=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:7f1c:b0:77d:248:c1c3 with SMTP id
 qf28-20020a1709077f1c00b0077d0248c1c3mr291412ejc.416.1663254314212; Thu, 15
 Sep 2022 08:05:14 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:47 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-14-glider@google.com>
Subject: [PATCH v7 13/43] MAINTAINERS: add entry for KMSAN
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
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
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

Add entry for KMSAN maintainers/reviewers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

v5:
 -- add arch/*/include/asm/kmsan.h

Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 936490dcc97b6..517e71ea02156 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11373,6 +11373,19 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	arch/*/include/asm/kmsan.h
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.37.2.789.g6183377224-goog

