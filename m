Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1556356A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiGAO1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiGAO0r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:47 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB63A1B6
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hd35-20020a17090796a300b0072a707cfac4so841017ejc.8
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ssAyKoViePAlR4LG6grDIIfDn5PGY84PY+YiOkKWqdU=;
        b=G6KzvVOzqo6QJFZMWm6nHQe5vJR+zroKwVscg+jN/JKqdskPZJ/1aqhWFYtC+2bwxo
         NXP1bfPuLlXUIIgvbs9p8xHqK+UMJ7rwAgUxvQozkeEjqAnLE/RFvNQVwvJnt+81yd+v
         HpfzN1hhNUR3zRliOOqHbAvewRvY5bCwm21yXKVpqWRCePcOpIkqnSd6sMD2Wkw4/xTQ
         KhUqVjXvWdacoQCUWPYOlEcJPWnDk+z27yXN8YpIbfxkOh5QZGnMGQLocZsfvItYsGD6
         QbDu599Ew6o6dwINWsW0S8a6FHYXse2CJVkRD/6pUzIL5NVKDDIcBkPGOvIc1AplaBNk
         xrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssAyKoViePAlR4LG6grDIIfDn5PGY84PY+YiOkKWqdU=;
        b=DpQfKMpDThr4HrqM90Rz+lwFxbCsfXSReW6+n3ion2cABPVCylr3fsZsbKnMkSYHPS
         gDqiuzE1iinDO5Ke4Np8XyW022biuuIm2JWOBX6i7LMje6nQuctiVjetgliNXgBm13G1
         Ou+zHmQGsvtTQwKtmFc5Z8OZrVgArL9wjzJPLIekEsNrncpUsWA7CuuWhr4KfWXB4jH0
         mA/C6zP0Sk1ywG18rk9xFwihI88fBTFFCOtYeQCtPRbhdAPPcVRexhS+yPD3S2twBG+e
         G9YoytAfdHB8W2O6UjCjQiMrYfb1zwezXdKOyTCGZiu/5InEAiEa6xeFroj0dmKEU+AO
         Fz9g==
X-Gm-Message-State: AJIora+k7nLj37sYxAGVR84LOp0/eTgD7FapHuLg6JycnoskjCjWzb7H
        /Bg0IB+KAm2nX8cH/0Hj34Oi6fT2oXQ=
X-Google-Smtp-Source: AGRyM1tVCF+sV/LeuqKsrQABp8XqaJxrk3E/8bbS/UOAygvrbBIURmws57k41Fha3AzhybLg/iCTnOg5f0Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:2077:b0:435:a428:76e4 with SMTP id
 bd23-20020a056402207700b00435a42876e4mr19161928edb.367.1656685476397; Fri, 01
 Jul 2022 07:24:36 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:54 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-30-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 29/45] block: kmsan: skip bio block merging logic for KMSAN
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
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 51c99f2c5c908..ce6b3c82159a6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -867,6 +867,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	if (*same_page)
 		return true;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-- 
2.37.0.rc0.161.g10f37bed90-goog

