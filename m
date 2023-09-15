Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2957A242A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjIORDA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjIORCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 13:02:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A7E50
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf57366ccdso25195705ad.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694797351; x=1695402151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFaSlC1Eanb+aGEVXbnD8fQMHZ9ukouqu1oCkaPSAho=;
        b=AMqGV4LWYluMA2CXitPG5LrXIL/L6LC7fUq3EO4giRqbZN018okEFAaIYpemNHDDBY
         WmBl+BUrU3/6lqgqGvakoUB1V87JzbpqtyKGysUVwDJmJi7W0wq0LyNqXViFSty478oB
         tdgh8cSNkqSsbO3zT8h3tlyPvR1rAc+L1OyoFgae2kHF7LwaGYdci815ZMYt98lG/RY7
         Kq7a08DJZM0Ea6gATUq2tJ1w3Rq6ojpOf7mNw+o7egSfGyWIKN5FxJA4eEf9ngdsSUge
         060tzEBP4/t/lche3fdU1PzqekIgK9OaH+Y7UfoeSnP9LV34E9S/wBqpe1lvMD5wdfIc
         i+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797351; x=1695402151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFaSlC1Eanb+aGEVXbnD8fQMHZ9ukouqu1oCkaPSAho=;
        b=fMFh696qiP5ep5ZozXRAqhwCS/Zqxs5SOd9I/DEN28xV+F6w9DN37nABfMTX+mv+lF
         sygS7p6NXZMKsbeZ0RrHg+DrDRaENy9ejK0i8xhYX4FU6ZkwiheM4EZ4JNiCz8dLFpwv
         yJ4J3CG/gQdrEe146fCucY6csV2+P+d1CzJL7c4koMIsSRA/wEviHxGvkx0ajJqC2s19
         0aWKFqrb02dY95AmchegEbArk4ppXLG8nsQiBOuJaqf5fcnjbUnITWfRZHQUiK4IIrJB
         i8Xb52YBL0dRvmnM+OPG2vRKUVOILAeNEWsTUi3HbqGHHN5eIHooQXaibu9W+m/34Dts
         I12w==
X-Gm-Message-State: AOJu0YyuKEe+X/FsdVTRqaOzPzfcyUgZUlSAp8X/3z7fab/iZcPb6lAu
        rTaWT15W2nxDZnh07o7KVa1Reg==
X-Google-Smtp-Source: AGHT+IFFMibfbK/b6MF0PIVWRSmwbwEFo0xt9xmW39fVktXtWQqqhBw6BFOrekLnp5F5kducpmo6Rg==
X-Received: by 2002:a17:902:dacb:b0:1c0:bcbc:d67 with SMTP id q11-20020a170902dacb00b001c0bcbc0d67mr8332563plx.22.1694797351144;
        Fri, 15 Sep 2023 10:02:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001c44c8d857esm34299plq.120.2023.09.15.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:02:30 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 15 Sep 2023 10:01:17 -0700
Subject: [PATCH v6 1/4] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-optimize_checksum-v6-1-14a6cf61c618@rivosinc.com>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
In-Reply-To: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This csum_fold implementation introduced into arch/arc by Vineet Gupta
is better than the default implementation on at least arc, x86, and
riscv. Using GCC trunk and compiling non-inlined version, this
implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
respectively with -O3 optimization. Most implmentations override this
default in asm, but this should be more performant than all of those
other implementations except for arm which has barrel shifting and
sparc32 which has a carry flag.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: David Laight <david.laight@aculab.com>
---
 include/asm-generic/checksum.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..37f5ec70ac93 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -31,9 +31,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 static inline __sum16 csum_fold(__wsum csum)
 {
 	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
+	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
 }
 #endif
 

-- 
2.42.0

