Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B2207DD8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbgFXU6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391545AbgFXU62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C2C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c3so3551580ybi.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
        b=j/kWNJMpkLx+QCXq2SQxzFXE4HDX6KCmSJPXrZblzIllowutKkBsG1ud3ynRKeW8lJ
         MtI48a2Cpj4ziGJGkEDlnEQv6DyxH1ousx99m6BnZKWQj6+/LMpBSQfN3Z2bJMnOIIhA
         veEviOrcT/oF5/ldeqAc8VZut+QFQYvbmgweDJvMdfdtNxBA3C8QstHTAtCWJCFu/uEM
         g8XBJvmlW8ZgWrslgR4KbC9ZLSy7BQNUKbLrK1dtpNcacunnYBX6IN8LUDosSMZIIPFI
         SKEMPUUw5qzV4tY3UOeSc9MtEF27mtDWWzIJ/xKaLfYUcG1fAVOTQnmOwrBK/8eH1yD5
         LvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
        b=XDu1H094awFK9SwAuMM8ORZUkLJTsUytUOWNOWU2XZqDLK9Xrr5vUs2yeDt1Bbq1UG
         5dE2I+boYX3OaMhVl+dvlUfYYsP46r1FMkaEwxBRfJtEFSl7GzElShdRm/PU8nbPtFtk
         NtRWIOOG7msBkohGwJy28fWZUwAzW6/6goLfI6M/lpjivCAHFvsFu92Bl05RxRZbmui9
         nbVwNzlTiVngndWilc92ah2SW2013tkuCljFtbdNgjF8U5cVxuGy5/fvAgHBPHZEo4r+
         ZWkR1UFV5VtYfu7oRAA6wO4k35t337HgrSel9KbzHH2kcX74zm375jMX1WAHzA8adVou
         ES6g==
X-Gm-Message-State: AOAM53334jKgw7FPihXiq3j4NWNTKKh1fGV8nQTY/sGbPP1TOlTB9O+X
        ZdAXjW0sPfz5geJ2khMyjmesbRd7BgdnU90RWnWqiw==
X-Google-Smtp-Source: ABdhPJyhpPPbZya9wx2VzaMGagNQNdOzG9SvfIE26+f96tSAZOYI00iBbgj44mO45Hc8tO4IzqRsiRZjGUUWMQvf7cudgg==
X-Received: by 2002:a5b:c8b:: with SMTP id i11mr45672710ybq.484.1593032307073;
 Wed, 24 Jun 2020 13:58:27 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:49 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 10/11] Documentation: Add kunit_shutdown to kernel-parameters.txt
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

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79a..e7d5eb7249e7f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2183,6 +2183,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.27.0.212.ge8ba1cc988-goog

