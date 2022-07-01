Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99E563594
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiGAO3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGAO26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:28:58 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50342599F7
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:12 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id cf10-20020a056512280a00b0047f5a295656so1179810lfb.15
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MLo3LhenoRrRqNTI2r4mtWD3J0vGsm9bvjleadBpMkY=;
        b=anOUkKWtulGEKBkArfZgJyNh0cGJx9d7Cq23k1uQwOBaeBk8BsWD249jvt+waaUJ0W
         wFq6nFfeaRMqhTZBfdHnekYcU9Y6DlOKwhd7zz8Pwv5Mf7POcnXxXlRO9IdWwc7sHxG8
         EJehSvYRYGgoI66twoBlGoYEACzjwkAkNmneLnfsKkPQFvcZRfWhgQAodIu6D09PjFk8
         Icdf6H3+rBIz7HcFSJ3Z9tX02BV8EOgwwt+6yOVuoCYfJOPeNjzAXzZ5xayTIEyTNe+u
         12rzA9yQKhB/zdr6mRJsJWTzWXROIdNbnWlGX7VZEuLugd3XmFTzxEYhZNDwatZ7SBn9
         IL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MLo3LhenoRrRqNTI2r4mtWD3J0vGsm9bvjleadBpMkY=;
        b=39FXqMVg1XGZO1py1Wx37hCcirzI3Yt/XADME/h4jJsc89a98hvQyslQykODs/AFyG
         nUoCc6zS/U6llPZBNEBEoA355czKvDBVo3ld/VWzEB93J2F5mSSZgD0jAZm5dvfPBO/A
         5pnnEU6F2BWCmlkYxou829Ez93zxcLLZGGCMrQdw+rIsoroegrFQw3Iupxy6k3hd9JNn
         ZaTOKmCwapcRMx40C/RbpVK1U8t7UMcFZtD9IcBtB58VGIEvQ7NbwdlTXbUgzDW/2bPB
         kP9LtWXfvwlaPdI7Wut7VWVxRhQybG7mVGSc7cFX2bhbIZJdMMaTbJuub33UyuXAkXLB
         7nZg==
X-Gm-Message-State: AJIora8iIDNM5AeP11vR81IULrShhHDihKpWK1yeIvMn9roIjk1yMNNj
        Jmq94lemI8xu4qGgG0OMCF3NnaBwbEs=
X-Google-Smtp-Source: AGRyM1vhkmL+KohFz0MszVF5zMXVYF2SuHbeJwCxM549Y5UN3wtICSWeskVNj4IhdECyposUmY2NkdReg2A=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6512:e83:b0:47f:635c:3369 with SMTP id
 bi3-20020a0565120e8300b0047f635c3369mr8918326lfb.659.1656685504982; Fri, 01
 Jul 2022 07:25:04 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:04 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-40-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 39/45] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
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
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
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

dentry_string_cmp() calls read_word_at_a_time(), which might read
uninitialized bytes to optimize string comparisons.
Disabling CONFIG_DCACHE_WORD_ACCESS should prohibit this optimization,
as well as (probably) similar ones.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I4c0073224ac2897cafb8c037362c49dda9cfa133
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4a5d0a0f54dea..aadbb16a59f01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -129,7 +129,9 @@ config X86
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
-	select DCACHE_WORD_ACCESS
+	# Word-size accesses may read uninitialized data past the trailing \0
+	# in strings and cause false KMSAN reports.
+	select DCACHE_WORD_ACCESS		if !KMSAN
 	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.37.0.rc0.161.g10f37bed90-goog

