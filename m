Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE24747D8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhLNQYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhLNQXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:42 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBEC061396
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:28 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id t25-20020a2e8e79000000b0021b5c659213so5659008ljk.10
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hJREyaJODzN59ymWNpAGAfGc3N4tvevP8UF37PAE+J8=;
        b=oTH1LhNHOLMxItxiNi4P80arf3V90zcZ2D7XaYrMWD5zhzjnQGBBNtzXBtP3OTeZbR
         tREgkLUiMUgnBhnlpBEcb9spfWY/cnsLiVkZ4gM7i0ckihbSR9YkmKCgOjV9S1v24RC6
         rcCk1732bioSUmVR0kALhf4VayHC/sBhWGQ0rYLrqC8INyjm10g/NTh+VCKjt5Ba9t+O
         Hb8n1v7nq8PZW0tTa5I8gF39PqqrSQOKemQDGVLB0z3T64pOPjyD2JlTfUJ0Bbh2pRjR
         2uBonmx/fZ6h/wKPOVGIAJrZhtWwZfkkFYy/2mpCLi/sxNccIF40o59aaOuAx9Kf03c9
         v5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hJREyaJODzN59ymWNpAGAfGc3N4tvevP8UF37PAE+J8=;
        b=WZkHZxp2Ja+cjypopt9aCh+W5uOgU1sb8jdSzER8tEqt14SQ1F1GzJ9IZ7w3YheEqq
         6jMYYydhvSwtxxr955rKJQPSsK2r3wgk+ZKjnnHxzrJNcKtDpo3+2wjjdSPKr5YRxmgE
         mCJVNv5jEZvU5U+cKgaQ/KuWgoLhuPp0AkB+tMRkWfy7sDz4w+WmU15mJ49JpN6dY9Q9
         Yq3Ho/sMe6SaMP4jF2vyTJhMNVeOEU522A1CLNw/Q3RlEagb9YN6PQ0E/gERMyWi0eP8
         XSLRHlHhlZTdqLZ+dlirtfQL+wbseQpiLPXpMTCdzFjpZ+KpRXsA5Rldr7ujD4du3zCw
         2Drg==
X-Gm-Message-State: AOAM530gewItwp9DEW4lGZ9jOY708NYfqrE7QRgDpBbNvzuDsoJzCCiV
        ln8vSb872SBfukI+nGMiab0dFyz7AAQ=
X-Google-Smtp-Source: ABdhPJxXRu645cHJwsRfEAXihfv0Go5u7KwQ4UTJ1n3lO79v1JEfsX0lC2OS7GVAzadP34TGcewWINvNhMI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:6512:3991:: with SMTP id
 j17mr5582774lfu.545.1639499006493; Tue, 14 Dec 2021 08:23:26 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:41 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-35-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 34/43] kmsan: block: skip bio block merging logic for KMSAN
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN doesn't allow treating adjacent memory pages as such, if they were
allocated by different alloc_pages() calls.
The block layer however does so: adjacent pages end up being used
together. To prevent this, make page_is_mergeable() return false under
KMSAN.

Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 15ab0d6d1c06e..b94283463196d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -805,6 +805,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	if (*same_page)
 		return true;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-- 
2.34.1.173.g76aa8bc2d0-goog

