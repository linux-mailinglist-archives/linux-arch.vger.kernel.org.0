Return-Path: <linux-arch+bounces-11248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D33A7A84C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C64E1894651
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF5253350;
	Thu,  3 Apr 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvc3WPSL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94552253323
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699442; cv=none; b=tyGmP0fS8SmdS2HJYF6D/uk08SyMdtIRPYk/PEvlYPnzKXpdWtN+wJxrERe93VnEhct+bmPBsyQyAiwQeUzQrCS45ZaOhuQE3whd0V583WqArcQw9ZJGPnbAosMAZUwOd6oYIhYQCPsXEbBqSO1cMW4lj+5TGz5TjfsMUd8Bjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699442; c=relaxed/simple;
	bh=1GBMY/blDMm/pZBEDDJ7pMxBepJY1ykTDsdud2Ofj2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=psDJrJXt8ZO64rax3V4OFogjmE6ST78i5WvDGzPWod3pt9cYd8dQyPNMFsw68qimTPL1V6Yr1GUfJvvNQYyrNHvUVptXl6RZ3JGhqmwbJylgDK3Qxg+bkf4NrVaGwCNNVGrQg+0TQXHbwiKdPaIIkqkhDUyEygjdCYca8ADU0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvc3WPSL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso1085770a91.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699438; x=1744304238; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNHCeBq+kt/FIoDgbEk42F0HhswOr1VLdQ14FXQaWQs=;
        b=yvc3WPSL11RWLmG4EvleEX73gnbfC5u/aeOF1Dz7frXMQqQ36cKW8UD8MMzJKUIkhS
         7ydB4D28QJ+r6RgOlgHZelz5/KrEURSnpbjE5pPfomPBjHsQhGDMRI+qboaQJKlGohMo
         tvEKgEUyEW1Y1fXbRRoDFHceYS7Tp5WTiK1mxfgB8TxE4dcZUTi9qBSQv6OLXh+VAztZ
         medFK4CIz0QAAJgcfOs6ZkbaMQQtlGNQ0SMr2lMQ1SyCm/onySe7ifE07GRf6nSoujGL
         fg5nJUbPhElSlcugRCl0jU+UendNjeU0SJzbE53czloue6w6RP/bDEH8QyoyQEwSJrIY
         thQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699438; x=1744304238;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNHCeBq+kt/FIoDgbEk42F0HhswOr1VLdQ14FXQaWQs=;
        b=QlgPoPOkXH5qEb6XHctTTL1NWN0DtX6E+/yVEFGJpwkMP58KKetFbt8tG+IGtHh4cd
         iLdalXBSuUCZFh9V2zY3yLwmDALsbJZ3Q6XHeEKQMqAU4f+QuKQ0h1s33UWkpGMWprmN
         PGQbPbVHvJm40+NksZAGksgGhQh/cIgbIBixKzmemLjQtR/l6IiiyXhINFlImbpZToKl
         lKm9DildOsIVr4KymOBsWfw/xi5sCMUzjex3b3FJaCzMWL2ALw4Pptw0zdN4myvC2MJW
         axsD7c6EtY1O5ujaI98yXwSOcGlCWd99mKgJDdgML4jmYf9ApotVoIMvdn3W6SVhvxPO
         0ZOA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0K5wBllFrSECcSgoll9SSSt6BT3vroQX2BnwNC856e34HcEEmLoPsjWVs7MXGWqXW6tpHlTkryTv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KZyLZxXmod2sYyzcQPOPKNN+TnPlt56CHc2PaEuamX4jbcXe
	3ysrkHZaKJik6TMpw6DHkpuKmqt1nV7OLEj1kZZFyBQK+ZD7Wv8jiWbL1TCjtgiTK0zppOlqdis
	pZpiCuQ==
X-Google-Smtp-Source: AGHT+IHwAF9KgN3kBG96nyN/c70dCrvtSADqCvq2NC2KDP9UQWERHeR8jrgnBfjzks/VkiX6BY+HKFC/mvhS
X-Received: from pjbpb6.prod.google.com ([2002:a17:90b:3c06:b0:2ff:5344:b54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:574d:b0:2ef:67c2:4030
 with SMTP id 98e67ed59e1d1-306a4975c0cmr355393a91.27.1743699437820; Thu, 03
 Apr 2025 09:57:17 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:57:02 -0700
In-Reply-To: <20250403165702.396388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-6-irogers@google.com>
Subject: [PATCH v1 5/5] hash.h: Silence a clang -Wshorten-64-to-32 warning
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hash.h b/include/linux/hash.h
index 38edaa08f862..ecc8296cb397 100644
--- a/include/linux/hash.h
+++ b/include/linux/hash.h
@@ -75,7 +75,7 @@ static __always_inline u32 hash_64_generic(u64 val, unsigned int bits)
 {
 #if BITS_PER_LONG == 64
 	/* 64x64-bit multiply is efficient on all 64-bit processors */
-	return val * GOLDEN_RATIO_64 >> (64 - bits);
+	return (u32)(val * GOLDEN_RATIO_64 >> (64 - bits));
 #else
 	/* Hash 64 bits using only 32x32-bit multiply. */
 	return hash_32((u32)val ^ __hash_32(val >> 32), bits);
-- 
2.49.0.504.g3bcea36a83-goog


