Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29081526D3
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgBEHar (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:30:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40813 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so736268pfh.7;
        Tue, 04 Feb 2020 23:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vg6BkPgdBnIv8FR0F7bUnVnyFArf9a6FL/TT2MUcngc=;
        b=GXOBtyBB3q0A2TeT+nsp7OGGr45mpZgvSN8MfaQ6CucjuRQnhPwYwu2AsXGc89/wb9
         D4CAtw1uRbMwE4lGkZ+XAOo8YVSa657IaTgBFNT6hERj836Y56HO7jwzb3vdxG+Be+9C
         DnpUTpH0CasiES8Pt3ykHhBaNPJvLPiGmeCkXG8HHBcvomBO+J340diD5wIFYYXOlNBq
         1zq8SQJSEHZGnSlKsqA9bqybKxkPlaehOCwkWVAPL0R7tks7QPzygPwnuaMugA/Us+hb
         TgiCJ7wtPHsnF8tNFfaTxLlTb7BWlv+fDUm+IrdC9eFvVBGneivW181WTT//CuSMki1f
         V30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vg6BkPgdBnIv8FR0F7bUnVnyFArf9a6FL/TT2MUcngc=;
        b=tCeXIuAHzcDb2w2Iskg0ZiFlVw4ow3yK93A15sjYloXBOE2l2I+SyGKeGlrXBKfNhU
         wnT23hBsm4nkYRdrGs/eQYXfgoLevHVnkttWJVWeyMvZJuhuo5ri75CGflQiN+6RAyaN
         l1a1XJmKFP8hCQGirWDWO1L+jHqqI7yJqe5n883ahvtfV3aR3LXUQqaFTy1n4cJg5JoY
         69BQHWN1wNmE5WX4Dxgzf+NmXgxlWHf161Lgzu4EguZSQz0H+DU2rXP8v1cGjX0kFM9h
         8ASgMAd0clR/+E4dVjmtKkoZL63djOfEPhDted9TYDbiQbVW5FxqnzUAfu37IfTcM1HP
         NIrA==
X-Gm-Message-State: APjAAAUITrRVq3ouDRlea0FO1kX+G5A8t6Nym4/hp6Y5WriAlOuKusQL
        CLt3h0Uq/5A8hmn/vRiepVg=
X-Google-Smtp-Source: APXvYqxvb2HbJGv3QZjO8DsJt6hJRNg/peW1+u/siA8n6J18Wwo/T9osvHo5c6KjaSQHqf+JoAdjJw==
X-Received: by 2002:a63:f403:: with SMTP id g3mr35969352pgi.62.1580887845691;
        Tue, 04 Feb 2020 23:30:45 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id c74sm11679902pfb.135.2020.02.04.23.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:30:44 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 4C4C6202572F9C; Wed,  5 Feb 2020 16:30:43 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC v3 02/26] arch: add __SYSCALL_DEFINE_ARCH
Date:   Wed,  5 Feb 2020 16:30:11 +0900
Message-Id: <67cc975b4ce5aaf1ce0e955d321a7487cf27d6a8.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This allows the architecture code to process the system call
definitions. It is used by LKL to create strong typed function
definitions for system calls.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/syscalls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5262b7a76d39..d61069aa869a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -203,9 +203,14 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
+#ifndef __SYSCALL_DEFINE_ARCH
+#define __SYSCALL_DEFINE_ARCH(x, sname, ...)
+#endif
+
 #ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	__SYSCALL_DEFINE_ARCH(0, _##sname);			\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
@@ -222,6 +227,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINEx(x, sname, ...)				\
 	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
+	__SYSCALL_DEFINE_ARCH(x, sname, __VA_ARGS__)		\
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
-- 
2.21.0 (Apple Git-122.2)

