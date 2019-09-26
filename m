Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA91BF828
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfIZR4q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:56:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfIZR4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so1953531pgv.8
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lMtAqLKIV7iaSMLHYcvPv+kohztZyY/Z+5xJ+D8O728=;
        b=UFt+V8/BMr/oQ/8CSnatqgIyXSDcvs3/19JyozsCgFPsqS0v3M/8jZg1fzL6Qc1wTN
         zcaktCKmkfBZrskzRVnW1lpnKnbT1CTtX0kHIF9idT+XJVt92g3bq0Dpz4OLE6nMC5XH
         NW8BhxFynv4qPmoQ9WfuzroS1lPcxOvqA3Vq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lMtAqLKIV7iaSMLHYcvPv+kohztZyY/Z+5xJ+D8O728=;
        b=EZaoA/sGWxtNwSoVWvRPca0wJqmhEp5IZkpc94tH9vV5grBAcmfPGw26QGszxdwURp
         qxbLL+OxVhxADL7bs3mlfWTSe/Xcu++kiDjjFO15ptgj5ii9OaN6fiQgD841fsskHc2B
         xcM9b++dFufJHvigtqPAsjgiMfqO70eC9Po0pwh2sRM/A0YQZlHq9Xa1F/QB7rY2gWFR
         WkN8bxSE/zbIESHheQk7AvPuY5nhAPYuTGSqHvfzeA7Zs5KAawNOqAF9Y2OHct2SDAlg
         BORaqXlo5ff9VpU63962hadi0MQGbZVwBULubfxrYV1PPQkpmdG88wC4XhfKqgldKELv
         MMHQ==
X-Gm-Message-State: APjAAAXiH0SlulmHZ3UprhwIi9rJfAU5Ym83VHF83kem2G2HV1nXbpu1
        gC1A2t+Zt8gZZsEho9JvKzCl7A==
X-Google-Smtp-Source: APXvYqx+mrEmgBwFBIoSkO5Knd2FiUPuYbkq8tX7W4zsQact6t42C/glSDDrgO3H24UWPs5jK1YgqQ==
X-Received: by 2002:a65:5905:: with SMTP id f5mr4751014pgu.332.1569520594154;
        Thu, 26 Sep 2019 10:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm2887306pfo.131.2019.09.26.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] x86/mm: Report which part of kernel image is freed
Date:   Thu, 26 Sep 2019 10:56:00 -0700
Message-Id: <20190926175602.33098-28-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The memory freeing report wasn't very useful for figuring out which
parts of the kernel image were being freed. This adds the details for
clearer reporting.

Before:

[    2.150450] Freeing unused kernel image memory: 1348K
[    2.154574] Write protecting the kernel read-only data: 20480k
[    2.157641] Freeing unused kernel image memory: 2040K
[    2.158827] Freeing unused kernel image memory: 172K

After:

[    2.329678] Freeing unused kernel image (initmem) memory: 1348K
[    2.331953] Write protecting the kernel read-only data: 20480k
[    2.335361] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    2.336927] Freeing unused kernel image (rodata/data gap) memory: 172K

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/mm/init.c               | 8 ++++----
 arch/x86/mm/init_64.c            | 6 ++++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b43d027..790f250d39a8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -958,7 +958,7 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 
 extern unsigned long arch_align_stack(unsigned long sp);
 void free_init_pages(const char *what, unsigned long begin, unsigned long end);
-extern void free_kernel_image_pages(void *begin, void *end);
+extern void free_kernel_image_pages(const char *what, void *begin, void *end);
 
 void default_idle(void);
 #ifdef	CONFIG_XEN
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index fd10d91a6115..e7bb483557c9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -829,14 +829,13 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
  * used for the kernel image only.  free_init_pages() will do the
  * right thing for either kind of address.
  */
-void free_kernel_image_pages(void *begin, void *end)
+void free_kernel_image_pages(const char *what, void *begin, void *end)
 {
 	unsigned long begin_ul = (unsigned long)begin;
 	unsigned long end_ul = (unsigned long)end;
 	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
 
-
-	free_init_pages("unused kernel image", begin_ul, end_ul);
+	free_init_pages(what, begin_ul, end_ul);
 
 	/*
 	 * PTI maps some of the kernel into userspace.  For performance,
@@ -865,7 +864,8 @@ void __ref free_initmem(void)
 
 	mem_encrypt_free_decrypted_mem();
 
-	free_kernel_image_pages(&__init_begin, &__init_end);
+	free_kernel_image_pages("unused kernel image (initmem)",
+				&__init_begin, &__init_end);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e67ddca8b7a8..dcb9bc961b39 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1334,8 +1334,10 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
-	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
+	free_kernel_image_pages("unused kernel image (text/rodata gap)",
+				(void *)text_end, (void *)rodata_start);
+	free_kernel_image_pages("unused kernel image (rodata/data gap)",
+				(void *)rodata_end, (void *)_sdata);
 
 	debug_checkwx();
 }
-- 
2.17.1

