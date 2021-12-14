Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4078B4747B9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhLNQW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhLNQWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:52 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C86C06173F
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:52 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so4843210wro.18
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n9hdbxHO53pPet9rVLXGJjutLvzY9K7ZBDkEw/sZKCE=;
        b=JHEdQfKv7HR3RWanTG4ZydCDLNq2lrvP4HdZTn5IwnSpjM0qsm+p2r8ZUTpBiAafC8
         AbZmuX3hs+QHumnreQKR/wXxbZbyh6O8uXOK660iyElIgkT34bHEwtakJkkMXVe2kIaY
         r8eGAvVksDisZy1RRbBXmpjVGBbwjaAoK1MGxW8Nmq8+9wBg27pQsts9zu6ZTa9mzXHB
         5QlQTAGVPBZ51vjVlHvv3fNVTZ2G4eq+0V7zlB2In/ViuSb06ajg56lchx7kFmT9VT5f
         /7Yo3X6pCK0XEbrztcdPbAK2XNRMT4Z8dEGdUZCxnhqQylBUTRxGFuuec79E+ZaBC4Rc
         7KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n9hdbxHO53pPet9rVLXGJjutLvzY9K7ZBDkEw/sZKCE=;
        b=4QfkpYAhGd5suBes/m4VIX0mHWTdG3CmVeWqlNGKgxRLFXuHM9HNpuEFRNE9iLPmdh
         ihRlZUWXJaYA4JvE79hUcOjMGAm7ol+pqAMSo1NrGRaatKPXoFE4XOlUyzM45GSCJ0e2
         +vkI/blgfDT3WC2FJp9Csih77X7pi+WaIOXKvNSDgyBMxsLyZ7PGsiMrwc3mzSK0wDWE
         qTMmkbF0PxL7cQy7XBt7DcGKv9QISW0iqPHZpYYd5OQHQl0SLjl7GrJAPSayvjMXA9oV
         nvhSn6FBbYlB5RqmgvxL9mgqn/Un5ARYwvbmOvMio8kmKxAkmyJiu+kSjFAhEvFC4Zcc
         yEGw==
X-Gm-Message-State: AOAM532GttKzUECCwwy1oUC8+L55bL0YJJ5lpjxov8t0Zla11eSqyQnW
        ZgKfkaPlyChvONAJLJNUexvjoID9/rI=
X-Google-Smtp-Source: ABdhPJysWuIKajBu41fBxQFQ/tie5K32G3b9ULI3MmpkCFPKsk2dJs2OmxSKdjDhXSGcDI1uWyhJxYHBE1s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a7b:cb98:: with SMTP id m24mr2273632wmi.188.1639498970919;
 Tue, 14 Dec 2021 08:22:50 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:28 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-22-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 21/43] kmsan: mark noinstr as __no_sanitize_memory
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

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1d32f4c03c9ef..37b82564e93e5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -210,7 +210,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.34.1.173.g76aa8bc2d0-goog

