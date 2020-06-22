Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F120423E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgFVUyF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgFVUxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 16:53:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AABC061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u14so424783pjj.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0f9fJa8OA2NYK/yNB2OP/HZmbwcQdR1u3azDKPTOctw=;
        b=Hd+JD6CBzuK2BqDJ7ALVYyglKxpkRCQl/0Pa2q6BAjhgJ3NHdrXKo6F4eQ6/jyDStH
         FIVqU3u47cOdbudkrx208IcOhncwoGH1jnGAJADb0o2PduIem6t5sPc9hr2tyZhQYq1l
         95xaMVXc58L8xguf+zEj8rW6zjssA+PybgqA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0f9fJa8OA2NYK/yNB2OP/HZmbwcQdR1u3azDKPTOctw=;
        b=G6KdRP8UHMYkUXPOOMBCgZAG2AgcXFhLUgNAjlU8W+pBuD3lxRY2LEOfJ2vkpyZI7p
         5zxHIqyvZuZE0by74R9YFeEoDE2RceuNG5cyNn0WL7u6UvZRt2Jr8gdIqipeHY/JxYLj
         s/FNFu2aZmQW78PboI2PcpW4weU1FvwL7b7iMRz8l53eM48Y64Er11gATbnOd8jdfCIq
         QAWRw1yowwmm3W0497Der2+7P0AitYJFMIfIVM3VuUYDzZIB4ua5KMqqhfsGaWKcdNO3
         PavNbxIh7PUUh4TbhSy/28NuqEj25jBT/Zt3qjdGmJGZp5H9TcpD48vDVkEtMadbieja
         MI6Q==
X-Gm-Message-State: AOAM533tk1lM2dfE3YqysNT/Y60lX0jms92Nq+CeuM8VFgrPuJbYKhaW
        cOQGnCOSqvyy+gFj1DzCQ25A8A==
X-Google-Smtp-Source: ABdhPJwDyDpJoERWXvnmPuVM21tZ6v5TTnDZi7kCn7EzQhXmCI8+YdMStbWxb/4Hf75B75ybRmVdhw==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr21722171plz.145.1592859227557;
        Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm13934721pfo.197.2020.06.22.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Mon, 22 Jun 2020 13:53:39 -0700
Message-Id: <20200622205341.2987797-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205341.2987797-1-keescook@chromium.org>
References: <20200622205341.2987797-1-keescook@chromium.org>
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
index db600ef218d7..6fbe9ed10cdb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,6 +934,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.25.1

