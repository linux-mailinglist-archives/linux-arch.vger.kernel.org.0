Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5430614B04E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 08:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgA1HUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 02:20:19 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44632 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgA1HUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 02:20:18 -0500
Received: by mail-pf1-f201.google.com with SMTP id r127so8044689pfc.11
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 23:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=vpzib0J5nj2DND1Cvoora+gxNlK5gAdhGn/MxnEv1DGxNvefQ3cALz+hejiSzvm/kz
         0te1TfEliFbLVQvJUYznkMSGK01039LVFSB9r+iJV1l9dPo+gzbJMyOcH2mgZxmTyt70
         Ylh5PypNoWdZcB1/mA8ew7tua/n8BZNZPi6l0sGOL4enKiRWfvbx0sjlCYm0qzRkNaUE
         JBTFAlidEjkqlvUrc46EMpV+Tyh7821f+lJa1cP65ZKovA0yreplcoZFc3eLrLoJTiDD
         DFfpjDOVoWz5jV5x2/D50lrKtfaFp6mPZAh7QuJTHBiTtuz0ZbzBY2L9w8zfbQIdnPl7
         x44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=NyW+hHsOJEQ2vkYfoTqmyn17LJmIJm88GKnDu1qv6ZsDswYfBlyqbN2Pqca413EmK+
         86pbgQoCg3SGATgZszLCg5z5U0br/qI9qHJthEawhEbOFFWwsXtxMp4mmy/UL5eM/Wxi
         cJyEI0D2xc/r+Wtt9OSq5GhPvPoNFbWQdY/ooweOb/iCSYJvZmSFA2u1TTO8yqaRch9H
         +gYyFujfbj05reJQiz+prxNeYiF1F4BC5VviKg+cKuvdfszLY6+tBnEg46q0Hz7MYoGA
         g864I5JUZHCCn6WksKIS//OllCyHPcpKvIIRA1MopoLcnnb+klBP1rDIkFLF9Q5rgl64
         Uz7g==
X-Gm-Message-State: APjAAAVKqHz6Rdcgnhnhv7iDnu+T8LKwDQdIcYOpBYs6q+y3s0/769Mm
        yy+hLxlEC8hu3eVeFUu5TMi6WsU73HUlOMCebgAQ3w==
X-Google-Smtp-Source: APXvYqxhr/v1PhdZEF/n7DR85NKPlp1nK8BnB+q0UXQhUtXxUX2SIyir4VRVLjV7DDEFnqw9g+ZcXkVv2G/Rzr1RlAuQdQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr23427156pgl.359.1580196018089;
 Mon, 27 Jan 2020 23:20:18 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:56 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 1/7] vmlinux.lds.h: add linker section for KUnit test suites
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

