Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81032207DF6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgFXU6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389045AbgFXU6L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E13C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j3so3603674yba.14
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J3ivtuBCWWA6WF3YNE0hm8BpVh0hgAMk0icQw8PVzV4=;
        b=tc++vE8OqiFWBPWLgjgz+8iB4vui6irGevOP603lUg1UNDik9D3RHD3BRtfvQnnEf0
         jrKRLdHrhmzWJKnehTSRLbse6SnSXGQd35K2w5Zw9Z+uwoCNqlj6mkrJWH36qGOISkU2
         3NifzTZEtRhL18lQl5iPbyga7DEY6bWA2ca3xSr4TZGtif0WyKPDe33h2W95GCGjYoTD
         LoLgCnF8B+dCod++2Ii9nCw49QtFtdis8Pk9VuDF5L/wQjwjqBE0rPgSwa+KcPbSzpms
         Ap+f4GQjV/9IxN/DKcUM1pSafBVlQkPDdfl802IjkfV7kftNlqpzgQEn6l454cRI3B5c
         XxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J3ivtuBCWWA6WF3YNE0hm8BpVh0hgAMk0icQw8PVzV4=;
        b=p5AkwSIuTZwdydqB6Pdt7mH0KZn9Gm1H4SpdgI5ymLpoFrUG6YnMYC9oViMXejmWM2
         7OYGLIYELMi8GvdTOK6dvTC8jfv0B6R5Ubueumt32kp3JyWEnUA4AgzScEEoNeC5S36e
         NWp5ALneL0bsABk1oa3Ya//t7U3LOnTxmqFvMSQuh24yNu3iy6qov4WBf7JZy+sHx+0j
         +R8GgKF6PhHfj9CDPz8kWV0ymrKtEVMRStAFPMy9/YS/YNLN9hYDyFtgd4OGShasE0NE
         tqgEtAMs33VmffpgDxMU7MNRvrV5KASreqO5VLjSKL9ZwhjnhgtdD+upBN5L41vO1ZpQ
         McHA==
X-Gm-Message-State: AOAM53030Q4mUopyYvwUigz3z81TZtRcAQ8Jt8EsqiDlIhtLA9M2HHwP
        k9KgQG8v1D8oLHlCQ7xpMKwojMFmp1zq/+qJCuIk9w==
X-Google-Smtp-Source: ABdhPJxdBp1vku0LQMvgNodo050SkO7FsfUngwFhnwGxx7442lwKRrC6xg8fX13lreYNm4d8BSbKm5F9o+C9V7i1TJs25w==
X-Received: by 2002:a25:ba09:: with SMTP id t9mr49146881ybg.128.1593032290524;
 Wed, 24 Jun 2020 13:58:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:40 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 01/11] vmlinux.lds.h: add linker section for KUnit test suites
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
index db600ef218d7d..4f9b036fc9616 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -881,6 +881,13 @@
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
@@ -1056,6 +1063,7 @@
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		KUNIT_TEST_SUITES					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
-- 
2.27.0.212.ge8ba1cc988-goog

