Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2E197EBE
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC3Oqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:46:35 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51364 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgC3Oqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:46:34 -0400
Received: by mail-pj1-f66.google.com with SMTP id w9so7679909pjh.1;
        Mon, 30 Mar 2020 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBNV7mCHl8ARll4ecc1sVG2Qhvtdfex91jBAy7FeD5E=;
        b=Xg7FkvV8uCD5UbuTMsSG7MouNqxGXREwGo2CzFyIyiHdAtB7sXqI3tOWVghjtUEYh0
         aXs+eWoOseSRSsH8JiqitZJK8BWXHmUUiLOCkuDb98VU3Phrph1MBzuTmTuW6DQsnW+E
         GruUp/0qfCRyDEsZ7tNIhn5CwEzk3RhKUl4sSSZYIOmzXcvrQcnlQMp78LfHMoJgypw1
         823cbowoiSUn/YmTyfTQhqIUOUMM03B9YXiNZb/Y8kJply0edBKDKPirKYjqlSFI24q1
         Z63y+/vmE+nTUoUwxQJKEeO9u7H/Mg3U6ITyXYlSHKvFhld8eynK6CJ9z8eW2eAEV1T7
         dlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBNV7mCHl8ARll4ecc1sVG2Qhvtdfex91jBAy7FeD5E=;
        b=BewZ4IfrctxzYYj2hGHGOPVOZ/Of8QikbMnLGy3BqM6bdGxCBPb1h2V6HlEpvrnEGt
         AVNra8+gIRef4wmZputjklOnsU8dIvHeXSG3NyGBTEeTN67rG25fU6YgiCSg/xe34Ba2
         5DTWNaIN+r8fweSmlUxYlAA3l6mOEby13OJp5VBz7e8RXrPJvcGVOXAt7ff7Bam5IHyR
         QNTDoBt89NkrDdh0zOBPdJGCKJQ76rn2Sv0RzUgnsKlfqcZGmni6kXCy4BkWGJOKI0XI
         8ALdhLskNGpirhd6rFJuh5fKQIRPWqyUizdkMmsrnzU7WajFwy1q/jddKC6zJ8hmoz1w
         bF6Q==
X-Gm-Message-State: ANhLgQ2u3xoSwGmDjImpzzAIuzFmCA1kuvEGtlYGReLlZUy20Y1h9MEn
        D21aqEVyuVNi9MAeuZBr4gE=
X-Google-Smtp-Source: ADFU+vuzOLitTeL+ZQiw6hgGpxorkO+zvB0TOdLFdQtE28ZuSntUjkSNVSQ9+B/KwzIkHl+Y7e0+XA==
X-Received: by 2002:a17:90a:f98d:: with SMTP id cq13mr16273240pjb.105.1585579593306;
        Mon, 30 Mar 2020 07:46:33 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id h198sm10333214pfe.76.2020.03.30.07.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:46:32 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 2A534202804C0F; Mon, 30 Mar 2020 23:46:31 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC v4 01/25] arch: add __SYSCALL_DEFINE_ARCH
Date:   Mon, 30 Mar 2020 23:45:33 +0900
Message-Id: <9b9d47a8be1c38561d0fc3e4478628e4bb6056ef.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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
index 1815065d52f3..e45815a3ee10 100644
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

