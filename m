Return-Path: <linux-arch+bounces-14344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E26C09B7E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Oct 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D641C81664
	for <lists+linux-arch@lfdr.de>; Sat, 25 Oct 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD4313274;
	Sat, 25 Oct 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J16YheW/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897A30F7F3
	for <linux-arch@vger.kernel.org>; Sat, 25 Oct 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410017; cv=none; b=H7WGqRhxaneZLWkUDXvzFEePxr90kwtcKYLhC1X7NtwofyEZGn1V2Rgdhf+JqQVrLmXW5ivAtoyHApk3CzspUPfA+8gdwNVLJG1TYHnfcuOHDE2Wqgcw9NYf5NGjobxrECwrYsMlhszp1cesgubzYGDfzl73x8qA407Xb9ZJP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410017; c=relaxed/simple;
	bh=/qN13PxTPUF7Pj/bbigcTnyf8UWTFD28fitKT4TB900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU67w9DxNuZSqA0k9G9B/n2TrOlEgOluSoITyqd59lcf3jVS57FfxgZIB1GVsGHUeEu4JcIOBQdpD86k3u3bYs/Xws2FACFctY5oRdG8f7I3OuaV9lYIMb2Y36Jekd96Pa9i5e9lwzkFQ0GFBTopvxZXAnRbTEUTy2spoI1stFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J16YheW/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87be45cba29so28813506d6.2
        for <linux-arch@vger.kernel.org>; Sat, 25 Oct 2025 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410014; x=1762014814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=J16YheW/d0Kpj6oKToqWNL82YGbzgixD1KVDzgU5DDcnKRodOb4Bx3nf3jFshxOQTU
         vHGup94W8nAwA4vhCQSuIY6dLNKHkmVvj9RNv2d2Xo7cIfI53G8Yb1K8ZQMKrUp4Vot9
         S0S66jF8eCszW2JfnjLsXQsmDQeB+Ih16S65uvhepxLQxz9out54bD1wrNnzc8MaWtRc
         gU7fzQlTagVNGasJQ4D4sYhdw3g+QdQ6jbs2jS231xdD55jCDtn6JZYlD3yid+ziyNXS
         ZY0EHt9/ZWB8QvVWspjpjlHR77eeXO8QCfXdzOpK9j5mPA2kPKabEHgsRf1yr+uxCije
         yP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410014; x=1762014814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=wiJyEo4d5jkG9BYnxDvp2qeIe+5m5AcO4SZ3AokB7f8jT8ZcsN7bQsS1/bdw3Uc9yZ
         xpIBKuA1tBzu3q4uQyRu6YAPCWv2VcVT+whD49wTEprNEhkBH9T3pxaL3Yr3jMBCy3tG
         B+8uYbEYtuxxWI7q3DexcCm6DJm5hwtzydQF3DAOSbhEuC8UxXmKmj15os9fUnAzZ2pr
         w0qFkKwyHQXZCALiR+nJXInmQQZdI93oTidTQ82b+iuGaxe4dgAGzlhDOdpzkfqmItf0
         tTFh3plss80LjdK2/iu8kqma/TKoGf6B5r8PwqiV3OTO9GfqM8rLbNGO0kOsOr8U0PM8
         TVuw==
X-Forwarded-Encrypted: i=1; AJvYcCV/6OKAksmNNj/pUk1tSkpLj9E0oTwOuam9p5jxKgXf95IsFjsZUJhblJeDeYWi8YLGR2eYUIE0lC2i@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCsv1t+9X6DxvrroqiROMq/+hRR3BEJslu3ElcyWwOAdPB071
	NDVWSKBf+CL76+UYrxNFAypIA5csBMvSfvr+SF2DJzbzYW++YhAMBW/Z
X-Gm-Gg: ASbGncvph2hyDcgSd4CQwd570vWWaiy5+7/nqiJFUzgOTvVQCnvG4hGnWXBfra9WiYo
	gM4xpoZfNcF6KLMsK6rxpzLaEJ6DWkWG2NIeBl4mjC63neUGawc55k1lDZp8uRmwUBP6MSphBIF
	/txb8T8E4JVeUi5to7JH/ZhGDbHUBQN1al3BCWeeCdyca2qfLDRh6rula5zlMXkJVFPTCTgCpHT
	R//cN6Rl5hOA4YcrNdLR6GxmPpnUQ3ohpRvoM9ZJ4uO4zZTAT9HbodlP3ReRpguhqfadGgqGAsu
	oLA69I5NggbZz16+v+LejKaqf++ZAuSrj5yWBQKZCVPtwcF6tj3hYz4HoQVPiBIenITTj/P3/6O
	O8DuamJgvCr7Eha1EgJpCcs+KcVCaQ/a3LpjKDOMT/BNzBRqIPyN9+FyF50CizY+fx3XhGS/0
X-Google-Smtp-Source: AGHT+IGaxqILFk1sWEKYs4/aKTapgVfZamjsAKwhDmFO0q/do78fw/vH+Xpzx9XExIL+rzfn38dWcw==
X-Received: by 2002:a05:6214:500a:b0:87c:2797:4942 with SMTP id 6a1803df08f44-87c27974b5dmr317695766d6.15.1761410014091;
        Sat, 25 Oct 2025 09:33:34 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49fde48sm16301696d6.61.2025.10.25.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:32 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 18/21] fprobe: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:00 -0400
Message-ID: <20251025163305.306787-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST/LAST_BITS() are
more appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/asm-generic/fprobe.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
index 8659a4dc6eb6..bf2523078661 100644
--- a/include/asm-generic/fprobe.h
+++ b/include/asm-generic/fprobe.h
@@ -16,17 +16,14 @@
 #define ARCH_DEFINE_ENCODE_FPROBE_HEADER
 
 #define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
-#define FPROBE_HEADER_MSB_MASK					\
-	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+#define FPROBE_HEADER_MSB_MASK	FIRST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 
 /*
  * By default, this expects the MSBs in the address of kprobe is 0xf.
  * If any arch needs another fixed pattern (e.g. s390 is zero filled),
  * override this.
  */
-#define FPROBE_HEADER_MSB_PATTERN				\
-	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
-
+#define FPROBE_HEADER_MSB_PATTERN	LAST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 #define arch_fprobe_header_encodable(fp)			\
 	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
 	 FPROBE_HEADER_MSB_PATTERN)
-- 
2.43.0


