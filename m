Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE027DAD8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgI2VsA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgI2VrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:47:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AADC0613D0
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:22 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d22so3655456qkb.18
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M/tCJ87SKQnbyhBQptnFDCNgoy9D1scy1+3ph9ahS3g=;
        b=gdAEDDvLlL0msAdcbIE0elhCADhQmKL9S16dzNU1NewfqdOooSY9iFqACy8+PZ7gHu
         RjJqXHtJjRJu9BoQC0Z+qcoslnaCbYOM5YVwAUiEbJv8oMPbNKei4NbKX8/eYf1TjsBX
         LuD//MCUmK3U7ZJ2uod6D1w8OHvoyhKJylEziLAmUyzobSpYb93PY4CL1x+jJuLiN+Df
         TJvELp9Gtnh21l2Y6CWFhRqKGqHS7xc78jprEFcrRoojdnbVtKont9eEkY55sgaj+pEf
         r+rlpDV8ZtQQ3iUVmb9timiu1KOz8XTe/0fr94WEPlFW4uof3ENuM7MDtO9p1BgJUAsl
         mKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/tCJ87SKQnbyhBQptnFDCNgoy9D1scy1+3ph9ahS3g=;
        b=DjWYVL6ACKLhz6EzSygLSX3CwLvQoOJpFAIyq0gc4VwLSuiqJ6TypPxr5vep7tn5De
         65F3/KKAeQ3/0gt9il5LWJoaQXH3axxufD2B3m+sakmvqOvPbZ77rBk4FI7Yc7wDUcf3
         pkMjXTKa3TNPtUOEkOKLuzQvPoc3tEy/Sin8CmPUjjYefBnZGeNkapL9jY7wq8n1rlzM
         xuCjB4V70dh6AE35Yl5hBJ9YpD/+72Qbb1zHsqh7Uvp9maAFFS7+DDgPVua0RBa8xT3q
         vvIPM1zc0RWdkGkzoDQ4Ro10NgVoVOXNmDH3T8OJOqJWB7rOmCG0nYWzFwGiyK7GhEDn
         vq2A==
X-Gm-Message-State: AOAM531KXTjzpprWjaYTHBuDNQQakgVw6yitDX1TSvuIVfPJyN6CFuFu
        VzHAgmpqp5cLT0jiqViW+Yw0RfcYgFyPSBKzffc=
X-Google-Smtp-Source: ABdhPJwIclf1YZILYpRHL9aLGjIyClVObMTVmWZ7pfwr9sU8b01qvKeenw3eQ8lUfzBJlACcTh5VbLCas1CqVTaKm1c=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58c7:: with SMTP id
 dh7mr6716936qvb.20.1601416041280; Tue, 29 Sep 2020 14:47:21 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:23 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 21/29] scripts/mod: disable LTO for empty.c
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

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.28.0.709.gb0816b6eb0-goog

