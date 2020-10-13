Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFAD28C63E
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgJMAe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgJMAdl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:33:41 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA452C0613BD
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g24so13845732pfo.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=UStis3hbnwPX4GBdlrEziRJNAuXpozGmmfM1jjzsAsE8VSqd0cbY6odMaz39IA0Ojw
         whXL6/eJ7EeqBedFDwaT3w5Q+1TV0rdJwA3Y3y9puXLwfjf7F0qnCIboZUysC1WDMVid
         4Nj43Y1l6hIv3BvqtYvKlA+3y+Qx5yGdBGC7iek7d9zIgRpsjTFpfGg7cM3b7K4jNPc3
         C+tUthfv3AI4pSRMqj3k+jNvTZwQ0NPU9oBd39SNZPMR7BGOFp7+kKDm9ZAbYc3IAGak
         ZWMXtsvozkuOgmM9rpB2qjGh1x8II7JaobE2C/HaxwERoWZW6ZWfuMc4skxi/3WZYGIY
         484A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=GGsKYHFCIyt5XwCeu0G0E2Cpyau2OO7jbLfYeNXeZuDeEdqI8EN2KoRkm5I7992G1i
         vFTBWVOTj1ES9U0TFgthPamdRBPz7GxplU5vq6FKopa/CGvCiVMqcI2tTpCCuBAFJvPJ
         IE2nsz8CYGqJC7a1RqLTwWh17Vgy0jkFJgG8RDCiHUKz8MMVQ4+V8FE/zdkr42YqHJnG
         ZGmb56QrZeGeZXqJq2LADpUOmzB98kt/xgjZhvY/facea7IZMfgZqsjnewK9s4LczXi3
         hndd2gSBB7Td12jsOGS3dSjJvsRKyym/7vAWWKzJGLqWyZy32SfZVHCerKhpgI+ew61o
         k1dA==
X-Gm-Message-State: AOAM531QWmumpWllE4oN/VkawJMSUfDojhoy/57Tqk2MPpMwkWZ28/KF
        ek5cFRujmPwbJpzvXYiFry+mu7wYjs/ANDxBmeA=
X-Google-Smtp-Source: ABdhPJys+9GAtwDLSAFaJoF/SaTJzh0YT4ITojDPzI8BvdeCNUSIWeGX02fenqn9RcJYa4C5XTo/mbLq+dmrOimZhu8=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:b40a:b029:d4:e1c7:db59 with
 SMTP id x10-20020a170902b40ab02900d4e1c7db59mr157311plr.85.1602549179447;
 Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:32:02 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 24/25] x86, cpu: disable LTO for cpu.c
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

Clang incorrectly inlines functions with differing stack protector
attributes, which breaks __restore_processor_state() that relies on
stack protector being disabled. This change disables LTO for cpu.c
to work aroung the bug.

Link: https://bugs.llvm.org/show_bug.cgi?id=47479
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/power/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..5f711a441623 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -5,5 +5,9 @@ OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+# Clang may incorrectly inline functions with stack protector enabled into
+# __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
+CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.28.0.1011.ga647a8990f-goog

