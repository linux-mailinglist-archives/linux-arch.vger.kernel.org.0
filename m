Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F36474797
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhLNQWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhLNQWM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:12 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F66C061574
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:11 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id f5-20020a5d4dc5000000b001a0b1481734so2039062wru.23
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vk27iv2F635cQnWQcbshAPEqVufkv6t3HZGPDzS+hy0=;
        b=N97xBrvZKeDEcFlNpkWBrtn7zEvb3Izxfed8tgccGP3KbP0JyoVvarwspHaE+pun9W
         hC8L+YfbQaFfkyLe8bnD8MYV+/Sdom3ZohAx+8SJYVoaN9+FGkeigUf/5Enx9Duw10M3
         I4GX5ncfr5sThlpIWYcUp2zJ4xXqkR3lFRPU4wJafzGrnYz7IvMJbp4PHnk9NdLpwQWA
         DYtFY+DFULdtU0LkVrKqqlVyi91CCthRiiScHr0/FyR6/4X94fi1/MO9Bm/l/XHO6CaY
         2R8KiVRheRSeJZYwjF3N1AftioY6J7C1jct6LWF2rPySvAGDOk7uvQD3ZoD6roS8/d5p
         BrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vk27iv2F635cQnWQcbshAPEqVufkv6t3HZGPDzS+hy0=;
        b=OMX0lJun9qETmirvVfuiYTe/fo/1FZP3cUa7WjhJoKrsrINnAUbcirG1KwCrrM6olr
         jtUoBW9l0SGLnOLqIBhC1Byk8dKy72AJgHdSZHL4rFtxZBLlubtxFvTiSXuNTDycwX4B
         QSSOnaNrLqHTnBkk4uKQDTXtM8Ij/l9J+jz1wNdqbkUUUcWtqQpfe5VyyxfxyHm8wfNz
         iQSyBk473YH3sYnlovLR2THKjz6w1lG0G2UQ9FFs3qjdqUY3DKaH4Wx63Bb4kv30Nr9w
         iDLBWQy16kEwuCu6lIEvuOfW77n7pKgOm3GQyOH270MUQepBTsrFlItod6YOKumZ7sYA
         jKhw==
X-Gm-Message-State: AOAM5325JwaQXjCmNMFRHh83ENUVTgHjZ0/4yqJDL/3LJD6Li4b1pS0S
        r1VkAKIAYnYP1CE1nmJWp97pujXqxj0=
X-Google-Smtp-Source: ABdhPJx9Wj6Cyb1ZV5OC7nThpuMZJU+2OnpAgbvGjNqZyuKNa8hLFTbdISamGeA0K/FUYpEbmCyQ0RRf9nc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:f206:: with SMTP id p6mr6600814wro.509.1639498930071;
 Tue, 14 Dec 2021 08:22:10 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:13 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-7-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 06/43] asm-generic: instrument usercopy in cacheflush.h
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Notify memory tools about usercopy events in copy_to_user_page() and
copy_from_user_page().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ic1ee8da1886325f46ad67f52176f48c2c836c48f
---
 include/asm-generic/cacheflush.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4f07afacbc239..0f63eb325025f 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
+#include <linux/instrumented.h>
+
 struct mm_struct;
 struct vm_area_struct;
 struct page;
@@ -105,6 +107,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #ifndef copy_to_user_page
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
+		instrument_copy_to_user(dst, src, len); \
 		memcpy(dst, src, len); \
 		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
@@ -112,7 +115,11 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 
 #ifndef copy_from_user_page
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do { \
+		instrument_copy_from_user_before(dst, src, len); \
+		memcpy(dst, src, len); \
+		instrument_copy_from_user_after(dst, src, len, 0); \
+	} while (0)
 #endif
 
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.34.1.173.g76aa8bc2d0-goog

