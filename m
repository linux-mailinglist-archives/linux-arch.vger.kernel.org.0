Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268A24E117
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHUTqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgHUToX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F4C061796
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x6so1458550pgx.12
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9ju+r34sWfhod71XL1bT+zi6vF+Wn+whGvig44U/H8=;
        b=mPcfZIGuf1IZHjreJOKyf+8HKo4m4M4Fs7OCfWzQHGepGQ2VKw/pZolBRvYuRnsgrD
         iO6Sm/0z9adI7m403A/1my//6tCmpz/F5LGl8FcvQXkQNaGnonYynUO4LclCHmwMJqs0
         O0N8myI4UIrjk5XmzJuV30avHlcvBnyogqviE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9ju+r34sWfhod71XL1bT+zi6vF+Wn+whGvig44U/H8=;
        b=bokjYZf1aiOAySoR9xCGkcV9syeisWoDxacYxlbyfVP36lPg8rTtV511Csj/NsLcGl
         w54bc8bxWIL/TUnpuvMZ/ljlCMJyeuPhjIpUeU3CJ2WQmtq1gWSoYHbG2a9Nd+G4ACfe
         huosmKDvvMpdRT7M96bIPlujE33bbdpBBNE+7V2b4GtxJFnLONbwzo8Hdtq0I78/fFzE
         pm2KeNRl+ckpNnY5ecyFtc5hIZKIr6Nl9dBlOWlRiDkrZKLcu/FyV7IFJWYEV7jhZlCT
         hmlRXA0VVbhQa3CAGZkz7x1T/UoMILX8S+5vVHvgegHswyrN/SmioVKa/VoLakmxYNdP
         bqvQ==
X-Gm-Message-State: AOAM533w3vQ+xEVRi9f/rrVhew6W/DUmsXJeuTZRUXHETrYKySUXYFkj
        6geyJ1WMfpZgrSSgkHHmm+jbGw==
X-Google-Smtp-Source: ABdhPJxNUi6ggriXccpA572qG6bm/FjMSOm/9dg/71/aIV6K+hAYLL89xzLCOF1RLAPDkBnD4lQ2Ag==
X-Received: by 2002:aa7:8bd2:: with SMTP id s18mr3530477pfd.284.1598039062849;
        Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y28sm3504632pfq.83.2020.08.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Subject: [PATCH v6 02/29] vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
Date:   Fri, 21 Aug 2020 12:42:43 -0700
Message-Id: <20200821194310.3089815-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the COMMON_DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 184b23d62784..f1f02a2f71b7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -957,7 +957,9 @@
 #define COMMON_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
-	*(.modinfo)
+	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
-- 
2.25.1

