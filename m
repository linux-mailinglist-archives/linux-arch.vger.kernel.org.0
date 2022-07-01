Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D656356F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiGAO1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiGAO0q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:46 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72D27FFC
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:35 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id kv9-20020a17090778c900b007262b461ecdso832237ejc.6
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tSPSuwfCBJYINsR4GH3IgbP5patOgmYnzcC5xbF5jrk=;
        b=fBpJ5slqI8D0FOXlutf00Q01e2/qkKGZMnWH0QFqV3SMTrnSjxCWOU4Pqh88ufv3NQ
         IfRJI3UQIhuhwdip4JvVQMQ0GmgbHCP23qV+TLI5z5xixX0f7GhYWJ0KQ1im+NF7L5qc
         Pkq7nAOUgfMsrQqnSYEqcjeYwLR5EOBvpP0TGKGBvfsM2Tv2Ix3OAW1CAWsOCQoKqQ9c
         em6kSS3mBnEDJKreuud9sUY6SkRHrCFbsdOQdD/6Y3m3J12I9+Y2wd+Aam71SXnA0koY
         C8Wt7O96xHpDNeJE2AG92PtC1SizglmTVKICFmvWSO765naM8cDe6vlSu0NadfhbBuA2
         mElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tSPSuwfCBJYINsR4GH3IgbP5patOgmYnzcC5xbF5jrk=;
        b=FeKMCq7eO4f1aOF2l4trODx/qc6NiEhkMiKfX6hu79l8FCd/k8f5sLYiyrZnJC/9Yx
         K7AwMWrGEyDyR184NBgtGOmohPiO1EOw//Dqz81upMfU//VVmfCdXu7kQ7Il5uLX4I6g
         1JT7Y8mxjtplmOQBxGTvaUcMBNXbpkWUmcpPErXP6+B5u4yB+2UMKXiyLbIAvvEGTov6
         1h80S5t7Ysa2ZnmbHAhdRRN+VsvF6H0Mol9cK8Q+rxVOpUm6RVh58GpfqHnpvO1rCRey
         h+ma5zXAYPAHWlloE5KfOzNLXaTQpKt2ItKgYG9pUjZXpiBYwAVM5mkaFA9ENzS9yxCs
         2Wdw==
X-Gm-Message-State: AJIora9LZHPwA+jG6h9uxPbum6q2t1RDNv3GFMYGT9NdFy1MdkRpoz5Q
        wTdFD7iPRGoEvcjCuLJksAwsxrerDn4=
X-Google-Smtp-Source: AGRyM1vbbcq8j11xYn5VJA0O5txvAR43cAqjEC618P5YqGVKcV6s6WBbHTsxKY+3oiObUtk4x14dSKdPgts=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:1f15:b0:435:8a5a:e69c with SMTP id
 b21-20020a0564021f1500b004358a5ae69cmr19068159edb.90.1656685473944; Fri, 01
 Jul 2022 07:24:33 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:53 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-29-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 28/45] kmsan: disable physical page merging in biovec
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
index 434017701403f..96309a98a60e3 100644
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
2.37.0.rc0.161.g10f37bed90-goog

