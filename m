Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C35A2AB1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiHZPK1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiHZPJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:09:23 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE02DD773
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:49 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id w20-20020a05640234d400b00447e6ffefccso1264389edc.0
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=PmohPhKomZXd1zOAWK/EQjp0UhZ3tSbnWnyq8ud/fAU=;
        b=YJO4Xg0+O4fDaxcbYp1umz/9KOZq6MT64iPBuvb1Eyk0CRlXy5BoZxooWMgHq81Mww
         aAkaFVvfJmx8okxcpaJTFDvGl68dPKJ+48I8mfAqwXsEanHocOAaCh/MGEgmAYwBPoyU
         B98RoAIMKx99hewKWZNnFsrHAzTgDEPPakAw+ENqyBC9iSPWmrVjYUMFS5UztA5Jrts/
         NAmFaPfKOWhmTiRrueAff3+7UOYpVyTReHij2nZk2PTf9O6wfSScGw/khRnRflK4HTor
         aK26uUCVllQrwo/IEachNt1mk39lrVOLqFljJSHkCaPXcdzGpzQO93EM3hejm5qh5wEj
         xnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=PmohPhKomZXd1zOAWK/EQjp0UhZ3tSbnWnyq8ud/fAU=;
        b=aEwkCvIyqY8Kf3Sf1j5JgTxH+XdkeUK0zrAcimNJAo8SeAPV+Zci715TrEVCHJLE1M
         UBsSXMAaA53N8v7hrp1LZMLSsNQUNUmYN+mLxkcNPVG50lY8DRWAPDgKqKhmwTetYmLt
         nqyXdO5Nfx5wclCB/LX5VzYm7NgSHFH5V49LOoLpNLg/lH/CSFq7UZwW33eozHypOLHC
         tLMWejW+5ilBgRYjYgLtysglemZfF5I334isrmdPoVrG9mv5Yrykd2jA2ARpaXUUta1y
         SOvKCuniLQTNbQt7ZWvmJJ1ik5LNHyPZg7kf/Sk1rSwLQGmpFEO8VJ8aOeoLyTb2/0Im
         UVWQ==
X-Gm-Message-State: ACgBeo2eSrzugHz4y8SQJqo6Ir7KCjr5zvxp8jedyela44HMARBXIXAC
        cdTS4i8wWxusJ1prs00gG8hCIz4zCsA=
X-Google-Smtp-Source: AA6agR7e2paC/ZuzvRhAHjB4767/oTAx7KXCr2XuebS6jhDF8RYl+Uz9hljfZfbpg8cNZSTTP2UQ/IVJ12o=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:2cd0:b0:73d:d80c:b51f with SMTP id
 hg16-20020a1709072cd000b0073dd80cb51fmr4282876ejc.619.1661526528970; Fri, 26
 Aug 2022 08:08:48 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:36 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-14-glider@google.com>
Subject: [PATCH v5 13/44] MAINTAINERS: add entry for KMSAN
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add entry for KMSAN maintainers/reviewers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

v5:
 -- add arch/*/include/asm/kmsan.h

Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe8..3bae9c4c2b73d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11369,6 +11369,19 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	arch/*/include/asm/kmsan.h
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.37.2.672.g94769d06f0-goog

