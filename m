Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC1F1828
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfKFOOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731758AbfKFONa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id 11so3632863wmk.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bz6tm/Oq0JWNumhKoQOUWz+Q8JBAOdsIYOzjRyK0W9o=;
        b=jlbxIkKeL3Kg9sDbtCvzA0n80dNlWQeuKrHjCLy6JkLv+44YWN0XV/6Ri5hrDJmKx7
         RMw4nFFVFEbc3Y43ASQyDevRbQ1KafjwpXr/+E2NcnKi61gvBNO4T5/CoC/aVOJm1lF8
         afbdpOMvBrB1PiyE7mIkTCZmfFEppYlBRLE9bG4/7knt6uyuQCtc6yz3OfqEd7nJhW4y
         GaY42uHnvI3nskibfGwiI5um1+tf3nhRZnrxGC/x4jUZBdRvl7Ux9op1d4aYxNqMN6Yy
         Ugk6EsBMx1LG9OwSj5B/GAIoV5iSi0eBnC1ZNGpu0dDycG59m6by5s72ZnVqiH3P+Yu/
         polQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bz6tm/Oq0JWNumhKoQOUWz+Q8JBAOdsIYOzjRyK0W9o=;
        b=UrImQKzphDE5v/4vtHYmTCHgyWsHxqFhgGDHETl3NutkSv1n7BiQ0jtjWoLQ8EUX+j
         bfe/LeETzdihyL6QiGM082lNc7dP2JJvMGP3vKcZiwuRbZqVO4eyKeLuWR8j7zz2TLVh
         pNPut5TPWoJ6c16I7Dw7QZVadYgN5Z43iVYhTo93AMTFzfDIYbsobPbodupu8tFfZwFy
         2e5TJaw07Rpy5My43Mvl6hm4NJ/tfoedeRWrRlf3ESxGXeplHIlainntGP+HzMf2h2SC
         FdVQOmy+NHcdkvCWwS8HxhO8+AgAZokR6SXlU1qDfl2opoPqaypc+pxEii75WBzuNNAk
         3U8Q==
X-Gm-Message-State: APjAAAVHBlgH0xN9QsRT5GomRnBcFrRxY3FiJZ4mtm5R69XM5LZF3OK/
        mTIlpeErkv6jdJhno75KxqVHTdlHOVAjAQ==
X-Google-Smtp-Source: APXvYqx0JMbMKxvkK6MwbV+885ST1BoFA+6H9mqlYYb0WUFjcxzb2zWqAt5vUgOEk43WSZGg8BgArw==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr2652459wmk.25.1573049607535;
        Wed, 06 Nov 2019 06:13:27 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:27 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/10] s390: Remove arch_has_random, arch_has_random_seed
Date:   Wed,  6 Nov 2019 15:13:01 +0100
Message-Id: <20191106141308.30535-4-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These symbols are currently part of the generic archrandom.h
interface, but are currently unused and can be removed.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/s390/include/asm/archrandom.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index c67b82dfa558..9a6835137a16 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -21,18 +21,6 @@ extern atomic64_t s390_arch_random_counter;
 
 bool s390_arch_random_generate(u8 *buf, unsigned int nbytes);
 
-static inline bool arch_has_random(void)
-{
-	return false;
-}
-
-static inline bool arch_has_random_seed(void)
-{
-	if (static_branch_likely(&s390_arch_random_available))
-		return true;
-	return false;
-}
-
 static inline bool arch_get_random_long(unsigned long *v)
 {
 	return false;
-- 
2.17.1

