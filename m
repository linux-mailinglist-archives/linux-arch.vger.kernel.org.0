Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314E2207D39
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406472AbgFXUdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406462AbgFXUdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:10 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0506C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e4so2428696qtd.13
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7CIu5VjUyqeUAWF5g9yThD8i7PrniBSkPgVIeHI/Dgw=;
        b=ri578dhLvQe03PuVkYI/KosO3BmuE994j1VVuunF6mqXcSxoUchnm+hnogX96YG7Yx
         yI/MHeu9q9kVZVlnIIydNSi+r5iCLXjTZcnO6Uxh+hmUL4ed/4KhiHZWp/xtvwTh9cIK
         SomuMXc3FlUpv/wxq+AMmks9S70kXGIVSq6hdIig9pY/BRVFkIkq59gCCp2yYhdgtpZ+
         TZxSgxiOsR9AcdF9rr0muiREjAZMfpam4EUBzlvonJ5mc1omg9Z9rzCkOz4lybvX42iW
         cfZVoIgjekwd1lX3DuJT3IjQ4IeC9YVCNgBTDnUF1CG7cfbw3hlLKLyVFbznVgBNgaOl
         aGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7CIu5VjUyqeUAWF5g9yThD8i7PrniBSkPgVIeHI/Dgw=;
        b=RmNw2urMI6rEj/uwqM1VWD6VeHHrqI8Vd9mgJAOTDvUZBMu4/ki0E4mBvXbkBdZviu
         R7cTJhoooz/ZWwVEB1cyS1H74rLra/SFZ7oF54yEDPYyj6rVc/miiOuNszkSr2KmRGDu
         bPt6HwRDSepSRpx/l6+j4opnqcZwjXx9VCUOCvvTcOi6wWVlaZPFdVHDN7KCFqTzri6e
         biinU6Ii6mHTXK/ea4E9JOTSGhTiEBR7IdDahtWiLHBSsMlngAEGu1Oq921HxdfyXROv
         j9EgkwGN8GBCQ/RZUk2dItBtEoGYCC7slyoXxHb13KYo3seVppKxg+xGlym8bEsMF5Pa
         g+5w==
X-Gm-Message-State: AOAM532zaPgb0EI96l5iEG9a8FRyKNk0lAss5C5t8GKo8BNbtZUeHhCn
        yE+3GFeVkc4jLeXL0tf1e0Ibpa1zAyr1YoAByNw=
X-Google-Smtp-Source: ABdhPJwCkKca/LbhSSbnwwC5SMdz9q9IjLlaNhvBawmgAX2Ds09jajOGxxF388XJGbRiV3n2n5vnK/squwZiJ1CODnM=
X-Received: by 2002:ad4:47b2:: with SMTP id a18mr33619619qvz.121.1593030789019;
 Wed, 24 Jun 2020 13:33:09 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:44 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 06/22] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        George Burgess IV <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change limits function inlining across translation unit
boundaries in order to reduce the binary size with LTO.

The -import-instr-limit flag defines a size limit, as the number
of LLVM IR instructions, for importing functions from other TUs.
The default value is 100, and decreasing it to 5 reduces the size
of a stripped arm64 defconfig vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 3a7e5e5c17b9..ee66513a5b66 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,10 @@ else
 CC_FLAGS_LTO_CLANG := -flto
 endif
 CC_FLAGS_LTO_CLANG += -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
+KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
 endif
 
 ifdef CONFIG_LTO
-- 
2.27.0.212.ge8ba1cc988-goog

