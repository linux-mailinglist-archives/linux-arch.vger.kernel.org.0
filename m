Return-Path: <linux-arch+bounces-9139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11F9D239A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 11:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A872280F9D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F01BE87C;
	Tue, 19 Nov 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctVq/mCd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D419C553;
	Tue, 19 Nov 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012191; cv=none; b=jlxoK9uD1NExEW/SS1rD8jE8o0DyYjoeSqx/yK9BrsbyUNhgQsW80gYyA5xlxxecg92qB5t5CL7DmA7BoutI863erYOXg73VnKSmj7YdQlEJm0XMWesDmTOtob/Ko2DMY1EpqdcvLTd95tY8sO83E4HsPyJDCbb+6r23ak80oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012191; c=relaxed/simple;
	bh=dGh64s+Kqvl6hMSA0kdyxbadJuotyddX4xJ4Wo6rs0w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gjkAWealA+iAqM01VEfOL+UwPcNdE+cCARqcjM/AE3PAFRGzTg+SgDK70Ex6kT0sXYxOoV8V8tEM0Ba7uV3MEFhgv0Yn7+yNQ4mBmy+AD/WZlzaLDVpwwmtytcEA3/hOV2afOlDHboIxY2WvGFPyNZGMaD2VTroQybaSr8vnvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctVq/mCd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21200c749bfso25003425ad.1;
        Tue, 19 Nov 2024 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732012189; x=1732616989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOw9MHV7KRt1eXKNGVgXOufOASCySN7RIHtVck5/tL4=;
        b=ctVq/mCd2uelrFOOs0FGfVD3xo6TDvJzSBmvx5WTDKXHB7EJfxG8ry4GjW+2CBS2fl
         c/8oo8ulIzWoTXGq1kjZk45Iq6UpyDlzlLEeWB3nCy0wzhSv24uJGUkkYWtLhV3Ylkc+
         LkpQj9ekVaYwLfpKSOrfHTG3px5L0sht8pAJ8MdlvtQBl5lKBUJovbwgHYToCuumpJLs
         PNI2s8aXt/0oVa0PHN6T6MgONScnUnywAhjVoX9rn/UMjV1edR52nUn5lD4TJD2n0+T9
         vUm74xBLayjGlXISO0rEeBmoqgnLp8z4UjqS0J/Nzt+gb5fLeuCOuUn1uTNIU0zvANCj
         1Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012189; x=1732616989;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOw9MHV7KRt1eXKNGVgXOufOASCySN7RIHtVck5/tL4=;
        b=QBwRzLkHPSsr3541xBUaC0ymfsgUXq500g9STStWj0Om/LSczS8MQH8nhS5Qa/8Ok1
         bungXSIFDfPFi1B8wnTloJkhMjJNAw0eg4l0x4P5qA0bdAjJmDuptSRCLaAaleiLgtDW
         tCxTWy2WcIbqghjwWSCr3w7hPcljGNtpmiFSejJkWmpEVckVgbXnVNQQdW2w5aD1w2Zc
         nxf0rkZTyD7bq6UAjtAdXYEG3JnI+kPaE5rbbFAmyqFqngXQKWNGmVy5KZCWVD4Lea88
         d8OFDxvXBTaUZP7fHGRm8QXngkagbzYIOlM7fKlqE9EKFbgsvgYWrFYKvimp1rLIC1Co
         Us9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3OzXUWITQ7Mgo4DsLnuQ8XSaQfzs2gXbp6GhmlL+MT3pZ5yDC+88/cpUJiTzSfKXX/UbpkTgpLtqwRik=@vger.kernel.org, AJvYcCWqIfPnd/FYu3tuUOSyt7nUWS/BQyKeNYBbBbpGbJ2KZSOWY56QlR5vL9/J8EJlg/kL2ZBFH830nyrPV/mQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGw9nDtc8JHYzFHcsamhUDaVTUGHF5s3jAFjz0Cg16xWQPfOj
	q46UBOU4jhPTIDQQALfsYXVy0KE3kCb4Qwsw7rtW4njKpXP04D/z
X-Google-Smtp-Source: AGHT+IGjPmgZGITjgIZAbFEZh1xtuft53899R6LA7gUtB/vv0OHvViNr8Z67ILi49wQx8T2CgbcBnQ==
X-Received: by 2002:a17:902:cec5:b0:20c:ce9c:bbb0 with SMTP id d9443c01a7336-211d0c94220mr253936545ad.0.1732012189520;
        Tue, 19 Nov 2024 02:29:49 -0800 (PST)
Received: from [192.168.1.9] ([106.47.210.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47adbsm71274335ad.223.2024.11.19.02.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:29:48 -0800 (PST)
Message-ID: <72406e89-7dee-4063-ad8a-1d63ddc5bfe6@gmail.com>
Date: Tue, 19 Nov 2024 18:29:45 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhihang Shao <zhihang.shao.iscas@gmail.com>
Subject: Re: [PATCH 00/11] Wire up CRC-T10DIF library functions to
 arch-optimized code
To: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/17 8:22, Eric Biggers wrote:

This patchset is also available in git via:

     git fetch 
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git 
crc-t10dif-lib-v1

This patchset updates the kernel's CRC-T10DIF library functions to be
directly optimized for x86, arm, arm64, and powerpc without taking an
unnecessary and inefficient detour through the crypto API.  It follows
the same approach that I'm taking for CRC32 in the patchset
https://lore.kernel.org/linux-crypto/20241103223154.136127-1-ebiggers@kernel.org

This patchset also adds a CRC KUnit test suite that covers multiple CRC
variants, and deletes some older ad-hoc tests that are obsoleted by it.

This patchset has several dependencies including my CRC32 patchset and
patches queued in several trees for 6.13.  It can be retrieved from git
using the command given above.  This is targeting 6.14.

Eric Biggers (11):
   lib/crc-t10dif: stop wrapping the crypto API
   lib/crc-t10dif: add support for arch overrides
   crypto: crct10dif - expose arch-optimized lib function
   x86/crc-t10dif: expose CRC-T10DIF function through lib
   arm/crc-t10dif: expose CRC-T10DIF function through lib
   arm64/crc-t10dif: expose CRC-T10DIF function through lib
   powerpc/crc-t10dif: expose CRC-T10DIF function through lib
   lib/crc_kunit.c: add KUnit test suite for CRC library functions
   lib/crc32test: delete obsolete crc32test.c
   powerpc/crc: delete obsolete crc-vpmsum_test.c
   MAINTAINERS: add entry for CRC library

  MAINTAINERS                                   |  11 +
  arch/arm/Kconfig                              |   1 +
  arch/arm/crypto/Kconfig                       |  11 -
  arch/arm/crypto/Makefile                      |   2 -
  arch/arm/crypto/crct10dif-ce-glue.c           | 124 ---
  arch/arm/lib/Makefile                         |   3 +
  .../crc-t10dif-core.S}                        |   0
  arch/arm/lib/crc-t10dif-glue.c                |  77 ++
  arch/arm64/Kconfig                            |   1 +
  arch/arm64/configs/defconfig                  |   1 -
  arch/arm64/crypto/Kconfig                     |  10 -
  arch/arm64/crypto/Makefile                    |   3 -
  arch/arm64/crypto/crct10dif-ce-glue.c         | 132 ---
  arch/arm64/lib/Makefile                       |   3 +
  .../crc-t10dif-core.S}                        |   0
  arch/arm64/lib/crc-t10dif-glue.c              |  78 ++
  arch/m68k/configs/amiga_defconfig             |   1 -
  arch/m68k/configs/apollo_defconfig            |   1 -
  arch/m68k/configs/atari_defconfig             |   1 -
  arch/m68k/configs/bvme6000_defconfig          |   1 -
  arch/m68k/configs/hp300_defconfig             |   1 -
  arch/m68k/configs/mac_defconfig               |   1 -
  arch/m68k/configs/multi_defconfig             |   1 -
  arch/m68k/configs/mvme147_defconfig           |   1 -
  arch/m68k/configs/mvme16x_defconfig           |   1 -
  arch/m68k/configs/q40_defconfig               |   1 -
  arch/m68k/configs/sun3_defconfig              |   1 -
  arch/m68k/configs/sun3x_defconfig             |   1 -
  arch/powerpc/Kconfig                          |   1 +
  arch/powerpc/configs/powernv_defconfig        |   1 -
  arch/powerpc/configs/ppc64_defconfig          |   2 -
  arch/powerpc/crypto/Kconfig                   |  20 -
  arch/powerpc/crypto/Makefile                  |   3 -
  arch/powerpc/crypto/crc-vpmsum_test.c         | 133 ---
  arch/powerpc/lib/Makefile                     |   3 +
  .../crc-t10dif-glue.c}                        |  69 +-
  .../{crypto => lib}/crct10dif-vpmsum_asm.S    |   2 +-
  arch/s390/configs/debug_defconfig             |   1 -
  arch/x86/Kconfig                              |   1 +
  arch/x86/crypto/Kconfig                       |  10 -
  arch/x86/crypto/Makefile                      |   3 -
  arch/x86/crypto/crct10dif-pclmul_glue.c       | 143 ---
  arch/x86/lib/Makefile                         |   3 +
  arch/x86/lib/crc-t10dif-glue.c                |  51 ++
  .../{crypto => lib}/crct10dif-pcl-asm_64.S    |   0
  crypto/Kconfig                                |   1 +
  crypto/Makefile                               |   3 +-
  crypto/crct10dif_common.c                     |  82 --
  crypto/crct10dif_generic.c                    |  82 +-
  include/linux/crc-t10dif.h                    |  28 +-
  lib/Kconfig                                   |  43 +-
  lib/Kconfig.debug                             |  20 +
  lib/Makefile                                  |   2 +-
  lib/crc-t10dif.c                              | 156 +---
  lib/crc32test.c                               | 852 ------------------
  lib/crc_kunit.c                               | 428 +++++++++
  .../testing/selftests/arm64/fp/kernel-test.c  |   3 +-
  57 files changed, 867 insertions(+), 1748 deletions(-)
  delete mode 100644 arch/arm/crypto/crct10dif-ce-glue.c
  rename arch/arm/{crypto/crct10dif-ce-core.S => lib/crc-t10dif-core.S} 
(100%)
  create mode 100644 arch/arm/lib/crc-t10dif-glue.c
  delete mode 100644 arch/arm64/crypto/crct10dif-ce-glue.c
  rename arch/arm64/{crypto/crct10dif-ce-core.S => 
lib/crc-t10dif-core.S} (100%)
  create mode 100644 arch/arm64/lib/crc-t10dif-glue.c
  delete mode 100644 arch/powerpc/crypto/crc-vpmsum_test.c
  rename arch/powerpc/{crypto/crct10dif-vpmsum_glue.c => 
lib/crc-t10dif-glue.c} (50%)
  rename arch/powerpc/{crypto => lib}/crct10dif-vpmsum_asm.S (99%)
  delete mode 100644 arch/x86/crypto/crct10dif-pclmul_glue.c
  create mode 100644 arch/x86/lib/crc-t10dif-glue.c
  rename arch/x86/{crypto => lib}/crct10dif-pcl-asm_64.S (100%)
  delete mode 100644 crypto/crct10dif_common.c
  delete mode 100644 lib/crc32test.c
  create mode 100644 lib/crc_kunit.c

Good job. It's great to see the code being simplified.

I still want to submit an optimization patch about CRC-T10DIF for RISC-V.

I don't know if it would be more appropriate for me to rewrite a patch 
after your patch is officially applied.

What do you think?

