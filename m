Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5664E7AE1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 22:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbfJ1VGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 17:06:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40749 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389632AbfJ1VGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 17:06:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so11380039wro.7
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mU+g+sfz1bIovsmfwMpnLnRDz98DNUSgbeHXg3LWxbU=;
        b=ribUHw8KQSMwF+HWzboOgcGnyDaK3YUsaQY5qHoPDIig1OlIIT+RSRtjqhXe7Dbg9E
         bSBQUcVMSR2hYT8aXJgTZ6f8OGIkctk+xHOQSOwJ6Q5CwvdDqm8e88AiepxRc7ZP1ybt
         fZNDCcdVU5u+XgHEnSecAhSA4O/3UGIAmBBvg8DDG4bGvgXFaAQ8BKz/3WIkMHUfBlmS
         oKK67aICFbH6k1HpTOZAE4EfYQIf0NUv0kei21drYEvGV16iP17AW1GGbOUwYExGH1Sj
         lsicZeW7Xu2uJgnaBUUTw18H4HUdfa/VFa8ufg7ZyBeH4hFKJ43/53r6cTSoTGfZETjQ
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mU+g+sfz1bIovsmfwMpnLnRDz98DNUSgbeHXg3LWxbU=;
        b=jYTcOnQek6I6ByDPCkbHuLll5a/JYVtn/pNVzA2XXMhQqypGNhLEKZYmiBbq1m1NRB
         7cUmW49rJEikRc4wJLl7JKRLcTxESDh/bzW+QogNgXFohBXXfargNCKMcRgG5AmEQZ8D
         484nJo+bubdlsRvZoBuQkKYSe8EnxlOY5JXAxZ+GS2QNCMZUzDIYWbUZeBIsf0ZqRDzG
         S3n5pxmEtRIZkDpLAAgv1zizVop/SS/0pa6PR/y5oiHAHW5S/gFW58WmyISO+idaDhWn
         r7dQ8htbLc+RTVt2dS7Kc/g3etnPMJ+oDMo8fWSHn17zdp2GNX6JE7Zjhnhk94wIq4I4
         x95Q==
X-Gm-Message-State: APjAAAWLls+zmo9s6C4ukII/liYIxLaoLqSfDY8Psps5Bpiw3ib6lkPp
        yiE+d8syAVjGCisEEEavbCsmUFKsF9804g==
X-Google-Smtp-Source: APXvYqwLLcOvu9N5SeRwebeTNTR9kL0tb9M7ihMiJM5pCGfJvj4BNTg8/+5IGhg+G1oQqTj4kcEk6g==
X-Received: by 2002:adf:f192:: with SMTP id h18mr17665670wro.148.1572296769066;
        Mon, 28 Oct 2019 14:06:09 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:08 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
Date:   Mon, 28 Oct 2019 22:05:59 +0100
Message-Id: <20191028210559.8289-7-rth@twiddle.net>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index c67b82dfa558..f3f1ee0a8c38 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -33,17 +33,17 @@ static inline bool arch_has_random_seed(void)
 	return false;
 }
 
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
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
@@ -51,7 +51,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
-- 
2.17.1

