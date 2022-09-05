Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0535AD2D8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiIEMbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiIEMaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:30:18 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C8606B1
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:31 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so2236165ejc.6
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=r3HZXk/BEn65kcaybENH+gdA6j04yycM3f96/pfDo3Y=;
        b=ASzeAsbMOdZf4WYpGmHP1pAOfqzeXvi1/mYmjoy1+gLpo2mFVGXt7YkxHdn2cGG7Th
         LhsyoqxduLzAWg9guBf7MeUGs5Sl556966lTsEax9VeA+GsBoCisGlbSkVEruCeqXdIL
         pmn8EWbkEJjYIFVr9fHMcvJQS7hgukxapq/1AYQ4UGaMetmJBsMlft+caiJ7o6VTTsRO
         /gBZA1HxzLhDIpKDjWeAuT4C4Rnv8Ae2OB/4lJ2Ca03N2vHUV4V1Gj7baRHl/poEsqyJ
         jflQ8NkbH5DBqPL8/Jio1X1Vv9nc7m22bqOJom4ePsHMKcBTNXLmYOpZp6cjj1DVwhN9
         4O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=r3HZXk/BEn65kcaybENH+gdA6j04yycM3f96/pfDo3Y=;
        b=HAbIgfx45kT6vx4K+I0f/0qVDUYzEdRsJ1Q65Yjx257C1lvu6oZOaVek/nvu5jzijm
         V7Aii6R0X1DfeMctOs6WGiFfLpxYWftJjsgqrS8YaDM0s0vr+USA3MZEOzi9z0acqUuX
         3QZbfTaU68uSVWizVuCjCx7Sv/5Lv6Qf6Bni9Bwfg2n9rlIQf0HtSdB7/eqDLwQlSrs8
         ci467EEHOfUkM6fGD5cu8Qvv8gTwqTSt6Nfkr61oZp4E3U5AAcaM6bMvD0PfK6puxrfv
         R+U0o8S7CwvJS9174wLc5OMjEQu9ZIT0jI0f/0TOvbb51wg56kTWTEo7tTQVr+O0v/fF
         WHmA==
X-Gm-Message-State: ACgBeo3yIe1u/xyynTzs+6JEJG2sUZvioAkys2+Jvt0niA8bNl/RYsUU
        BKw7flKMmKAc3yjizucpAiIpAc+BqlY=
X-Google-Smtp-Source: AA6agR4ywNo4RURTtgkJzNxgjjBzX0rpx4pVEpcnNVzzj6eodf3zbpdzsA8Tkeoavta9Gzz8OJ5GJVPldJ8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6402:348f:b0:448:6005:68af with SMTP id
 v15-20020a056402348f00b00448600568afmr32104195edc.184.1662380777495; Mon, 05
 Sep 2022 05:26:17 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:37 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-30-glider@google.com>
Subject: [PATCH v6 29/44] block: kmsan: skip bio block merging logic for KMSAN
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

