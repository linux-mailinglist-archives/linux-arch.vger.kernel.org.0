Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643685AD274
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiIEMZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiIEMZC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:25:02 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB32186D1
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:01 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso2248016ejc.5
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=H32LKJ4QtRE8PW83scu/rnCN+O5l16ld3Egd+3MOYzM=;
        b=aLfolEGF+4z8StWe09PixkRhroqvOPaKUooAdeTFsdKSl+v49Odm5vs4CnLK4fsq4S
         Jq/AR2w90iO6+0l+zBekr5ajfLWj2kU/XP1ultUmMcjL/ul1CQk62zeHwEWlR5EaPCy6
         xtEK7vi/KQ6RS+ZuXFb9epBPjB1wW1c7oIClJGqTZzAROZRQOKU79SXsmYSjjrE2ztj1
         zJTmRhJindsP0wNuL26Hs/hUR3y7PcifrgmpFh6HPlZKRzPQOtdWukP1Dh9II1PAI949
         igQPGgi38AzhhZXpXIUCQqjOqv7RyRkj6cvRWjsdhzpIjgyg29OzL21jiUcjEweBFcPc
         OORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=H32LKJ4QtRE8PW83scu/rnCN+O5l16ld3Egd+3MOYzM=;
        b=g/gZH3xgkDgzLDu3alBjWV70Tkj9YjqeGKtQm/3aitYxb8rOoBPAKxVSOkbdh0yAVW
         h/btAeJhVAc1I9Dil0Jm7aGpxqo8hFwtMxMTt4QtsMGhZcc3XjPuWoWF0eIsZhp5gi1z
         /ePfxwTmAX1mJwEBXcdtqvBnpJVsDJUZaI+zxk238O17T29YE1clUMdc70O9uHOftWrf
         oUGnkbvvosJB5eFBXah5YEHbsJW7VMGDIcz7NT7ptxKSS+y6/BqbPqf2f5j2//f/cQHb
         Ig8hrBAE0OmyvfivWiF55uZAbHKfmQ1x7kExGWgoZLA8aGnH3fty6g/8AEehMYHHj4h+
         6Kyw==
X-Gm-Message-State: ACgBeo0QkZdqX3J7T02A809VCR7Y2tFPKgpgr4faGV+u857+OmJ1s6lZ
        B08p+OvK2tiABnEc5ucrZSj7U52snjc=
X-Google-Smtp-Source: AA6agR5vWoTcukwzW12FJUqSgHwZUEspZmnu3gOZAV6odx1vq7y7ZtPkLoi8mVSYWK1T4yJjFIX66KC09ZU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:aa7:c556:0:b0:44e:9c95:a9a4 with SMTP id
 s22-20020aa7c556000000b0044e9c95a9a4mr2284696edr.301.1662380699688; Mon, 05
 Sep 2022 05:24:59 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:09 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-2-glider@google.com>
Subject: [PATCH v6 01/44] x86: add missing include to sparsemem.h
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
2.37.2.789.g6183377224-goog

