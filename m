Return-Path: <linux-arch+bounces-3319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE5891437
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548401C20ABA
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C152F7D;
	Fri, 29 Mar 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EG0ST0Mz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9B405CD
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697102; cv=none; b=BPDoozzPV43gj2VP9gJInWdNwM0lYqr/Khk3XQGyIjZsJrPeVj7geJRk4t3roHnBdVrASUJa1QPyaPqX63EXA3xHPiXqll7mXxhhsyJtcNZOQ4eUTwcnJMgpanz5zUKfSGjZR33KTTDyVUtgzbrlBQdwMXnvVEV8aF8RrnXmFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697102; c=relaxed/simple;
	bh=dD+iV8uD7G5MpjHgE1LVjx/5PSgKP1NpMjf5jkr/+qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9w02LF/DEoe4misaSe/yGd/VlkQcABtMsjSn9wqCSpwJ7QJJVlEKKPc2yecLKULk4IemEpmQPGjOC1GfgBcVrOHT+NxSDBIxmghsyBhizdb+yyiAlt+4MSSn5rbQ7oPFj0XxfuPCWyzjNDDFxUMVhzCW9tFkDRtz+X2wIp06G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EG0ST0Mz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1168064a12.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697100; x=1712301900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
        b=EG0ST0MzUSqGXWbSEr4O8g/gowltE2/hVPIPCASKrGA0l0afnWGkRfC5kViba1VwzJ
         wpezGDlK+KuklUaNYQzNW7jt24ytT9h6/JaCR8MIGsXmRQUI20TQdGyWlH7/KkTvIkBM
         UqG2UbH2M0Jv/00Zq4eN1/30ooHPhi8yPZGYP4sPP8DisyhjmIuoOsZK/cnxdJPg+yoH
         O9QHa8OnlyzlAURSspe8ltqxGcjD9xJ7EMsSgiuHGoEv8BYjGSIB5xI/DtAnOEICZcOJ
         jmZuUJMuABz6oyMni4RR30iGGYhwx89LylETSTx/4oRaoMdvqW4uqV0UG1Aj6vWSaVRz
         DjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697100; x=1712301900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
        b=QDh5jYxpfDBctiaq35XJKgCfG4GZpSq7ap1X+owJFo1brZ+XsfQuwtdDcc4XTsv1pk
         p/++gvV3fWuWB7oE42L5U/nj4YX3Ad+XLWxe1T8CVGEpnRQ++vklm0CiHHhkivPq2nWo
         tndFfnbupYQFOwUFpj4k8u6XpvLwDDD0gycciI7KIWMkzF9bxrCLudaUDfK8NlGKuh9L
         iABf2rZQui/AlRftOA3hy+nE/fqVm2zFWr+LhUtcIQXwfNocOJTO+/vcy88FVqTUrvqz
         3dtCx4Hfvha5gADDu6r+rj5624PHEuMfnmXV+MkdVJe5v8wxZxacGR9RffzKGis/9+CK
         00XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFJgzFtZCzwhMsuCzt3jaq0Z0Rr8T1rVJlb++EXDMoz96L1Bw8bB4w8GTMJ/sKJtDYYx4sNAOM3iNZswrwPdwbyfVOIN2naFnH1g==
X-Gm-Message-State: AOJu0Yx4ac0mWOskTJPZHeRvj5Y4bBGzo+IvJ1jEgTLfCb8o5w09in1p
	r6+uOLXFRuizWkYgUEBLBDbvfhRWNSuqZSfW0p8u7kS8PDMrIMqD3D2xWhqoKGM=
X-Google-Smtp-Source: AGHT+IEs8kBZu3dBChnRywCF22OnC9/Ej+znSx9gblpEFd+wsOZOeprciOlW3fwk28PpRrFgoWrM2Q==
X-Received: by 2002:a17:90a:d3c3:b0:29e:975:3500 with SMTP id d3-20020a17090ad3c300b0029e09753500mr1446912pjw.28.1711697100232;
        Fri, 29 Mar 2024 00:25:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:59 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 09/15] x86/fpu: Fix asm/fpu/types.h include guard
Date: Fri, 29 Mar 2024 00:18:24 -0700
Message-ID: <20240329072441.591471-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include guard should match the filename, or it will conflict with
the newly-added asm/fpu.h.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/x86/include/asm/fpu/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ace9aa3b78a3..eb17f31b06d2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -2,8 +2,8 @@
 /*
  * FPU data structures:
  */
-#ifndef _ASM_X86_FPU_H
-#define _ASM_X86_FPU_H
+#ifndef _ASM_X86_FPU_TYPES_H
+#define _ASM_X86_FPU_TYPES_H
 
 #include <asm/page_types.h>
 
@@ -596,4 +596,4 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
 
-#endif /* _ASM_X86_FPU_H */
+#endif /* _ASM_X86_FPU_TYPES_H */
-- 
2.44.0


