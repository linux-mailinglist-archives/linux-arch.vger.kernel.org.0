Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF11F510466
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353404AbiDZQv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353182AbiDZQup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:45 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306AB48307
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:45 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id cm1-20020a0564020c8100b0041d6b9cf07eso10589623edb.14
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KgfdOYR2+eRzwy3N1nFbXjWhZjMyNN/8KPMy2HvUIiA=;
        b=DiXJaiB8AJMG8+A1MDOZ3VuBShHUCaL1GlKQxcD6mV0R7Av/UajF571MXN7vKcH+xJ
         B9d0v8KhVCzlQ+z94pkBBtVLTSnlc2yIkyIXP0B+bFCdaqtmHA9pe8/5NYuKcmD5Vy3L
         fA34cdtJjSamNgh5dsmbUVd7b9zA7hnjKOjdt88/6jqxc/UG3ZHi4m5Nam5rWzqbzqPm
         cd06DBJ3ACVxlq9XrgpCh+wVKQori1dj0NvbQ7HSZw0NjHsIf9jtgKdLkxo1euBXeZpk
         ExnDMib7ea+byjuGF4JqXiPnkpgw3Zh2HRRI3cVSjxCjQ97crsBXKlz1IuJlZ96GONPP
         Cgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KgfdOYR2+eRzwy3N1nFbXjWhZjMyNN/8KPMy2HvUIiA=;
        b=aS4VG5+6b5FzIkfxAl3djeWb4larSPKj3pn/qBJmqM/CYM4Zz5Ik5+HpvZxc8OAMNy
         bd6Q4/5AKkTOfliHOlU5FFKhD0o9Q5spvrlDFvxJeRcb1Yba/CV5YnB3+BEJhWpVYA6b
         B4DRwIfyJGrvQLd+sHMJX4FtnvU+D3eKvLLSmqo3Q46g9+ZaLq4Ggahi3slQeDneHM67
         ng/75FoYmEfOjeRaS9rFSwE+RZ5Q7nx+9dLS0l6TqO2wlCloqD3+NpZQXN4MOukvg0yu
         eZZvNgEQtfUH6GuWs5xbJp5m7+ybi9ffJsXX+rG3B3JbRF0uEfnd7s0fqr1QFfzjBQSo
         ufxQ==
X-Gm-Message-State: AOAM5334taseaxwvbG33ZV2U3ca2qDIoyxZJGkEFxnGJvL+qK0ITn31u
        lBJxENtkUp3GDIORDdUInSgB8YyD3uk=
X-Google-Smtp-Source: ABdhPJzCT8fH32RoUVNaiZCyh2VQrj6uF5kLZlCQX+kBGFsZsTKhLxpnKoIswBSqwHZF0t1dzIj5uX6h2dU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:26c7:b0:423:e5d6:b6c6 with SMTP id
 x7-20020a05640226c700b00423e5d6b6c6mr25480700edd.61.1650991543391; Tue, 26
 Apr 2022 09:45:43 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:01 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-33-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 32/46] kmsan: disable physical page merging in biovec
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8ccbc6e076369..95815ac559743 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

