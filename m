Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326576D7F11
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjDEOSf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbjDEOSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 10:18:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1151C1;
        Wed,  5 Apr 2023 07:17:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so141489775edd.1;
        Wed, 05 Apr 2023 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680704270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Aezn9KwOiaMHT8QBIvXqxw3/7pRoTbwoU4+L6kaZfo=;
        b=h6B0D1guAAz/+Fh3o2MFRuBp2njF7Fye/Xxf2r9nX8V7xNi91MOio5aDjUQBXijRT0
         75EwXqWNYR/1gi60t0DEKttu9WLaqB3/MY8gXnTwiu4Oz4MkVmFrs2JDhb+L8fnPcptQ
         7nrJoQYBcxE0Ipea11+gFcYnJH92f8uuVoDqyuTltBWba1oiCcF6uWTEYtwCT5xdTLlI
         qcI67O3MKKtm2Ll2/izFTSnFMbusRse/8HmyoHl63V/KzowbwYrV1X/+8pt5J0I287/X
         g/ngG/l9UiDfge5nIclREoyJnIxf0VVxBnBlDK8hGh94SIMNrCXES8Wpb/gmo+IR/6pP
         21wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Aezn9KwOiaMHT8QBIvXqxw3/7pRoTbwoU4+L6kaZfo=;
        b=r/8UG7SMi8mmqluMZiaS8+A3FcRxef+e0l7LrTLHji1vBGlMpGTOcJ+6wvg6BG6io3
         Xwr9WAMi2irDL3rApOJmIFUbvrg/MEUHwln4r2snAySlkpEIMJMkKL/lJOIgZD7ONoE/
         sjjFj/dC9aLAcIu9eWoKYzWjhZrKryKiGfgaM3nCYzpGAA2Tc7eYrXeuFojwxSOU2fzl
         EejMbB2IKjbPBU3iRifDiPNW02rY0Z7PGZQzmPumDjDrjkzOJ6Q5cZiNPEFeH258ps7o
         9MJZtiG8UugzZHruTc3RLDxEjNJWitx7LgS5YJgf6R+58K/OSITKO2yj3CoJPEODBYIO
         WNbQ==
X-Gm-Message-State: AAQBX9f8jXM1pm/VoKWQOvA3OY0Ai4ABtvQ9kb2N4XZM5mPUY93epFvL
        iMYyVyD+6uopp5rRjY1XXZISPO496/J9Mclt
X-Google-Smtp-Source: AKy350Z/3xgh/xSykpZuUX3JQoJOOenna0pCFqtY30j4WZoVD6fIcb1JmDg2U9Ji+C4VhgW2S0ytyw==
X-Received: by 2002:a17:906:d977:b0:8b0:f277:5cde with SMTP id rp23-20020a170906d97700b008b0f2775cdemr3133825ejb.32.1680704270128;
        Wed, 05 Apr 2023 07:17:50 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b009334219656dsm7381246ejb.56.2023.04.05.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:17:49 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/5] locking/generic: Wire up local{,64}_try_cmpxchg
Date:   Wed,  5 Apr 2023 16:17:07 +0200
Message-Id: <20230405141710.3551-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405141710.3551-1-ubizjak@gmail.com>
References: <20230405141710.3551-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement generic support for local{,64}_try_cmpxchg.

Redirect to the atomic_ family of functions when the target
does not provide its own local.h definitions.

For 64-bit targets, implement local64_try_cmpxchg and
local64_cmpxchg using typed C wrappers that call local_
family of functions and provide additional checking
of their input arguments.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/asm-generic/local.h   |  1 +
 include/asm-generic/local64.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index fca7f1d84818..7f97018df66f 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -42,6 +42,7 @@ typedef struct
 #define local_inc_return(l) atomic_long_inc_return(&(l)->a)
 
 #define local_cmpxchg(l, o, n) atomic_long_cmpxchg((&(l)->a), (o), (n))
+#define local_try_cmpxchg(l, po, n) atomic_long_try_cmpxchg((&(l)->a), (po), (n))
 #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
 #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
 #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 765be0b7d883..14963a7a6253 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -42,7 +42,16 @@ typedef struct {
 #define local64_sub_return(i, l) local_sub_return((i), (&(l)->a))
 #define local64_inc_return(l)	local_inc_return(&(l)->a)
 
-#define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
+static inline s64 local64_cmpxchg(local64_t *l, s64 old, s64 new)
+{
+	return local_cmpxchg(&l->a, old, new);
+}
+
+static inline bool local64_try_cmpxchg(local64_t *l, s64 *old, s64 new)
+{
+	return local_try_cmpxchg(&l->a, (long *)old, new);
+}
+
 #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
@@ -81,6 +90,7 @@ typedef struct {
 #define local64_inc_return(l)	atomic64_inc_return(&(l)->a)
 
 #define local64_cmpxchg(l, o, n) atomic64_cmpxchg((&(l)->a), (o), (n))
+#define local64_try_cmpxchg(l, po, n) atomic64_try_cmpxchg((&(l)->a), (po), (n))
 #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
-- 
2.39.2

