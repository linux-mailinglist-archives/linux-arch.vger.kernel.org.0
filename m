Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02352CAEF0
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 22:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbgLAVjp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 16:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390137AbgLAVjd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:39:33 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE3C09425D
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:43 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l15so2203160qvu.8
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=vXHUajvUgn40LQCYOvZPKvqCWjM82atINdDHUGd5EhIZaxvZWNECR6Puf1wV/Xm1fz
         RZFUluVJoen54/2OkeSIKDLooJAqo6nO6jmid/KnIY+pQsB0jUK1FLQCjzUfvDCGjqfW
         5DsweDMH7mPM+webX4KoPPbT06j0wd8ib/BAqCtFcLiXN9fRxFfzVzezsrV61oCpnhyb
         7uduG6UItD7EnvVpEffELx2wbLPqlD3Oqd6UlZIDNGhgDg+wEFbzFvokQCivtnRsGs7N
         92Et/EOjPux1Tii1bL3i8/gTtmbaMJpflMTGhVRAPssOG6ib3nwdVtng5zkY0hoNy4H7
         BGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=jEgXP9XDflpaLkmOntXXA3q8+rdRGPjromdC2Ovz/G9nJ1nu1v4sMSRhQ5Seq12rIL
         AGxfzBqqr7GPSjCUvazdT9YQ5kk8qhK/t1TsTI3hd0dQ1S7ahEiLJCMF5gxa/REngvKI
         0k2VzyUWWFf+a69RvUwz/UkO2aRRsH50g98svUaSaalunQqEqmJk+9Zgmy/zlwJT8AbO
         vSs5xT8JVTFK3FUO+RUnbQo81SPB0uTsD3HpOWbvGz4oc+/A2GwER3SCVFtPE/eDy9TI
         +wmkSutR+V7iExeQ+A0g79E/Mi0mZFHzAVqc19Y9Rwt3j+Lj6WcecNseqVyvupKLJz5e
         7Q2g==
X-Gm-Message-State: AOAM533YvBrPuD5hbs+edxI/gGo9qAb9+etusQqerSg+Dsq9f1+DHyt5
        yMmWLtoic/F9xdWegBUI8b2PyNhh/B2LRfkwrog=
X-Google-Smtp-Source: ABdhPJx2UMQKvzPc9YbjuAcaOdZsXhK7RlcIM2M9pkfdRpnDBi+U9k28DqELenlSlo2tvxUYIND8c9jWK0Acmjv4ppQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5685:: with SMTP id
 bc5mr5091015qvb.48.1606858662372; Tue, 01 Dec 2020 13:37:42 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:04 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 13/16] drivers/misc/lkdtm: disable LTO for rodata.o
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
2.29.2.576.ga3fc446d84-goog

