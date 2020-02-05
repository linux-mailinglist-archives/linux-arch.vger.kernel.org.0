Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7E1526D2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgBEHar (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:30:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so538333pgi.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Dna74YdYRlTvjEF+bamCzYS7zvkADnMfS5QZs5tBd4=;
        b=fCuCVCEc0XFRXau1LqxEA0/Cm7EL/NYr6Z8jlK7R/cfQBoTFNZdhV1oXktzh04ue5u
         Gn7NbeG9hcvhDAcdfkvH9ACcHa6gkjpeECMpVCxtwUR0HmIySPx6cjzjzfn0KCrSbMd7
         0Bd34f9A57BL9oVj3W8cLiAwT9vM/wFU2ef6AZqLbzeyCB/OIwytFNBk0iVy8mHH51eI
         pmmhUfvJlw9lZTuJFNSJzcFr5Z6uLZKz4F7qfeZ7GU7usepCHCt7MgdXWpijiHy3ajhF
         kecIghzPnWRAKMTsGSNCMzbZlHYAWerax5YbXZNUtVTKyrZbHQ1Q6rZH03+tqycR6JjX
         ENAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Dna74YdYRlTvjEF+bamCzYS7zvkADnMfS5QZs5tBd4=;
        b=KPc7U9njhLvRGmXs+j47gMCUgKt1fuR0xd/H1QSq/NS3X7rCzdvpZXxSaNwTZ5/5Ch
         7ntGybUatDBUtNNzKrX+FZ7/J6tj4KLn2htbm0Hur3AAGrXeHGwSzqj5yAMOkN3+v3pV
         28LeNKTkUaGoLAUt/Yq47xHzltSsl31vNkm25lG5Z5Nc04dRnawvLb3nbuy9gNmlEnM5
         gWemQXoaqWPg2rS/DNAXPKZvvQJK1qijF/f6d+4IsGcD6l27ws9MgL6tH42DeNytv5JG
         F9Q/whHyGdQTMPUjs8Z+xoz4e81lQhoe+APJ5ekc2JNl9D45v+C9Yw1RsUV2/jrjzfCq
         Rgzw==
X-Gm-Message-State: APjAAAX5syW4knF2DE6ThnuYdeYOZO5Ss1FFJsqn1yGiNGlynPOKsqnC
        ksKGgjD/NTJieeQsmy9w2us=
X-Google-Smtp-Source: APXvYqzJpryItzlRmuVT9f7SRrLUg5hEL4zCL+VSqfX/etnYD0qu7lnliQBvdtx8apM1fJj4CClMQw==
X-Received: by 2002:a62:4ecc:: with SMTP id c195mr35725224pfb.158.1580887845329;
        Tue, 04 Feb 2020 23:30:45 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id r198sm25241079pfr.54.2020.02.04.23.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:30:44 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 45C0B202572F9A; Wed,  5 Feb 2020 16:30:43 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v3 01/26] asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
Date:   Wed,  5 Feb 2020 16:30:10 +0900
Message-Id: <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
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

With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
are not compiled due to type conflict of atomic64_t defined in
linux/type.h.

This commit fixes the issue and allow using generic atomic64 ops.

Currently, LKL is only the user which defines GENERIC_ATOMIC64
(lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
issues before this commit.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/asm-generic/atomic64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..9b15847baae5 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -9,9 +9,11 @@
 #define _ASM_GENERIC_ATOMIC64_H
 #include <linux/types.h>
 
+#ifndef CONFIG_64BIT
 typedef struct {
 	s64 counter;
 } atomic64_t;
+#endif
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-- 
2.21.0 (Apple Git-122.2)

