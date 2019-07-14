Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE76810A
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2019 21:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfGNTWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Jul 2019 15:22:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfGNTWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Jul 2019 15:22:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so14825235wrr.5
        for <linux-arch@vger.kernel.org>; Sun, 14 Jul 2019 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RPogbEY8giKWh8C58kfv10i8Q6rlGe1EWIOUS1oxGkY=;
        b=GsyeEI1WkTZ0azsaeVBWSsTyM/C1N2YiVIANokBXvRyPa6wMsvXeAtZxplJQW7wJtq
         DfmZp9ISvWbH6xrVa0V+2lWL5H3vOnjyqthd85kySYi6PlWEmYjOkmKlQL5oTWJeVM7E
         zmMRzLPJLLbM/SktTCRnHseAveqIto14SDAz5fdC3W4WJzVP8AUWvrEAEmsLwhsmW3o+
         BEHHWHkUx+muciFESGq7gdroQt0Bcim8xzqQVn+7nkSsLPUD2WU6NNA+lDJzNgKRmmvk
         576wVOvq6V1iy2N3+HL7td6xEKryiZSYlAVRkxWBJCcUtU37AsxApncOV0RuBaQhLDOG
         cVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RPogbEY8giKWh8C58kfv10i8Q6rlGe1EWIOUS1oxGkY=;
        b=t9wm9bHYYw3QRQG0M0Poi8VxYVno6yB1HdzfRt+1qjAqyDKbFRrXaLTLt9bQUDRgW7
         X/bYsalCY2CJOs45xQvuoWWnVyY7V44+NLrsPLZ1myb00Uon96JP7dUWPuZVCg1XKupi
         SDUJBSpfeilSykM91agkicKeJVBaxS0KKytKzYcVzfsSS84c/ATeg+2aDDSC57Zin5pp
         JQ315J+/0tMn4sKkoItMLvfTv8kRD74z3/VB/FIusbm9Tc+7vq2zLfFolb3Ss6/jI4zt
         rgA9K1ZVTpttVAUtEBAPioKgYB9VfeGMNjsQnA1dKgjSCAbexfnEHlYmKRnVJDw42w/1
         xPBA==
X-Gm-Message-State: APjAAAUiT4WgPx+u3f7Uf7bzLiXFp4lHQ2kn6jNXqPgBAvEmLWhCsjmx
        PpHAzRoC+36pYQGYEu/1Rv4=
X-Google-Smtp-Source: APXvYqxBHvqll99BERQ3jIVLs0yGcM8OkAW3DFA9uBUW549tLhs7vBU/IZMJ5vjEmzYUuG+tB16aGw==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr25127408wrs.93.1563132169572;
        Sun, 14 Jul 2019 12:22:49 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm18142743wrt.95.2019.07.14.12.22.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 12:22:49 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, Christian Brauner <christian@brauner.io>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Date:   Sun, 14 Jul 2019 21:22:04 +0200
Message-Id: <20190714192205.27190-2-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714192205.27190-1-christian@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A while ago Arnd made it possible to give new system calls the same
syscall number on all architectures (except alpha). To not break this
nice new feature let's mark 435 for clone3 as reserved on all
architectures that do not yet implement it.
Even if an architecture does not plan to implement it this ensures that
new system calls coming after clone3 will have the same number on all
architectures.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/kernel/syscalls/syscall.tbl    | 1 +
 arch/ia64/kernel/syscalls/syscall.tbl     | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl     | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl   | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl  | 1 +
 arch/s390/kernel/syscalls/syscall.tbl     | 1 +
 arch/sh/kernel/syscalls/syscall.tbl       | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 1db9bbcfb84e..728fe028c02c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -474,3 +474,4 @@
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
+# 545 reserved for clone3
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index ecc44926737b..36d5faf4c86c 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -355,3 +355,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 9a3eb2558568..a88a285a0e5f 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -434,3 +434,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 97035e19ad03..c9c879ec9b6d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -373,3 +373,4 @@
 432	n32	fsmount				sys_fsmount
 433	n32	fspick				sys_fspick
 434	n32	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index d7292722d3b0..bbce9159caa1 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -349,3 +349,4 @@
 432	n64	fsmount				sys_fsmount
 433	n64	fspick				sys_fspick
 434	n64	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index dba084c92f14..9653591428ec 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -422,3 +422,4 @@
 432	o32	fsmount				sys_fsmount
 433	o32	fspick				sys_fspick
 434	o32	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5022b9e179c2..c7aadfef5386 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -431,3 +431,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f2c3bda2d39f..3331749aab20 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 6ebacfeaf853..a90d3e945445 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 834c9c7d79fa..b5ed26c4c005 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c58e71f21129..8c8cc7537fb2 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -480,3 +480,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
-- 
2.22.0

