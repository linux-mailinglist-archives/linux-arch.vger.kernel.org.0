Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B94EAD87
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiC2Mr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiC2Mq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:46:59 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6C24ED96
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:02 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v9-20020a509549000000b00418d7c2f62aso10948228eda.15
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g4O/g3yGtjFTnRq6Tym+8EhZXJHjgp/RAJrohmerxSE=;
        b=qOFgBTIRaBAgytLmSPVdMFIKWup6qEgqCTL9zlLnfBr+1qisKGAs7mZQzS5fF1N0/w
         75BSqMadVv+ZwN4R/Y1880VwCu1sYPXecdfh1+jci1QJBCu4bN2ZpoxrkGg5fNAeuw4/
         uqe7fS8vFdcz0MK3boRrEmswcahRoIs30mkNDrxgpAlwqh22khuALzbXXL7Bb57cf0og
         bNlPI0uZOKQd1VXKE1IEuIH6YQWnxA8v5sTwzz+4zJH90L3gpVOfXta50Pkpjz1H1DCt
         0Gsp0BrH+su3tpLOFauLfvXBA1RwcNoUCkd+jh5ebsHf0jr1Db/zRDrg1iivqcmqkSXF
         Zf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4O/g3yGtjFTnRq6Tym+8EhZXJHjgp/RAJrohmerxSE=;
        b=r5RkPWTZjk0a+wfZ6UYf5UEZGMfyEmbK2QtpAfutuUERU/PrntuGNKxqGSDIu4xI5d
         OqHeKEAr3u7tG/M/yBGYG4RZsHsDgjF/Bo6f9/70qu1246VVG4Zl5VcCG8k+ZUw4nFXd
         8vlyEBthr9EQQfqw02q/skqBOseCvurDeRD8y0kQqAJEJVpGj51AoB3YitnjU4i1KEcI
         Fnij+wtvFTgosXm4p7P70ozSpEKhtMTRkQTwCrB1qiYcSyq8BUuuic3+iqME+gSS5l1R
         6bBjamIQZVx8HAR2qi/5V202MGTjA9RtBAYBMRuJaAyqpveM2fQujXL1Dn492E1TRXug
         ulfA==
X-Gm-Message-State: AOAM5300i1Nc9zxjK6xpupq+td6Hso6OhoMhDGwu8GJv4etOC0nytNZu
        pArYqw5Cfwy9rDQfVnL/RmvO7V1Um0Y=
X-Google-Smtp-Source: ABdhPJxPAPS1bh/Xpqng2jeIO39gOYiCpSBLkakMLcyM6oP3/B0k9R3pYWtakO+RdreM9L/Qpt7ZGcmIJWk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:da6:b0:6e0:c59:f3ad with SMTP id
 go38-20020a1709070da600b006e00c59f3admr34366333ejc.85.1648557720656; Tue, 29
 Mar 2022 05:42:00 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:03 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-35-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 34/48] kmsan: disable physical page merging in biovec
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN metadata for adjacent physical pages may not be adjacent,
therefore accessing such pages together may lead to metadata
corruption.
We disable merging pages in biovec to prevent such corruptions.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

Link: https://linux-review.googlesource.com/id/Iece16041be5ee47904fbc98121b105e5be5fea5c
---
 block/blk.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d5..eb349916ac116 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -93,6 +93,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
 	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
+	/*
+	 * Merging adjacent physical pages may not work correctly under KMSAN
+	 * if their metadata pages aren't adjacent. Just disable merging.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
-- 
2.35.1.1021.g381101b075-goog

