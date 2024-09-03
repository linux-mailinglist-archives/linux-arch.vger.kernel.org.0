Return-Path: <linux-arch+bounces-6943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035C969D07
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A3E1F25F47
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51E1C9861;
	Tue,  3 Sep 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9fJCH2U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EF1B984D
	for <linux-arch@vger.kernel.org>; Tue,  3 Sep 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365397; cv=none; b=haYLyDcx8eKMnXa4lIpUU1S69+BGdwIzOtBy3gBveceRpGZo7vh2qR04vlj0lo4wR0rxSFEIHc6eyBxJ8MfvNOpFs+e2IfTM9+4I0/JIUUUiNlWrLNLNNf5XhpFI1sFU95Y3RPJuyWpBQn4l7rktFMrY1HkCpVLueU0GVZT+CRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365397; c=relaxed/simple;
	bh=N1qqn7vYKBlbeXYmAR1aaSBjOkAuuoIsPmVXjG1IKa0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VmNJfX/BOPeAunGp7pSccIQaQqsqpNYfzcMfJtbdiGQ03nUn/MiuBKKRII4PQNO/OaT112ahNiUGajEwvE5p7rgFNwhYYqYPQdbF/oSgZxRSu9MjeVCRKB0R0DpVfQaN5PrkWy7Hyl2IoAYIVxyNgxvfmbh+FXaUWV/4e/kkT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9fJCH2U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso28244245e9.3
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725365393; x=1725970193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLYlLLGKbB0TvMjhCmijODtjVYZ8RqD6X4SH5pHru3k=;
        b=S9fJCH2UgJkF2l+UauktRfkH4nq6TM7EIxAYnstUodWneXJ/guUWV3jxiexAaIpX4P
         cOq8nLDzfXxC24xhhrjvz8eoi7ZCHnuoeIc9i5DH2nwzRDOdkBbkMElRrv5Dx5N8rVH0
         daBP0biULvTTipG6uBkctB9INyCkes3hes1btVssSexWAWLn9xBLIUnBQYOpgVKLNU3I
         RmQVAeQuXl+Z1Ew8SF0UsboblwrwBQioUMVgi3C8lf1Xu3gc0XDkEQeX3+dzbKYdjQjt
         tB2SGlEpDmfrbfc0mEyAoZ40Cj+dHGrp4/SxzdaspfziCz5RqhBjWQmsWgv+wodJCxeR
         faOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365393; x=1725970193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLYlLLGKbB0TvMjhCmijODtjVYZ8RqD6X4SH5pHru3k=;
        b=fKGC6c5kcG+zXDW4LUkMYUE2r4iXGgA9HS58VlRtHtQ0bz0zLybXZ3dpMqwEF62j+z
         DtcxERMnIlvFjkeGjR2Q2DM7X8utRwHU9VnSuJ1QuvJxMw2UkMr5Qg8FflIF9FvgqS1c
         rgiYC6RgBNldu1RrOSTxkmDy1QVg31+s2KQTSYLDsxy+DwHI5565DAecRYZc79E1IQy8
         jTVHBFBcDLYo93zWGxv2zlsF5qgrQKg8Gjes4AzaQfw5Bxw+gJJr6NjCdrLVM+aXblsk
         eFwFM1RoVdgceEqGv3bvDuJe54q8LDmA6S2puGfaebAsjYeMtlr9tYxHdi/cIyUcf9wN
         60Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWGn6lE2FVgZX+QzOW4KWeIMTwbUOpbmZNlnDPZ/2dXAf3NT8SefQApNdIanf6JpN7F9P9uUw8dAV0W@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNKPdpMWFgZNts65v138Vq+An7YS+N90U7gWGuv3j90hRHv0U
	+MudRcA7yX74C13rKwh/vAKCTponLPAztzk61ZATT4wHQCcGBjtmADHM0jFYsFk=
X-Google-Smtp-Source: AGHT+IEyoZ4C1GIHdc4etZJ5y8/7i4ZOxLROM5omYazPOI3P6CpupmD7KGheFpP2J3CHj/uHt2FC5g==
X-Received: by 2002:a5d:440b:0:b0:374:c847:852 with SMTP id ffacd0b85a97d-376dd71aa2bmr403119f8f.29.1725365393138;
        Tue, 03 Sep 2024 05:09:53 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a55fsm14069238f8f.10.2024.09.03.05.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:09:51 -0700 (PDT)
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
Subject: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
Date: Tue,  3 Sep 2024 12:09:15 +0000
Message-ID: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement stack-less ChaCha20 and wire it with the generic vDSO
getrandom code.  The first patch is Mark's fix to the alternatives
system in the vDSO, while the the second is the actual vDSO work.

Changes from v4:
- Improve BE handling.

Changes from v3:
- Use alternative_has_cap_likely instead of ALTERNATIVE.
- Header/include and comment fixups.

Changes from v2:
- Refactor Makefile to use same flags for vgettimeofday and
  vgetrandom.
- Removed rodata usage and fixed BE on vgetrandom-chacha.S.

Changes from v1:
- Fixed style issues and typos.
- Added fallback for systems without NEON support.
- Avoid use of non-volatile vector registers in neon chacha20.
- Use c-getrandom-y for vgetrandom.c.
- Fixed TIMENS vdso_rnd_data access.

Adhemerval Zanella (1):
  arm64: vdso: wire up getrandom() vDSO implementation

Mark Rutland (1):
  arm64: alternative: make alternative_has_cap_likely() VDSO compatible

 arch/arm64/Kconfig                          |   1 +
 arch/arm64/include/asm/alternative-macros.h |   4 +
 arch/arm64/include/asm/mman.h               |   6 +-
 arch/arm64/include/asm/vdso.h               |   6 +
 arch/arm64/include/asm/vdso/getrandom.h     |  50 ++++++
 arch/arm64/include/asm/vdso/vsyscall.h      |  10 ++
 arch/arm64/kernel/vdso.c                    |   6 -
 arch/arm64/kernel/vdso/Makefile             |  25 ++-
 arch/arm64/kernel/vdso/vdso                 |   1 +
 arch/arm64/kernel/vdso/vdso.lds.S           |   4 +
 arch/arm64/kernel/vdso/vgetrandom-chacha.S  | 172 ++++++++++++++++++++
 arch/arm64/kernel/vdso/vgetrandom.c         |  15 ++
 tools/arch/arm64/vdso                       |   1 +
 tools/include/linux/compiler.h              |   4 +
 tools/testing/selftests/vDSO/Makefile       |   3 +-
 15 files changed, 292 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
 create mode 120000 arch/arm64/kernel/vdso/vdso
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
 create mode 120000 tools/arch/arm64/vdso

-- 
2.43.0


