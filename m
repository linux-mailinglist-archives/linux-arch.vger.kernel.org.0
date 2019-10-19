Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB8DD626
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2019 04:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfJSCUw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 22:20:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSCUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 22:20:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so4336817pgi.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2019 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OZxB3yUZwqmkE8nLK0z7B1QOB/S9NBhwSOUrUzW9bzE=;
        b=Ph7M/rPNYPADQmJaP49bXc0xz4mq6WHHW5zTvjajYV2BoL+iLcPY25tzrl1YhrFp8X
         xxFObrvyMJXmUB3IlfeHJBOw6oVl45vEq/IHgpGO5mg9QFKzgT6at3FZqIjBiupOb9XX
         Vs9Q3GNfBNJoX77w3ZYaOVYkkmYWft/zv6KJ/rHG3IHs6MRYcC0hOzMGpLt+qbic+qbX
         +3Okt15ibCSrAQM6khnnZnAgfnCoD9WlKfppm+8Pt17EEyOz05nFUwZi3P4ak+Qz4Bwg
         LVuycSLJvIi/3y+Icjo9PFu81ihbxLXLbILVOfUOl94R8vjwVfBqWherraEqPsJwtClp
         ymlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OZxB3yUZwqmkE8nLK0z7B1QOB/S9NBhwSOUrUzW9bzE=;
        b=fOykvn/i3iWVTeNcW+9JfRY8U+qnwF4+KInIaHzFUQs9F9O5GSMKvsR3VSiEP4aojY
         4vDWXWCVb5O4MiZxZ2fvpzrIZel46yKu/ykkEUaKbfPY2tJCL04o6sUof87r+e+6398k
         pNpwM50BYPkRvk1EpGuEY/7UXAepPMuap/v+5ACSxta4rz7dvzUWhMDWi9hULu5IKHVw
         Ikjbz2ddfrjuO5ptIE2urmlca+S6T/p6nfID/ms8opiuu1ct+KNTn7fleywETaVde5po
         90+UKDqucNmab4Fd1D/ONmtcuE3o46DEOM11aGphKaZViRfOgxBTCUUeuzXwu2MOBL9Y
         Yzyg==
X-Gm-Message-State: APjAAAWW7fY0iIbtsLccTM5rac8ZHBV/lF1sCiDalU0OGTnHDkIRDxGP
        +J0DLSUopAsm1ynvyVlCLbPccQ==
X-Google-Smtp-Source: APXvYqz38lTUQmrPoILgjPmnL2NLsievHn6HKcnthBzPOb1nk5ouaMoUhSqGykRB4C29lhrEG+AoUQ==
X-Received: by 2002:a63:2348:: with SMTP id u8mr13305452pgm.422.1571451651538;
        Fri, 18 Oct 2019 19:20:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net. [97.113.7.119])
        by smtp.gmail.com with ESMTPSA id l22sm6635148pgj.4.2019.10.18.19.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 19:20:50 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com,
        linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: [PATCH 0/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date:   Fri, 18 Oct 2019 19:20:47 -0700
Message-Id: <20191019022048.28065-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Richard Henderson <rth@twiddle.net>

The ARMv8.5-RNG extension adds a hardware random number generator.
The plumbing for this is already present in the kernel; we just
have to take advantage of that.

Possible issues:

When should we use RNDRRS?  For now I use it at boot, when validating
that the implementation can produce a random number, much like other
architectures validate before enabling.  I also use it if RNDR fails.
I don't know if that's a reasonable thing to do; the generic architecture
docs are too vague about what's going on behind the scenes.

I mark ARM64_HAS_RNG as ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE so that
it is detected early, because crng_initialize() is called early.
I don't know if this is quite the right thing if some hypothetial
big.LITTLE only has the RNG on the big cpus.

Tested with QEMU.


r~


Richard Henderson (1):
  arm64: Implement archrandom.h for ARMv8.5-RNG

 Documentation/arm64/cpu-feature-registers.rst |  2 +
 arch/arm64/include/asm/archrandom.h           | 76 +++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  1 +
 arch/arm64/kernel/cpufeature.c                | 34 +++++++++
 arch/arm64/Kconfig                            | 12 +++
 drivers/char/Kconfig                          |  4 +-
 7 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h

-- 
2.17.1

