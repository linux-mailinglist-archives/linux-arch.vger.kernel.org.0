Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0F24E15A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgHUTzX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHUTyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C2C061797
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so1347890plj.6
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdQE3ckXVQaQMZctNKe7+WI4MMPWGnzLaa/Ga3pSK5c=;
        b=iZ6STMhfCfnlcIksH6lFcgl1iRc5Ipz40ciRwj5/xUiB2quTrrBfw1cgVpJYFMbyFi
         wLkm/B4u1iW579uXJIrcTAmAqLtJgXuQlTr0Jw8TE4vUm+lyJaDqm+THT2m14yyN/64A
         qOkwxIhzTLvBmqaLWYpt/YgXsfKu4Nl9ZprsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdQE3ckXVQaQMZctNKe7+WI4MMPWGnzLaa/Ga3pSK5c=;
        b=JcXubkql1h9iz9u5x3yQRw2Qixp18/dNHUfKEzKk9cTHaeVGbaETxDfQ3XDdz6WAy7
         GpTXgkdFaOz1zYomDMk+WEyvs0wxjGF2F27syAPueHkwRwXBleNu1TRnCQwWzxzltKA6
         FI2QtFRi72WTc1x9mF+EJZThY4zGZt3NW1sqbQsh3rvILF+fz/Za2vUZhU6+GmwJF9jI
         COLJkhxR16GNreFgm7Aiqc3ST9NcnsqbJCo7UrahOt3gBN9yZI+HkpUodfCsRDKL1/VC
         SUS++4f56Mlv9R7Y0HrzklQaxhSzmYKCwpntL1k8B4nWShR3wErkF0O0g0x4UlQDt8Gp
         r/zw==
X-Gm-Message-State: AOAM531d4HEGlUpkxjNiMMx0CzQ/0Le+ddd56lV5aK3s0wDsJmKAJC26
        X8lYFyDYHQwHd7YmYbYlZi2mDw==
X-Google-Smtp-Source: ABdhPJx3+jtNnnJd5zpPHLfvhbuFAhJz5nokpNldUaNYUUJcrj2heuGLYxm1XOgYFBH0L7ukexa7gQ==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr3515645pjb.132.1598039641368;
        Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l9sm3165356pgg.29.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Subject: [PATCH v6 21/29] arm/boot: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:02 -0700
Message-Id: <20200821194310.3089815-22-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b1147b7f2c8d..d6cd2688ad7e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,6 +123,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-- 
2.25.1

