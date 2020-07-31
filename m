Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB33234E63
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGaXSN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGaXSM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97659C061756
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f193so4780034pfa.12
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYWiGkzrodMZw8E6moJnKNf+2pJurSr6gU0bXIJriLs=;
        b=XLAgtFMgltivYzdrmr7mPeCf/STVStGznvQ9AetuyotpG77ihapGJPSOw6e/9bGeJC
         hnPfgK4hvRPSwIXsU3jsGjxizKoPAk/GU0DAj6GDqHdxtQmLultetRDJHUsYBQ5wLmRe
         GyZCYcSM9scCXDQH2r7rsPLe7prnm0EXpd4kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYWiGkzrodMZw8E6moJnKNf+2pJurSr6gU0bXIJriLs=;
        b=ttWfRelKn9ynUpV/NqyWKP6GfJzR39aj1Fp1Ukr06LP0/Op82P0h/25DOGs/5yoXZ3
         9F4IXmrt5SI/93MvahlOuyxAWpw23pAtZ05WXtR32kk7oGu8UyNPuBMz4evh0xLFKKZV
         oq685s3oZk8h/QYJdnge640ecQk+H2oy4fqnFrMl0+jxkeWRFxf/ce6ITzL8BDtOWyI1
         ZejjOryRiKrGGOpwY0csRNKuExiC3d7HE1DtkOU4RAivr44Sowzl+QWzVzEaStQxPxNF
         /YMdV5DiJV+K3nqyHoypPlISz0motsMhVCMpKeMg7piaPV5XlC3LXKPlarbhdSVHGRK6
         TQ3g==
X-Gm-Message-State: AOAM533FZYHsjTRNov4OuQqFnh43mUAknMGwMRl/aVzJ8NB/iv88nEcq
        DMgE2INrQgA46EjcozcQ0gD6eg==
X-Google-Smtp-Source: ABdhPJwz7lNV75l53ANINXJYmgu5YglRuap1WdUm9GJ6Hh16kc46QlK2SQ2/0EKz7ozsRQIWIWRvRg==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr5904939pfc.134.1596237492142;
        Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7sm6300502pfl.156.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v5 28/36] x86/asm: Avoid generating unused kprobe sections
Date:   Fri, 31 Jul 2020 16:08:12 -0700
Message-Id: <20200731230820.1742553-29-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When !CONFIG_KPROBES, do not generate kprobe sections. This makes
sure there are no unexpected sections encountered by the linker scripts.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0f63585edf5f..92feec0f0a12 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,11 +138,15 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_NOKPROBE(entry)					\
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
 
 #else
 # define _EXPAND_EXTABLE_HANDLE(x) #x
-- 
2.25.1

