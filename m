Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9494234E60
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGaXSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgGaXST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5FC06138D
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so8615382plr.7
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPxMtdaVEuf/TmmMX8wDVhETGtH9LgUyfSDjSNQd8LQ=;
        b=PtKKgTcchPWFwmNHCOELBCbedImXn8QMPZUx6BmT8IS2wiMXkAnvVSwandzH318pso
         Hjyv+KSkEYyXk4GV2I31Nrts7XxM6cf+zk2+8PSOG4M9OnwOvFGW0i2HmWqrqkC4EY2C
         U/pecA93OxRO8DIbgvcfQD7SYw3Ny8vnG8WlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPxMtdaVEuf/TmmMX8wDVhETGtH9LgUyfSDjSNQd8LQ=;
        b=ci2TtD4b7kC7tjaWxKJLJvYiLYhpXAHyG8fqIpja6coXa4Fw22UarJsOsvytDA2Ca0
         Q+dNcq6Eft/9g9JdVTlZUTKHn9PZRHWefiUiPmQmSSJUsj2SSn/kn7KszyYiCnfduduT
         vaaVjydwZaXldvOfGWRCiOFp2wtiZOQRDZn7uN3Rb/Z2KLHIH8eE2jdkkczaJodSyqS+
         lVWQWLuKLZcIB7gfT2o+wt453ONGO6AteJDPcq4ES+v2g7LPiinfGrdTS+3XeubVf2bw
         8jUwmwE3owecQ80E82zE7xyt6uLJ75D3IjS+AGuZLZWfe8+Gz7Vy+94/aHbKK4njGi6+
         /hOQ==
X-Gm-Message-State: AOAM531MA3yfLXdinfywXxMdMAMJUuVDukh+q7Rwi8QX1Nvd2ozf+jd0
        p2gYs1faCXj+3R2/YX6OXZ+qoQ==
X-Google-Smtp-Source: ABdhPJznb0jB8vv08BLZve0OvcyfCLdlXMgQKl4ItQYtZUCrXVmc6VSnzMZBZfdW62Kpwqwn9GzGMA==
X-Received: by 2002:a17:902:9a96:: with SMTP id w22mr5577756plp.172.1596237497869;
        Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm11510899pgq.66.2020.07.31.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v5 25/36] arm/build: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:09 -0700
Message-Id: <20200731230820.1742553-26-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59fde2d598d8..e414e3732b3a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
-- 
2.25.1

