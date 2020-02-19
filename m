Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7438F163C30
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSEyg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40622 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgBSEyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so22569048oii.7;
        Tue, 18 Feb 2020 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dr2Q+aHg/1SGjzpWBsBNv11ATwozDGCBBkaKKg29VLU=;
        b=RlTQIa8CRCM+VNzdVRfUcZhF+5zjAHPs4z0EywqhlgDJhQIBms6nhmImjyHTTHYkOy
         kAE1qCHWRhwFAjVqLvaXZJa49nISb8dLeexOQVcMXPsAchxmy08bxmlmomC0ljC4G6r/
         TPAs3CCUKPBkIrP/fhQdDQthulzH5Mx98wdmPnKA4kQLIIZVOm1iycVFu/zwQzT6lvAs
         IAELIMXwPbuzc3ConrlHpGVxcz4GPCA6jwhoQCgJFAH91pN7I24IxHQJoVQwmxq+q/US
         yFqU1TwG+sb6fsmvXFmjg9uYEDKwyxy2qReN/DutUyQQASjz7GWVWs8oeR5tslTVZTNO
         Bd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr2Q+aHg/1SGjzpWBsBNv11ATwozDGCBBkaKKg29VLU=;
        b=CnNwVYxo05cDLWodHhpy6sXVZGrzR7ng5HE4yI2+0RkFCk0vbU7SV7tIcGt8vz1RjF
         J8TRGaYDTf/ZWCw5X0Dy/zgsKOWsZCSt9MoBGNOSGgaXcr3+FEKW14ylpZi5So0ZCp1r
         dpXF11Me7+WmKvqrIzH5LZbcebkhjbmOlQhfoUzX/v5u0D5zI73tzZ+6f3m0cPyaG9q8
         4WQ3hdyPJG9t+TrV5N4vp30FS3Y5kUpZ1t7FKlqZt3wNDT2/6FvsWNPbmiWEvgYm0OAk
         6mo3RfIYCiUi3oaGs9TIGwyA9tDWVW3OGegkL0oEyYNl3jXAOAVB+gj55jR4+AFaSFlA
         /4Ww==
X-Gm-Message-State: APjAAAUYhMnJprMKBo3NHJzCQ4/GieKIDvm2FkQ+WYHRybPE2v8R7gDF
        gMZrjyynHJbfMT04YNy/WFI=
X-Google-Smtp-Source: APXvYqxyb3BnXAjNQrjcn8HqOmkV+kjEbAKY9iDmYxHQnfG5ebZsrdug8IdEe5BqVTLiXeR2InjgJQ==
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr3577268oib.137.1582088074161;
        Tue, 18 Feb 2020 20:54:34 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:33 -0800 (PST)
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
Subject: [PATCH 3/6] tracing: Wrap section comparison in tracer_alloc_buffers with COMPARE_SECTIONS
Date:   Tue, 18 Feb 2020 21:54:20 -0700
Message-Id: <20200219045423.54190-4-natechancellor@gmail.com>
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

../kernel/trace/trace.c:9335:33: warning: array comparison always
evaluates to true [-Wtautological-compare]
        if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
                                       ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c797a15a1fc7..e1f3b16e457b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
 		goto out_free_buffer_mask;
 
 	/* Only allocate trace_printk buffers if a trace_printk exists */
-	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
+	if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))
 		/* Must be called before global_trace.buffer is allocated */
 		trace_printk_init_buffers();
 
-- 
2.25.1

