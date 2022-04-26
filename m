Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F586510464
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiDZQvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiDZQv0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:26 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F548E6C
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id h7-20020a056402094700b00425a52983dfso8257334edz.8
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XPVyte1DHdZzGVqIYLZisC9WWn/NV5PTOOmKGsNYVqI=;
        b=tfexPWSj1PSjUb4y32u6HDb/QnE+2ju4Q3VQ+kF29tn7ADhoO3fHaJy9KBX3jTsEd8
         BhBWx/VeORcURqli+p+9+1QH8obAqShcA6ErLkkeVUmnfCO3qJEDT5UirMbYVSK2rKI7
         EHcv+GYbS6ck2ZGcmgknDsZroKT9WTKBy/bFVemoqQAXMDxG6HC+soFmb8T4ca/gXcrO
         ftqfgIZ/fqbniMJnPu4e11czzALuk3B6wUJb7Az/LpjxMDJcInKVf5CafrOSxVa2JPzU
         ++NO1MFfBz4ggnwPlPZhMJNmDFkkEcXO47/KdD9d+fQq4LH0V9JjN+pdxl1pwz5u4gCv
         AAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XPVyte1DHdZzGVqIYLZisC9WWn/NV5PTOOmKGsNYVqI=;
        b=G9QNQFknTzogmA2eALDILikQHBfj/Bv7KHsMo1mLe60K5M/7i7T6KoPhth1MIECN3A
         7Rg103w29bUnGMqhyL1M/+Ts7+gJpunaKm4DkKcfRuUJQoswovjgOwgSY4AJGT0G9wK0
         om/YDb9u5CyDZLZtfiAaAfVbWhYVEpB7DXGUDkK7mmIYTqEd5xqOnph5K1Iud9bh9RH8
         +X1XkbukyxD+DbsMpUIV0L6lxTebcMKj2G3ARln93fSEh89A8DLuuYF7+rvpEVUgM8Ux
         xi6PBX2NaZsy8HTYnRfBZ8lHHE9uuOEwfIC1k/QHw6ECd9uLw9+jJqr8HvPU67RJNdmt
         eb6g==
X-Gm-Message-State: AOAM532NVGmNYVlT8Xu7oBn05R5F3dqB+2gjrnFROiya36rPQpH5ruN5
        KtvaNyY2XIvcAWygAUBAxMp5qPk1br4=
X-Google-Smtp-Source: ABdhPJxd69pRVvXv3tLXpgiAhti/608pH1mq1OSHk1HEp8P9KBrw2Up9R6Lp+Ti78ee6VL9a6lRzmQRfcX0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:906:478b:b0:6db:8b6e:d5de with SMTP id
 cw11-20020a170906478b00b006db8b6ed5demr22938586ejc.161.1650991579678; Tue, 26
 Apr 2022 09:46:19 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:15 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-47-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 46/46] x86: kmsan: enable KMSAN builds for x86
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make KMSAN usable by adding the necessary Kconfig bits.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I1d295ce8159ce15faa496d20089d953a919c125e
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3209073f96415..592f5ca2017c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -168,6 +168,7 @@ config X86
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

