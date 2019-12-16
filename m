Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E6121C61
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 23:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLPWGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 17:06:54 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:42912 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLPWGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 17:06:53 -0500
Received: by mail-pj1-f74.google.com with SMTP id s19so141021pjp.9
        for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2019 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5GF2pWf6msGQN8etrt2iWOqdBHUuLXbl9k/FxNh5v+M=;
        b=TokXY0h0FaJqcvxseVpsJGN6ZtDjjoNbdzkLrp/FhUz5OP6IXO8ZCrIXDI+PY0fTd1
         oZhnN2G3IY35fYa0Vd6aKWkkKfpE0XctXn1bZnDNJ3CzEvoBqo+SatsbITCDLDy8ykR6
         fxtkiFTfU3rvec9vRRvpWD2YlOMxO6UMc5CK40/eVLYp3ezoi3Fvp6jASFpqrssHDfhQ
         JoNpxsQO2k472r0XC/Os5dmDPkCAIztjTmIo7eM+W0jioX/6cYwGsOxuL6giyAoe9ug1
         ox0hj9kulfl2piPDZK2eDsvD1R89K1OSaRpkkhQR4te1nq2plCbTPDiiJniBhzGPKAph
         Q0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5GF2pWf6msGQN8etrt2iWOqdBHUuLXbl9k/FxNh5v+M=;
        b=XLCkJn0lGSPrpLzlhoVf1LQsLqBcXu7+lG7XNHS0IEPR33v14Q9ZOISR+IFZLcS23/
         OEDoCt+DT/mZrBWv6qSIAMwbRA2U7NylcYs5N7KBBJ613F2IESg3vSR8d1ZIeIA4vW9l
         jSoDzfcmmTQGbg5JwVxYofVw78Q7FgUWl7kLexRD9ZclKRTiRs0VKrzau3fnnyYp9l0Q
         h52yx9Y3q6O1N/Zl1X0nuE0Yxam1zOeuwIci6Wt3Hw7rc6cEyaD8macDqIwsJkEf2au+
         tFO0AswuIMgFnvehaRAYM+4mieAMNBtzbLuVigS7KR0FHPTKuEa62WHPxy7TDYwu6Rkp
         olkQ==
X-Gm-Message-State: APjAAAUz89zv5m6XBl94ubYaC/uygrAofh/NquRlAXx91/Obvug4zfBf
        JdHszDDtteIMwqnqtH0YR0Low3v1+9BJQnMH0GkYWw==
X-Google-Smtp-Source: APXvYqz7Zh96kKZmFQEhLR+5+8b03CjI/b3463pKKBrTBSZrKUfy+3thDSrMp+0LJ99EepEYrJc7YHRMsYbtyIxAiEtJhA==
X-Received: by 2002:a63:a350:: with SMTP id v16mr20232559pgn.87.1576534012471;
 Mon, 16 Dec 2019 14:06:52 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:50 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 1/6] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
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

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
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
2.24.1.735.g03f4e72817-goog

