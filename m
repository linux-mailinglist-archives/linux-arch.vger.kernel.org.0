Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A624E0E8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHUTo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHUToc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD12C0617A9
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so1254817pjr.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbD6RkxNdJTcKmyBxOnwhwhFLlA3pFOZa2+9BxU1UDc=;
        b=k/ZAm37VP1X0Kj1z64OdTHZH+kgOl4h92xzOZByWNVg3dzcR1sl/edZWM4g7/9LMAK
         2Od2ht3mMCq299yi5RNhkiAxOqIYIKOtTPXtLMLUZ5+K4ApR8llZWbSSfqPKO9vpdM54
         u3IVf46CxIC/7wREtzNOaKaD0JXG4ZkzQ/GcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbD6RkxNdJTcKmyBxOnwhwhFLlA3pFOZa2+9BxU1UDc=;
        b=UFuYd5Xr8x9yQbqm1fyBO0jswfLIrpUhaHRUyDSNNro+f1eyiByUtEi+bimPu+lQN+
         OTJuKMzmXNzrejyMivJgRX1dmHoW8c2dt7am1bf9GiPEWNJWvJfHXIvCC0rPXlYoU9Kf
         gbdEjjg/KXrNQvmdYBUngPLlPipKdDMgT8NGBsj6XOtd9Qw+EhyVUHpYMxDkBm754rDt
         ThExM2KymfMUOJpNxNrUPDoldxg5a5av4jfCOQ1gbRZ2dLj2Ugz4xMVKOAJ6djTOzdKQ
         fFGp2UrmXgsiiLkPx7kCjHXXmi6woobPVHPwezV5+X6DpPovLRpzE7yY24rq0VBi+xHu
         +qRA==
X-Gm-Message-State: AOAM533IkI7ig6kfnSmmGsria2uQz5aJtclB6f1lPsq6d1E/m97dn7NY
        bJFI+3Le+WsSy9e1f8EwdE3Q+w==
X-Google-Smtp-Source: ABdhPJxDM/ng4HXO1XmyLDVgiDpkbXCWteROsynvEzbdVUNlJ67l4Ln6nf23ww8a+EXs+mGvmFV0/Q==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr3757015pje.37.1598039066650;
        Fri, 21 Aug 2020 12:44:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm3556730pfv.27.2020.08.21.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/29] arm64/mm: Remove needless section quotes
Date:   Fri, 21 Aug 2020 12:42:49 -0700
Message-Id: <20200821194310.3089815-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..e43c805b7b8c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,7 +43,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1

