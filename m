Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B2234DEB
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGaXIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGaXIh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE4C06179E
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w126so15008333pfw.8
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trKW+y6QNGDib0LNTvVtHw5m6UTBgmGvLbmxtpBgaL0=;
        b=De36nKOtpwsMqO/u4tRAWqVBvir2dLkSaohu1f53IavT3wv9lR7e0hWZSL83j1HWKZ
         rY9B4gPBpbNmb8nPsaGi7A0vFOBYN9VMjC2dQMJB0cZqVHEEmlhv4MftBmYpUmCh97rG
         af7Dn2HaS1FdHmrNihpjv3LcQzJOvb78J2620=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trKW+y6QNGDib0LNTvVtHw5m6UTBgmGvLbmxtpBgaL0=;
        b=HZUDGYM3khzui0tAVc2fsoPFlTy2nxNubF7zzuYmBVZWNNUPi7T9O7lXg5XtJrhrcv
         tbkHRlbMW7GbobCLXL+UTbMUWhaYnNrb0cdhtRWe7Ppr/Aw9AP5s82XKtmFx55M+8/pH
         3zv6SwAZXEXzzMdEQv607Mb0MBDba+eTw0eL2XnM+DkCixm2hpgHftv3IfilxsbqQ1Ms
         5n9xNG+o0RVQOYqLdOLr1FeB9R3tZ3h0/pU8EBZ4uo2dHuE9HO5OdBSSg2/QP9Ew8m+a
         emAOf0f5XwZ9H68yLgaLDzIzW0NZMR4B643qHOXae4LBkI0L14+t4ojE9MwcRidUlbA4
         PMFQ==
X-Gm-Message-State: AOAM530pYBZWXHHqD1xXAzd157egvV5jgQ3kjD6LsneCEICmy9zenvCr
        WwJ7AhBGiiI1Tzo/rCKR/av9+w==
X-Google-Smtp-Source: ABdhPJxNYU1OV0bbGH5LVe0igil+VUHzo3wFC8ED7HbZKWsssjYo+rn362BnedNm2DgfjyOMkog94g==
X-Received: by 2002:a05:6a00:2247:: with SMTP id i7mr5645713pfu.217.1596236917400;
        Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm11680681pgc.77.2020.07.31.16.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:35 -0700 (PDT)
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
Subject: [PATCH v5 08/36] vmlinux.lds.h: Create COMMON_DISCARDS
Date:   Fri, 31 Jul 2020 16:07:52 -0700
Message-Id: <20200731230820.1742553-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Collect the common DISCARD sections for architectures that need more
specialized discard control than what the standard DISCARDS section
provides.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 052e0f05a984..ff65a20faf4c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -930,13 +930,16 @@
 	EXIT_DATA
 #endif
 
+#define COMMON_DISCARDS							\
+	*(.discard)							\
+	*(.discard.*)							\
+	*(.modinfo)
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
-	*(.discard)							\
-	*(.discard.*)							\
-	*(.modinfo)							\
+	COMMON_DISCARDS							\
 	}
 
 /**
-- 
2.25.1

