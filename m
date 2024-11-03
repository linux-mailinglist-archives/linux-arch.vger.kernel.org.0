Return-Path: <linux-arch+bounces-8797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE239BA607
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 15:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142671F21738
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C01714A8;
	Sun,  3 Nov 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IwLOAFDm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980F70820
	for <linux-arch@vger.kernel.org>; Sun,  3 Nov 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645641; cv=none; b=r8NnJMz34TRXp8TgpWpr2E1waIE2ZYLsqNSJxrGDV6EwpMdTvv9tOqauhhsSk97JZae+cvljXG7e+P3xMWQXElkto2N5CRMv439srihk9rmKi4Gzn0nkOtHWXeUCfpWauRaAZlhxZ05KT/JV3zeeE498Mm//ZYE2p9vM7Sm7gHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645641; c=relaxed/simple;
	bh=I9YIkC+Jr1vfCxbUp9hWddXX3XizMNgS5ezZYWoSkNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xu6wLZdK7kfiu2ZIv4wCJI8AmypchwZIf8PxC2Vqd+BQQ4/g8jeYRvDRs5liCzQsFYsKvh1GIe18V/bWpwXPMSqFED6Vv3icBWADsIk6uBP1cKUwNWVC0BaLwLgHuO1aF42fI0u8P2zZ3QLUL4esDKpY7BoMvMPJM9qJP0adplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IwLOAFDm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d47eff9acso2180710f8f.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Nov 2024 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730645638; x=1731250438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nql3DD9359qdXdLLpVtxL8oa+5wIDas5DqswNkA3KmI=;
        b=IwLOAFDmmiiHzdE9o+zlyEuI1eZQCoqkvnE2g1WFiI5dQwK2UL80wONjuRQdrnbZoa
         iGXKkYHh+fRmiDei6b3ZIzGouZBWYphaxq5QteihSa0kZEcqUTsUHVBK0eZJaMZa0D2S
         pMRIZ917kFyxtBtJS49NORVCRFbo42TNBDCQbOh4PvZLrJC2YwMy8c2/3PuD+kLfSxlH
         Q/u1FFWbRWnOz+UkOrYpLjXroFVbmUHNW7D0mOcW69X86dTJZDDAXwR/N0DFkhNQaQtv
         hRrDvqMEM6yid6ieQg/EKs4L5t5FdNmbHiNQv/v9ehNcvjBMo9p2ZPI2zYI/uIQgO7cD
         S75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730645638; x=1731250438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nql3DD9359qdXdLLpVtxL8oa+5wIDas5DqswNkA3KmI=;
        b=oh47UOijQnhLa+eeyy3bsRCOMBnPT71EO8bfnksJJr/7Jrdi2iKaOiG23Dhpr66G1g
         XxEBMsnkoQhH2YGl5wLfCZaE/N5XVSxtk8RjYKqGSg8YPaHKvu8KMNdg0kz8S0URV8PU
         qlO3sYUrkBOly32Ik885pErH27u7b10UdNI3GdN3fmQV6G9xXO+V228654n+P48pZos9
         vokVduu1lKmi9mbFOOZEEZQeHIr3PayEAfpu8ngGDeQ50j1s/Zeq5ayAETLEm+bmMGWF
         aW6jwzEc1NwYMgue00+FO1GWlZSmJn42k38sBgBvBv1/ptMuDYhVhbSbwrXqz+8O/5SD
         1l5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWsbvZJxSQOYrSu5MkOqwmCEFxcwlYyinvfi4gKLrrwrruaSK/eRRELV3CxKSVuL3iB8BIIYP3Ui3u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tQAKHZt/0NlBnI0Bumtf+B25WOeSIrAkaP4ovGwoIhQ4qerN
	6y2wRAokj6AqeyZiR5TCnfNnjhn29SPJSTwvjZsCIumd6Z1U0Aq+82bkAcxlr/o=
X-Google-Smtp-Source: AGHT+IEzqXU+n6yFRFqvDrou02tN/4/eCcsT/sjowi0L/ehc2kcbHr+rCGMDYfv6CZMwRO5vLoFRDw==
X-Received: by 2002:a5d:47ac:0:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-381c7a472ecmr8333590f8f.6.1730645638302;
        Sun, 03 Nov 2024 06:53:58 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d7e0fsm10710932f8f.47.2024.11.03.06.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:53:57 -0800 (PST)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
Date: Sun,  3 Nov 2024 15:51:42 +0100
Message-Id: <20241103145153.105097-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cmpxchg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ebbce134917c..ac1d7df898ef 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -245,6 +245,11 @@ static __always_inline void __cmpwait(volatile void *ptr,
 		 : : : : no_zawrs);
 
 	switch (size) {
+	case 1:
+		fallthrough;
+	case 2:
+		/* RISC-V doesn't have lr instructions on byte and half-word. */
+		goto no_zawrs;
 	case 4:
 		asm volatile(
 		"	lr.w	%0, %1\n"
-- 
2.39.2


