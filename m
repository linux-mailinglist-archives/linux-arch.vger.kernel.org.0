Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3B5A2AD3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiHZPON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiHZPMg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:12:36 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8BDEB7E
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso624257ejb.14
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ThlNJAw9Kex8KZrskRhHj0vt2sXcunlblCUmHxCmdH0=;
        b=qQ2U4pH+aEHV3VhL/BG61D7fD+fTTCboEipAha6RdIlQZwkpHT+D6S+zluEN3z1B+q
         p6KSrVqARRa5621nYeg6EZduZRldgx+r7wiEO2xx4Q1xdyk3NHKRP+n4BtOU+EkTRiBv
         n9pYohc41L9MNpZ4FFw1iKeBekfif+vSNYJKYp9IPK+WdwoL5Xq+pRz96l2kWYetAuz9
         ItAJhGyVh4AlEUo/NPut7UEgT36U97b+onPRJ1+xwb33JHHm9d1XBCaLKaZdeHB78F1o
         GDrzwrmR2heq2RM/Ijy6NFuNEoHEGLQn9rAcq11k6RQRmGERKya5Rzxx6la0Wnscwu1/
         yKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ThlNJAw9Kex8KZrskRhHj0vt2sXcunlblCUmHxCmdH0=;
        b=PIanlyoaXshqczSS+CqaZ+mvAUPMmz8eRjooJawd5F1avPkI/dt4D7UmhRiva156Gd
         wuue0EoU6jp8WP1Mqg6R1JC1DR5pyTILwJNJmPP9Pg2++S98XFOJHF48dWxeJGtMc1eL
         jn5dKzt9DAvlrpHZlwaUU7pA8kqmeCNwABaojhlSflO/B/S+JBpCmcKXgz9dEQhlcGHg
         vPpTExwCk7cmV2Xac2od74+MSHFLeCZua8IkPrQBL8RJdXBjJESb4Rw+fXxK8Z6cSfkP
         pt0W3VeqPpLFcxhxMiLGWw0hRFfYDpifSMMPHgDsWPlO4s569ZeyObtKs3Qlsmxit9mT
         eNhg==
X-Gm-Message-State: ACgBeo3krEpmsrD/+jM63+Jp1I+FiZJmnpA1tb1WlTCWAuE/7XQK+CXl
        AkoA1dmmMShBnz9dgjLbvW0bP0R1qpw=
X-Google-Smtp-Source: AA6agR7P1+orY1RNadpoV0ZNi4BGK9MvXVRSI3uWf43JN88nANc9J/bmowMSnW9dE0hDywQIYKYvs/S52Ck=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:906:9b16:b0:73d:af6f:746e with SMTP id
 eo22-20020a1709069b1600b0073daf6f746emr5932849ejc.32.1661526573448; Fri, 26
 Aug 2022 08:09:33 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:52 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-30-glider@google.com>
Subject: [PATCH v5 29/44] block: kmsan: skip bio block merging logic for KMSAN
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.37.2.672.g94769d06f0-goog

