Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678455A2A74
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiHZPIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHZPIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:08:18 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EEDB7E5
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:17 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so715470ejc.13
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=J3VjO5owb76kN3paB0OLHywjIHrYCcgYmjupWIyAPgw=;
        b=aCsHGgV2sJxTYt+AJn+GIymUxqtSkf7JOSyz7vtwxv7vS0L3uEaVpG7DpI3UZFn7Rf
         D7zIWrIK46DZU/rRMq3m92P1QW307EPb+BIJOkzmXqQ8PCl2pATj4E2Z1WkltcOGRGH6
         X4s+ctoBmXCp+cOHvURIAa7E0w3KL/dAIMuJ3L8QZdm/NfQUl1dcR/AaILFXFY/SbQCL
         36XR8pcZkoIw/0JS2OLp31Xw05XYV+OvrpL2omMECtGFmMj4DIIeOo98maVmQrFF8Xkl
         zgX7H+3jSLRXR+rJBrs8fyG/5arariUD9UxBlfK0i9oPhMg0ntqpE7GJ0QJEkhQTjoVw
         jDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=J3VjO5owb76kN3paB0OLHywjIHrYCcgYmjupWIyAPgw=;
        b=xLGDcx7D5WGws57fZfwnl71BiO4NQhWJSuLnvhmI7BXASpRzgPNieHcxSfsuzOwfbI
         2+CnXPufbNLFW6aXzh6oALMBo11HGKTSe6TMSCRV8lSfaJYQCj2WW4wEh3jue4iFs8Dv
         XEP78U0/DFSGzUfiQX9v65yrqV1LAbAL62DJKG7QAmnsZ2umA/agAar3Vcissq4LRRYy
         GoonwGX9y84dzbEgIosWVGqLe74kkRyTv590xTwNUOyeDp5xCqsBBMEmbAMJdXEZsTgg
         zHgpa1bMdHw7CTx13A8sGIvjJx8PnjBO1MmIwVLe8c9yohs1tPw+9SdpIk2w7iGtyr08
         dGCQ==
X-Gm-Message-State: ACgBeo0yG43P+OWlrt5X8Uo8bBfLW5bOWHOgrVprNpC0KGFGv8jGj8Iw
        qSJA4nntRXzPGOUpvuB+NddwJkCrxAs=
X-Google-Smtp-Source: AA6agR6nNKRDoPy16VFGdamdWo+M+pvpnHCU2sYnAni0z8NRtgZc0jeuf/gSF+/K7FUxMeTnWWm/3XJf1sI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:aa7:c611:0:b0:447:844d:e5a2 with SMTP id
 h17-20020aa7c611000000b00447844de5a2mr7350187edq.10.1661526495846; Fri, 26
 Aug 2022 08:08:15 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:24 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-2-glider@google.com>
Subject: [PATCH v5 01/44] x86: add missing include to sparsemem.h
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

From: Dmitry Vyukov <dvyukov@google.com>

Including sparsemem.h from other files (e.g. transitively via
asm/pgtable_64_types.h) results in compilation errors due to unknown
types:

sparsemem.h:34:32: error: unknown type name 'phys_addr_t'
extern int phys_to_target_node(phys_addr_t start);
                               ^
sparsemem.h:36:39: error: unknown type name 'u64'
extern int memory_add_physaddr_to_nid(u64 start);
                                      ^

Fix these errors by including linux/types.h from sparsemem.h
This is required for the upcoming KMSAN patches.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ifae221ce85d870d8f8d17173bd44d5cf9be2950f
---
 arch/x86/include/asm/sparsemem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 6a9ccc1b2be5d..64df897c0ee30 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SPARSEMEM_H
 #define _ASM_X86_SPARSEMEM_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_SPARSEMEM
 /*
  * generic non-linear memory support:
-- 
2.37.2.672.g94769d06f0-goog

