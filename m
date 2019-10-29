Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F3E91DA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJ2VUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:20:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43213 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfJ2VUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:20:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so10534452pfb.10
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CyoXOdP2RSQBzcYa2ar7sJXCOKRhNFJ5bhxtCWldzm0=;
        b=SwWBWcGnfRTErjye2RFJl7Aib5ngymVfhFI6SrLYhwbsvQk+AnQ9NuQ0+LRVqvGhgr
         zw5WrFykWhH4hCt8QM/JyvhkKumTwsec+ev1e+K6Fcbb1EtKhpHRegK8vb6OM957Q9ZO
         UG1x/M3i2lCnML1VAM/x8BtKr539SsfdQUXrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CyoXOdP2RSQBzcYa2ar7sJXCOKRhNFJ5bhxtCWldzm0=;
        b=c/Xr351NTnOZteT0uIMDUQft32vsEUvb3mHKSGpK7GjFRh9iHzYqgwd17Q3Nql6XHl
         YDt5AlqBC5k9H9LeD2IocBo5o5fGblOo/q+RsLxq2Fc03SdAXEyrejL/rucv2+j2hn33
         +YeKuL0yuJdSN89nDQMGlzXhC1k2Uj4kjvxBKRUhqm8136JdWQLZ5kBEvpfQbi1cEpbR
         tFxZzGatEVuFeIOhSGajWgt+yxjZBuUSkcPoN0NqN/2n6qHQgk7Cu/+SA34Ic99e27An
         qtrM/fp9RwYcj6UNBiTgEOH2TVGcvamkVL4JBNQF8SvBLGxNGCXWx/ve2CWCiVbLBe+e
         zgNg==
X-Gm-Message-State: APjAAAVu+EctHpy1lHBaTmbPcTUAGxHClHEfvoXgjE+231jpaxbU38H5
        SH/jWIBeougxKi9w2SwfOEZSVw==
X-Google-Smtp-Source: APXvYqwBFdMf1cjARJwLnvFrBgEj47UdUQleXizVAEOutN03LaOfJJkqIZHBJa1HNFPv6Xbz9E2F0A==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr28208584pgj.86.1572384040153;
        Tue, 29 Oct 2019 14:20:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65sm52280pfv.50.2019.10.29.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:20:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 27/29] x86/mm: Report which part of kernel image is freed
Date:   Tue, 29 Oct 2019 14:13:49 -0700
Message-Id: <20191029211351.13243-28-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The memory freeing report wasn't very useful for figuring out which
parts of the kernel image were being freed. Add the details for clearer
reporting in dmesg.

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

