Return-Path: <linux-arch+bounces-8799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC669BA610
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 15:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5B51F2179C
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F91714C9;
	Sun,  3 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z6yqiISf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F516DEAC
	for <linux-arch@vger.kernel.org>; Sun,  3 Nov 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645764; cv=none; b=hRGkrRBGqZV//U/xbABP+/aknlj+Ikc5qJNrh0zHFseaw9R+ig1d3TQypRP1eUghWBumCmToTKvthelzXThDotZZ10L3XqjCKohM+pM4RLlG1cU+syBaM5FOLMVzUYH8Ro1GqwDZLjLRyIy0xx87QTd7sBH6n8Z+WRdkRfcG7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645764; c=relaxed/simple;
	bh=DRgDwMt2Jlwx1evaYgD0rUR9lyNA/XwrvCTgk+IBusk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6Iu31RhdRJcOPOE9ugp8f18psPk0ncNWJa0NS2e+AUI/VC8wA4x37Lojcm3Kt7EIymIPBi0bA/uS6Y+kPuYl7ue1CvnQTmJqTAt3DRK+I5QA1uKwrBw6y6h7QdZtkvbqLFvu1d9vCIQ7MMq0dof9sNn+2Tvfqa9q6O0TUGSvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z6yqiISf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baec69eso29035165e9.2
        for <linux-arch@vger.kernel.org>; Sun, 03 Nov 2024 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730645761; x=1731250561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lAswjGp3xf0DHvJRryPePimKYUd7lF/oN62wU2lB88=;
        b=z6yqiISfjOngRuB2+EacocBQYut+r7Ta6UjRUXgl+SQuyJWkOyhfMgJNYvBGNGsm2a
         Ydm7xAv7hq9KP5x1+eeye/B1TRVY2N3Q3u4RlxEI2htd7v2MHlq3nDNvJx9CEaeW/POS
         Iram1YERIiAdzJXmdzxuC3ZltRhD1kgO6ftfe6G49bK8pVKsy6tomu5pwkthRAlFBvln
         2AYtyGBp+9061PIfcLhBtMuNSjH4JArlV/YecWC+PqxFrMrXqLlM2MiaNSlTW+GAnbaM
         jzT0GJFbXPn5ZmAoOcZ9hh1hRwnIQpeYauP+dAAfqRisAdtVqoo0U8pCGQhjLdYIjWaT
         /u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730645761; x=1731250561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lAswjGp3xf0DHvJRryPePimKYUd7lF/oN62wU2lB88=;
        b=lTInbmxAm30h+wv24kZ2qAp3CHlNcvAHLXPKo/eY3l03Q9nVfrGGixMcHrdJCGt3e4
         4aXv1hkw4KdHqUAJTfZrGh6/+V09OWcvBBox1FrgbgInVRyko+rHT9LVyzx+bctMDWHX
         GWTWc5+9jV18RFwocDTSO4rgqFwR+Zu+zZnDtwzSF8H3cXKc99zgtwcglWgfcytQkcBg
         T0yV+2/VOdi2xubvYtNk83DyP+U9qi1AxnkwUH9+6b+O4365HfR7cL+8diRHYmoS0Evj
         ++G6T1EMEc2vOavH1Cl60vB+TwaX3ECg0P/26Z78xMd/iQd30S5Kdur9UHyJKLCQROie
         Ib3w==
X-Forwarded-Encrypted: i=1; AJvYcCU3yzyqYpxr3aXTWShIo8BTrimEeFxYNZnwan77JJWVgrABWXyJ1pUItVfrNsvC/pWEkuNYtRWaevxH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyij8XdqDOEWKLPBbmeJa7jRgfgX4RXSMz0vw7OayaV/OHKkalK
	mZVVyzTX8/HcKfL9TTlO5zI/svuQZh8Y3jtDs015kbeRL6MCfHrnTlMtywZdQIg=
X-Google-Smtp-Source: AGHT+IFXcE4yQOkwclhHZgMus+XU93hkWLBdlkgkjwLbfRe2UgNWPomwyzpyojRGnPIQGSxet5Zozw==
X-Received: by 2002:a05:600c:3b04:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-43283242a52mr72748635e9.6.1730645760870;
        Sun, 03 Nov 2024 06:56:00 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad6fsm10730912f8f.98.2024.11.03.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:56:00 -0800 (PST)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 04/13] dt-bindings: riscv: Add Zabha ISA extension description
Date: Sun,  3 Nov 2024 15:51:44 +0100
Message-Id: <20241103145153.105097-5-alexghiti@rivosinc.com>
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

Add description for the Zabha ISA extension which was ratified in April
2024.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff57..db062107823b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -178,6 +178,12 @@ properties:
             as ratified at commit 4a69197e5617 ("Update to ratified state") of
             riscv-svvptc.
 
+        - const: zabha
+          description: |
+            The Zabha extension for Byte and Halfword Atomic Memory Operations
+            as ratified at commit 49f49c842ff9 ("Update to Rafified state") of
+            riscv-zabha.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2


