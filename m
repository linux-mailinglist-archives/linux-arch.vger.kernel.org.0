Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA01F3F14
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfKHFDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36287 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKHFDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id v19so3876611pfm.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdQzqUTDdPCKipZzqeoQ0qh0njqgqODS3douIl8T/zE=;
        b=jB1Lfa1l0s66Jca6rqG2rk+hhfVNudDnUrxGClndqRmaBL/Uc+LvWED/pEB4aQkj4S
         WkEqi3v7CHuvUwpWzy3SHLty94jNRDOsjcPAZNjXXsd8+HlJxph2NiJgnTU+r7ZSs6/9
         uSFw851rCyDAKGfmAX8OfAX6PDY80qr64a+poRCHSTu0NzVO3qxhjzyGMApKcQWzwm6d
         Ugi1y1OtjD3H6bvMPA4xz9YqA/W14RmO9Weym0N56Hph7cce/q80YSL3ejKj859Qo9PD
         P6MQibhaB+uxWG53g7UdjZ2nF/A0xSzMBAQN4NnBigE+HFFaelu2qBAuODgRupawESkS
         jmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdQzqUTDdPCKipZzqeoQ0qh0njqgqODS3douIl8T/zE=;
        b=or09zWSIVkcZzjAyrWranxhm0QhuqKwRVnIW+cec4d1XWCP6KCUJhDO4hsfMTevHMa
         +d5FaSx88I5lO54SILKBWAWiLPn/aEqcV68ehNtrrLB0/AKR3LoeQrJ9Hn2rPG2ikeiK
         vFjbfWdOnB8P048zHUMHoHXFHlki6M88/EdrUgnaqsTQ4DXOSGdS6UoAxAl+3MV8bCSB
         TDeJniB6IfpjavQ0Z4iLeI1Rsw88puYDNNhNgLtafn+dcFHgN4TBhbdiQizyLij+7jLT
         MuNIWzpXcRyW4Y1AY6TrqIueUSwocFk+6szx0/EQ6OgiVJnW9VCPtYPpVb3p8mCBrJ3/
         2DTQ==
X-Gm-Message-State: APjAAAXxkIsexRW5FD+wfvFUF4yhu5HMuV0ApKcfEfNwmo/zN+518nbg
        Ck3eoKnsrSdO+AlxoTlu6Os=
X-Google-Smtp-Source: APXvYqwK4vVInJ5LQ9Ah05ybRRGnhlZ51+XIbpE/dDIfAjYDRM5yQj3F+GlZzuoX/H+iFmDjP+Zpwg==
X-Received: by 2002:a63:eb08:: with SMTP id t8mr9673784pgh.49.1573189384295;
        Thu, 07 Nov 2019 21:03:04 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id y22sm4661021pfn.6.2019.11.07.21.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:03 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id A3628201ACFC47; Fri,  8 Nov 2019 14:03:01 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 02/37] arch: add __SYSCALL_DEFINE_ARCH
Date:   Fri,  8 Nov 2019 14:02:17 +0900
Message-Id: <d2d52cac3eff859b8cef0bc755cb6ae4590f27a6.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
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
---
 include/linux/syscalls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 88145da7d140..77e52fe19923 100644
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
2.20.1 (Apple Git-117)

