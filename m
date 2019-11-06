Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB987F181E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfKFOOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50433 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbfKFONl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id 11so3633740wmk.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtW7c5+Vxuw361NPgarxEa4pkxF91xrS2XEr4qnN4jI=;
        b=e5nNk39VJ5IOgRqdcXf58JkLAmLsag2O4+U458JjYo5P0PSEMekSFRL7LZc2d3m3VJ
         URQyFUvE8jMn4eVvMtPS4S4bwU+o51HOhtfgwYme4dhoLAOHd8OHl1q5buqF/oxhumhw
         +z3jc1g7Ck1yBgoUiT30MrVfaQcI9SAZcV6//J2C/MjC41OM02IYNasElc3UDquPybqb
         baWyh7WRSDEfEhipTjcqjxsGo/IM/qSUCmUCE5UrGsB4dj0txgaPvPHy4E6e/8b6xTks
         +7wsbS1O4VTbwJoSISfsP2WPk3MvEuhRHnX4Tq6FkCgrC9KgWh7M7bDPmgQZAuRo+xGE
         Q0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtW7c5+Vxuw361NPgarxEa4pkxF91xrS2XEr4qnN4jI=;
        b=tPC7tyUG57ctDNbrV+sTZ2ngfKOsz2cgNrCcanYp7k6J1kV/+Hl34/g5x6SoKv6XJC
         yF0U88YNh1MkV9h0fRApdZ5/QDCMTKOqhfistaPG6SkvL03LFVVK1Z4ma3nsTCTFL/e2
         UhQiwtixZq0C7WmHNwYVgEL+iiYFLohcVBxxc99ssfl2DJQB2MoreegFS4Jca68xa2bB
         xlA+Y/b9l3JhGkXan5+MJliRfiPcvyMxzP+QWIoT62hQ0mFKHC7g0W05Sztri7NuLJvD
         mX7zkcXVhrcxI7XHMc3Pa4VOmH7VBLiGaUd307dfOZqSDx4V0yYsmnRoI3KEOx6Hwxhs
         m/XQ==
X-Gm-Message-State: APjAAAXxRK3rKoPISHAmCZFxXO9Hq2EvAcxyi9LGehSON6FYSufeJDj8
        BxR9kYLnnAhfWu6ep0I+nWymuQ==
X-Google-Smtp-Source: APXvYqwQkS3HkPb4xqO71j4GDBQsJDOPu6hiWKUGgF3l2gy8AO8EiMAAlXbkknCw6t0pwT+ISh1RMQ==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr2609658wmk.144.1573049619319;
        Wed, 06 Nov 2019 06:13:39 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:38 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/10] s390x: Mark archrandom.h functions __must_check
Date:   Wed,  6 Nov 2019 15:13:08 +0100
Message-Id: <20191106141308.30535-11-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/s390/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index 9a6835137a16..de61ce562052 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -21,17 +21,17 @@ extern atomic64_t s390_arch_random_counter;
 
 bool s390_arch_random_generate(u8 *buf, unsigned int nbytes);
 
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
@@ -39,7 +39,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
-- 
2.17.1

