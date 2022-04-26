Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C425103E8
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353134AbiDZQrv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353141AbiDZQrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:48 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C8194B14
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:34 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hp17-20020a1709073e1100b006ef69a535c3so9359188ejc.10
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n1CPd29HHKe3iLELt5x5zSxX1l0GlMUVKgGqbXsXPsc=;
        b=Ul2x8GzRzl3HHeVNodduisFS+GirD7ttp4YhxIfHtZ/wAm96wAOKW0A3UvjvpnRyGE
         dGIlLM7rLl8SOQncEfIhzWSYbpzWK4FIquce/uniGQa5s5Khmoip2xUEMKpML79SS2Nr
         fjFDfjY+DOzRzBepJfAOlaHW98Dbj79IrR8+XSS3SP0heVjAw3rhmHavoXW9MHBQKoZG
         wag5mhU0cWEiD2fbJEejotrtfue9XD44tRsrIfEYSpEORbTnfzF4DdsV8zcndXNrqw8l
         /BmYauMIADOumK6gR7O9BDkDjdwUZNDb4ZrqS03yp+ROELB3q+NAfod4pzAvjwcIAOW/
         JTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n1CPd29HHKe3iLELt5x5zSxX1l0GlMUVKgGqbXsXPsc=;
        b=iwAsPf3bpZAOSufFftKYab077caBW095pr54CjPoJBeTtL5zUkGCZ+fw5wTlR0HD34
         Kuki1fQoK5rt7Mh4CALn4GBVeTmcMD1dKLo4o3cerovyMiDpH67pKQmNinKqb8p6lu+P
         X5g8Pk4zmpeLbvjlv/MfOkjdDZfjbHQEQcIu3/VcyJ6d+6os1TLl1qLIOZDvKz9NEnht
         E26kXSaYtOzfpHaNwWBULEIlw6XHf8CNUtASch2cU/UCMewgXnKQF9NGhgPUJPPwQF1L
         5XAgf9AL917kpaLXGJyXUpnwv0E6QsIdz9hgBfFOH8djaMUs2HGfBySEvJGz9zUS3K1+
         ZOrA==
X-Gm-Message-State: AOAM533rmR1LtnacMzho4D+mP2BsVJOoTkW6LZBwtov/3i9xEUvDGemh
        kuzLd3qm6bvrKnKtbgqJUBxBy1RNs04=
X-Google-Smtp-Source: ABdhPJyMKZH4q2GhaVIalO1baxoI+dFp4AmHdfwHW+zpAMwIACuxCiWEQZTqeJmEu9W2AFPYPsdcZ1aQv28=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id
 b5-20020a056402138500b004132bc64400mr25986634edv.94.1650991473255; Tue, 26
 Apr 2022 09:44:33 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:34 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-6-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 05/46] x86: asm: instrument usercopy in get_user() and __put_user_size()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use hooks from instrumented.h to notify bug detection tools about
usercopy events in get_user() and put_user_size().

It's still unclear how to instrument put_user(), which assumes that
instrumentation code doesn't clobber RAX.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1859fdf5cc485a2fce
---
 arch/x86/include/asm/uaccess.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f78e2b3501a19..0373d52a0543e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -5,6 +5,7 @@
  * User space memory access functions
  */
 #include <linux/compiler.h>
+#include <linux/instrumented.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 #include <asm/asm.h>
@@ -99,11 +100,13 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_from_user_before((void *)&(x), ptr, sizeof(*(ptr))); \
 	asm volatile("call __" #fn "_%P4"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+	instrument_copy_from_user_after((void *)&(x), ptr, sizeof(*(ptr)), 0); \
 	__builtin_expect(__ret_gu, 0);					\
 })
 
@@ -248,7 +251,9 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
+	__typeof__(*(ptr)) __pus_val = x;				\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_to_user(ptr, &(__pus_val), size);		\
 	switch (size) {							\
 	case 1:								\
 		__put_user_goto(x, ptr, "b", "iq", label);		\
@@ -286,6 +291,7 @@ do {									\
 #define __get_user_size(x, ptr, size, label)				\
 do {									\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_from_user_before((void *)&(x), ptr, size);	\
 	switch (size) {							\
 	case 1:	{							\
 		unsigned char x_u8__;					\
@@ -305,6 +311,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_copy_from_user_after((void *)&(x), ptr, size, 0);	\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

