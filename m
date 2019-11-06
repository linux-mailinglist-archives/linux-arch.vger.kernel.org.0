Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B667AF182E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfKFOOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731872AbfKFONe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so3524255wmk.3
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSWMpSoTK1qPuZQMUXUs+rrNl9psDWT+JwajLc5x63s=;
        b=o3RLE9hugfNMGeayOKXMF63poaTZyNZSixnercrQpPsfWWgoGcVsahZ9wGvxqajkTL
         65VNFHB6mdXVYgOXplvY1kFNexysDEPq5Mte9WIOjqcg1aowVtTrhVDsnT0wub/uMIGv
         9plm99mfCRtSEw63V2+FJEO0avUTLLDH0v6gLjF9DVOTaBg6oIbNyb7sjS7eGkIP45xe
         49mB8MByUP2KQml5xF2ln4ggynO86gSJMmUBV6ZeCzC7nwpX1YYgQOkj2KBMtTdJsDRM
         SSr5E0h3bqcqVqwF535O59szwWAxXieho+zlqJlenhqMZUeXa7L9rW2HfuF4DfbrOvdy
         Hi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WSWMpSoTK1qPuZQMUXUs+rrNl9psDWT+JwajLc5x63s=;
        b=iJDB1YrT6Gv4rKyvtvTmSVnbjkM0b2+QEjXyyJvWlb2XydYP6fTKJCy6wwal/vfs9g
         +wN3Y72uzNxFBzuSASzks/z3rO+fCrCyH02AlK5vtpd55oYozrfRCCSxu8ZlNVLS69X7
         tGEdzSC+6acMF80Co5rbM26MV4H5z6SsaE3YvpYpRwYm+7dTyeTbqmIcVzxOKs+cIsIU
         axFDQMdR/6L32eMW/1i7UMl+MUCIVJlm54y5FvHFNXd7ca4SooJCjXPys/H2JvzKyCCW
         Li7l46akLX4JAlpHjjEM4SYVNnRsVGuEAG2r3kqKd0EBTs79CEJpwmC2HRGjLa8N3iP1
         tj6w==
X-Gm-Message-State: APjAAAUKT3eqS6auJDSc8OW6SuY8iq34+KDsbUxXu70R3oWDlCNBBcGq
        U37by3J7sF8Dgn9VPbDLjk8mHA==
X-Google-Smtp-Source: APXvYqwYT+P4BzTIZpyLp/lptFTQGB4DXq5HOBhfHF4antZVjWqLX7iHjEffS3qreneqv0oqdHj7Hw==
X-Received: by 2002:a1c:9a15:: with SMTP id c21mr2802805wme.93.1573049610656;
        Wed, 06 Nov 2019 06:13:30 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:30 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/10] linux/random.h: Use false with bool
Date:   Wed,  6 Nov 2019 15:13:03 +0100
Message-Id: <20191106141308.30535-6-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Keep the generic fallback versions in sync with the other architecture
specific implementations and use the proper name for false.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 7fd0360908d2..ea0e2f5f1ec5 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -169,19 +169,19 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #else
 static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_seed_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 static inline bool arch_get_random_seed_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.17.1

