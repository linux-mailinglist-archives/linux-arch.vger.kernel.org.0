Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED1234E2B
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGaXJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGaXIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912FC0617A4
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so9129449pfd.2
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xo3Q84YrxwUiWcBw2aOaAxjUU+KH/ct5i4ArRZb6NA=;
        b=UOmfMzCmziqUvRhPYa+yYqVSk1m4tQNkydUKWMwHOqa9jOGpy2SdYgaJLcq/mHaWXh
         zacXLwriPv2Ri+BNefUVSy7N+waQxDV79aIcfmEBlB5x2MgmKl6KXLtRXHiNRlOgfhju
         VFSHbOijca+jat3MDYqe3dO3/6omRradiMlw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xo3Q84YrxwUiWcBw2aOaAxjUU+KH/ct5i4ArRZb6NA=;
        b=kCVq+vJhjG2jpqctrZ/3L+Zk2NSRB4kiQv/dQis2MYN5itBt0YaX49edbCo/Rm49Au
         MdfPzc3m6YrKKkRykFCytE7qGfRIZf9WznJtPb08AIfmUR4I2RxssGIRQ4SiA1fpsKZM
         fv+1C85hAs/cLaIjVTz+MooRvvZnzAkwZtTOuBRBLFoNcrd9UJkPBedzWLMJS8lPu/VQ
         wdS3ANtAEaN9EoknbQ5Lb/N/WHiVj2KcfeaBL23IaZntwTGHt6faLFzKIzLrSommvB4y
         EOBcIgQt7CvdWhLlUSZvrhdY2myMu9SUPhydEF6fjc4YGMZYhwTJPsX3+tApUiedyLOX
         hC8A==
X-Gm-Message-State: AOAM533I2BMxGwHgpJa12aQ/tWSYapzVgZtcRvkjaLM2l4Zw/bSNxsG0
        7vZl9SDaa73QaE0fN3xyy37HaQ==
X-Google-Smtp-Source: ABdhPJzj+UXk+6XOR8nQ2GzywdieZm9fcrAxd+t6miZrKiy5n0SgtqPnKj/QvJ0LP/t472pshpKEKA==
X-Received: by 2002:a05:6a00:22c4:: with SMTP id f4mr5321141pfj.273.1596236921685;
        Fri, 31 Jul 2020 16:08:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm9909036pjd.33.2020.07.31.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/36] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
Date:   Fri, 31 Jul 2020 16:07:56 -0700
Message-Id: <20200731230820.1742553-13-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the ELF_DETAILS section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 22c9a68c02ae..2593957f6e8b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -799,7 +799,10 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.25.1

