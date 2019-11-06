Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A79F182C
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfKFOOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbfKFONe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id a11so25965963wra.6
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOCSV59QoWVHACgzHE/U/CUT/RhU8DoyNGp2OnfJ+HA=;
        b=Lt8NSkicjrMViO5Eg4iicjQ9Um4Q/kPhTekzALb+HzNHfhDBmznekCXpWfFCqxbPf1
         XOZbS8K2jooY/Eh/31ehUIBaypEbhpyPqh9lub2S0lbmj/O81IwFa7dqMAQj6ppnMr97
         h/sNucOFsQ1bw9fFy47CCesF+0lx7lCCx4pM7OMgkxiGq6zqQ0YuondQvtGoWarNmqPF
         O03RynY9JHqQ9r3dfWX6s/Iy4zuK/kFgiBT3QXKGHNPYenHtppO+8gHzQKodjZWngOGF
         /2dp4+1OO0PAUlrW0CXW7rSAK8WFPvwHkNyb3WEsqOlkKLv3LtcOVNpqbcfmzzDC32/P
         I53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOCSV59QoWVHACgzHE/U/CUT/RhU8DoyNGp2OnfJ+HA=;
        b=CrJgW8rbv7x5RsLbKlxJciVHCY7teWluMmaURIahvmXCKB2Q+qDC96x0YzB8TDlRIu
         F8aT4TPc6Y6msV1/vuI0YECFrv1L1Z8GeUckG/xRtPeQjwIS+VcGRdlTj2HywvRNqTjw
         tV+Wbidh1pGzRAxE6rvFfJyaUV4AVnPWliAutMBKUjvCgoeLknXSJnPoUwVT7M3Q+Sed
         5TB6nNGfizN8BMdw4C2x0tCXdnzfeu0AnsA0N6/Tw3wLSJfwa1etQXJmH4D5Hg21/Ee2
         W/kruGQ1jVHH21F6ScW68aL1BXdEd1I4zU+fqITkpQj5JdO8Sm8SyqqFYyGe5WiENbSz
         q6Pg==
X-Gm-Message-State: APjAAAXSyzXdKJfzeuul8PcnIibcgNxxwT6aia+Axi/ezvgGbXOKmMui
        /eMHdRap0Q07OHlgrUkhAFTrTQ==
X-Google-Smtp-Source: APXvYqzK5FGfZx+mRuVsrOtGAG1CMADIYVflqnomqokFyeKkGb54YgnosWkS0ihW4ENT9j5fGGhC4g==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr3106213wrq.287.1573049612495;
        Wed, 06 Nov 2019 06:13:32 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:32 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/10] linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
Date:   Wed,  6 Nov 2019 15:13:04 +0100
Message-Id: <20191106141308.30535-7-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index ea0e2f5f1ec5..d319f9a1e429 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -167,19 +167,19 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
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
 	return false;
 }
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return false;
 }
-- 
2.17.1

