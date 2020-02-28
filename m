Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD06172E44
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 02:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgB1BVU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 20:21:20 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:41371 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbgB1BVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 20:21:14 -0500
Received: by mail-yw1-f74.google.com with SMTP id q128so2550959ywb.8
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MkaS0G1bk+Q5OhBTj99Zlxgrs85NSvS6F5H6SOsXVyU=;
        b=IH1npzZ+v8JTFD9rsz35zQYEul6R/W7yA2D6y+OHVbHvXqTHNvw94iwhkAAP2DDbVi
         GBl13bzJPRjEuu19+D47ufplr6qg9wjANWrvanrNpgcqF3wYeITyoFt3EBjPEKAChMee
         DeaGGyUBsY44m410q88ZWKqK3we31TbcCkm2I/9FYqcTsjtfZrtU59w7sW8UgKR1PAJe
         CAKr9zLHEDRGuRNAQVHoLYwNfztD6WsUdwPciC+p1QF6ZslfNc/x8Hy7CBCjDGP7F1O7
         OMmtpISW28bF/hQBE0TciN5jdd+8PFqiw4ehn8+83YXO6s8MOtXeeqCaCT+kJgk3y0WI
         ockg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MkaS0G1bk+Q5OhBTj99Zlxgrs85NSvS6F5H6SOsXVyU=;
        b=fBtM+YLgaBuuRqJgUvtKhncdgS5Keamf9GnLBSyGcXd5QOGO+6ZyDpFKoajEekEIAg
         z9Gtsf1puTl4re6IkXALilvJSnHEgiG04/dCCbw4kdYDHcxV87v7gTnJHkhIZ0ij5yvk
         dTv9khRU1pQKBjjHt/LT0cstrWcLfCM8SNtIsPXkwMbCKQraOiIKU1Aqd+Ebmo4nILBV
         MsdFoiWAXeG+daZYdEnSh/hykzBp1ycgq1k3PHCQG1tYUxIWQMqaCqJyV3iy46nOvppD
         85u/P++sbI/dei6iJYRUozOOMKomdxXeLdCUY+pkb8fz8OD2e+wVHnmU6cRu0i09/zc3
         QLig==
X-Gm-Message-State: APjAAAXAOFDFgSSZowPrOWlRASIOoWoBD7nNj2N5/A28T6uXFNueoD8N
        N+i1ML3wFmYsivEUx7ufDJ7WDQHVSq+kVCcoGFeU/w==
X-Google-Smtp-Source: APXvYqw/2+N2t2lLq1K+89TJ7bx2qoTvJJopuhhqt7f6cbBPG3uSnhVLpCVqqF2LFAFntCjNNsq3zJIjfvM4Xn6GSUj6sQ==
X-Received: by 2002:a0d:c584:: with SMTP id h126mr2210425ywd.173.1582852873384;
 Thu, 27 Feb 2020 17:21:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:36 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
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
index dbc22d6846275..6ad63e98916f9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2099,6 +2099,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
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
2.25.1.481.gfbce0eb801-goog

