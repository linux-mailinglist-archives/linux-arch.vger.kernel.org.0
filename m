Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1055B9E5C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIOPKQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiIOPIi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:08:38 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0C5A81F
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:56 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qb30-20020a1709077e9e00b0077d1271283eso5523466ejc.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=r3HZXk/BEn65kcaybENH+gdA6j04yycM3f96/pfDo3Y=;
        b=aQq72eadbZwq/GT1Z6Tvw/xmOlMUZLlJTyI0TzrhiZrves5ntWwvh+3uFDLBYpLZrJ
         h1ikkP9rXSVFWTA7ciUJFF1f9AUJxqJ97pqMJydqQcXAEzGr5ROFVuNaZF31wV1P7g8M
         nPgn0UmEt2qu/qdoDASndOpnDkzYfrDFlTkTXR1TZFGxdGAy2NWU1EHXUoqxbAKmtWHq
         Drjc0QS6zlbEIhSvlyonau7djr6wX8/b9A42B31BEiQEkTzvbOq7cf836X8Y6zwp4Xt2
         5z7af56B6lhbyz2HnKF7iuuVKYQhx5EEMxMssHo7LL1JYSTlA627gSdeqm8QJnNMhwiu
         c8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=r3HZXk/BEn65kcaybENH+gdA6j04yycM3f96/pfDo3Y=;
        b=MS4XGJHMVrzWgHLtRHCM+J5hLxAYsV3WhN+1ikr4mPr3IK6fE8q+bwG28dSyNfhg07
         0dAtb1cjganGW3DeSM1v2FHQbDbv+EriuhUs/13M8Xn4BXhhUazq2DVge402MRm/9L4B
         COkggwa5RK8sRAJde6pwxNvQJkjmqzuYl0NbXFgzFJbD1bgdX5Aak4dFD0kiLD1J5UEf
         ZznEKpXO67UAfAXzvEUkCTwDKVVTewl/K+oBlI/QvL8sZsror98v2SbIGbsRTUrnFQbe
         QJXUMApQ04vIjTn7ZUsyBVSNx4FoFRS8+rmxuRiqIKqch/zna1W+NDwG9xEw/xivwGV2
         LGyQ==
X-Gm-Message-State: ACrzQf1O6tEgTL9HIkY1x7taG+dgeO4qWM4axQHlK/CkxNwBphdkIDzQ
        XQlPYZovbtbbCdDZo5Et6d2W14IONi8=
X-Google-Smtp-Source: AMsMyM6uBsA7z2khpa50VHXjQ1OsQRpz1YZswt7+7yb6nCMBvzQUnbwuUJjr2s0ZO22E81AmTxMrGHgbB8I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:b0e:b0:77a:d97d:9afc with SMTP id
 h14-20020a1709070b0e00b0077ad97d9afcmr287936ejl.199.1663254354566; Thu, 15
 Sep 2022 08:05:54 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:02 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-29-glider@google.com>
Subject: [PATCH v7 28/43] block: kmsan: skip bio block merging logic for KMSAN
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
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
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

KMSAN doesn't allow treating adjacent memory pages as such, if they were
allocated by different alloc_pages() calls.
The block layer however does so: adjacent pages end up being used
together. To prevent this, make page_is_mergeable() return false under
KMSAN.

Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

v4:
 -- swap block: and kmsan: in the subject

v5:
 -- address Marco Elver's comments

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea25..106ef14f28c2a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -869,6 +869,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
 	if (*same_page)
 		return true;
+	else if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
-- 
2.37.2.789.g6183377224-goog

