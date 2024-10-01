Return-Path: <linux-arch+bounces-7547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2598C2DA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5860E1F24881
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9E1D048D;
	Tue,  1 Oct 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zo0Dyvun"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE71D042A
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798886; cv=none; b=Aj1VY4FjVLRB8oN1NNGtzZiq4+ZwqZoq9zANtuNJfj0yewW9gdfgNdJW7XhBFcvqxGIBa6FRaU1Ep63nOU8hoUUmvroQ1SPrw5NYBEiTHKp9/Z1l9nYFfHp5b6e336Iav26eQm6S1vBu8CarMGKACJtqrIlUQ7RysX0zD0sJ1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798886; c=relaxed/simple;
	bh=vUZ7rOUMw9RDAZdbqhr8Hsm+T/749V5V2ULrkIJqqRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKIWFXenkOuzkwSRYfS4+TigMsDq1F8Yk+mPR+lsP61awaKLqWa1lCzJt3XtSZYoImS0usLDF12xF6lYTuJHTOv+ENUKcEnG4bYzluNcuRG/xHOokcUXw4PjbhC8WmA+Vu1qWDq3Uw4D3fH+6o4bWZNL7TznvoMKj51+TbMj+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zo0Dyvun; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e07ad50a03so4286157a91.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798884; x=1728403684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDZ6InrT+eerMmZ4qSLMUgeWEoIog/HDXgAiPQQVAR8=;
        b=zo0Dyvunbgpr1AgqbAAXAOBmlNW8fp1W03d/EwtS/ZCjcNwunn6qlCNTjcdTKUoKL3
         O6wNk/MAj3/odt3/GcTW3FJz8DnRF/mt+/EzmGg5n7YgxKFQ8mcS1HKifbtScTfIl8ib
         1uoWlgfsrnCwh1yP54e8p5awnapvewumCeGiLq8aPtWOWRfcXcJKBi68o3avbBIU9OQ5
         VrzSq2+Rs4lKKuTVgXwW4PTlsUD+1pVI7bVN2TmUA4APFrEOzucLKzp1mZ5o6SQLHJ+i
         MJPCITiRSDm5zJRrtg2iX3b3bfEHu+TmsAk4O1KCazUBrERqtMTd+5iKEdSf+o+j1+S6
         T53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798884; x=1728403684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDZ6InrT+eerMmZ4qSLMUgeWEoIog/HDXgAiPQQVAR8=;
        b=KhBGT7zR9cghEIYI4Dnai3Bzyq+csHjsUS6HyLZsL8nyUuSSSHC0STTP47gYNDKoEj
         Xlc5ySZYNExyOv0OV3cffxqib/7JlFNk+xb76GjyKeYFF6r1O311xx8gwNoxZgqx1KIY
         //i7SiSrByBuYXh72rajM9su3tnSOYNU1LXKVhONPGWVn6WYdU3ZTxe9FuJdOYazb32J
         fagwD53Iq3GukL/Oh1M7oi3JXIXLxglo8gZL9Wb8Fn9m3vAeBKyZjNnwUihhsdrfqV12
         KafFXvCf7p4aHuKtY3VDj8rjGTeP83x2PG+sYqbLRyGb2t2phtnls4RXe9HcoLFF5Q7O
         bngg==
X-Forwarded-Encrypted: i=1; AJvYcCWsVyJ5NYPeBldyStpbc6K9KUGoNTAynco/UgkBPQtuLtpaB48+YjrMGxevFVY/NKWMiekD6rx8/2cl@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKgRpm+NglScAU0U6DWBUZvVSvV99cv5yyzkAf/RrvDh9phcW
	W/JLcJB1334LvDVx161WzKf/EMF+/ZFg9iCyrTjmFNOjzyFfSNQ/WSeLclY01pg=
X-Google-Smtp-Source: AGHT+IHXYXQ1OwFDd1dtv/2VxG8PWP7+nvRdzMjo+9YOaXZGTPtIIOVqtoUXrRFuXQYTqOg0fWXwSg==
X-Received: by 2002:a17:90a:4607:b0:2e0:8bf4:f298 with SMTP id 98e67ed59e1d1-2e182cb9256mr279683a91.0.1727798884295;
        Tue, 01 Oct 2024 09:08:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:08:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:29 -0700
Subject: [PATCH 24/33] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-24-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 5207f018415c..6db0fde3701e 100644
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
2.45.0


