Return-Path: <linux-arch+bounces-6924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D2968BED
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835511C2202D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB23BB50;
	Mon,  2 Sep 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwcYyvop"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F513AA3E
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293965; cv=none; b=eGvaCRU1HeTwrnKRXOrCua/hLkgOPLyF/gy5BkEcwkDwpDcHICs9UqhlC5dPmuoPGWL7/9TqFLk21lQ8oYPeu7OJsghUZTlzJnpkunRSmqQj/tx5c6ZlcfpcKmh7NfF2WcQ0IyAKbJXz4Ayr447Hq+HwjvOyE5VD7cqYFNSBemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293965; c=relaxed/simple;
	bh=44yzxRSTqwlOROlkCwEXzmTbMUBKaeO1+N1E/oREDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EggcZAoVp/ihuuYPyRvdWJNRYB9VMAKHH108PUk0buvvRXOb4zrDczh6MmqQ6GavuThi+1Z++H37xPDBoPnTnPAHHxeacK9msf8bT7g2bGDkvVLeH4WJXLr5Zw59thaZXQWkMIwTE5nG7OGeBhC3/gLm+v/uf/OH40NGDRIPOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwcYyvop; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbe908380so25437305e9.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Sep 2024 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725293962; x=1725898762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=lwcYyvopyDeBgfSRp7/tIiAcqCkEOuFwD51W4k3NPu9Z6o0XfXuP2+72Sw/TLb8l22
         nQoGWBcyhptiOP9BWeovgiZROJ/CsKQPSFiQKAz6HVa744lxQEkY8Y8cNNJONSJaqo0Z
         jIwNlMZFR2t5UCdFYyQi+b3ZrSaEsm7QHFderSjWPCWotBHMQ6CHgLXxO1Ek/hU6KEp2
         NPSygsa+43jKjimBcilASH91FJYo1bn5ILNa7BJkZZS7y4NeOiXSYFauUgcDV0fN1jdo
         RiyQpgMOeopXXpxua9DY/ap9RlBvAWatpvlw4KVWhUf2T+78DpwEfJrkMNz+2GuTgURj
         IOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293962; x=1725898762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=mI5zrF0YJ0/DJFqrCrZIuZjsPgbukhM1DJY4weg3tZpq4OdHnKv+38osAiiI03Pfkv
         I4KzCP1IL8WoZdjFzK+Sz2Fji80PZkqyjwqgxCAN3ZJZ8VwUVCpwbtQ95TkykZu+lFGe
         GNZ2S0uhFfTL1JcoRp5GZBGHmBCJjkUJds0VWe/XU+IkrUf3T/Xkn+7xG58TB9+9rq81
         ccE2vAAb9Zo740jAoWonR5g0JsQJV74rAKw5fFapNhF98stszeW8WVwnanTBRgj98Bgu
         hu4BhtZ2cJqzIdrtaz965WrJ6/IL4gKDbk5m0WucNClQO5uSq8CNsMBVTPh/l7gay12i
         3PSA==
X-Forwarded-Encrypted: i=1; AJvYcCW1xN6XHyNeM6JVstaYo0o2kWXe5ucnHWciBSIvDEodEbcXlQh3F+N74zNJYUVKxnyUWHulH4h+0FMB@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/dlGL6NcWnv/qbId5uMOVJXr5YP90xfxuJtzAukwvrvqFfh/
	Bv3tjKjW5odUG75uNbKPVqokk+64RnOp6aGg3fZbjrl0dVDlqPB4V7gQX/sOEhM=
X-Google-Smtp-Source: AGHT+IHxlg744kdhRp7ia5MEnyLycaQtMyvS6PmquQ558nqH6B/b8PrByKr+corJQzJhDTQ9+etDCA==
X-Received: by 2002:a05:600c:3b87:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-42bdc63348bmr46501825e9.10.1725293961685;
        Mon, 02 Sep 2024 09:19:21 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm145970065e9.5.2024.09.02.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:19:21 -0700 (PDT)
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
Subject: [PATCH v4 1/2] arm64: alternative: make alternative_has_cap_likely() VDSO compatible
Date: Mon,  2 Sep 2024 16:15:46 +0000
Message-ID: <20240902161912.2751-2-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
References: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
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


