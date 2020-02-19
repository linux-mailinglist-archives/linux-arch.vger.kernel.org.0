Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1488163C41
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSEyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40216 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgBSEyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so21922314otr.7;
        Tue, 18 Feb 2020 20:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXMSq1G5rPTXUEP5geAUCtTmXJBdNGAIZfUMzXa3xpk=;
        b=J/JOa0IRUSQzS/wfLNZGUESDgz1LVTCC8zLL4GgLJN3TkqqBKqbwTtKzVV+LKQA/ow
         Ctahh1xRv+Cjvv8ps3OzOLyz0wsgaXJYVIUktvu7gxbtjoVSvKOjLPBf2kHlscZCiHiN
         rabnjLDU1PUlEMJAtn6k1Zde4XJg6WcwaOUl2cBKDUlCkAiaN0aRXU7B1+fST7KgxUc8
         plxxVegSLtHSF2Kpo7GnyPEjvBEqw4jusa3DIb+rb9MEpwvSQsLaH834lRk7M/UNPdnw
         AMNyVfRD1iwflZr8McSRr6QzaZzvWMNXySOrrLThSzklcMr35jGETEW9goqvDy0a1lYR
         8tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXMSq1G5rPTXUEP5geAUCtTmXJBdNGAIZfUMzXa3xpk=;
        b=mg1jVHMwWSwI1h1zQn0NVKhhHwwfxavdgHnPkFhyG0lD4w6ykpWfBT5jbwLvn77x98
         ESrY4a5YHASP9jH8dtRytwKaFP2aS7wQ17WPskTuJlN4wd58HnapuTVOVDMlPQ4eljk0
         fjwaCrh1iPd0aANqJ8g86pfMEGvirbjWKLcmPrczG4Xm2uKFdiIEChEeJn85V67fq57w
         2DYTke4t331QgmOzr4wGf1T/VZh92HHZSI19vzuqfTAbkTUX/cs1+t0nvG97T3mQ2QDl
         fbclDRy6rg31iGhx05/6MSv2Xzkwog922OAb/ER1EFQua5o1sukxSZ0cqJaYhVAcOpqi
         zVUQ==
X-Gm-Message-State: APjAAAUfiYAQprj2lQA0hCBB/Zp4AAXhM07PZNDR2VDtkLLSfoYUeI0F
        ryZKI6ukWcd7GF9aKKE264E=
X-Google-Smtp-Source: APXvYqzGvAZO0x9jw5WmNLprzgTxW6R8oyixD2CIDl8AUW+oyej/NaXt3g2Xbd0NMuq30pnEIYLxNQ==
X-Received: by 2002:a9d:6415:: with SMTP id h21mr19176451otl.152.1582088076125;
        Tue, 18 Feb 2020 20:54:36 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:35 -0800 (PST)
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
Subject: [PATCH 5/6] mm: kmemleak: Wrap section comparison in kmemleak_init with COMPARE_SECTIONS
Date:   Tue, 18 Feb 2020 21:54:22 -0700
Message-Id: <20200219045423.54190-6-natechancellor@gmail.com>
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

Clang warns:

../mm/kmemleak.c:1950:28: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
                                  ^
../mm/kmemleak.c:1950:60: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
                                                                  ^
2 warnings generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 mm/kmemleak.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index aa6832432d6a..e27655526ba7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1952,7 +1952,8 @@ void __init kmemleak_init(void)
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	/* only register .data..ro_after_init if not within .data */
-	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+	if (COMPARE_SECTIONS(__start_ro_after_init, <, _sdata) ||
+	    COMPARE_SECTIONS(__end_ro_after_init, >, _edata))
 		create_object((unsigned long)__start_ro_after_init,
 			      __end_ro_after_init - __start_ro_after_init,
 			      KMEMLEAK_GREY, GFP_ATOMIC);
-- 
2.25.1

