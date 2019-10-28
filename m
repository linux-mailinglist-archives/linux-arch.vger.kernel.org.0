Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D0E7AE2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 22:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfJ1VGM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 17:06:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35855 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389634AbfJ1VGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 17:06:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so378540wmd.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Trmz1oMdXkgQduJ6dSMyWBdvnJGLiBd9x/YQsqmt/z4=;
        b=sr3/upyfRhBPqhCuVvZlquM3tMXK+FLoz2Y2nWEL97AxtydZpmz7kH//aqFGKiF4Uj
         T2vIJpuxpjgsJR3rIQpNvFQVY5soBLF7Rzf3kczte3zotj8zq3w2XVhRZTCaDR7CqU7r
         RBUwhO+4i3EY/QsMdN4kaoQeRTj+v8bmrvmbWptIdITT6sdQlhfl3EEo7901M1AVyGBF
         BzpN7dQq3QUNjSisrKVonu11+AOT7oLI7vEVJZTKkyM/rLfUXe7RO2M52K6BA/L+sGVl
         aqo/xtW2v0EDkxghzjz9ty/HLo5VwHQQyNkUAqMZydgPyJwt+m557X5M9tHGkKY6jlxL
         JIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Trmz1oMdXkgQduJ6dSMyWBdvnJGLiBd9x/YQsqmt/z4=;
        b=WiEjMoCiLiI195I2pc9exH/inmUhZ34TZ5wtEq3/9ktKZYXd/bb020GbOnwKz2NR0P
         G3lbzkp9J5/nAXWE0lDtJNIzzRP3m7umYDisVfb5qag8zC+VRnms90nX0taaU2E1xMn8
         H2DkgMdydXoY/1dzU3AYHiGbrxR4LiZaDNxbQqY7ZApimJf1Hfz4y70MZPxb2J+t6lR0
         IKUC1liGFATQ2s8LFqSkoOSIHuZynlyUJwGzSEoaPf2b1SXl0hR8XWmsNshdXLHUXvee
         04hSrUSHzdRRx1946o5v3gVZV7tZnkIkUrMcBm5RGZWWobZCqJ5F2ewPN+ovGHyZpPrG
         WgBg==
X-Gm-Message-State: APjAAAUkoy5ugJBu/VLYqJbC31T9mSNM1KljAjO+RkvtSilBBMlKHFu7
        scoL0Klk496/KWDpKvkk/9VclTmfT3ciPg==
X-Google-Smtp-Source: APXvYqzrjUNW6FASV5OYKYITB32BLwiqX3gvbSlyQ2rHCnIhZsijRUh3wkyp6SvrHbUKPhK9PwFpvQ==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr1074821wmb.125.1572296767937;
        Mon, 28 Oct 2019 14:06:07 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:07 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5/6] powerpc: Mark archrandom.h functions __must_check
Date:   Mon, 28 Oct 2019 22:05:58 +0100
Message-Id: <20191028210559.8289-6-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We cannot use the pointer output without validating the
success of the random read.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index f8a887c8b7f8..ee214b153a71 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -6,17 +6,17 @@
 
 #include <asm/machdep.h>
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
@@ -24,7 +24,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
 	bool rc;
-- 
2.17.1

