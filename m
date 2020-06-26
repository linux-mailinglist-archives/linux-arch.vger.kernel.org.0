Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E572820BAFD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFZVJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgFZVJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:09:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23757C03E97B
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v3so7913266pjy.7
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=IYUk8YqgZgCYajUvAr7+TZpYM4MMks4ME5jJR4NVadGy4ZU8CwXELvDm9bauUFB3L6
         MUcT96gdSqW5+5z/avFny8BX08RC9p8Y5njsdOPASFhovoAmh4OpguPdJDLxPdDlL8wH
         sp8gBQ6KdTpddWyZpEu6zGrsSRpgYbXbK7x4cCxZRVANzDO3EjonaRvSwY1PXJroQJmj
         8ohKF8v+doy8LmpsmkdBSyq0EG3AEnmmfRs0Rb2q8rpSFPq3YC+AUHyHeWkgoGopcbJn
         nBDwB0rz8Ui93SdomCLrCW+Ku6Fjn0SFklLb+6i/vy36pSSNMv/TbI0f696FLOb/W9s8
         ZqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=TR2Xm4ioBTAJLTDhFUMvJL2Iy18wfgUv3a9FWC3t70nM0damKpRbYp8Y/HZmDstC7m
         3Tet2HTwDx4MJwThsQ8Z2pMW+pKFpsdUUW10uGgfYfZmRSYoCm12xdWWuwWzUBiNluKB
         eVYyVAeioEh4+ESh5fG8Z6jTa0/zxnxcPPPWPVW411KWeEAjtbfLvJEIum96+YMD/OQ5
         t4yNiNvFEcLXeSAiBQWvni2h/TUc+eRqBVPtGYj/osXZGJTlsqVPOUTbfZMhhq9xq4Qw
         tnGQP+dfP5+8qQIynx5cTII06EB6Jo5bjcto6kdNvru6IWJe3ig80FFP50Wo8VKi6dk7
         sNSQ==
X-Gm-Message-State: AOAM530ZBhRN740Mw2p0ZaKOYv7Z8RX5Tj3sSts0dd7IGVvSpoRDmfru
        t0cjJq3l+6s881DqkJ5JGS5n7vsWILCqHlMmwRFuVg==
X-Google-Smtp-Source: ABdhPJzjvOtIhOG1aOdqb6LPRxa8gBDRx7iYFD1jkF8voJyCoykf8S53mwqKxZn9IwZNUt+dngOweMijabbbSnkBKS6K4A==
X-Received: by 2002:a17:90a:70c6:: with SMTP id a6mr5043991pjm.16.1593205767469;
 Fri, 26 Jun 2020 14:09:27 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:07 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test suites
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

