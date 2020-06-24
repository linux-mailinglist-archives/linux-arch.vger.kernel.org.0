Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5019207DF3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgFXU7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389295AbgFXU6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F0C061796
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so3619771ybz.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=r4C8omzldjna6reCrt2PzuMWWZE3IZ2y3f6lclc933vQMY5LTWLxwFuKexT4JvEe9A
         iElOlRcRe7ONH9zL0N4HZ5GBzncNZey4G1Aoed+ZlwUMSzmLjxbt1S7d8G7s/Q1XyI78
         vPZb6jL2BlxrYw6quFHLcZOJf/UggWPfVY4qEsf4A8F6Bru5l+b/GBLsNWCcwZiYHph+
         Dbsa9CXKlN1jQwhe67MA252WId0W7TqOPepmJ+EVxQyaURVV/mC47v+za56p/w4E8JVC
         87eyLI9ICUIfZX+noq394fm9wzUFuOaDtYoDrAvqofPlXjDofFz5QEHCCF1kl+6cQ/sl
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=G7RCOAzDa+InTuJHNqXuT/OF264sZm8dzSZwBfOF28ozsBCs+dAleskVZxNQQBYgxf
         CWxlpDrGWp9AMvmvSclXykZeognJs7wBsAf5hVpnv+AD+w89PacQ/GJOYbT1GbU4yMPD
         alemnYfEH+ZqQCvmLwSmiZV/OzC0vaFE9wEt2OZWiUv5B/gXKAHck0titnytnJNAufar
         DHrRbAf4LwKpEcqDSkNQDWTDvRXooo5YDLOkjFIHmMjPWZcJ1XX7jrfGE4HQrb7z5FOY
         rAzpvj+c07hxfX7ucNQrRR2gD3r1t0xSpwxR0KVaperKbFQFYVdDO6vlRAz8WI5lp96p
         smuA==
X-Gm-Message-State: AOAM533291Dwyg8Mj8hUJ27EueI0KxVxj7zAMm3PU4rcEJMr6QDn0TrG
        P9RjpoR316TPK8v/YGZWtjzq0i6OTNbnZ7WMuhrnXQ==
X-Google-Smtp-Source: ABdhPJzw0PE1cr6miTcf36AU/8/D6CtmczIAUZsitjQKI4FCtj13PFtWbSnnwhEssKH9DHeczUteecQfDP7L+Nwm+WqoHA==
X-Received: by 2002:a5b:2c7:: with SMTP id h7mr46550583ybp.162.1593032294101;
 Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:42 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 03/11] arch: microblaze: add linker section for KUnit test suites
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

Add a linker section to microblaze where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/microblaze/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6b..4fc32f8979a60 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -128,6 +128,10 @@ SECTIONS {
 
 	__init_end = .;
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
 		/* page aligned when MMU used */
 		__bss_start = . ;
-- 
2.27.0.212.ge8ba1cc988-goog

