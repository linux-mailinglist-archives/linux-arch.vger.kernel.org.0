Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BC5B9E59
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiIOPJx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiIOPIg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:08:36 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E19837A
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:53 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so5705316edb.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=T4yulc1U4RDI/lAlxqlpzG4AIUYO9fQrzg+B84ydySw=;
        b=bjU5Y1Uj6lzmlmNdbvfJIhixfGz/+MKGRYCvur483Xf78D7CTzrNFlvd42wNziHYle
         Vw8zzRUPc25b8rF96my1wPCxCLp6TfupI3RftJKXAn7dq2QlPkGvBgmhor+As+69qJvo
         ts7cyW+lzlkiH21NDXMKOi08blf2XU9uBJs1YmQtKDbV3CYIcVN2LJH0wP7yDNAqAidw
         2NVtGckV24urbHpg+UiXfOqAjGlT6CwNPdgB8y3HFou9URtWV43Pi53vkh8E0/1cN/xT
         J7/cYcC0yfDbDZhb+v1n2EFZPIQNAXrNcvBidelmwV20Zr+dNqjJnJC6KZ8B/YMPJfPN
         pmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=T4yulc1U4RDI/lAlxqlpzG4AIUYO9fQrzg+B84ydySw=;
        b=OCjSZt2p8SeViH6xlmtY9xw7nJSUwd8STOjhdbs+3PHcMSJ2ZRiCCDKdjkeTYk9pVT
         cSEP+KxmF00PW4bEOxjb0xdjN750HNrpLaZXNWnKj7xo0cNGhtsasx4e4k3qyXo7yihT
         moxE7NtSTufb3BE5pcyYLLnJPclYwK/yzcTd3NC/VlEiQ6N+VRFkHNOxlymuz8h0RjHl
         UOE8FkGm0LPsUfFbgw1LuYrS8ztoCBPaES8sB82j8WyZLpiPTGzduRKXGAuVWcljf+hA
         b06GWLSSBBPHbXGpTd2QQBds6F/Hfn1FjevX4VzdT3GY4ftEDYBEhkYZqRcgktaAK5Gt
         ztiw==
X-Gm-Message-State: ACrzQf3BGDVpJPjNc6RPle06XdtRDNtJE9aHW4tytjyLOZI0vdX57cFg
        Tmmb0QpSTBf1zOE8uSvEVvTGO9LmiZE=
X-Google-Smtp-Source: AMsMyM7l8lWYGJuBODDQ/HU6R5pl1eaYbgBKHbyvWwWvFjThOz32FII2oCbiswhP6heZLHjrzuBd6Y58nd4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:d06:b0:440:3e9d:77d with SMTP id
 eb6-20020a0564020d0600b004403e9d077dmr260579edb.286.1663254352056; Thu, 15
 Sep 2022 08:05:52 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:01 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-28-glider@google.com>
Subject: [PATCH v7 27/43] kmsan: disable physical page merging in biovec
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
index d7142c4d2fefb..af02b93c1dba5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -88,6 +88,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
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
2.37.2.789.g6183377224-goog

