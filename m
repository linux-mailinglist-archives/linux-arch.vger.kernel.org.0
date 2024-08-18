Return-Path: <linux-arch+bounces-6290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF2955B6E
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB55A1C209ED
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C810940;
	Sun, 18 Aug 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0kmnSv2S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A2168B7
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963191; cv=none; b=hN2ymiVIFBKMww8u49zGcdtrdnvaxHmNCDoP/wqm/u67YBflrfIjJCjevLNocjiRpxNPADBz/c78yCFoHPxCTQa1LfJ7CXPFZM6zYYN0nvpjqQhhVVoP3++7E6HWc3YuSC2M7nqJtGf29o25p2SPioVMhAnmMBXM5EDwPbedkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963191; c=relaxed/simple;
	bh=tnccALh8+1g50zeQtOru1Sy59cZzidIrCrT5x9+SPLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqMYxENN6veE08OVtdYjy4GWNCGjlyaWB7rTlkTfhi4FIWCOoWt8G1ZJsPv+LnO8iRm7XmKTi1h693zwYaTOAss7IqWDlEUfhyac47I07tyo2AUjocLM/WDvcCh6J2K2EsArMkzNJ0lDOWKdUvZAZNhI+D099lVjbIdZ4jxLQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0kmnSv2S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e3129851so25485705e9.3
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963188; x=1724567988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sYtVuKxVaNEjuRyviwIAJgcsawGj7aKXy8R1Bii4eU=;
        b=0kmnSv2SZcmYF2iOoSRbkaouWHjGCeErm5JXreyGbLty424rwqoLGX3pBvygilnniT
         IAmg6ClUZqGDF48BEkBxPSipnoSmKGXTt1ILJnZdqgeqdc7sC27etLnA7pMjd947O0FL
         1Tan+08wLS9mif7Oj+y/hnvbjm5jShSJFsGzkk8WW9uKSX4TVPpPh8rZdBdYUnNWaH41
         25o6/1g5BQv5hkTE/KBsIL1eFEXEQvYgS3yFjmtgyN4tXIHGG8ljcuhsrVlpu4GE6ieg
         iwM6FLTSZyPwdy3SCE1HAv6iM62FFpyCvrC6bi3Zuql7/z1JAi4DM6ggrqoEaNw3vHsr
         LPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963188; x=1724567988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sYtVuKxVaNEjuRyviwIAJgcsawGj7aKXy8R1Bii4eU=;
        b=sAcqAf1tDK2BdSHjvuqeLkax9kWd7xa5PkJ8qKz0f+/EGQVlqYEQ4Y5B/KZyN2IIKC
         YwLKwr1uxoswP7Nihugt32OPltuMQf9TJ1VSO7XRMB0bH1hHFh+zbdYiKXzuN/pdF9lj
         IAZsrKx629/gnPnZg84FPg83PEgc9qt/BDon/Sg5BaGDCfVzgQpl8L4oeO99HDK4jdzy
         KpSOVo6SlbY9+5k0hfQJ2oG2GiKJ/9A3L61zr6K6q0CEcZN6DPnmRvhZfKxo3uq4/eXx
         pbdAChEMqM2H63o26WcKt4GDBD23Toy28APjTkiy+tKad0exri/Y9aHBYPZnxMSnDf99
         lQFw==
X-Forwarded-Encrypted: i=1; AJvYcCXmTbLtdjTCeX4+iyUGFs4kYVJCY4jT93iCk/ci8RNxJUv0EwdtuKJR3rU4lWKUl8cFFpqe6h01kNAug1mapHFVgUlzJER2a6fDdw==
X-Gm-Message-State: AOJu0Yx00l4eWhwqMOqB4UPLWMTrD2ePfqLb+Y08QD6VmbPxrPXrau9b
	7cn08uMoUZF6GwoiPLFE5QU++Zfx4BNCVVrAo+oHFsbkieFCMp1DGuKrgdabJGs=
X-Google-Smtp-Source: AGHT+IGGAMdr2P1EdP5GWl4akDsUdOuePbLIYOG470k8Ym7dIUmRU5AiPcQ2o3G7Nw7Sy6NLXGgTQw==
X-Received: by 2002:a05:600c:3c9e:b0:427:98b4:624b with SMTP id 5b1f17b1804b1-429ed7e4314mr53197535e9.24.1723963187547;
        Sat, 17 Aug 2024 23:39:47 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed658e9esm66744295e9.27.2024.08.17.23.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:39:47 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 04/13] dt-bindings: riscv: Add Zabha ISA extension description
Date: Sun, 18 Aug 2024 08:35:29 +0200
Message-Id: <20240818063538.6651-5-alexghiti@rivosinc.com>
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

Add description for the Zabha ISA extension which was ratified in April
2024.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..a63578b95c4a 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,12 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
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


