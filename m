Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCAE7A1E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfJ1Uc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 16:32:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33157 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJ1Uc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 16:32:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so497349wmf.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y4EUhsOM5hSQLRpeshpyDAq+iJB0OfhKCO0yxAAKOe4=;
        b=Z8eNxH6WsuheYqo/vZnrHazR6/lM9U/nvVmHe8YO3jbCharUCNjeF+ZjgtzfO+zSyg
         oggI2Z4KPkwVHHI02pKw9iEtvl/stHYRd0QhZVMds9kpxwyrO0sZgeMcpOvHAe1RwPiz
         Q9JLJUaVKiGvBa2FpCLamKg96iwEdfUAs0xbDo37b/k7FScicyT+FX2nXeRzr6OvE7dT
         yiXUhbhlbiaLoWZoB86O8euwhPLThUw8Df+hydyDmAxH7KMchEzfIflsWzwRp9sJu09p
         Ov0+szgl5IgUd2gaK19J1ibb6kcVtNz8yiJLn5t6xsQnq79vKMenTZz7zFJRKjvnmBZR
         NQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4EUhsOM5hSQLRpeshpyDAq+iJB0OfhKCO0yxAAKOe4=;
        b=IGX2yXngCFx2Z6ZrfHwI4DmvjPnKSRGyyYAfmxFlPDrujSRtmCZ2LD9tDQsTUAH//X
         Sir52PiSix3hKgjy95UKASpyusI3JmJHWFa8Ij6R+x+PqzBeshkKzAJxYujKrcEGJ2Lu
         M0EdC+aOnit3ONRWPnr2CO3kUuElaCtmZWexaVFs73OwQ9Pkzep3P4EBVF+/EVTrrz+G
         FGGmfbRWFjIavuJyYcTnOfMVH3fUcYXx/orARZIk46lasZcCN6vBY3eWcUUstf5Hs3gd
         SZucV7fZPkVc2EX0gPvLTYe27/bFtAEaMr5fVN6vHB6zZyV6f7px6BDYk+aCHOQSbfPz
         AdmA==
X-Gm-Message-State: APjAAAWMrk7MOm4ETOhI+jIf6elmhLNvswdKKTtf+ndMklJ4kWkdHooK
        NmwkEX6S0aMkXFZE3Vlsoi8REQ==
X-Google-Smtp-Source: APXvYqzLsiJ5xm1lZ2yj8onrwprZ+84mNuI8jwYKwGHQ1E8hknH1Z4Pmg7lRD9IWG7ET6ILcZCe28A==
X-Received: by 2002:a05:600c:2247:: with SMTP id a7mr1000824wmm.19.1572294776077;
        Mon, 28 Oct 2019 13:32:56 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id q15sm7227992wrr.82.2019.10.28.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:32:55 -0700 (PDT)
From:   richard.henderson@linaro.org
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, Dave.Martin@arm.com,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date:   Mon, 28 Oct 2019 21:32:53 +0100
Message-Id: <20191028203254.7152-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

The ARMv8.5-RNG extension adds a hardware random number generator.
The plumbing for this is already present in the kernel; we just
have to take advantage of that.

Changes since v1:
  * Use __mrs_s and fix missing cc clobber (Mark),
  * Log rng failures with pr_warn (Mark),
  * Use __must_check; put RNDR in arch_get_random_long and RNDRRS
    in arch_get_random_seed_long (Ard),
  * Use ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE, and check this_cpu_has_cap
    when reading random data.
  * Move everything out of line, now that there are 5 other function
    calls involved, and to unify the rate limiting on the pr_warn.

I have a separate patch set to add __must_check to the other
architectures.  But it doesn't affect this.

Tested with QEMU.


r~


Richard Henderson (1):
  arm64: Implement archrandom.h for ARMv8.5-RNG

 Documentation/arm64/cpu-feature-registers.rst |  2 +
 arch/arm64/include/asm/archrandom.h           | 32 +++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  4 +
 arch/arm64/kernel/cpufeature.c                | 13 +++
 arch/arm64/kernel/random.c                    | 95 +++++++++++++++++++
 arch/arm64/Kconfig                            | 12 +++
 arch/arm64/kernel/Makefile                    |  1 +
 drivers/char/Kconfig                          |  4 +-
 9 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h
 create mode 100644 arch/arm64/kernel/random.c

-- 
2.17.1

