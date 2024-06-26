Return-Path: <linux-arch+bounces-5142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DF9181CA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C191C21BFD
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5C186E5B;
	Wed, 26 Jun 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mtyO9Z1t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616218734A
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407157; cv=none; b=YYdAW1+oxr5s4c5hfm0MM1MpaW3e3gKVCZ3FlJDliWVbw/6n2K58QkY5x+B1IZysGNiWEoyKwCUrsvYhDNPKGiG5d8CINmBpaRCoDrIFX38w4vQiua5RHpW9Nxh81KmEuSXziIStAARUBcVoIthPn+uZHKrUkFMzPs6p7QJ+v3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407157; c=relaxed/simple;
	bh=tYSKztlvYXjqrUVGqUlFZcjNQFbhaN4iVt2oyZFJdVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeftZjVqv90iRGFabMd7V9TadAfweL4oiCjbW8mt2oGLvtlt0+XYSH1//fYnxgaLeAavQU55A0HIreh8AL3UHzINwleRCy+LfjW2hqJViNroE5VZ/wRmB1uOy5GARGugzplUMvbsVT2b5Jy+b/uENiXd2HQctRE+EXxv4T1wFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mtyO9Z1t; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ce01403f6so4004932e87.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407154; x=1720011954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=mtyO9Z1t2T1EDXVZGrkLqYk7i+oB2j+lt1paslYuCYQSOxDgHw9tyHRqJioDvVu2Gz
         WOdBvMxFFKqRUFfR16cLelrUHBo+4M+td7iSVAihK4oio/xdzUD77MLO2iH6FDxlTb26
         KkbpYcbT/swcrq7lRKtu/tvEnI02EfRAgxNVqAnGUrNxruGF+KtrfJrVZjrM2sEju08W
         gL5cEYc67ZBK4oDX8p0TsnBxSdNJkRZuq9R2sm1LOJs3UFUOyiA2a1HL//0/apUpyqiI
         6zAqFYXrgJQc4rdP+etFYDWv59wSqVm59zmpLnsMKvPUfGRfbIvjXr5+1lpwbC0eqlDC
         SO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407154; x=1720011954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=I2BEsjYfSKKKxjjyfsg2Dq/vKAbo7Kkcjq+8hfmPsQnhVu9xDvnXzX3ivRy4C8fOSF
         A5M5PHbYNc8UEXUQuXm9aoc60ryqmywG4e2c2CXp9LDc2QwHXfBrqPT2llZKjer5utDo
         2aqlS63IJcR5lZRTYXuwJEMeDeW9EjDn+lZQCAbEFq7HIgKmCiT3aL9fDbFpjjlq5CGW
         Yta8BsyfnGUhby1+VgBv99pUFGt9XafWmtFi/gr5i/SnbR/CEVErUks89Pgq3IHT1lnU
         4D5BQaYi2D/6h924ezEM4zSTSPPhkq/Qqtlrg0D+RYGGHiKPZVaB0/aerERe9PoPK93A
         qhKw==
X-Forwarded-Encrypted: i=1; AJvYcCXNQB+n+bJrUrwBiXIUEZa4nAi0oXteokFfwHMYoP92Zs5KCNKOcQ51Lq1KSRBS++XVD7+dETJZivUnbEChO1+kLup7C13HGJLVCA==
X-Gm-Message-State: AOJu0Yx9399It+dVUPoZUL9FqlLjiE9zRNTpqIRE+IazJphFyy+sDZYF
	MZzZ0/ZTu1u4e06Dc7p8TUVNC2sHsyQ+ZyL+bpQolXlEY0AlJwPpDTJSZwGvnjI=
X-Google-Smtp-Source: AGHT+IHX+jzGQgnJriZOGQ/oAJSCUkFR6oZJI+0k3ahW32MnlEUF+2I4ESnYZpAqS9088kQ4KTVI2w==
X-Received: by 2002:ac2:5f4e:0:b0:52c:e030:144e with SMTP id 2adb3069b0e04-52ce185ecd4mr6228931e87.47.1719407154179;
        Wed, 26 Jun 2024 06:05:54 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9bd0fsm15831149f8f.52.2024.06.26.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:53 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 02/10] dt-bindings: riscv: Add Zabha ISA extension description
Date: Wed, 26 Jun 2024 15:03:39 +0200
Message-Id: <20240626130347.520750-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
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
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..e6436260bdeb 100644
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


