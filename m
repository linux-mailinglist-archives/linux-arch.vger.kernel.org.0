Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07F288E0C
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbgJIQOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389701AbgJIQOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D44EC0613BB
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so9316590ybk.9
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4HzvBRrh7y77qbzNEjVJ7UvC0hGlxJRwsbNcMQwghFk=;
        b=ZNNTphyuqijkRLPow6CC/aXgGKsYBRFzq/yKSKcyxkgD/lkmYvVzPyhTAXclZndZdh
         L3lGMAoJTnYIv0JKMzOqbYFxS0Z/IXLeipSXzl8ZMqk57oa/VznHrTFfgXFW0/IfZcD5
         RqYTIdP+HiFz81jIb/NfQ1D9Haxc/uPLhTJVMZahC+e46ULJHAo2s4sjJ9UcS9BRTN/f
         US6FT8LeKQoMEj/HEtVefzXtpmZ2ndjtN2ZYgQYJ/yL6MsN+9+7BEiRxGDQkpU/Prblz
         jXweMCv47z7uMWgqx10kSVje4u+fTnnhzw09XocxwMtFtHquTcS5T3ofegl5oYhmmSKN
         kLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4HzvBRrh7y77qbzNEjVJ7UvC0hGlxJRwsbNcMQwghFk=;
        b=KT8nVSaJOb/2z+508Z4YF0bFs0hxW2TqYkqud7a9zV2svX5lbZISWhbscZ61wgTnda
         2heb+m9WQ0mgIB5viiI+Btn+eqAPEAcKPfa0butspu7rjAFmNmyh17STkCrF0GfQehli
         U1OtDcysNF131Fqr4I1nstwR1CfqpaPMuLQ96EqB/OK6k99LOCnhKhACw8Nep6wBOmjA
         xCmn+rxQpoeSGCwc+EtbJ9QN1GzUPiNdKws8+3FQGsR467hMTWntA7nqz5BHMkMLd/2e
         lTgYeBPu8/umApENN1fPsSukrHMZu6Jn//MAzCodq/O29c78NYOFA8bs4bk8Tze9nFDy
         E0bg==
X-Gm-Message-State: AOAM5327eFKUYACum5o6h2IWzFxItAeHUUf2gFh2V0zrqByku7fca3U0
        X8OJo4pLazmbRsH4+454z0AdU0tARgNt4XziYcQ=
X-Google-Smtp-Source: ABdhPJw9ZF97isedllPPEidWjLehS6Y9RG+YGmBbMiJNYvcjDkRjrFEYfvutxmTQNPM4Efl/aY3oqUISefUn5+QvCQY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:af90:: with SMTP id
 g16mr17666057ybh.259.1602260045402; Fri, 09 Oct 2020 09:14:05 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:21 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 12/29] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
index 6d31a78d79ce..3fe2dca17261 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.1011.ga647a8990f-goog

