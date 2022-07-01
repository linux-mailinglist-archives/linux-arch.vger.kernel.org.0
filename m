Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75056354F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiGAOZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiGAOYe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:24:34 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5583DA5C
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:52 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id i9-20020a05640242c900b004373cd1c4d5so1893292edc.2
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PCXlNDV7asGuiYne5zMLVF95C5LbNPo0tZu8h92qf24=;
        b=At0kpR+7GbMYGbD3FSMWgm2JP0BV8RH8Rto+ZODMMn/z0B3vgzhxxWFmIqaMmM9L3C
         aNCmXfo6YUoUIiTJElUOiEnHhSBIqPy8a7onAGUAl9n4baUa/KcBUobt9fplCCRo7R+2
         FJo7QcbMRDLlB8vftJOnq+M2J1oN7gTUZDWR3uyxo+NUMhcERhdykf6ykg37DhNfFVtM
         x3I5LV5DF8QOxuVcmdOlWAmT5YLzMlab3EWZE6++Fq0YccDaGwEWg4rtgrg7cGiHpldO
         RsbX66G8NwOBHTBYFwYfODhKpIkfxrnU8VZ4zPBZ+qzKi6r+qU7sLkEnyV6MCpb4vpNM
         2+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PCXlNDV7asGuiYne5zMLVF95C5LbNPo0tZu8h92qf24=;
        b=EO8cFwtFWj+lxYhoajZ+UfmQN0fiuo5TWXyJOXhcZ5RS+DtzMAiIDlRqMJ4ZKQj18D
         63mllgjxitvVX5KDrUKh8A0djq4hgX8ML1TZ2nZ+n25YJBOBmvN22Fa7mzCJ+yrshnqz
         CqrBEESgIVAtFQj43bgRBTIotA1fsEHHLr9G87VSaU5dzkW7J2c0P6TDko8kcHbwqnfe
         gJvCYqevNLclKxjNEY1096Z/+q2d10nwoAc6k9Rz64HJp/rmnkK+WexdG61XcT7ZWwLI
         FLvkCO141al3/uyjlop7JOBWza2Pzw8O7cw3WqOieWJhGO3K1twODr4EsEh8L7PKTqcI
         C3SA==
X-Gm-Message-State: AJIora9W0K3QrOw9AkQViSR7zgze2qPGMdbhNAGAM8dKV1SdTydBh+ri
        KdZLRhZEb5hrcU+KoYsW+awgHOagRkc=
X-Google-Smtp-Source: AGRyM1u9I17I9UxxKSpcqjnVIo/mN4dyAvFgl5Bm+pBE1XybOt2h9kEiW1jwTQ35IIGsBNaKQVlCw0/gS1E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:906:c781:b0:726:c967:8d1b with SMTP id
 cw1-20020a170906c78100b00726c9678d1bmr14665371ejb.54.1656685431730; Fri, 01
 Jul 2022 07:23:51 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:38 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-14-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 13/45] MAINTAINERS: add entry for KMSAN
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
Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf1415013..f56281df30284 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11106,6 +11106,18 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.37.0.rc0.161.g10f37bed90-goog

