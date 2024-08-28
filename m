Return-Path: <linux-arch+bounces-6690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E944961E8A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B03B2328E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853E15852F;
	Wed, 28 Aug 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SdEfP3uD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288115820F
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824185; cv=none; b=C/bb/fvjuVjSAF/fjYrq6AJeeq5IMsVDnaGjg2vCcvdPEOvjQMAujU9rZZFDINqrQw6QdcJloEnFKK7wIIyHfcw1maNJkqyl4el8WnvSlhXBos0TYC5GlaRV+o80Pkq5GEyevBjiqe+B7VlP+bOWmjRsM3fjAfgpwMLQYcCzNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824185; c=relaxed/simple;
	bh=h9Jl0isly8hfO1RunVOJNqZoeZvdanuDoXET0lufwJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GudwoIWDtRfZgRui6WcdkH0qXLw6yik4g6LV4LknxRsG3+JMS2ARQ9mW6RzPEpbYAny1spgSygD5EsJHk1UTdO5BOwV/qW5tcGLecS/09bRlYkL5b3jpk9Sguc/3XOeHm1r6aCK1XgVw/aJcKn7OW6Pu5zWFIk4Zq0aYq3YYdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SdEfP3uD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201f7fb09f6so54511065ad.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824183; x=1725428983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5srBcKEXlmg65Adrhp9lVjL7ktMhhBJWYWob6ko31g=;
        b=SdEfP3uD3zsNjVEX1Pvh5I+ZIZUakaUIzBEKiPkmhSm3NWP3i48Vox5K7/qd4G01Zj
         nedYNM/PePwBL11dBTmfx/BT9cUcK9iCb5WYgSxijzDNQ/wte+Cx8MIKUPgWNj35qJra
         k3hb+Bqtg9fCrGUwcGaty3kxVFvcjVS1+lB6ZMxDqQFELzeakNjL2v/2rFYfNRBr77gW
         Yh9/ieECY6bcTGEqt96y1TkpVRGOx/0vwR1ookdlxbE5E0aPJUWvhWhORs8dHuRFzyjx
         rsTcxqhrvJyNhMvOaszQfngUQKGCMA0BbU15eU8LRqbQkYC0ThnobpJAEHjgQbH3xH39
         YBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824183; x=1725428983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5srBcKEXlmg65Adrhp9lVjL7ktMhhBJWYWob6ko31g=;
        b=lSvaijEgpAxnMfw0roopmygcnvJp/fQIFUepD4I5eFMnqBKS60hk2o61i420fzqT47
         O0pqHhC7IfW1LSESPDqqO4o5XmwDJ1hGJcBm52z+Gt7nAK9cFBBtEagaeoL5TIx6g3qM
         y21bn38nVCI3YTk6Hjl30XfWv+1fn9sirTiNrtYAhC2V1D+a8zSxVSmqx23MInl/QaYJ
         +zpTNOOk99PFMFO7SadPfe0F6PuafPu597GnSNfc69jE9Fymi7TVv4k0nA1ip8mDTdXs
         1YSv9IdwK3PdvFK8uP3yiVxCfpUgU/Wst8DJegv+mF+hnce965qvl3ESp3/UT04G2+w2
         lm8Q==
X-Gm-Message-State: AOJu0Yy6dnwIsEfDu7/dKnSyB852GW7bWhjn/Z6vQtJQ/gy5k8I2ruA9
	p+Ppv30lZVy8uXh/2K7AD91RlpPz5SWHZQr+VQoDzrHRfSXONqDXUbHX1ednOeQ=
X-Google-Smtp-Source: AGHT+IGHu+eM9GywkA2KKhkiXH1gwQVKDtYtrmu0o3xp962KqVz7yKVZ3UFfIj7ogPOJug6LrKMhnQ==
X-Received: by 2002:a17:902:e54c:b0:1fb:3474:9500 with SMTP id d9443c01a7336-2039e4ab846mr148619915ad.27.1724824183237;
        Tue, 27 Aug 2024 22:49:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:11 -0700
Subject: [PATCH 05/16] riscv: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-5-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=h9Jl0isly8hfO1RunVOJNqZoeZvdanuDoXET0lufwJg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XXFHufOLGl2Wf1oQkLR82ZWndTOfPt314eCzeyv3r
 BZKWtO7oKOUhUGMg0FWTJGF51oDc+sd/bKjomUTYOawMoEMYeDiFICJNPxjZOjefGX9Tl/G6Irp
 nxS+dN0zOpEeMVEk78LzG1JnNgQw8RYzMpwwaro+TU52Snefw54npdeqTGoNrXMnik1KMY5Wjl7
 KxwgA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When adding support for MAP_BELOW_HINT, the riscv implementation becomes
identical to the default implementation, so arch_get_mmap_base() and
arch_get_mmap_end() can be removed.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 7ff559bf46f2..20b4ba7d32be 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,16 +14,6 @@
 
 #include <asm/ptrace.h>
 
-#define arch_get_mmap_end(addr, len, flags)			\
-({								\
-	STACK_TOP_MAX;						\
-})
-
-#define arch_get_mmap_base(addr, len, base, flags)		\
-({								\
-	base;							\
-})
-
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64

-- 
2.45.0


