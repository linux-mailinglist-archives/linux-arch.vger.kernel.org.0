Return-Path: <linux-arch+bounces-7274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B9977552
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 01:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B91E1C24243
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16B1D175B;
	Thu, 12 Sep 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v/twBUNw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006F1D1725
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183124; cv=none; b=O+DJJM4cWBGSs3L8DmmO36p0vMjr0fOsRS2cT1dTFPnG9opylWLC8WStF6eTs4fSU2sl0K8umTWLAKdZfKgusC+mvuRKUJ2jGxFj5KZ4vw9WtHdfKJGE69wyzh8r/XY2oLEoDCcXy2lQOkyTV/k50f7Iywc3CXMfhUENdxg2dhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183124; c=relaxed/simple;
	bh=uirmiXIIcpcwdYjmCxMSJluO3Rk3ctjv/oUXjeM+7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkMQQnEverRbH4jkPHGR4Sm4xg3YUD1KLoUylvx9r+PWrGHlaypxtO2MC4gBgayr3SSwrpivfAPIUvUbcTBuhc4IQwk1l66c2GGh2LqOirAQuJVI9wNGoW8heAfDK1ItdgjRP3PUAYxfVSG7uHBo/p5oT0RQhEwrlUnPnm2+/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v/twBUNw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso1114999a91.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183122; x=1726787922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+38J+w59/fsg+wZPwkpHjWKQt6YBaFGJt3wtFmX9cIM=;
        b=v/twBUNwaL/AtzowBUzfbEQonL6jaLqmYTosfwa2sYoQIWMxbLXBfBsdz7RMxiMchY
         4eSvZ7VvUpj+Zo08EKQVtkRzIPQQOM3rIosWCNUOUU9EG/lmawhYuP/PGnnZyQC6MDDU
         y3UyW99bhtHNkIHDh6Cqk7lv5Z2VQIuwptXuRYMVoxd1+hCr+Qbg/ocH3vsbfVeaDagQ
         nUx8jV79yltAwnzOY5R1/4xts3T40VwwuZ6XpXAQS8ZGPRBCSpC2/KzmHyx8MhImS7nE
         3hbXH4YxtBJUBC5MRyH2KLO+U9NNTQe7A/e+wbk6gzpk9dCEfu08DS5zWMsEROdhhNKp
         MvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183122; x=1726787922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+38J+w59/fsg+wZPwkpHjWKQt6YBaFGJt3wtFmX9cIM=;
        b=O6rZs+nXV0OOMSfmbdykt/syoQmFXCwvRcQhZrgB3jdlxrG4NwTZcVGdAmUY5i4+D9
         0Zw1rZsBrxYLykRkYXJME7+/t43788u2GKcDwWs2eUUVbDE/upr14K5oP4sBp+FV5/So
         INxmIWKaoXcdKk4AA6EXySwchGm38IQORtg9TupO3KS2A9nzybvQQHV2LQ55mYCNmMpV
         VOOMuAKaudVpEFfgrhCnwRqJjaepsa7DjYyR1Ra1DtFH78vOf3vBS6HjLHY5QAHFEMPR
         V1FGx1UWdLDCIsJbSt5dYr9V+Bfn/JuGZwfl6K5FZy8R/a7ZejrbbbUGJas7TCdzKQzn
         nuyg==
X-Forwarded-Encrypted: i=1; AJvYcCUeeVmW426AcTz1++Xo2198bzxu4hUpz536bp/Ry3U1jGTjXLFvsQyjG5nEwL7mr5+9VoBZE0cI66kx@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZUDEPtcBJqsnHcQqw6tDqqSehE7KwxVVQVRbQw4ABZO34/1J
	DgUQGJV0PXVGfJhlJCbQNNPH+7H8rV15vXT9FY3PCL67hPDTv9HKeyJnYmqdMdg=
X-Google-Smtp-Source: AGHT+IHfT/S6FiX6u36xFuQAdjiVXSnBTlg8zgoeNqcnzuIIMjt0legeBCv+aVmkm3X/I1OJo91O6Q==
X-Received: by 2002:a17:90a:4b44:b0:2da:9115:15ce with SMTP id 98e67ed59e1d1-2db9ff94036mr4324100a91.15.1726183122337;
        Thu, 12 Sep 2024 16:18:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:18:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 22/30] riscv sigcontext: cfi state struct definition for sigcontext
Date: Thu, 12 Sep 2024 16:16:41 -0700
Message-ID: <20240912231650.3740732-23-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shadow stack needs to be saved and restored on signal delivery and signal
return.

sigcontext embedded in ucontext is extendible. Defining cfi state in there
which can be used to save cfi state before signal delivery and restore
cfi state on sigreturn

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/sigcontext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index cd4f175dc837..c4d19a10651d 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -21,6 +21,9 @@ struct __sc_riscv_v_state {
 	struct __riscv_v_ext_state v_state;
 } __attribute__((aligned(16)));
 
+struct __sc_riscv_cfi_state {
+	unsigned long ss_ptr;	/* shadow stack pointer */
+};
 /*
  * Signal context structure
  *
-- 
2.45.0


