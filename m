Return-Path: <linux-arch+bounces-6944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329D9969D08
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42DB283480
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74A1CE6F5;
	Tue,  3 Sep 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6f+8c2B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F81C9868
	for <linux-arch@vger.kernel.org>; Tue,  3 Sep 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365399; cv=none; b=gx0Hpu8pd2VilRytZ1I2iFKiHPTzBAzkRaumf4enim20dW0/iZEimzNiDKBIVcrMv/VleDf+b+aaviGHgvMJO8yJ8Q2mn0uylFN4GF7ZylztKlopEiog0nxgzICBDFJyeR0Dw7464SuXgNrg7y+onCjM3GdAwxy5w/UeJvGHivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365399; c=relaxed/simple;
	bh=44yzxRSTqwlOROlkCwEXzmTbMUBKaeO1+N1E/oREDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfYttEYZ+D4D/huNfTp4LYJwRzky4eywoQOiPcutCePioLRbBtr2SYdCu8TQpeE+BRKXIK82RnimcnT3QQAUrIezhPaVIzqQVVTdqDwgmCqcua7p2+0aFiQw5Vl101vp21rqOYwGbtvia2VZ/xcYXMVCkptajEzbKxSVpTwBHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6f+8c2B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso58697295e9.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725365396; x=1725970196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=A6f+8c2BdG8o+Y7O5uRJFBHkFlH0wNBzQPPcmb2rLp1n6O2+pj2PIans7wSwV3ZtJz
         cF2m//6pNZJxbUx/iwdJetrS0IXrbo610bm8ip8ChOsoji50g6laURTZ5n3qutnn7KY4
         Bo8tFVLSIXVCGoFAPYbZieLD+iOW3LfI6U/73nNEGgBEp4p5l0z6eQ+m8XYvWfL0ve+L
         cvnoyAcuylsbtoERPhCH0VHyJ+h6TvrIZaw+zzFkES36/2LisAtEq8yXRqJ63be8Ci5l
         IUfQ8EX+YjpPoDvAAVJvi4fxMFGWtGT8qmvDgohmXuxBHwNM6QQZSj2QNtTuGr0zi1q4
         npsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365396; x=1725970196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=pY17W90AgTCEZamKli/GclNes+5KdPzFPzHlJzMdcfn1//97ND8CUfVTy+LSFs7jN2
         FvibxIKJH4P4+1ooGmdPvPboITpjcBhPHEGCpRIfSEdCh1/bOGXk7gjSuWJw+c+MSqsS
         mcMLB/rJASzePGUEPkxp+XhguPD4pu0BoM/tbt21xH7wVrAHMPK2N8YmQTHM0raRDgyX
         9IcUNhjuJA8+XHzgu9wl+CyyhfjwJVn6Etqaiu5c0FVCQv+JxV+d0dmOvaTBHtDUPEea
         A2ZL+ASh0E26XQRuK4VfPItgorlUDctN5Vl1btbmhmcGAo/ILNhaKgXxAgeizYVVingF
         kq9g==
X-Forwarded-Encrypted: i=1; AJvYcCU24y6DeQryD8YLY2DUQUkIdut2OJarDo3Xcul3dH7hUoix2Le/auA14iEvF6yoRdKT0tYaXklUizIr@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJHpgRF4mJNVtq3RaPjGzG1b1AUCUMMs6BhGMMxOoDqVfhwox
	XeuTs2g/h5uHUG1ugye95I2GW4bZSgykoJU5fPgkAXEfFDw7ZBoUdSMeEYILuYU=
X-Google-Smtp-Source: AGHT+IFcoK0ATItLWWMNoYyO3QSsujmu7MhadnpNmBdao6RwrBFoO5Fsa1nhUpv/GrvTkZFRm38cOA==
X-Received: by 2002:a05:600c:3c9f:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-42bb01b5f50mr137762745e9.10.1725365396400;
        Tue, 03 Sep 2024 05:09:56 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a55fsm14069238f8f.10.2024.09.03.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:09:55 -0700 (PDT)
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/2] arm64: alternative: make alternative_has_cap_likely() VDSO compatible
Date: Tue,  3 Sep 2024 12:09:16 +0000
Message-ID: <20240903120948.13743-2-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

Currently alternative_has_cap_unlikely() can be used in VDSO code, but
alternative_has_cap_likely() cannot as it references alt_cb_patch_nops,
which is not available when linking the VDSO. This is unfortunate as it
would be useful to have alternative_has_cap_likely() available in VDSO
code.

The use of alt_cb_patch_nops was added in commit:

  d926079f17bf8aa4 ("arm64: alternatives: add shared NOP callback")

... as removing duplicate NOPs within the kernel Image saved areasonable
amount of space.

Given the VDSO code will have nowhere near as many alternative branches
as the main kernel image, this isn't much of a concern, and a few extra
nops isn't a massive problem.

Change alternative_has_cap_likely() to only use alt_cb_patch_nops for
the main kernel image, and allow duplicate NOPs in VDSO code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
---
 arch/arm64/include/asm/alternative-macros.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index d328f549b1a6..c8c77f9e36d6 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -230,7 +230,11 @@ alternative_has_cap_likely(const unsigned long cpucap)
 		return false;
 
 	asm goto(
+#ifdef BUILD_VDSO
+	ALTERNATIVE("b	%l[l_no]", "nop", %[cpucap])
+#else
 	ALTERNATIVE_CB("b	%l[l_no]", %[cpucap], alt_cb_patch_nops)
+#endif
 	:
 	: [cpucap] "i" (cpucap)
 	:
-- 
2.43.0


