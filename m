Return-Path: <linux-arch+bounces-3731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819898A6EFC
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27D41C229DB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55E12DD95;
	Tue, 16 Apr 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrpBiHO1"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734112FF96
	for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278981; cv=none; b=qA5+HOHkKlK4uMKnjpgAPao5Cz3vWpttYcBIvf5Fdlg8kmxr5s1C/7hXChIbUnEHFR+G1rnuehwQ4gg1Kar9BnRkyIztsaOE5XDzeCd3rlQRRXT5EsObUsixf27Ouhu+Psh4lCQAUpBKcUmyefWw9plSh2EcOsdA+8Luv3Ny7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278981; c=relaxed/simple;
	bh=7ARtCr6gtBIZWPixhMOKo/+c9HV56ed5oMvKe8ko6Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2TFyMrV6p6Ql/opKVo/vITxDrP8oXfI3NNjX/oN7QWq/QQMmjUveJI2Tydjsy2U3B0JrlvYcQBV/X+vvFJYGdqDIlaZ9kBFGVr+/NOIYceAkT5eXJHbtGVTk+n+3Mltdz6FKtbq+yIOlvEhd3wGg5q8Rgsfffh0GNmak6+RPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrpBiHO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713278979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kro/6N3hNJUz0mvlhxtTHwRpm8U0aOExj9xAbQAp3R0=;
	b=RrpBiHO1J9ueoJSFRY1JNYQkAQmKftHGnGlkKZAHe+j6pxRPKitgQhAS2ckgQA2bUd9ScV
	1KTx/+t5g3SZlpPec3/6CRIF6SqiFhf0YoIVH9dtTb71kSc9Lor06auzZqHhwDLIYFcFze
	lqmbnAynkzj7KgCbPm1Qfzq5Pu6xhUg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-F48Bfbb7NgShjBLlx_GDCQ-1; Tue,
 16 Apr 2024 10:49:35 -0400
X-MC-Unique: F48Bfbb7NgShjBLlx_GDCQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860931C4C3A0;
	Tue, 16 Apr 2024 14:49:34 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9847492BD4;
	Tue, 16 Apr 2024 14:49:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	llvm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1] LoongArch/tlb: fix "error: parameter 'ptep' set but not used" due to __tlb_remove_tlb_entry()
Date: Tue, 16 Apr 2024 16:49:26 +0200
Message-ID: <20240416144926.599101-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

With LLVM=1 and W=1 we get:

  ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
  but not used [-Werror,-Wunused-but-set-parameter]

We fixed a similar issue via Arnd in the introducing commit, missed the
loongarch variant. Turns out, there is no need for loongarch to have a
custom variant, so let's just drop it and rely on the asm-generic one.

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Closes: https://lkml.kernel.org/r/CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com
Fixes: 4d5bf0b6183f ("mm/mmu_gather: add tlb_remove_tlb_entries()")
Tested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/loongarch/include/asm/tlb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
index da7a3b5b9374a..e071f5e9e8580 100644
--- a/arch/loongarch/include/asm/tlb.h
+++ b/arch/loongarch/include/asm/tlb.h
@@ -132,8 +132,6 @@ static __always_inline void invtlb_all(u32 op, u32 info, u64 addr)
 		);
 }
 
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
 static void tlb_flush(struct mmu_gather *tlb);
 
 #define tlb_flush tlb_flush
-- 
2.44.0


