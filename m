Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2C25CA90
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgICUdp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgICUdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:33:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7373C061A1B
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a13so2510931qvl.6
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KoA5zv+DpjEyp13/YuX/m1kwH/JJTx3lL+cQSxNvvDE=;
        b=iQRyuXb7DQREhbTivVeYcDoSGjtob7g8M5KS5z8R2T1nBf9Gx0F/IaqPMtn2bzwhh2
         DvvxcFNLC0B9wSIyz6SplW6mCPM1aenF7xoo1ziClwMNK+NKE53qTfAePUKqHL2UJnkB
         FLm0++eFSfi/lPj6VdPdxbPF95syaHvlo+Sk6yuM88i2IZzlSpgq1yQGQxsjz99mcX7p
         m9V6emvEp6fvuUTr1uX1VsgenOsyFKN9dFgrfxlx04zsYAMmRAr9kaydPt8YWI7OzTUw
         /xEzK08P+0B0NFU8v2bS7pcwz8uTLGPrj4WfYV2c9K1P9hISKsyvAPYFID29+oNZ0pwD
         RY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KoA5zv+DpjEyp13/YuX/m1kwH/JJTx3lL+cQSxNvvDE=;
        b=DgroC5Ym2kU7+bX666Q7LfgdmMxnFwIax60G4KhP6njvXE+3OD3pgwhUZGDgjASBKY
         7c8QItCmraDinqaN0tN/S/QL/y/mdFM4C/XnLtS/0nmTHZmE7hcUk4CqcaJK9GR832Wp
         AfzdmqBADaSLZ4FDavdlU47pD1WBWTCllghS0HHYUtGdToVOBXdZGkiM6QARhcdQKVS1
         wyzqFJZNNekLRqcFItcxipCeGXqQ6wgq4v+WKfcm21f6LL/dxuXGkY3cdMrvkNo0gwcH
         i1bNzlW1mZ7bqmjqd9v/l7L1fXi8NCkduWD7l7olZez5D2kjoUlZjf2uotcYgg/wJm0+
         6OCA==
X-Gm-Message-State: AOAM533uPhWzPXJYPTT2D2M487fWe8U6trOwTOs+i7bDZyy7kQo3zoeH
        V3lLq/7QF61CWdQQMdI2M70ElJi1feFnhSdNcSo=
X-Google-Smtp-Source: ABdhPJx+z0p9xaedPgPNzeY/Rz32SVtx7k9bWUtWq2o8BTU/tO7RQ+3N5loCDPVr3FxVA9GPo0ZEtNIss1cCzuNBmj0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1105:: with SMTP id
 e5mr3719981qvs.11.1599165111812; Thu, 03 Sep 2020 13:31:51 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:52 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 27/28] x86, relocs: Ignore L4_PAGE_OFFSET relocations
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

L4_PAGE_OFFSET is a constant value, so don't warn about absolute
relocations.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..8f3bf34840ce 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -47,6 +47,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	[S_ABS] =
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
+	"L4_PAGE_OFFSET|"
 	"VDSO|"
 	"__crc_)",
 
-- 
2.28.0.402.g5ffc5be6b7-goog

