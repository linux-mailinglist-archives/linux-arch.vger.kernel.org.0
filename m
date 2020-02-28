Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5D172D1D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 01:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgB1AWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 19:22:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgB1AWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id o24so710540pfp.13
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fHzEreEHEKZLIitB5E8ew7g5jiGLQoDWIhz+OknFf0=;
        b=GkeoYAU8e8z3RjiVy/lNoEzHu3xfZdCSskh8kGhFyVvHqzRnbnRbxbrn4TM4McSa26
         b5dJvQCjoNTHztfI/3Yk8649TLr/Dejr2bVo8DdGFJbM/WkYGZ0CJ7NMkfa4SauXTXqM
         Nv+INQ8nhKoWxsj1wa0sdOVKRnF3rnDP62/0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fHzEreEHEKZLIitB5E8ew7g5jiGLQoDWIhz+OknFf0=;
        b=jt0uhdUMvQjNqaDyYODmghgEQQ/fhCEG3dq9Gh3IKWlFC8uNl+u4j0kwMxb0UauacE
         CfexVR9MnI1qkpRwrDlVo0ehzxZQD85G6I55NZRMqRq1RPZhMJCh8Jt3RAEc8NuZJH3M
         xfGPvVPqkr9kGl8lvM1OOiG3ut8VxPvCxqaSp38hRsuTP7QusM3vY3uGUiaBVkVJA3Vq
         u/tbFv8DcfT/J+lBJ+Coy7jPMUi5wNv63kzB1omvEpyZyy+C8iuLyCQlNhKxNsIDNusY
         D3qs+salyucSXLuYUhmMrBnljZeGo4FESAVK1cgJjGsHWmWrQZl4cC+LVooWHctbDXhm
         RN3A==
X-Gm-Message-State: APjAAAWywSfELJhFtvFkqNhBT1sOe/0H4pZkZcKKVAZf/oTrwnEj+mdW
        dVUi0Vqh2kks2qnHlI5MwE81nA==
X-Google-Smtp-Source: APXvYqznb6YTTAlhNn7JqjD0ERUnnj6NxCnvI3DxIeFfKY/2l5deXUBraE5hW9O+0SqGg2RsiPTeNw==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr1670426pfl.205.1582849372029;
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm8485301pff.131.2020.02.27.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Thu, 27 Feb 2020 16:22:37 -0800
Message-Id: <20200228002244.15240-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* section,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..303597e51396 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -902,6 +902,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.20.1

