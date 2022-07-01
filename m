Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167B56358E
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiGAOaW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiGAO3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:25 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6566D55B
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:22 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c20-20020a05640227d400b004369cf00c6bso1890263ede.22
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/n5egAWhgjqHJF7YploSYMAs3TFFsaM1JiTS0Bn58vA=;
        b=Q64KAy7Oa2nU5QEGyiPc+WuoNDDnAlGeuwj9Gnp4CxbUOEi4OI3mY3DVAxjpBiKgfy
         oa7qyOyW4RhD6IyTiejiC7YtXEPcWRYAw5gxMRCHiOP9br49u9DBYFU0wT8izXo989yb
         SsJ683z3889b7saADkdB2NmfOQkA9W3PR5kSJXdTK6rlAIAn/matyXusT0WxYIYR1PdC
         nsJAkTFlORzo0vstvDMrGlx6qd2DiIZ3JP81lA81CBvxEItVe4LQpcoX5OTFruunfhnn
         6Il7stXu45y2U2bIykk0AFttgTTdTXs+YT4Idf4maBbQ8qhqqM+TVsUW/CeEtqqLOi3k
         x6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/n5egAWhgjqHJF7YploSYMAs3TFFsaM1JiTS0Bn58vA=;
        b=SXRreUbuszIn8QqNNv1+0rHmeLXp/bhV8IrCt3NeGyKODdmjsUoQww9A30XDcVl2Lx
         r3WCfzlMuH7MBVAoefBtduq6XexftQuxnGx3Oc3O/PYrajeTa0tyF+Con2ZZAYlr+0X/
         e6n//euMkErog/7W1t6ihdTfo+scdN3Vf93lTpmHoQjqxNARd7sORgTV/T+2C9/cWx4z
         2VAFytLduoILGNeTONaRfAVKdhD3azRJAGXGeVtW7Wwa1R5tCp8sa9n2plBj7cSqomOP
         tFRqbTL7evjlXrAx0BCSvv6BqK2cXcXpOlLl9Piu/ZUWZyD9O/gHd9q+v3Wdg7FHKKJ0
         8ZVg==
X-Gm-Message-State: AJIora/jjRaTbDtC4Kvmh5n1GzY4WH6VgUjaynspxwKcd/Ys+yCYc/kF
        tq5jUq7S0ERf8Uv4bz8qy/jg8AuCUrM=
X-Google-Smtp-Source: AGRyM1vUh8ZooMqVrhXc2xeGCFSNfOoXJqVl3ZPA1oCNI4qUloUIWKz76DRGg3RXhdunivVizxxEE/eITwE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:51ca:b0:437:79a9:4dd with SMTP id
 r10-20020a05640251ca00b0043779a904ddmr19173589edd.319.1656685515729; Fri, 01
 Jul 2022 07:25:15 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:08 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-44-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
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
        linux-kernel@vger.kernel.org,
        Evgenii Stepanov <eugenis@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains@vger.kernel.org
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

Under certain circumstances initialization of `unsigned seq` and
`struct inode *inode` passed into step_into() may be skipped.
In particular, if the call to lookup_fast() in walk_component()
returns NULL, and lookup_slow() returns a valid dentry, then the
`seq` and `inode` will remain uninitialized until the call to
step_into() (see [1] for more info).

Right now step_into() does not use these uninitialized values,
yet passing uninitialized values to functions is considered undefined
behavior (see [2]). To fix that, we initialize `seq` and `inode` at
definition.

[1] https://github.com/ClangBuiltLinux/linux/issues/1648#issuecomment-1146608063
[2] https://lore.kernel.org/linux-toolchains/CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com/

Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Buka <vitalybuka@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-toolchains@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I94d4e8cc1f0ecc7174659e9506ce96aaf2201d0a
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3b..6b39dfd3b41bc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1995,8 +1995,8 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
-	struct inode *inode;
-	unsigned seq;
+	struct inode *inode = NULL;
+	unsigned seq = 0;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -3393,8 +3393,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
-	unsigned seq;
-	struct inode *inode;
+	unsigned seq = 0;
+	struct inode *inode = NULL;
 	struct dentry *dentry;
 	const char *res;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

