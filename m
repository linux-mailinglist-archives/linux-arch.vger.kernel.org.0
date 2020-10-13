Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671C228C618
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJMAdY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgJMAci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E77FC0613D8
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g184so13880833qke.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VMCZDfrBZTgAeIay1rQ29+uk2lw3Iqw8lHEoyZvJXcw=;
        b=nfKwI9L0AIFN/q2chPmhJejzrBkYs0AxSEEy5fMqd20mS1osQThhU+ktBGNYJaYON2
         MjqIs9Rl7hlo6AIxtQ8N9k1pcoq5ps0nN8zY2Xo536Oyj1gVgj/lQEyGB8wz3lEphQRn
         2a1yV5HhbU2nGBMNwGgkGuol3VvcnDW+IkWtbFHZhCYQRfBcbMJubOSbajBBqU+1O5Lc
         vfXB9fY0pxR64gHEC1sLB+1X7ygPM6rsC8GT4gpvySGeXGx9VtbnLfGxKbpXvIJwD6/H
         97AQwdvtwYTTmK+V2mtwsV3UBIBJzwfFWuK8t1tvV6xVdxIgGCV2JLCT63S6ODvptoz5
         tFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VMCZDfrBZTgAeIay1rQ29+uk2lw3Iqw8lHEoyZvJXcw=;
        b=GfM8HpCgKsApuDQUMsW7czXz3QtE8ZTk7vqxl4Qg5wFPg4TgNasOPjMqAyw7/cpX4q
         J3Dqv67KTKcAARgIBorSsb3qYAmju4YOS4jaPbS4D+FE0K0WOflQlsM7H60XiVlXntLG
         NQBz/JDX/ydXVDdml5v9pPIPj4BKBMBwyBGHDmanc8DwosllB/lVmU03I3Wu3PsyqwHZ
         5iGhipHvbcb4GMDJwQee+NELmELv85ABo9wZkcd6kdVfS3i6tegMji6KTaB8f7WctrHO
         m3pYKtgtn59sNSP3HulaXKpyG7x1sG2sff4ZzhWQuQOUj8scrRoRPPo3q4ECINdmbpyx
         9gMw==
X-Gm-Message-State: AOAM531L8GbzBtDOnxtcKBUO+arYzFFvkzYEkFflYmCPq3ooJC3XbJCv
        zxWX3ploQ03TsH+IPj0IFwLBNZwivRPgx1APRp4=
X-Google-Smtp-Source: ABdhPJxSmGaKr8jvnZZWeZs3NgnMtwPC1onr9g3CEDlPD9ytqEe1Dbwb5OtBLL/kqlcnIZWLZSXhLwgEYzEWhabcOlM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4b2a:: with SMTP id
 s10mr1226538qvw.54.1602549150461; Mon, 12 Oct 2020 17:32:30 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:50 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 12/25] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
index 91cd6caefa6e..41b01248d400 100644
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

