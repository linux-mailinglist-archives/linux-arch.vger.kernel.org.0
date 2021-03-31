Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED335094B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhCaV2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhCaV1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1240EC061761
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 10so3672928ybx.11
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VrfRHkoNzR+0/b/OZROtS1u75H9EO8EEUwf0vNpKXW4=;
        b=lPEGjGAWaiYjsz9zU+YHuadto6OsoV7V49BU7GsqscQe5wK/si5GABPDlQXYT+c+Z1
         mb0iBsdbFeDScYW+6Ep34gTydantp6e+uiENRCYegt6foDck+ev8w7TstW0kE3+NLA2x
         v/80R9LLk+21unRgCwZCixd3RJqek9N5I9CXu0emDkhkyEsavlD4eZJDBCQL0gdu1l/E
         KZGm5gBzVK3x6BXEL/DnxIp9qarxFEGoOoq89b7yhh3Cw4cdSZR5pG2lrq7dbUe5mN9x
         dxn8t65kLsbOAQqIUcrNXKM/V7HyJ5KLsL1PE/Xn5UzFRc43UqksnE95n14OqVoTrSwo
         KriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VrfRHkoNzR+0/b/OZROtS1u75H9EO8EEUwf0vNpKXW4=;
        b=ZL2ELj1KxZVV5RxgHxzt+idBysRWf5i1O8/PbSIlvR2lEzqYXSW7anR5I34FBu+DGT
         Nx5JWSm876L2KxAnmZyAy7f6eoK4WfYSuckRNYm//WhOU5OPtGmc0KlZzbha/To7wTx2
         /Dol8tLiGik9qb/cwPN/UjLQ9hd4JPSwzhlxVYQpIIeb+L398aFLnJagkZHvNIOFuviq
         E4c2mpH6GFvjKLvwKI3jz91bicfhUJaI5XIvzeTayht/hpGeHJIk6yekGAGZJHJ9DLcm
         xUThopLEdNROChcnXkl5JYyE2L4VxEiZ61ID5UhdxCJJSsLoifbCgBZVv4HVV4zfFyUQ
         pxjA==
X-Gm-Message-State: AOAM532HPkRP1IQWlf5utfJm59X15g3iX7NTNJpmaI/4980WcnM+XPll
        tRir3AvNVvHYWEOzmNYhSerHQhUPTXbTZjeRCJU=
X-Google-Smtp-Source: ABdhPJwxA0CtxdkWc6M/jwZJvtoqXk9nSdTKxmLyT5rwl9B6GB5FZIGHnM0kBXshVGaK6mnJ+f6IJx8IAQpBxGRL/Bk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:bb49:: with SMTP id
 b9mr8136529ybk.350.1617226059304; Wed, 31 Mar 2021 14:27:39 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:12 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 08/17] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

BPF dispatcher functions are patched at runtime to perform direct
instead of indirect calls. Disable CFI for the dispatcher functions to
avoid conflicts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3625f019767d..2f46f98479e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -650,7 +650,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -678,7 +678,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.0.291.g576ba9dcdaf-goog

