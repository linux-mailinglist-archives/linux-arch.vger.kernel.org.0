Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2311234E5D
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGaXSR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGaXSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A04C06179F
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t10so12775731plz.10
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=mhl2cYQ2YEfGFzqu0lUm7PTEdf3xYEpybnJ2cfLPuY6LR4v/YBY5dJ0ivTK2K5UAQM
         0k9arXuQB4cv1bpNG0r3VncPs3HFypojskLqEB3mHI/LVxckqJONf2cBzIIP4It97oIL
         ccOz8l1eiz5ARWhIbuGZYnApCYc1UDxK86u0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=dXa944LFUQY28elFLcd6ydQGbNPLKVXweqarEsqQ6hNo/Ae8ALIzE1iG/c6mop8/5i
         sFUS9sESGOwFfdumy3AvspNt9E7peRDPnLmUdlGyxUq+H60I9ELlhdkGGDzMkIzXUPCZ
         qeT6hdt8xVfra1lMoJy9WQSIgDfjAL3Lm1dOzv+uADZYufnit0IZ50xx0sFP0jx/1eWK
         KlbM5+UndeRFFCS6dger02T+ziGvBsVeDRoy2QPROoCAB/nGNMpqla+8g/S0Qw1fdE7B
         STSQuZdVK0PANKnL3XRW2HkgkHm50rKkPwAXjACw/9wmniMWwE4NmwdJ7XEMcGbjj92F
         uD8w==
X-Gm-Message-State: AOAM530RrdmGSouOJaS9onbXdVetXUk7Onpd0ssT9ODjA3n8tmnzDddO
        UX7zcGQRCLIW61vcgUa7uQIy/g==
X-Google-Smtp-Source: ABdhPJy7boJ2rVpqxGdhrmjmUcJo5jNiV0bmJoTaMG0L5+Tg8lheY4n/pMplx9rYVCtqWI1ZntGMZg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr6284010pjj.28.1596237492647;
        Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm11932082pgh.94.2020.07.31.16.18.11
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
Subject: [PATCH v5 19/36] arm64/build: Add missing DWARF sections
Date:   Fri, 31 Jul 2020 16:08:03 -0700
Message-Id: <20200731230820.1742553-20-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Explicitly include DWARF sections when they're present in the build.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5c1960406b08..4cf825301c3a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -240,6 +240,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
-- 
2.25.1

