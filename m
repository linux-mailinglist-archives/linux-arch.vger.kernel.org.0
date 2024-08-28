Return-Path: <linux-arch+bounces-6698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC00961ECA
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6D11F25083
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164715B55D;
	Wed, 28 Aug 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WOUEfXng"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2C15B97B
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824212; cv=none; b=KkByNcntCAslg4jBnA5f6n9CO7mz0bRl7TO/F3JQnVLj8iulGrd0rOj/tVql0OaxxD5nN2R2S2nUMsIIu9ePp4FvfJ0zNZkVrve4fwsQhT+pM5JslMK2srTZNdckidyXUqBoOuAZgJYYXLc168Nz/fmf/zl6D5ABTN4KBCxCrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824212; c=relaxed/simple;
	bh=LDlOb3puh00G9LsastMFHCdP3tuzGW5CWMac22J4/f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7b+3KxHajyhdrojkocHcxgy9LdFVxo2Jlbzrkk5sg+CeRv87I5rF568MXUj/AkLyem9rZbLVGTWdgC8wTwqKl/JlbLKjSjIJ5q22JA4LgUIqYD8eJvoTtOpazgXkCCbDlnhlR6I2+1i6HTqL1EE+hBXKwqZeYUB6DZp+5tEUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WOUEfXng; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so3982704a12.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824211; x=1725429011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AarzQWw7jN5pNetRW1c1iMmZVGfhSNhFxAvdf8X4j7o=;
        b=WOUEfXngpjQ87wuOKKNoWVcSr0ck/IjM1p/QVhgggmTQtsSfLD35lLHQTr7aopno83
         tA430b/vzZMEmQEkDQECZ7audo+xxtt1G/yRKW5h+7VxAyICk8YlWqsjPmS1lJKL7NHy
         /uarLE1WvsohbnJe+k9OIpWTZOlpNKnnNIR2Qj3Te8mlYRCyVE4ftY0KbJWLtoq1XSEA
         UyyH45C5FAuB37iz/HbrArCjs/Y3OnAtF0GaCTNJOu5aXqJz41SqzaWdwjCY9c+JRMiG
         tuL3/8ER4PHR0YOj4AVA0mFcOauL3v1lz7da+c/FF8PvW2bVmvXu/hCjcQSp1tl/OJ0b
         MEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824211; x=1725429011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AarzQWw7jN5pNetRW1c1iMmZVGfhSNhFxAvdf8X4j7o=;
        b=wV8ZqA3tEJvy81O2zptz5KEVYAkm7l4U6ibD+BM74kkesEzScwIJKFket+ZscICCTq
         h/Faok1PoKP7QDLmDGPudvUT8jK/H1AiA3AAKUr9ovN02YnUrl6HRHgAwDw+aF6/83JL
         EYMFIlRE9y5t86OdV6KosfMYFBLKlqzT1VfbKVlEaHlGhEfO5DBF737FHS54+FxKpgCw
         53Nij2UmkqgKkho5tcas8b9oKIjGE+fVT/oK/ukWBNXqdz9IZS6pJeKirxSi1gWfdyVA
         f4tTW8RiK/qe3w/uTu/sos5BSwv4ScGQiVE/Y94wZYTCaS5Y2OCJQIXnpMIf3/bOf1Sh
         7qow==
X-Gm-Message-State: AOJu0YxB+aNuVJeTMzz/HGF9OnqaxFJ0lk6BwFCecJUB8JerZu3Ekjzw
	N0PIgovRpAKKyZ16wCGwOGEBTmT2U4XQGNBfzc0BWKXPIKunVqB94fHSB6yCHd0OPB+tH6bRagj
	R
X-Google-Smtp-Source: AGHT+IGSDxOLe5G0EzaI75j/pi3mF3L/KyOur/N+gUKJdt7aHyrcvZDzyi6uPsaAVyWSE2f/rnhW5w==
X-Received: by 2002:a05:6a21:2d8f:b0:1cc:cdb6:c11a with SMTP id adf61e73a8af0-1cccdb6c913mr2470861637.24.1724824210534;
        Tue, 27 Aug 2024 22:50:10 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:50:09 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:19 -0700
Subject: [PATCH 13/16] s390: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-13-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=LDlOb3puh00G9LsastMFHCdP3tuzGW5CWMac22J4/f0=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XQkTzp+9JuBqJbUp4CZHz86P7jsl/+dUPtx28/aiw
 uJ/F77s7ShlYRDjYJAVU2ThudbA3HpHv+yoaNkEmDmsTCBDGLg4BWAilewM/zPyq60vOxt27XXL
 PhSUqxi9dMWuaSXlSf4nvq4JmxBdu5+RYfa1r9wzZq5YzaDtGr2m541pUMtOl1Xnuf/rbZGaqVf
 Eyg0A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to addr
when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/s390/mm/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 206756946589..29e20351ca85 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -105,6 +105,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
 	info.align_mask = get_align_mask(filp, flags);
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -143,6 +145,12 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
+	if (flags & MAP_BELOW_HINT)
+		/*
+		 * Subtract (STACK_TOP - mm->mmap_base) to get random
+		 * offset defined in mmap_base() in mm/util.c
+		 */
+		info.high_limit = MIN(info.high_limit, addr + len) - (STACK_TOP - mm->mmap_base);
 	info.align_mask = get_align_mask(filp, flags);
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -158,6 +166,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
 		info.high_limit = TASK_SIZE;
+		if (flags & MAP_BELOW_HINT)
+			info.high_limit = MIN(TASK_SIZE, addr + len);
 		addr = vm_unmapped_area(&info);
 		if (offset_in_page(addr))
 			return addr;

-- 
2.45.0


