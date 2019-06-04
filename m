Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC234CE8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfFDQKA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 12:10:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36706 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfFDQKA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 12:10:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so13415654wrs.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Jun 2019 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygMGl15yL8Dl/CKxDv58CFgXErk1JZawsiPT7PZu59c=;
        b=Ugq8j9ea6T6m2QJYNrHxhrwF0Gfbdtq8EVLSsuEpeXNBxuPCF1eyBO0rdgcAhxHjlU
         a4SO8JY6dra7YmOYqhoAsKfOR7vbCsFCacO5FpAsmS0jFl4+Zhvlb4Dh4S0hdP7ZRL6S
         Pp5sDM0b/05jQIonO7S6jG2u200oGGYlwVHW5JFYRj9S4y/UhHJBfoynyuzBCeKzEAqo
         5MtXRUUfco1DLg/7OIsMowDvKTd8Xt548bUkDZthXP38d/cbyEKRls+Nx6TpBtsYjyPa
         v+Z41qiuP582owphpatCNRAmB7NK7TzOht+2VeefvCYV9aX54HC/QTdjVr6DTTDHWkhZ
         dHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygMGl15yL8Dl/CKxDv58CFgXErk1JZawsiPT7PZu59c=;
        b=QxFJxFlLo7/GGO34+LqAUJTJjpwfpqfZ1T3/Atm6HcUq3/jjkxhgORcaySySopwXFR
         eZlRSBORRSY6Sf4WJuYlyqZp7sjvS+QD1HOWlvZ+MpfxOkIPhdHmp0tVY8yPbG+9RsjY
         nbPStnkZhfwd+hM/KY1k1luWZ+yExdieynVN/U3joBdHR7sxPzj6iHnm3NRVE/+DsjcH
         D6t4ZO9jKQ2Lsk7UI2XlXdkUsv1YfSrCijbLeMGXf8L34DirfRaCLB+jzlyJ6F22sb2C
         nBrNxvpCCKHYza0naXKaClvEJLf0jfvirUD37oT8W3ruysiVC6uslsOHr8KLhx/LGzIz
         g03w==
X-Gm-Message-State: APjAAAVncjcqNWEqtL7TopCc61TDxeBe+CYSINxCqe2Z3SClryuwRenu
        KY8RaFjiKPJ4CWsjKELXsEdUVg==
X-Google-Smtp-Source: APXvYqx9i1pt2SCjFhQVYdpuY6VDAIjUCZcF1txJy0/ITOaZoGzSMolb0o0Ld1KzyHQYmwpTjyKRAw==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr7207099wrs.113.1559664598427;
        Tue, 04 Jun 2019 09:09:58 -0700 (PDT)
Received: from localhost.localdomain (p548C9938.dip0.t-ipconnect.de. [84.140.153.56])
        by smtp.gmail.com with ESMTPSA id e6sm10578055wrw.83.2019.06.04.09.09.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 09:09:57 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com
Cc:     keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 2/2] arch: wire-up clone3() syscall
Date:   Tue,  4 Jun 2019 18:09:44 +0200
Message-Id: <20190604160944.4058-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604160944.4058-1-christian@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire up the clone3() call on all arches that don't require hand-rolled
assembly.

Some of the arches look like they need special assembly massaging and it is
probably smarter if the appropriate arch maintainers would do the actual
wiring. Arches that are wired-up are:
- x86{_32,64}
- arm{64}
- xtensa

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
v3:
- Christian Brauner <christian@brauner.io>:
  - wire up clone3 on all arches that don't have hand-rolled entry points
    for clone
---
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/uapi/asm-generic/unistd.h           | 4 +++-
 8 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..e99a82bdb93a 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -447,3 +447,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+436	common	clone3				sys_clone3
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 70e6882853c0..24480c2d95da 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		434
+#define __NR_compat_syscalls		437
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c39e90600bb3..b144ea675d70 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -886,6 +886,8 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_clone3 436
+__SYSCALL(__NR_clone3, sys_clone3)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..3110440bcc31 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+436	common	clone3				sys_clone3
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
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..b2767c8c2b4e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -404,3 +404,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+436	common	clone3				sys_clone3
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

