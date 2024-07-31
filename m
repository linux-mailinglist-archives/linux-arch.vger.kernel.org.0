Return-Path: <linux-arch+bounces-5745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB49427D2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763802842D2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F11A7201;
	Wed, 31 Jul 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b5Gbn6IR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54516CD29
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410774; cv=none; b=LVcKSnkF3DSiyEXTWSKcsg+9Upjq8+kRYZmjFNs4gR/JWtFGvdNP7DVi4Mn5gWXkG7OpdOPwwMu3IV5MtuQSTZOlxm/TT9yNB29fHZYgUm6eQR4kTnWE/pGlxeQc85he+RJ+TxGEWCegqzJX7hS8hCs1yC60yfUplNNhhPBtQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410774; c=relaxed/simple;
	bh=J67YKbYp1c1+dYtGt9ihjp1nazBSRKyY+Dh1Xv6jDrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5azajbqjfR3Y3cCEnz0pTo627rZyxPJXIaPH3c3HKuInlSMA2xZgRlvD9g0z1i4dhmgfepSGmRGAHEddf8wM+18jb01FMQORkMaSJPZE0y/1+SDSUWL1+cUU+EngkLZ4a5R/T20SIH+6mUKftTewPtZNcwuKWrXnB9F+tI8D60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b5Gbn6IR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso8628692e87.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722410770; x=1723015570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5b/A6qU74AkfxdtYyxiBPFCfAn9Wby9ZSL7Rzcj1cY=;
        b=b5Gbn6IRAvY0tHkf/7Ai9odhhMKW2ZR1PwZk/hpn/QFX8afSXWRTbRRFejDQkRzcpz
         hIvPfOUBhPNSk5oQpwMQAvPfWoMvqIcIghXxVyut5fi2n9skxp4vcNAd2N1+4tiNCdhx
         qQiuKvRncHIN7rbh1e7mgLryENr9OLKIiHTuJameD/AseWb1vepFfMYmyohMdINw3Q/C
         B5R4r4O9wUtxSNoHQ6lAx2Du9EpDgvUqf0dor8OPcoc3SLCo2yjGpkwMmPv1HVzuuQI8
         GnpJphVjN0E8smQjioiIhltCn3vk2bdgpC7GLfkaAo1XOXVVpZq+Frd/aFPHYzWtO9KE
         ue/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410770; x=1723015570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5b/A6qU74AkfxdtYyxiBPFCfAn9Wby9ZSL7Rzcj1cY=;
        b=EuUrgWVWPvs/BVjn6Cy99XKXBBX1SpNGH0qjrbmtnQbB/+ohALL7fCHeeMS0N2nukB
         pMTcOHtlNcw7GC0Pz0wK4XQx+0TsrODJ/X4F/vcNvr5LGCwfNVybbR6mUbnAJH9W3qv/
         xJsrlAOJ+OHyN8VVvuaMZL7Oi4A5dz2SnN5UIat2O0nJmkACzKTiIQB07k7J1YnW+gxP
         Qy5jpYZf9KtukrJ36hG9aahpXtuqSbVlUod61H4Vyvx56Z+uiPV6khOSsfA29P4Nh8VU
         TdAB0cZ8Ul5WA85J32kMo0g0Azwp9weDnbNM6XWojkX/1WSjr3i+FyV398cQ/u5mYWi4
         aEOw==
X-Forwarded-Encrypted: i=1; AJvYcCW4PMspQEgU16KFqezzpQARabksR8R15XNO9GAUuX5eMpVDRwEhhuLvwcGkxLUCkSCZGxGu5fbceTzQgyGLIwHSqJ0zAitOA5Cepw==
X-Gm-Message-State: AOJu0YzVG+NVFKbNp2EOprHe44ytMEctwrotwETZxABwTdK91wet51UW
	xZQF2TcM/Yj4z5uv9rmwcB9CYkQhXZ/3LgDCMPvr61HBuOQdISL4xHdg/Utlcrc=
X-Google-Smtp-Source: AGHT+IElDfoIlakrFYsMBeeLlbntHhhP6Di7Erttb/4pd4dWg5QISN3W8tux4DC9SLwXgyAkaGYd7g==
X-Received: by 2002:a19:8c58:0:b0:52c:f12a:d0e0 with SMTP id 2adb3069b0e04-5309b27a656mr7792329e87.28.1722410770171;
        Wed, 31 Jul 2024 00:26:10 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac7349sm10525575e9.27.2024.07.31.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:26:09 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
Date: Wed, 31 Jul 2024 09:23:54 +0200
Message-Id: <20240731072405.197046-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv does not have lr instructions on byte and halfword but the
qspinlock implementation actually uses such atomics provided by the
Zabha extension, so those sizes are legitimate.

Then instead of failing to build, just fallback to the !Zawrs path.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ebbce134917c..9ba497ea18a5 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void *ptr,
 		break;
 #endif
 	default:
-		BUILD_BUG();
+		/* RISC-V doesn't have lr instructions on byte and half-word. */
+		goto no_zawrs;
 	}
 
 	return;
-- 
2.39.2


