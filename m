Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA3163C2B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSEyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34932 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgBSEyd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so22608360oie.2;
        Tue, 18 Feb 2020 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4GEXAYyqQWsp025ogzeKnxOXkjpBM0jeh4Jkb1AQ/E=;
        b=GxU8H+8wHFYPadW4JaajZHSEVBcXNLGzyU3EcBZXx+nG/SCQ/ASmuoJLfPCPUeuTcU
         FPKoRZq2suxke3wLsTkQ3/gIM1UWeWVU52/tJzPsh7F9zxB1xTyPTqbDXA2XcyCzn8kA
         iWG/YrzUa7yE/uj8JF+ADOrARv+qXt5jGgHTl3dGWyQcvrNsChBzUM6v8hKbMjzOjbne
         Dv7HJtHNa1r3sg4kQxML6Nc9dqgwX2cEoYxS/8LynvMCvXhgd/YzZn9ZWcXiUNKliTpN
         gvs8opTGiEwt6oK3ylCI00rjpTlVbwmdaK08ckbydc41KM39Ff9Rfz2SBcq1CUbJye9R
         M1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4GEXAYyqQWsp025ogzeKnxOXkjpBM0jeh4Jkb1AQ/E=;
        b=YFJN4/G02fdhn8rp+qetJjO4Oq/sf4ht2kjX8GBFJPUt5ZwqmG1m/fQYU4c5o7S9nN
         Cz3qjC+75KdISfjI8JWwzxI98SNmODfFsnF9qnqBMnEYUftMTjg3GWbNQOiZO2xwibMD
         mz19vnrnpN2OjpsB3Dmq0r8xQOk8d73j8xS2JPZ29mI9RxxJ0cifPgG+cXzJriCCIlxO
         ctG/PeOS4m3A8pNzOEe7/LZlhDtWbXLhzuNSGI7y6Fmwab7XKJhhIIEjJaN92XwQvhCG
         M81BYaj7d2YgecelH9lH1mE4KL1wb3OeRA+rj8IZOoRX+OxcV98guokFQgElq2Yo0G37
         O8PA==
X-Gm-Message-State: APjAAAWspdyzS2Yh/8DEinxL3Yh25ytexeXR+TqjmCnnbYuFLtMJsunw
        U7FtGoyQ4rsBHUO0NpoEOhU=
X-Google-Smtp-Source: APXvYqzPqnhDSnUTxbnbVTbSbPmWK7BxoBMVOIdmKFVTG3pZ9TJDv5U6RijdtiI3Af1f4g1Jjlyyqw==
X-Received: by 2002:aca:c7ca:: with SMTP id x193mr3514163oif.70.1582088072470;
        Tue, 18 Feb 2020 20:54:32 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:32 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/6] asm/sections: Add COMPARE_SECTIONS macro
Date:   Tue, 18 Feb 2020 21:54:18 -0700
Message-Id: <20200219045423.54190-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When building with clang's -Wtautological-compare, there are a few
warnings around the comparison of section boundaries, which are linker
defined symbols and just contain an address. Clang says that these
comparisons always evaluate to a constant because it thinks they are
regular arrays. This result is expected and reasonable since we just
care about its boolean value. The kernel does this to figure out how
exactly it was laid out during link time so that it can make certain
run time decisions without hard coding them via preprocessor macros.

These comparisons always evaluate the way that the kernel wants (done by
comparing a Clang built kernel to a GCC built kernel). As a result, this
warning should be silenced in these particular instances so that
-Wtautological-compare can be enabled for the kernel globally since it
brings several useful warnings within its group. In other words, by
disabling -Wtautological-compare, the kernel misses out on several
useful subwarnings that are found with existing static checkers;
catching things with the compiler at build time will make it easier to
catch issues, especially as clang starts to be integrated into CI
systems.

The warnings can be silenced by casting the linked defined symbols to
unsigned long (normally uintptr_t but the kernel typedef's uintptr_t to
unsigned long and some kernel developers prefer unsigned long) to make
them purely numeric comparisons, which will be converted to a boolean
without any warning from Clang. The casting is done within a macro so
that it can be documented why this casting happens, rather than
sprinkling random casts in the few places that this happens within the
kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/asm-generic/sections.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d442aa5..e1f3095a50c1 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -169,4 +169,11 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+/*
+ * Comparing section boundaries trips clang's -Wtautological-compare
+ * This silences that warning by making the comparisons purely numeric
+ */
+#define COMPARE_SECTIONS(section_one, op, section_two) \
+	((unsigned long)(section_one) op (unsigned long)(section_two))
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.25.1

