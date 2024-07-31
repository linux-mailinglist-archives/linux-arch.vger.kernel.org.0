Return-Path: <linux-arch+bounces-5755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E9942823
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51A628435A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799261A7F78;
	Wed, 31 Jul 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kIF3nudI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17621A7216
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411386; cv=none; b=svme3iVnaZDjD4tJvYPpNqR5HC0UyT/PA6UTkSioiBYTTptKAiWqsBUu1uFan8i6G4y5MH17B2Te2SeGXW0EXUj1Z+/NPRMU2UNwcs9AlNM59KKMoS5y8i09BbB0RqLKYLxi+h0lDtzzphEGL+r+ByWw/Lr39jZu2zYarxZDL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411386; c=relaxed/simple;
	bh=0epfWlqEKIrTUoCSMykfoCNPqNc62wspUCzRCxIl0GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXnddLrHEO2YPt7gS97rJp8UKNiJTT0hxJlabHOmdA2cZCBYTi+kzlwSFigcqtY7KkQfObZckf5mKddLc+gsC+i3EIHErFAsvh2/9Opp3dDlPAUnHiMzM8EIWFWIoJkeGuxxKJnswEdW+nJKrfRWP7rakrP1gQ3EnssnIE23oEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kIF3nudI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso32260885e9.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411383; x=1723016183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StkHQugPFKmcMlCdkJBjlWwaxWZu+axwFXxjxfJ46xI=;
        b=kIF3nudIdUZQL0iIhd2fJgL9YuWtarDBdrRqo/tgOaqEnhQgpWS6JA4DYtuWcjBnbX
         4Yo64/b2dmALZvTaiITaK4NfjnfUPR8p7z0n1UriNkaOnJk3hUhoGufkmU2NRs52row8
         njQ/kRJhn0IV6msneeVwsTdAy4dxtj5rE/IxzsyuQ6+pKcYyEr/1bv/R/GRzWSHiT9vN
         jGpz1yCaG7TrWWt/aFDhHTL+XJpYgGYS2687UOttok7c/0QS4NyObHVk0nN1OTTA6Je4
         WwGLqn082/t35VDjvCr2nIjLweseY4WMZalOXgMD1T85YKNo2T3/nxcBB/G1qx6D1ues
         lrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411383; x=1723016183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StkHQugPFKmcMlCdkJBjlWwaxWZu+axwFXxjxfJ46xI=;
        b=cNRI3PtLQwJWgmbrtTXlHBvdF02HtmJJM+RRq9eDuBv/et7vIWX/091ByO5h0MOOJW
         dgh/yq+eKGumw5Q+GVE6B1505h0jKxXDPODlB8NCA2lx7gfyc3Dh+H1XPQME8YGi2KQN
         wEYF8BeBb2kwKZPs8/cdDsbsDLnifVqET2CZJchX5xQQvZJyirm8bYfJhcq1E5Y0HldF
         84V+D/6F/pyG8Xr9EGw8M9eFdjDmS2m9gvZsw1srUAsSNMhv9PNhWj0F35GfLJUOt7rY
         gP6YhGQNeu1wvud3kG+WMpVBzQfjpOnz76gvOVtnXdEcy2+zv8hPh2UuEInpa1ZheqsM
         fmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHk4x+dqbm7bznwCcl3yVsdVBLbl5CpVCi/QyBvO0MAvFnVpy7V72PfCdXGtbXIeO12EZlHFMCfh1L2gtzGVeWs/9HVVBD0V+5bg==
X-Gm-Message-State: AOJu0YwUC+LtXW4Xe3pI90uuAMNgNZypRAAHdU5h6vSTN75QOo9UQyL6
	ndLoFRrcwSh1vpS4kKkZkInGdTA4q1PJqOXOXgGEfG65Z3dtro8eN/PPRHJCG8A=
X-Google-Smtp-Source: AGHT+IEiU0CaFWiD1hh70+ka7aQVmGlrhYH1/rnpyVPMCyVRk32YX0EEddiK4g7ZX2FGkW4AWaXtCw==
X-Received: by 2002:a05:600c:45cb:b0:428:1007:6068 with SMTP id 5b1f17b1804b1-42811e0b70amr100189195e9.34.1722411383067;
        Wed, 31 Jul 2024 00:36:23 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fce64sm16325946f8f.61.2024.07.31.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:36:22 -0700 (PDT)
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
Subject: [PATCH v4 12/13] dt-bindings: riscv: Add Ziccrse ISA extension description
Date: Wed, 31 Jul 2024 09:24:04 +0200
Message-Id: <20240731072405.197046-13-alexghiti@rivosinc.com>
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

Add description for the Ziccrse ISA extension which was introduced in
the riscv profiles specification v0.9.2.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63578b95c4a..22824dd30175 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -289,6 +289,12 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: ziccrse
+          description:
+            The standard Ziccrse extension which provides forward progress
+            guarantee on LR/SC sequences, as introduced in the riscv profiles
+            specification v0.9.2.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.39.2


