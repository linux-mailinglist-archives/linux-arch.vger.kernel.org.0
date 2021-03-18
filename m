Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE7340B6A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhCRRM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhCRRLv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 13:11:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98528C061762
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:11:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so49232915ybk.9
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=aYBLAtpCowI5H1JqYq772XaFTeVfjouHZwMxvtWqKz0ax7u9Y/au2Ku0NI+kpVVVEV
         vQvsGUIsOpTjJ36aQQvTpE7x/CJBZJZEcPADNXX/fkSxN0CBAmLJAvN0vHtrdDQ+pGST
         DGAp4GusUbTpGw0XxzY3odtrE7wXqUlF8FFGWiTSCWvBA9b+vewRP4m6fxCfQnqGs2rH
         +ChJC0BJMzLJFo/OnePz7idXJHoBy6HFxdbiSEFE5yvW/1FKKTuI51km2tsCCcg+aQhx
         eEgwxCDN6i5AxYDNJTQw/kInx3EDjxdme+bIZSCakewjcYT0MJcPllrH4CaKisimsKEO
         xjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=c50rtOKSD/uP2r3QlYM4nlq1XTENMVoRQD/1Nw1pxA+OI0PAr2d3SmN/dbTcaaLeRQ
         7S3oJoByi8hRvCi74GetWwQaqcRgvDIkmQ4OCPbizRfZ45ysDS8nFJlm4tCCpdjjB+x4
         SBRHNtPMIs/tpsTtuJdf3EjsgQBpfEEAA+gJ/IKe41DQmHo9f08AhEa+5x2aVlVqHyuj
         fhPTc34jVAFNY73a3XGrO1z+FzAlHvfu2UF50DBsVn52TMh3MQuvtdPPTDzwvlPyQS8W
         Q8hDAIRbVZmtfWZpioM12qbOx/HsJp9b3tan1ft+IzXccBXkd3Bz/KqhobOhQQd/AB10
         r5Og==
X-Gm-Message-State: AOAM533Ei+RbwGiSmQRfSkg38O2dw4/7scer0gXSq1R03k/LKi9uAdS5
        zkL3xFiSLlyMNBkFW57sITiPz5ZxcEFEGlX5QiE=
X-Google-Smtp-Source: ABdhPJxfDxQbMdPagHU96q0vd0r/A3PUk45QUl9DhnRRAk72oe17WrwgV5kycp+B2M30G42p2T6WH1P2jysN6RAin/w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a25:b443:: with SMTP id
 c3mr548188ybg.32.1616087509883; Thu, 18 Mar 2021 10:11:49 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:10 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 16/17] KVM: arm64: Disable CFI for nVHE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..fb24a0f022ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -75,9 +75,9 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
-# This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
+# This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.31.0.291.g576ba9dcdaf-goog

