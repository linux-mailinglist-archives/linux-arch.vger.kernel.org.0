Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B80207DCE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgFXU6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389323AbgFXU6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:13 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A4C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:13 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 94so2147995qtb.21
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=Ur1fLf5iHlKMYZXC1PTBS+I+vVSZLrwtsudyGKcS4apEjTlQlWHIVHccmjstZTZ2A0
         XpAesa/HexpPJ9lkMkGhBnF6Qskxhzu2Ugio6H/p+KIiUclPfy8g1bBrcb7XDtFj1fPA
         VhqqvTyBMz+4f1As4j6RChLXUWDpJpaCKf8s+VcdwMv144usfln+/z4SjWwh8S8wWOIT
         zIFXsZgc2COv4+INh8ZCWPZm65Gi+O1lsnv8GiFgvCUD1bjd/Dw8gnuPmXj6lL0ut1uv
         GSJrpDJHuaTL4yqBLz4GZSN4VLUjQGoPlUwe84SvdDiBJQ8E5KFn34V8W7sRUPNHp5K5
         x9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=d+iqyxL6E+N08e+m8YSE6zeJNj+xmxMYxGOGremwJZA7UjyKQrY8ljqHtODKYtRlAr
         tuD3iXET13d0ylFoeRK0K789MoeAJdYPUOERRQTQYtDLLrEfMhKf4+XGXYJ+rX2GdI7G
         r9gQzvg7p2bMkRrrqnir2ys48a+ulzxN/73AsxAG8k0Ptb0B5ZJsOdDLj8L7Yp6Yhmsz
         byHDRZfPSi95z9tVITPzH9F89Epgl1Jl5of3wgzQaUUUv2Q8DKOAyGXp/OkxjYGWXGhA
         PudWpqc386kqApvwERGg6tCQQVM8nu2rHhTfNseIVp0zbRd3gX2/Ez5hPaEcunvv0sac
         1Nbg==
X-Gm-Message-State: AOAM530aH2MJ9Tf/eK8t6Y+ThTRBYiPJv8ujSAVLi+t/TVksj2rT5P9N
        FFCKresP74UFJ31FrKS0Gqb9t6iasaIv/5rY/EEKUg==
X-Google-Smtp-Source: ABdhPJxiJGG91wgEwxBBSujXoL0BDsw9UNFVENxNw1T3itcMUFGteR1x45PAf5QA98p+dstOOYTnC7ogGU5jYKFNmTfkvg==
X-Received: by 2002:a0c:b346:: with SMTP id a6mr33657229qvf.142.1593032292307;
 Wed, 24 Jun 2020 13:58:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:41 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 02/11] arch: arm64: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a linker section to arm64 where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa54..a1cae9cc655d7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,6 +181,9 @@ SECTIONS
 		INIT_RAM_FS
 		*(.init.rodata.* .init.bss)	/* from the EFI stub */
 	}
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
 	.exit.data : {
 		EXIT_DATA
 	}
-- 
2.27.0.212.ge8ba1cc988-goog

