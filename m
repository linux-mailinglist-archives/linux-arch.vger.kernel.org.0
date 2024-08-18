Return-Path: <linux-arch+bounces-6288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72762955B64
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D831F21D05
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1309F9FE;
	Sun, 18 Aug 2024 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UdVKXF3A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30317555
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963068; cv=none; b=b4pXRZKvAvo22/GNQ03/c6HBBqEczqhmf6aLAiP7c7O3OMROJfnGZ78pSNx3ceHowCUcjdTx5Yon+C82DWiexFapHti2Sa9bEsivGpNWkJZQ+L+JrdGXJmByJO3jdaNomcY8z+d1Df0srP++qPXmEtE2mDIkZgFLOiDfuLyab3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963068; c=relaxed/simple;
	bh=p5C0mPrYaEV0ZHTAtYTAehGo4qZczBizeN+6aCANZ+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAXFygslA9o2FgLywYT8+vZkFovv+pPpDtPyIDBP9Q092mA9APZ9AUxssUL2bZbqC5zt5AEUx3ILd6OsuJzmz7VYoZwK6MhZ/jouEGk3QYikdd0HdV2OY6b19VUnKi5IlC4gQITJUYRmDAbJLLhloKY94ZIAes11XL+GweK6MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UdVKXF3A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428178fc07eso23515635e9.3
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963064; x=1724567864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baf+ls/kqppHRVa4XBeUzS5UcHJPfW6ACwqFNpH2vH8=;
        b=UdVKXF3Awl1w29iyh5jWcrKC181zC+3B0oOIr0O7IABxFn37cqqyDpvZPtuRatadYV
         9xDNhr4TFm2E4OL+1BoUYfwbutLFTdf9Y2/CbW/pCFPp8iw8Bu7bB6KDr/c7TJ9fSU+W
         CYe0+nAurfkqxHegeIKFYIsuoAa0JZ6/LmKFo80PX/bDeBmnMPpXHX+71g71DGDipfZ6
         KxHbEPdTT5hHlO3VvJdBczZqUD9Xpf8QCjgZ6JTa48VLwgAFOggO6p762ymNsgm7BW4S
         ONMedDD+buiolZmxEoe5AwegFmPRbFEWYYDG934z62Xr7K8ruin3iwAwCoagxyiQa7sE
         Ymaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963064; x=1724567864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baf+ls/kqppHRVa4XBeUzS5UcHJPfW6ACwqFNpH2vH8=;
        b=pM6Yf8pvoe8eYPZLYKjgL9fzuxDF5nCVxIa+OHBB4gW8Y7oqf170G/6XvXAJ/JeE9v
         AxUh+OIbEjVnGr3GZEBsuKF/YC5B//v6etCoPdSuT1URCsrp643PUnlhynTPV6lloY2j
         0NPMSut9hEaEVPVcyAmoz6OiANnnsfYCoA0whi5OVFM66j/b6q9vV9Z9VL8SzfJ+Px45
         Yppxo7dqpsV6GwB7p9ghvO502ytF0Z1Z6llS6f6FoXM9eoIOzkU4x3Qu8oIAzQikkq2o
         wiNN3Oxr8H5hoysItvklVT+YOf9OB7Sr03xe4hDCpYKF3Wg5sLq3Db61S0k6flm0wAjL
         djFg==
X-Forwarded-Encrypted: i=1; AJvYcCUxBENM9N9jLipGZLb72oP1PaCxFvtyRXKt/lXmuph11+y908zSFti4BGESpPg/W5/CO7PHY++mZ3I88n/9p2T86+ZqFLj45g+1RA==
X-Gm-Message-State: AOJu0YzK2sWzIsdUTuTDisGOq7VoArJmN/T4UKeTYg/Nq2+tRWPRgOcD
	HZrJnzSKx/B/sQXLUvqBDQiLWwZn2AO/ikCgoR7u6anWhudUadKV7LOqVXqgkH4=
X-Google-Smtp-Source: AGHT+IGOB8iW+hQOXjQLAOh7AsPotaVJZqzzaXjL4GlISP37ETZjWU8j89260z8kTNAIQ1PuXHkP4A==
X-Received: by 2002:a05:600c:3b1f:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-429ed7f9224mr53506085e9.31.1723963064325;
        Sat, 17 Aug 2024 23:37:44 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7c93esm119862495e9.41.2024.08.17.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:37:43 -0700 (PDT)
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
Subject: [PATCH v5 02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
Date: Sun, 18 Aug 2024 08:35:27 +0200
Message-Id: <20240818063538.6651-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
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


