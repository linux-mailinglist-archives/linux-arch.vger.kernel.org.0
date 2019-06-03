Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDED3327A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfFCOoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 10:44:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37406 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfFCOoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 10:44:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so3160242wmg.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2n8KUWE3mEPh7r/u0P9GAsbcb3XzF8DN1nLPmw9SmYA=;
        b=LBIypiuLvGlf3u5FnslCwaambPTGPqJStGZQ8uvhGsKj8SUoTcJtbrhHrStYJpTutl
         VquqSWxjA1nLl2LROx2iNWN/8ddkwF8Qur2OLWm5F8gGC18F35VZIx4/qHmFNjwwPf5J
         xr8vGiNAgc0xPiYl94/W/H3fwwPqzdR8j9R+vv5Yam3VXmIRrEIKO6uVuLieKzvpE/z4
         EI4fkNgavHs+aMAG7KHiDMbdcDcoalu8gfqkjchsW/VTNBJ17hnOw2EZAeEyEcyZEnxW
         O6CkStlPk2s2N3W5fXTsdQKyH5iyJvznQUzPScJGCsVpJvZeEMBGxLuTfnyddTdZBC5D
         GFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2n8KUWE3mEPh7r/u0P9GAsbcb3XzF8DN1nLPmw9SmYA=;
        b=ObhrVHRbfjEVv2bwQE4nM2z30gbCiHHAIREcFcah5YZ5kN7tYGZ9ekIFAePFNvGidQ
         tsrc5epdoVJbt/VpEGi6f5NL/+GsUFUQ1zTy9nsepk3a+viQ8kpAVOHtGW83ALO5qltt
         uIHkYOMz4xU2kHS9AlCLKjKdbqWaP/8Ub4vesKugxm3xucwNCeyoXgfQeahKa0Jfk1a9
         jcnGRZDYiJVFfAf8kggfNTV1pjzOrGzqB3JoftRVd4ULQv+RsPvtnhzS77SlShxngpVy
         tlOXTrSMKI1y1DpYTQQhMv4PDC9xooRu9LhQv19VrUN6zA7INl4P04fgiV1IWAQljGcW
         fygg==
X-Gm-Message-State: APjAAAW2GHJpzFk9kA13YWFODYryzv8J4gg3XsJ3C/Ll0WfZ3bbdjE2J
        Q/9u2YtV3N3I8VZurJHGYO93/Q==
X-Google-Smtp-Source: APXvYqwOq8JMLcKmAC25HfB3WU9PodW1dRPByveHWW7p+wN+k1tru28BLGgM7YcFm+xuYaHmqa5ldg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr2501197wmh.132.1559573042055;
        Mon, 03 Jun 2019 07:44:02 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 197sm14672583wma.36.2019.06.03.07.44.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 07:44:01 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com
Cc:     keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 2/2] arch: wire-up clone3() syscall on x86
Date:   Mon,  3 Jun 2019 16:43:31 +0200
Message-Id: <20190603144331.16760-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603144331.16760-1-christian@brauner.io>
References: <20190603144331.16760-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire up the clone3() call on x86.

This patch only wires up clone3() on x86. Some of the arches look like they
need special assembly massaging and it is probably smarter if the
appropriate arch maintainers would do the actual wiring.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Adrian Reber <adrian@lisas.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
---
v1: unchanged
v2: unchanged
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/uapi/asm-generic/unistd.h      | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..80e26211feff 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+436	i386	clone3			sys_clone3			__ia32_sys_clone3
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..7968f0b5b5e8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+436	common	clone3			__x64_sys_clone3/ptregs
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..45bc87687c47 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_clone3 436
+__SYSCALL(__NR_clone3, sys_clone3)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

