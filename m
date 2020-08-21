Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044A824E134
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgHUTyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHUTyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85CDC061574
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so1361102plr.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLGrXrQrOnwocgl0d2lDlCmyCMk0LzJNzAhGu1QupvY=;
        b=TOCS9QXFvi2sKYKTRr7ee6kse0TEhswUvVuKqMoKi3tljAuSEAQbpwLZo0K9qaprrb
         0bsJpMg221HwjQsJw+E3oqeYuH95C/KSW+y5f5cGNHh1HZGSHWEcRCqDGVat33dSK1xj
         BvjA1iJ703xzao5ihIUvP0L+zcmeoM7uEoJQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLGrXrQrOnwocgl0d2lDlCmyCMk0LzJNzAhGu1QupvY=;
        b=TWcqiKlRxxXLN7ASzeKuCB1lRl3TZM3E796ZHAJAJlu4q3sH+6DOSFlM5ZYOlSe6zv
         QeA5xUS80ydc/sajpAgXvsZD7uR0acBqb89Q5v0PGEBLvQRt70OzR9G6aScKDhNUu59N
         tHGf1rWrEWQQCDipd3uDvMEwfoGqSSvrW5xIbCFm+cmjCMoHRaLRiYc8/STmmE0V7fbx
         zCwOyAI4eiu9POOXah9S/qRcktGbABzKFNvpTOQZQcF3ymPrAauy79GR0tSdgOPPVYMx
         CU7PSxvB7xqsarB5H+sy+Yqi7906X7oMpOF5UOXJEmAdz4S/IB7LOb0/KUjb+b3ANidV
         rxvQ==
X-Gm-Message-State: AOAM531vuBS1vXwVwRUbFPfJJkjAHAbivDo9IPBrYaHl0zB9i3bwG/Ld
        Bqi6IEmKpVBw2o5AJMw3HrM39a65CymsmQ==
X-Google-Smtp-Source: ABdhPJxQwlh39B9Zs+13fgS+Mj5RyeBXBYwZUtq7yzKxm2wrKQBpH/KK+GuDxakqY9UBFLOVsfmNSw==
X-Received: by 2002:a17:902:c211:: with SMTP id 17mr2292148pll.343.1598039640054;
        Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm3139562pfn.218.2020.08.21.12.53.58
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
Subject: [PATCH v6 28/29] x86/boot/compressed: Add missing debugging sections to output
Date:   Fri, 21 Aug 2020 12:43:09 -0700
Message-Id: <20200821194310.3089815-29-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Include the missing DWARF and STABS sections in the compressed image,
when they are present.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 02f6feb0e55b..112b2375d021 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -69,6 +69,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	DISCARDS
-- 
2.25.1

