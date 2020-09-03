Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC35525CAC0
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgICUfB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgICUcw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:32:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3E4C06123C
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a5so4012643ybh.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=ufRzOZtYYauSzvxZUBKz1JVbuUwKqmAJdSrdtsdAtyClxzQSdbUMjMfIMupNHjnLGB
         WO4ZqGFWI4GoHdfXhHBAF+P/jv072mNJPl0sQzhOhWjmxcDeq8t/wGGp/8OanND4USfj
         LhikjLiJG9jAk0+cvkHoOwClvc4d+s/6mEvmHU+7r2wfgvpCQERcCjQH7zsDH2517Ogk
         GD3ZV/LG3aSx/OdpXy0Szz6VTm1uw47NfsFGVYKWXK4IlQH2y+9jyGDbrxKpkAqRVQ6l
         TgM50rxrgjBcqFMaRVrmvkVprT/6WaCjwoJLbBtb5rXpbpl2VQ2HuV9qu5Jf7aVs2fRs
         o+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=a+VRSlyCyn3bbStZDS6E2RFCBxGTN39RrKZNGFB1Wihhd0Xm0udo28ZrChvlx6VIw9
         QAbIvnI4tiImCtRNM7edNKvzK1PdJXvfPh70CvEGHc1r+Z4G/d/pfDw0prRLrBvR80Ea
         RiODueSM/YYdbuvRJe4RzKDE5Rf5SZtaTthPd39EsT7dYjXHTU1TMqZxBQ7v/JIboock
         L09/Cpnro08yol+nKFhe77FPLEJTO5doj+8Hqq/Nannru5yLChxsd2oph4KN2qGQVX+G
         CSaNMx+0W5Dl2mOCXi3SmyyNi3rUaPoU9Yvk50XR7YhDu6lAhbL02ZPjRHx2jlw9AB/7
         dFjg==
X-Gm-Message-State: AOAM533GQy2FDEf/YvUA0x1QBX6I6CqLV5AU0xKIL+KxNcU+hnMApjQ6
        mDZ8y2PUm7g5sUU8lv4qC7f2ytVFgP9NlcfI6Rs=
X-Google-Smtp-Source: ABdhPJzSHh4NCUcdQaWfXuHL4xXV+3Gzu7YAUpxYnKR7xzXHL7k1OIFuYPArBmNIqbbqiPyK+SQbqhBjAf2rbEmrgrI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6555:: with SMTP id
 z82mr6003281ybb.472.1599165098726; Thu, 03 Sep 2020 13:31:38 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:46 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 21/28] drivers/misc/lkdtm: disable LTO for rodata.o
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
Sender: linux-arch-owner@vger.kernel.org
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
2.28.0.402.g5ffc5be6b7-goog

