Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11E714E5EC
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgA3XIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 18:08:34 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41546 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgA3XId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 18:08:33 -0500
Received: by mail-pf1-f202.google.com with SMTP id b62so2771144pfb.8
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=AfGGk98bnxyyqHcpetjQvX41oGap4DIh7+0oNSJEg2O3R1PQCiDZZtdDhFMDnBhxK0
         /1IpRPnzmNWZWCdDA+YmoH11+yZ8yuUmpOyt1a1C6USU6lfL8qgBToLhsSsLZNa22qcw
         DeN090IVkvjCCffCPn/5OAPM2nRoarPWAvvLk+KM9KuY5bXHOlv/eW4GgopiPEam5w1U
         OoY2SAfbLPxbM5Od+4uzT/fCGGx4M5wAozv3qmR20QB92nwmZRbSl5NMzEqnr0ikTRje
         jyRldGQ6k5yB9GzKUFfikjYirdZINEHE5zYwOZsqejJsbcphEn8KaagiB3vqxnjMBUIk
         K+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=GO4Vvk8gwhqUPniYwGRJTDOIytihMcU3lp3Rztli4gXtcDamIFhOSxnC3l6rku+Yr/
         i7hDqDAPtQkM9cG73RVHZutzYNDmFbdVY1qHrdY9XEiWEJNCTqH7nQor3uf668KScrdF
         4557l0BlM1XhcMpILfCk1uAv2hcHbSBLL3WJZ1aj6d+LSL55hV8pbrhLVvxA/wYwFzcU
         IqUBVi+CB1jnLkY179SVgDGA3e3z2CT3pagYVkM3iusiEnNP67thfchlQRulUonaC3k8
         po1jP+01++JUD8gS7nhRkvF5sCgnWx9JzlYmItNxd/RRRZVTBbJKC7RbImhcxJE3/TkO
         adCg==
X-Gm-Message-State: APjAAAVMT4Hllh5lIVpslC9LxLuTUu2Ao8JbF+MZ0gXoABvHh+w5fOCJ
        MFYPNYO1gt6zsWpjriwdekor+JT1igdP0i5hceP/AA==
X-Google-Smtp-Source: APXvYqzSRoUUWeQ2bKif6Z40xm7qv0HYLPbmPInMedOryPT9s0Chn/fw7nXAk5QeONDTypQImuUErdEfZqufShGTpuizag==
X-Received: by 2002:a63:e649:: with SMTP id p9mr7159890pgj.15.1580425711922;
 Thu, 30 Jan 2020 15:08:31 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:06 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/7] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a linker section where KUnit can put references to its test suites.
This patch is the first step in transitioning to dispatching all KUnit
tests from a centralized executor rather than having each as its own
separate late_initcall.

Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4f..99a866f49cb3d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -856,6 +856,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TEST_SUITES						\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
@@ -1024,6 +1031,7 @@
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		KUNIT_TEST_SUITES					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
-- 
2.25.0.341.g760bfbb309-goog

