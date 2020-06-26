Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299720BB0A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgFZVJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgFZVJn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:09:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02540C08C5DB
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a9so6637255plp.5
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2m42nyan1QaRICISfHXn3ke8By3LNXcToZfpb47eLnc=;
        b=EvV5AKqL3cJFlET9VlHMspDvH6mNrw9mdUE19R+kJN+pESV53C6mXgdfC4clw0ELfW
         tr1lXfgcFIiRv4MoSwDDJw9jES4cPLxshoo4C7q31woRW8JkH4PJyxgKB3GXH0/ppNWd
         VYX0IClBCrnQPoVcJ7+R41T9X+pxOD5zTcbXFZUkeJP1HULYEbP1KoSYcn4K2bAedO1v
         PFbWA1LgvH8S3ANmNmQpeNJVoIh0t7N4GhwGwZJhqxQZ2el0LxOrgFNYE/ayUYd81Dy1
         cmA2NsAPucNm9mEnjHr2mMd8N/IQtdaZZ8ZxjgdncUA3OeneJDLj9pAe/uiXPqgh5ocE
         Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2m42nyan1QaRICISfHXn3ke8By3LNXcToZfpb47eLnc=;
        b=rwJN/raCmePYq6SyciyKaaq+XckKe+ddnTt9+kRntUQeoKNBohjeLZA/q0p8jhZern
         HMrNqI4kvUVRLwr2rFUjid2R2ELloJEMB5L3OBtB5b7mawQNFU6aEgGFwwwq6OTEWaS7
         mzQVUzxysV7aXpFrUD71+d0vvCAo9xf79Z7WXx5pPIHW4xeNUf9LFQtfD3Ra9RetLVvx
         4I6qM7qcyxFxYB6x1kX/+mI43jS060RbjCD0roDqgQkxY2HsCNp9hoLEUYh5RCJ/MAkT
         NHZa47NU6Yxght1Pb5ER0IxWWafN6i5SjMYK8bSMhAvTcx73vU8CZXB31YR+XwOCU077
         3LnQ==
X-Gm-Message-State: AOAM533u6I5JPGEjy0NxAI3AJMJwDGNYV+soq7OzOCE80+Dp8+8MxPp+
        eINrScLKQLZZYIOGhcLbzZvKmNtujNJsCnMR/tXExg==
X-Google-Smtp-Source: ABdhPJy0+rXtJcmUjQAOQ1aAvDwonrj9UP+Ys357A/5trD7jFzZV4nkOkOzYhaN1/GJa0Ye3QtES5GjMO0EI2sSfq7X/1A==
X-Received: by 2002:a17:90b:3746:: with SMTP id ne6mr5608123pjb.166.1593205782452;
 Fri, 26 Jun 2020 14:09:42 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:15 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 10/12] kunit: Add 'kunit_shutdown' option
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

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/executor.c                | 20 ++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a95742a4ece73..38061d456afb2 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <kunit/test.h>
 
 /*
@@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
 static void kunit_print_tap_header(void)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
@@ -37,6 +55,8 @@ int kunit_run_all_tests(void)
 	     suites++)
 			__kunit_test_suites_init(*suites);
 
+	kunit_handle_shutdown();
+
 	return 0;
 }
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f6..d6a575f92317c 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -172,7 +172,7 @@ class LinuxSourceTree(object):
 		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
-		args.extend(['mem=1G'])
+		args.extend(['mem=1G', 'kunit_shutdown=halt'])
 		outfile = 'test.log'
 		self._ops.linux_bin(args, timeout, build_dir, outfile)
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6d6d94a0ee7db..a8998a5effaad 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -49,7 +49,7 @@ class TestStatus(Enum):
 
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:)')
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output):
 	started = False
-- 
2.27.0.212.ge8ba1cc988-goog

