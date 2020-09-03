Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE325CAB5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgICUej (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgICUdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:33:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C7C061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mu14so2156350pjb.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2NV0P0BZEhFeVXK5NU1s/CPB7b09hharJKRKaO0KUAA=;
        b=iQC3MXcnnX2MJeVDml9r32koVHGM9fCnhlqFyGQpI4kg6N+GAVi3eGpcReIyaQtftv
         +8hQOVada7+yAvDv+aDU/EX2lefZWBlI9dX0gvIJ8Kui/Wbd4nfao83zED/RIwUOKlUV
         gA5DFOuDkiclAAdzZ1/RROkyKMSuawdisMFROE1LrIYELe2IjMVIt9K4CTCeZdrJwu4h
         7qDCOjod/u5pLmt4qqLI/ZOb622Ix0toxovXCmz8FD3st43YIbEjbKdrQpK4ZVWgCZs1
         02Yx3hYWMaTbxLOVDZUON1042qKsUxlBQ0eLPqPtOoYsRyCMeWYMt5KLAQ1gBbndPuHD
         TPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2NV0P0BZEhFeVXK5NU1s/CPB7b09hharJKRKaO0KUAA=;
        b=F40Zjz8i1dOdx7L9QtKso16W2mxESwx2pWxgA+TVN9BAJEkNqBB1igLprOS7TFkRfs
         RBnlwAO9YNC6LWMo6+aBXhIOgr5SoeYdzD877laJpHdNwREZdx7kvTaumM0uuMwVIZVZ
         0nkDGTbx9nLAsXp+UAGfiqFJRReUkF0xTS5tPuAokA6XIHilNcIiBNlEwDYjnloysk8X
         UAC3h0DSj8r2ukxlRzE9Kjh3go5xGj/SUL0ZuNATk6R6kwfq7lPk4OmDhdQMVrc4auqq
         kdYCHaQdhQ3xoFbzkL9BekXfmF/kCMPDbWQo748nMiAnlKrWlNAyueNsUYXJBAqsN14f
         nTKQ==
X-Gm-Message-State: AOAM531yt7hhB2uMeASLsmCnlawyXzjFc3K0Z7k3exgTchltRvdEKUDS
        S7avrUk9RzUGbb5nkI1F6co4mI3iLHwrZqd+zEI=
X-Google-Smtp-Source: ABdhPJxXEiK8iQgluE8U1P9eVcF55qIItGQI+hRRjVeMXkeZ98njIjZMcmdWbshQtzwoU58/viNSLC1erEh/riMVVr4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a62:e107:0:b029:13c:1611:658b with
 SMTP id q7-20020a62e1070000b029013c1611658bmr3713577pfh.8.1599165105298; Thu,
 03 Sep 2020 13:31:45 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:49 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 24/28] KVM: arm64: disable LTO for the nVHE directory
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

We use objcopy to manipulate ELF binaries for the nvhe code,
which fails with LTO as the compiler produces LLVM bitcode
instead. Disable LTO for this code to allow objcopy to be used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..c903c8f31280 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -45,9 +45,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
 		   --rename-section=.text=.hyp.text			\
 		   $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, LTO, and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_LTO) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.28.0.402.g5ffc5be6b7-goog

