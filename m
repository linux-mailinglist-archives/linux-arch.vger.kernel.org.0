Return-Path: <linux-arch+bounces-3407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD43897C2B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA2DB2860B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28490157A7B;
	Wed,  3 Apr 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mTG+xJHH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D180157A6E
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187703; cv=none; b=CYJmxj25uqgzsbVkzdTpFa8uAFOsyJEvv3xrCUCN017v/SvE3kHbbM8AluIC3reP7wiNYBJoASanms6I5R0nC1m1obgP3Hl8dBK6xCZ8KBjHD+9EZeEp1w3IoxTGb42pChxcRyPG1e6uc9h2xRv3h5U3DYep1gA6aOoOLGgmkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187703; c=relaxed/simple;
	bh=J89q9o6s6HqxbEZ6ljGjC0aJm6z4lMiWud5hMQgiuBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZslVpM1f6KNFqPFXTi0fL5fM/fEeolitIZIv75PIiv3GW5ie96x5xVjsF8cNRS6LddzfNOOfPj2YSu2qJCXtjQ2F4+9sLZUvNeK/fSgV8H4tlRVxyV5uB7HM26AEgBkO1HGpkKAfcrvMmPCxgIbUYzBna+Rxb12zpJU/WyNLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mTG+xJHH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dff837d674so3263725ad.3
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187701; x=1712792501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orqHimAqeIVvjnhm+Lh8YT/bDSQ5kt/uWL0O/MbcU4M=;
        b=mTG+xJHHkSNXluhuTNXNcLAt5ecDKHwA0gaXd7JrpPDne5+qSTWIVILo1n0KKQTz68
         Q03GKkaE55tLxNhpQtdk2ILD4s931BjN5AewwTG2sqF5y3UYbHzpo2I2Qs9AzCGWG0f3
         SJO4aj58OQTcYbny+4vw1CAKrUFKPCRQ738CKXXqdxa+9e8wapDULkVfxLZXjKRcWlzd
         GPx3TZy6+/0jtuUvedaKNVic8C7AJdU9XS56hU+/xgTIVvu8kiKqZmCkdWnYuCaP5g/7
         RY8R5F0X4xjnJrlsEX9hIHyZW3z3Fq+EeXG2x8Bs3usTqY9ym7jRQvILMrjhdiCzMcSX
         WSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187701; x=1712792501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orqHimAqeIVvjnhm+Lh8YT/bDSQ5kt/uWL0O/MbcU4M=;
        b=hp4KxQb/FEgZAlOfG2zHejvXir0Ptpdooo6l0AkRpjvytnu8bQoXYHdTr9gDaqpgwn
         DC65W4MxSqivAjfmptvF5ANFdjZgpJhFo5PfBMHD0mqa2OrumEPs6MLQ9JYHp6Juj11y
         Hu6QfOKxdNaHBbeeWgfYDT52d+pJS/zWTirTcbs5uztbEGc7W740o/wFaGaxbS7Uzl25
         Ffa7cTyxhXJnOT2aREcDrh+CTvmjFqhP+wBFi1unV+Uv+2of0UufIgSQ891dQInVsAKz
         I88vB6zPUg1lQQXtm2QZGamg3/CFInAXFb5bOi576rL9VECKv6BETf7zakaXT+DExQcT
         F69Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoAZ2BCX81nIatfMCyhk/4nWy+uzg9SFRzOx4tR+yzdHl19phBPHrN9/39OWmKBZPpmCX3yvyDkQGxZW1g4lCCtjEJeLjcf7cIhg==
X-Gm-Message-State: AOJu0YzznAIjHSMpOjH0sanHSLbI0DdcVNXjkiobct4U/DZZpjQbgGnd
	0F532LfrqqGjhw+QTQttZB27TPbEZxmGbUkGsmoHO0ZeuIqkqwd1UPH7FQr12t8=
X-Google-Smtp-Source: AGHT+IHS90cA+AgUmlXmCnhm/ecMbFJNWD0dZq3yi8zpTRzaElJ0z3lk+4PPNraXYIXlpU0z512YdA==
X-Received: by 2002:a17:902:d4d1:b0:1e2:8bce:b338 with SMTP id o17-20020a170902d4d100b001e28bceb338mr994151plg.5.1712187700925;
        Wed, 03 Apr 2024 16:41:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
Date: Wed,  3 Apr 2024 16:34:52 -0700
Message-ID: <20240403234054.2020347-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..45b87ad6cc1c 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -317,6 +317,16 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
+
+        - const: zicfiss
+          description:
+            The standard Zicfiss extension for enforcing backward edge control-flow
+            integrity in commit 3a20dc9 of riscv-cfi and is in publc review.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.43.2


