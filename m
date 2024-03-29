Return-Path: <linux-arch+bounces-3298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E08912D2
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553C61C23D5A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C423B1B2;
	Fri, 29 Mar 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hSHHA9Ke"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D83535D2
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687610; cv=none; b=IbHmM6YI+WJfTE8fhcNLt4+ujc/NOOkSyiNhOeDXbXeY6M6ifginGSQzueqOOpp50WOi/2FSDQVoUwgJnS6Xy4fPFHpEq7fN8vtCXwvjDvIPKsDzuT504IEyX9zWEuPit0SXGgrQPbKd/0CpUU9Fl6CNEzlUsCSIPepGTZ31fCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687610; c=relaxed/simple;
	bh=tp04Tian2VbAgQyGkrhWqNwzdHeK/WyQhUL89J1WvPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8xO//1fVZiNjtubOS6icE+FoRBDUg3HxZhzbRGL1adSAwFw+k8PfsHjyQHGMtZ6ETPUtN57ky7Vrq+OQ1anmCaF6w3uk7WnrwbvJ4DJLhmwfur/FMY8XEjpUpQvcNpbJ9L8/wLbDW1opiuWUuGvkn3RLJJcdav1d4phXkW22Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hSHHA9Ke; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1782392b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687606; x=1712292406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jzaUmiaVJT+7AndpgdFUVtlaA8dH1VTGpl1Yp0ZHRo=;
        b=hSHHA9Ke2WuQz9S+0ugebZaQHaPdXUt9olJ+rrReaptyxKFNAvhkZEjvUyjaCjfSTf
         Pa6C8KDgRKeT9OKuNFagB4AC3OaKbZvn+Y+RKGy81yCBkxCDu1b+ngLgQ4AQm6nC2X5P
         JUApcOcjXOedWZeyg5iGD2MNnzVcDnU5KbrtgH8r5uaGfbom0ARX5Bp0FIcLiVo221kD
         T2wYs9HymvMf9vQMzYzVPQjm/KlvunLoTCemqDpvgIYKQLz5E0IeJxMxkituXNKNRnkl
         0FzbWBftSF1BE/GNtT1P+Q3VLw7JrIJyD8dmmzOF+TsMc5CPERdXIF8FYcCycztqorHP
         cNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687606; x=1712292406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jzaUmiaVJT+7AndpgdFUVtlaA8dH1VTGpl1Yp0ZHRo=;
        b=VXjJ9zOFBiYVBiUo6ufUOC3xy8Eklrj4/xPwSfloVJBGNye7zGWt0BEHQp7rsNZ0mj
         G0tEkmTImNjY6PuQnb36HxSSqsEOfFLe4Jm0KRu7cL3ToUFRM2drItl3Jp+q/d5y+mmW
         3B2W0Kg9hZpxZhHkc6W6VbMYcE/AhBT3Pt1XUtwvHDvfB4JR2cyu5Lijoil/9xkTCWJj
         hhvBWQkou9p/Qp6ygWvT9+rcWMMQL3U1OW32y3pagmHQ909fSs7RQZZ6tOx582qLVqUJ
         Fa0MjCDf2131GFqcxgVNyDkhBjcGRyqjbOncZ3ydDgUR/P8VAfJN8xRXCf50bDhEFTkc
         4obg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+p56p8WxoD/kSQA+8F8NXSAfBJd67yTBho0zddrkYXGHK1fUlgxD9Gy+Ny6aLllkLyHe2RoJ9PCCP3LMnKPrh+xWVEdibF5xgQ==
X-Gm-Message-State: AOJu0YzCyuavtDDNmdyk2ICwhKmYm7myg6L+UX2M8zUdJF2Ytwix7Frx
	8Fpo0Hf1FjVcHVV4zFqt76vr1HPgt6s3AxyGQyroPI1cMY1VYHpZB5cwfxFOsdU=
X-Google-Smtp-Source: AGHT+IFw+iNT/fZ7ZDIngivJRJR8RkOVDCFWMSifsiSz96HEhcDTVYzJoolJ7eKeIz36X1Q6OzEzmg==
X-Received: by 2002:a05:6a20:8414:b0:1a5:6c7a:a60b with SMTP id c20-20020a056a20841400b001a56c7aa60bmr1845203pzd.11.1711687606505;
        Thu, 28 Mar 2024 21:46:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:46 -0700 (PDT)
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
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
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
Subject: [PATCH v2 19/27] riscv/kernel: update __show_regs to print shadow stack register
Date: Thu, 28 Mar 2024 21:44:51 -0700
Message-Id: <20240329044459.3990638-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 105ceb8880c1..97c812753c9c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -89,8 +89,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);
-- 
2.43.2


