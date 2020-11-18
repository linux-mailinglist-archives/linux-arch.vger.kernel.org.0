Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF402B8759
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKRWIG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgKRWIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:08:05 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99328C061A4D
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id q25so2799698qkm.17
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mxI/yASg0f6Fr52O8HbJJtAQuezjHMCx8HIdyf0ndaw=;
        b=wXL6d0K4ogSQ2FXaTmMFlblc8ygekSoyqjsrSzzJDjpixZCmnN20/goG3t/ED7/DTH
         OxdlaMC9ge+QbZ8tXanDBoxT3LpWcOf8luW/CBKbpnh2xsq7sGt5KwPvZSVnl9APk3gO
         8N7JkaxorXB7vboromu73acJ/93kZSSKsn9wdnqxhZRK+w7gFkEwM97MObjc/QMVHCur
         LGzCFisEIGmrlzY+iEYp9MAwtUT5BXbioFgGSXGwTvoJdAm+0xS7LKQ79iRezYDrbJkJ
         e3z4mvr4MBID2gFRQexM6A6nq0jYREQkekiigQeetFyTb8zgk9F3ePzJdu41Y2TB8/OO
         uNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mxI/yASg0f6Fr52O8HbJJtAQuezjHMCx8HIdyf0ndaw=;
        b=Ovw5olu9hheHoaLdxUXmk+oxtTjLOxiU4VGVFb1yAoM6g2v2oSn8T7Y7hnQpt+vQuH
         FJM5qwDXJsZFeMoxrqi/f7W2Z8PJHXc0u3ux+fm7J0DvULDjUl/XX7ltIy1bysLYlgvG
         +Epfbsa3afdmcI81o1UGzMJ6Ug7tjTDKXYlPfRQB8laajNZHE01g6F44Wy/RKV9Bt7Nk
         9bMATElohmm/3cYVx8s591Kq6xS6/7R7RCAkedqnNj49HWiBeMx0Qni7wgrAI/wqVpd+
         HNrDKI3EDSkuZJ27N4X/wWM1OhLPlfAPhaZuMnr+mXiHkXt1/3H1MECLUSOvlHGx1a1l
         CaXQ==
X-Gm-Message-State: AOAM531bfAOjmfFZJFX930IruZNOm1IcIGcj4Pk8DwpUt0VXb7N5LOMH
        ysxDSEH7wiwGYHPKybijCTqHfCqkwnPxK3VUGCo=
X-Google-Smtp-Source: ABdhPJzzh79iYBu53HM7s0ihX08oKft9CFEoRm+vpxgv6uzQ9nNVk7YbdnmB9oztYmiJRe0kvbcEJOxZvLrcJbYG6fo=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b34a:: with SMTP id
 a10mr7403176qvf.15.1605737282753; Wed, 18 Nov 2020 14:08:02 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:27 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 13/17] drivers/misc/lkdtm: disable LTO for rodata.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.29.2.299.gdc1121823c-goog

