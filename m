Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552651043A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbiDZQuT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbiDZQtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:49:05 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207565EA
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:16 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id b24-20020a50e798000000b0041631767675so10628652edn.23
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vFqZ9iNZJAVQIjd7MnY5jhYV4PJ/+WpYoNR2VRSWpiM=;
        b=eaD4tCJ/YLTDe4ajl2gQ/TiaUeEA4djHXSqlMDmsulc+qbwyzuVd2W9yINHg7fHnga
         3Y+nBojMivWb/vlWu7aJjqdQ3YqnLBqv0yN1IxxX322BLlHzj3IM9ELCwxkKAp16qOhv
         LyADFdDfCUsE+lxz9NxlRdyYnWL3NGagYS8JkeULjygmzHGrjysJLw6McGcbkSgOELQg
         1Rc7TqbJxh506aPuLFlQCeuB/YWI3RUvsBYyts3m6+c10BC++lIyRNin1VxoT8iWyPi+
         5eWh+n4wLJVVQzkWe/7aM9SIO+vr3tXqfKqj3v7+4FSCDACZ5wNHzbimfz+M1Qn6e6s2
         Njyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vFqZ9iNZJAVQIjd7MnY5jhYV4PJ/+WpYoNR2VRSWpiM=;
        b=7OIJtfVem5zhZJ+7rX5RBPhVJie9E8NOWQhlRLkxp5i/tpBsI7CA1jzGzq0N+9gVFg
         hivAxvPLx27LsLI7aFsnSRMz/XJTvmTxRY+4EzIwcPg1qICdFtPSUkTfPzDYOf1ONf1E
         WyVaObXGg/rzr5s54ALAkdOZec34ZBb/h7dUW8lc1MN6Eyv4v5ttN1+3FDHZihuNo3Gt
         9xByvAHT5HELkMKvowMnRdXkroMWM/t/yJuN2d0uSGWnYHw1IJEHUL5L8mqrnggP5gKm
         Hx9onn48f2+TNMxif72Kqfp05C+4jUuLhl9BYz0MxecoNhS3bQWLxUECzrS2RAM67Yy3
         MTUg==
X-Gm-Message-State: AOAM5321M3jZbysXWborPLcC/xt7u4U7lDn/LMR3e3eyfXUeK+woJE9n
        boWzvmtYbkdSGJylbS2K8iUDpci2Ph4=
X-Google-Smtp-Source: ABdhPJxSGoEtwF4OOq0yTBsFRqUEi4ydvzEhY/S3s2+/j9D6/negQ9CVvZDUHjNLSrRATTf6/ojzjnCmZdU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:906:3e05:b0:6f3:a14a:fd3f with SMTP id
 k5-20020a1709063e0500b006f3a14afd3fmr7558438eji.640.1650991515225; Tue, 26
 Apr 2022 09:45:15 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:50 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-22-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 21/46] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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

This is a hack to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
---
 mm/mmu_gather.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc45..2f3821268b311 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,6 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/mm_inline.h>
@@ -253,6 +254,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
+	/*
+	 * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
+	 * unsigned int value. The remaining 25 bits remain uninitialized
+	 * and are never used, but KMSAN updates the origin for them in
+	 * zap_pXX_range() in mm/memory.c, thus creating very long origin
+	 * chains. This is technically correct, but consumes too much memory.
+	 * Unpoisoning the whole structure will prevent creating such chains.
+	 */
+	kmsan_unpoison_memory(tlb, sizeof(*tlb));
 	tlb->mm = mm;
 	tlb->fullmm = fullmm;
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

