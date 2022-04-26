Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D0510455
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353349AbiDZQvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353196AbiDZQu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:57 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B548319
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:47 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id z15-20020a2e8e8f000000b0024f13acbbf1so1663608ljk.13
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GtiQESdTzDECedHCE4txXpUZH3/tDa3FQ07WXH5OYuQ=;
        b=UW3AswRaq6F3AUzKmXnr7cPkQ0g2XLtpFenEmpgWjfvp2fOauRXzdotOTeUNyWSyYs
         4tmhw8qwzpN9wiAWPxJUMCVxV1rWcYuXS49a+1tCMi0Oc5SG780CX3I+mnAa6/MfcB77
         6+gdBv5jHg6AKYvKP7kA5u9scJwMLXdv1i19bLKNouK41RBdBrSMPPJuqKL61o2W1+Ho
         pFIgSZPybW4jMIEebVa0EuG05Nils5rY1Bzl3+5j5IX62oqraNKPX3IyM6K8LuZYgWcI
         qaxMdheHooD/KCw39MnxjCE+Vv1BhdJnZkIOIVorHWlt4oOjs2wI7s6rPQyDKu5idJkG
         PQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GtiQESdTzDECedHCE4txXpUZH3/tDa3FQ07WXH5OYuQ=;
        b=O5zuRCX366nzktKlINldIEANhc3EGr2RSOLjG5inyfG/Ae2y4JY/trROVt9NAwLaio
         md8Cf7XgpNSuW5hPweOnzQo5v4TN3OdFeXO2qfmVBHfJWm5wkEx4+W6hntEuCJAebOXb
         J1WTTGIqWqWPOy0MWGgoINHUENgXXmaGBRDaBfh5qFleAfg8uWFGT4ucyEWx8gxOQ2Fb
         N3meqAfNFOBLRdcMD4ouN5gYd0Wi7E0yWhE5cVYZ9uILFSmqcR/oO9no8GmUiXTiHemu
         MmnbO/eAAsLXrVMxxgrTBbmhKln2WJEOr3611q8qHALiVbBaq+222OiRzNpfDi50A3kT
         /ogw==
X-Gm-Message-State: AOAM533IJJc+Zj1kdqe/NYMR+nGje/YVGT5KxiE4dg5YncXLz9SHTvs3
        H3rwp9QQlpAqvEQCXv+ftYcU7JbUcuw=
X-Google-Smtp-Source: ABdhPJwozf4GfzZ3k/EMYH1LpIZPBrUltfR1bzZ40SvgirQ7Xof252RdKVFQ5zP9UN/h/78LotXJK8Dsdf0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6512:20c6:b0:471:fdba:1480 with SMTP id
 u6-20020a05651220c600b00471fdba1480mr10896844lfr.425.1650991546042; Tue, 26
 Apr 2022 09:45:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:02 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-34-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 33/46] kmsan: block: skip bio block merging logic for KMSAN
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
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
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
index 4259125e16ab2..db56090c00bae 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -836,6 +836,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	if (*same_page)
 		return true;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

