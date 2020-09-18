Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48D270641
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIRUPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIRUPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:12 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C1C0613CF
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c197so4356944pfb.23
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AuswF6CKDN8dO1xH74r4m5G29uexAro1Nb2/kCMl6ng=;
        b=pyxY37ArYBcWk0pTveeYem7o3r7m0QxYR7o9ddMazv3C4wUXpf2wO5JjRX0hn4D99a
         ZfGgMQ7Y6Q0IcMD2Az+PMWVEf1UQD0bMp5UvODjcuy5A+HFY6tfMzIjH2TOqDSGxfrkm
         bzhUpRLa1APdzJJuc3rFYJAUGU6Q8y3Q93uvmCIMm/1oh0Z+W85oIwCWP5Q55yaYOmbE
         gk8wLX192p13Gd0rr4JArg+R3FEIeSJsV0U3a+yj521FBPN70Pf7378jB++mxf7g6bky
         21wEGkI2GQeXxYFaCDkQXFqja2UN6FX7KM68hCqpPYC8vhf6aqeVZ+IoZbZQITt213Zj
         ebpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AuswF6CKDN8dO1xH74r4m5G29uexAro1Nb2/kCMl6ng=;
        b=oslWE8J/Lil27llQ9fhUBDkiT73sNkPT1ZI81p2iMn/VO+HYZzSCi/aky2HL6jFoFF
         gB3c8tB4MNQMI3SJb7xKHmJrtL6AOWrVxZ0hSz6pW6mkqRRqMKgfPeop70nhbPOuoLn8
         D5etmca5SGDKdDV2aL4kKilvE/r6W4zaEIIHX4L0dnBX8O7Dcv6aEZsihpB2Ir1OiHxs
         FILMFaahfZJGYYAl7qqSV9k3qnokeMXBP2SZlJkBX7q3cs1MzjO/7GpDoYSGGDhto0Uz
         QEE0u9R/9vjyC5V1rC3qGpC2JK1s7cCo1EhhG3nrIhPgduQJQp7e45AqWKfeCgGp2nRj
         7+Mg==
X-Gm-Message-State: AOAM532GuxKP+K2UngHjq7rdggr5/gIN8gYkOXaPo/qk5BEF8rEEyjCP
        SK/FKf4f5WTZgbVKMJOwcujPtja5DD0kufkTS+U=
X-Google-Smtp-Source: ABdhPJxzZeQUOl2JhbPGv5v7ZLZFcYcdjlAn8PduxMhR73rTNKLtzUhom6BcaktSr/Lr+jGrmaYuXtBeO2vdou5k7ZQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:d70e:b029:d1:e626:d12f with
 SMTP id w14-20020a170902d70eb02900d1e626d12fmr17241070ply.74.1600460111357;
 Fri, 18 Sep 2020 13:15:11 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:20 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 14/30] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 629d4b18e413..973155c24711 100644
--- a/Makefile
+++ b/Makefile
@@ -912,6 +912,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.681.g6f77f65b4e-goog

