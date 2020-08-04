Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8726E23C0EC
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHDUr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgHDUrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:47:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E3C061757
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:47:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k35so24771259qtk.9
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l0j4SXLxck80GLdHUQry5KIFoZtv4r8IlcuWa364DVs=;
        b=a+wy7+3FtUG0JFCfIgR9qrCZywwrw0V7CNU6FJdQAvp5UG3v0AxVcm5uBR7mxm1b5+
         SZ09Llj2URMzjmakMQ945Aqcf9IB/vh6C/OYrNrUzfUTk8HSVsL6nngFKojrbe1LIJdY
         unjWAzObZAWiiHERXa/5+uXD8DwGtMGDrTcsTqkz9v1PfzEkcvExsunEqQoi96jv6jEY
         qcVgy72yz2Mo7Eh+TpcH3gDQVzPv5wd4+JFy5sMtwt9U+7i8nJ4jh3TJNezObyMUnh0v
         eVxJYeCEVX7g2g98mkxo/9n7BGp2bjO+Jrzkufw0O5QBpUGaTCBVmJIiFGMT8DIrUCaW
         H+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l0j4SXLxck80GLdHUQry5KIFoZtv4r8IlcuWa364DVs=;
        b=b1tzd4vFxsJP9By2FPzKDvEbLQ9Jbr1NGxVryP8rtSnx0FNpvVc/4KOATNMGAURYY5
         +VjFsZlsSURxdQtDa2vt6O6/Xg4WupblmbgCqGtkm/4fd59HVpa2FaracSOjOAvzSSq9
         oZKnR9xJVzmB/B0TMxZAHbNj/Oej5/sQcjjY+hcLaC1PPRhd1m+DYi6x/u4Sysa60/Xw
         WllrXx+Bj5W97okRuETz2AbFk1g143O6sT/9QMMzce24Q2s75fjq/7HTAxodojoc+/Pj
         K6BL5Gt6XrAqt8AMQkv//HVfru8aLbKiJnAlCCVeMEOskIGSoOYMNUIDtGgCq5jGFloe
         o9fg==
X-Gm-Message-State: AOAM533hWTgCmVJv/ZNBaPjBZtq7IQwjbjEzH7ce7ILaFn0FAcAi88pJ
        sPtWVLkC8AHaBVPhW6hEYtQMrC56Q2IA8mPq9URgkA==
X-Google-Smtp-Source: ABdhPJzJLSr+jiO03PdspEcRzr8pHmSLzfuYlQ3t76a3c3nKUzZC+S5krHnvMMjyGnBJ6cKJmIV9sm8B56R2oFlU/Ep/WA==
X-Received: by 2002:a0c:b712:: with SMTP id t18mr180439qvd.205.1596574074175;
 Tue, 04 Aug 2020 13:47:54 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:41 -0700
In-Reply-To: <20200804204745.987648-1-brendanhiggins@google.com>
Message-Id: <20200804204745.987648-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200804204745.987648-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 1/5] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
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
 include/asm-generic/vmlinux.lds.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 052e0f05a9841..75130a4d92ef0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -692,7 +692,8 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()
+	EARLY_LSM_TABLE()						\
+	KUNIT_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
@@ -884,6 +885,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TABLE()							\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-- 
2.28.0.163.g6104cc2f0b6-goog

