Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC54EADEB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiC2M4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiC2M41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:56:27 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8E25D5F5
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:33 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id er8-20020a170907738800b006e003254d86so8131052ejc.11
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0QWUQ+RqE8jiHyj7/O+KujG6tRpsbOFA8yuMseJPgVs=;
        b=OfXq72ZoBUQGSWSvm4KVtJ07Y6J70d5V6dAjwsYPNQ8KvQs+UemAzoD9b+EXKX/OTw
         Q+izHPhM0oLIkOLIiuKDw0qaaM3HmxBX8q8lxNCUTVCL6uMVfLhs0yBqTwJyZYo3a2Dd
         PHMlh5zEbtKHkaJRb6sAKEdQbGhEcA7fqUGVsUSQYvLsCZPqYBZ6kCgNZI+IIO0DTiYw
         dKXtVOTB8fspK7u9aonJCNi788zBxPM+etWoLtYNpYHL5mhBEusrVsXgVIm9RsvEQvVL
         BVUcgD1GuztoqNHxl+h1HcQQt1n0AN97ckOSFFHrUUEbkVxi2NvTa3+e0HN0zz3+BFfO
         qT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0QWUQ+RqE8jiHyj7/O+KujG6tRpsbOFA8yuMseJPgVs=;
        b=29Xd3CQpdAj5uIWBEeDDjtOdKapplxelBbxB0JKyWJlV1PuLXRiNsI1lXTJdI6KgCe
         43iIjLVEq5aNGYgjfyT/VOUmKrza+AfdJl5HvDT+xZ1NPD+GO1xq04ppuyIiEuQ5RSaO
         T3ybzneu3zXnXI3aZeUyGIZlcrzCGV2jOkQ8x6oEvX4x2baOi0EusIOtDnw8ln+X3Cbp
         MDDJTt3z0zuuUH8Is5i5AWqWueSEtihQNphLV+PYVCFQvh5C727Vtqq2TGLuMkdT12Zj
         OuWz04yd1JAl3DRFO4ewJhFtmXO0h2eO6gw0g+MRJlplkqJGSe4KoJdlwSzxR7Kv1aXz
         XAZw==
X-Gm-Message-State: AOAM533DVXhh8oS4EZtnSb7B2xAMyKiucQrY08Emx49g9PwJmAL8WaVQ
        R9TtFO7NuIMvO8D+sQAdZBsPWamwAK4=
X-Google-Smtp-Source: ABdhPJytokWuo6v19GSWg2KLHdtKqtVYC2QIF6Shk0LT4bep8x7ZGLJY2F5r9sIe9kWDKcupdjioDqnZsL8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:948:b0:6d6:e479:1fe4 with SMTP id
 j8-20020a170906094800b006d6e4791fe4mr33417649ejd.240.1648557751382; Tue, 29
 Mar 2022 05:42:31 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:15 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-47-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 46/48] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
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
index 86df15017f79d..646a7849be4cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,7 +126,9 @@ config X86
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
2.35.1.1021.g381101b075-goog

