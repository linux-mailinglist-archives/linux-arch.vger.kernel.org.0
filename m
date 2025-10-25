Return-Path: <linux-arch+bounces-14345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B5C09D22
	for <lists+linux-arch@lfdr.de>; Sat, 25 Oct 2025 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B91C0580F56
	for <lists+linux-arch@lfdr.de>; Sat, 25 Oct 2025 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6BA3191D0;
	Sat, 25 Oct 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgS7FhGV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456573164A8
	for <linux-arch@vger.kernel.org>; Sat, 25 Oct 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410480; cv=none; b=Lz3NhnmXoEGQj5Kh02i2RyZ+K7ub2N3mI9nZdm4gJlJeSpJAIFcVJTkVbsjo4GYHj6EjBsSM/WXUIdo8MifN7V7i2Il6W17oU2i1LsLqP6ncIzQBzjz6TWEej4paM/bCSBkJBPuXZVrkGw/qXHZ4fob+JPkzGbYoXzF1xNG2Hb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410480; c=relaxed/simple;
	bh=/qN13PxTPUF7Pj/bbigcTnyf8UWTFD28fitKT4TB900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMT4Y9JcT65KUt8z1R/ExOcnF43+LffGMRXjkzhgPBr/eUuMIPPENMNbTQ1JfUK4cj9WWsqz2vG0ikAyknXYaiYzSYKOtbhzONEwoOG4kMVia1J75pGl7B1rktGk2zUjqhAf0EH21nQL6JkwHkcd5kTJYo/0KlMNsB73VWqAxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgS7FhGV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e891a8980bso31466881cf.1
        for <linux-arch@vger.kernel.org>; Sat, 25 Oct 2025 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410478; x=1762015278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=CgS7FhGVg8fFqEhBJbb0kDUmXQ2pmzjMaG8/WeYHyxGL/QlfuYZjCRof6QXqY+WBPG
         QAcUcFWvoSmJ5/6YRoGpBO180ia6S94cNbVo/dm4q+P7F7nF/+Utkjsgd/GiDMIxfxkA
         eZLdu9t0W6ELmPSChAAM2B6n/UmYA5PKVi5JfQLexSjQPBDrFQwKEiKHcPaVaURJt5BO
         DYlFMCI3+uK79vyknH/4jbYNUjIC1JdUcYa5Ijc8Bmsc5LVRAbnoLMTXyAOUTY4IY9Yn
         yHhE0L+KbPykcjz5ewqreNySG8mjDlR6WYCVOf5coTMl20OBcE/MFf5QT76pTx62+yyK
         wjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410478; x=1762015278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=Ylu4CBAZgxdGYslV2IDBuiZGOiiNlhx3Djpc4eFc09KMBqFnVJDBouQJdyaf7siI1T
         j63K8UpLDEIH8F4ZQqQBmrhn0WcL+7AQxSESiUjQYxBXwizJgs52GhoGrmQiRt6dt1Te
         BIdXw0c1Oh+t2O7lIb55HBoYYkZOVL2ed3GvxvmUVwYyOWuO8Uyykg4DFJfXp7HFhQoT
         Bs5FSPgsiH8POJNqyAqzzcFI4D3bydKbKED6FiQZtEwMlOE50w/ozo6s957aDld58jnj
         /41Mq1MHzXmJ/+JqE045QKvcmH1aXRXXfQstr9RYpSUpB2URXvS8q/+EVe33DryNjWDq
         s/zg==
X-Forwarded-Encrypted: i=1; AJvYcCXyS/9YnRGbydRc8XPfv6QD91Hqsw03xK3xIs2y2iwqdTyCfsD/yd/RDZ/75Xz0tZFtrdM+I5H0kpz5@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpWABKiEH1GuCX5ICyvWLWkmLFc9RqpyhxBFMla+GU/mfVD5i
	67kenfR33qJ2Izf7+FVNf25wcqa7StvAg0VqP6NptaMDldBMuz6KosJi2r6/Iw==
X-Gm-Gg: ASbGncuFu1Eu2JI+XZ52rChPjx4p20GUyG1/SiEyft/qBjv8XDpW1fZoBeiV2/UQtWR
	eK5dobPI3oyI3kpj8/hhmOBxQYFhQCl4xse5/6yQnRwfYR5EOvfxZQa4d4gUCij79YqSG4dUHPz
	hCfNpO/97KN+OfAK+chr5ALmSvThv/OIUa/dNDdgytkpEBKjeF1HiMcsFvwdaq5mf5ySXXuDcBS
	Y0Ky/kGzAJmXf8pAHMlz3EQ6ZwNJ/+b4inHQSWmWdr6q84GCol92W25o6Pv8xK6p7xtvw98B1yy
	tHOceDLY5F6lJsCGa846BJsm55uTQZHgXMlJ3NcZHBUX1klJ1n3qDtm8UGW6s2yib/ak9DXyBJR
	Yc1RWTQEQ8zvqO6A3OHKZ5+ZD96DPLO4RxAOSTBgpZQDsTMwBEloiCSE0OoAlfcOztslLYDKagq
	MLZtleuPShBAPTC3VU/Q==
X-Google-Smtp-Source: AGHT+IFkd2wHzM2bhvAxcegsRzuQmKhnwqeGyXDU7KQiqF7VzEOSt8dgBNcFI9XF+zOOfS1sMpRDCw==
X-Received: by 2002:a05:622a:101:b0:4eb:a668:f80a with SMTP id d75a77b69052e-4eba668fd4bmr28177301cf.32.1761410478191;
        Sat, 25 Oct 2025 09:41:18 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fba6sm175785685a.4.2025.10.25.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:17 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 18/21] fprobe: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:17 -0400
Message-ID: <20251025164023.308884-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
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


