Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249232069D3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgFXBuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388547AbgFXBtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F872C061755
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so551556pge.12
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=TXdY9FVpjgIhWRYoyXUuLGhQMeQ53VV4aKQM/q7y25nB8/JtVWIste/uTV5qFOVEAg
         AiwFcvmIJkGaP01f+FxsRre0U1D530Nko+V2qMyhP3wgN3vMhwW/eYK/szMmI5u22cDZ
         jsFw2NfSpjfdjBM4ANCXNfUIMmS92dojpKWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=oRnf4mixXQNZo7FbrvcpVfiASRNh8UB2Watsi5Gjc1Stcc6ZOjTcnZIVFtP7Y/K3D/
         6bS5MBSdmxrtqysBImy03lffed6EcbMRnZhLxzQX5c0kYrB05e2T7dycseYef9L/Qn1s
         U3iyb34fjEO4DNILQvoycuoKU5AGxHPoOBQirFwNOK69MGGrtgeMSsF/4aY7DERJK/G+
         WS3RNR5y3lM+YEz+rOWArpsqTw3rdG/UJt/ZAFFHrJMmcbznku8DdMWOS/IJ/cPypgJ3
         CCr3d9fbzfXzIJqw5xxDiQiFQWLGoD36OiXV4evMyBxz+tTphdF10NArnQBvySmIs2CK
         l/TQ==
X-Gm-Message-State: AOAM531a+7KFoRiGuAfH0KUo5CRfB9JDXljBli0gq4W8H6WQlyXz/Be0
        qazr/alLVhQed5HeDo9O9/JzKQ==
X-Google-Smtp-Source: ABdhPJwP+OIipEHU1rtWwvydXUxFmj7C6Qtq9SLHZvGQi6oapb1adwvvBObqNVtv97LQal3R11cR2A==
X-Received: by 2002:a62:2acf:: with SMTP id q198mr28740207pfq.48.1592963390089;
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a33sm7555553pgl.75.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Tue, 23 Jun 2020 18:49:32 -0700
Message-Id: <20200624014940.1204448-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..1248a206be8d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,6 +934,8 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.25.1

