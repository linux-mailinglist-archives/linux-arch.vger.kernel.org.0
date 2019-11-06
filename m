Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C069F1806
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKFONY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:13:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55431 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfKFONY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so677179wmb.5
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5J/Ofk6ylx2fNP9WdzIRZXeA0e3ywJAg5ijroGTIp5E=;
        b=tKY8u23aHs4/HPdanAkyFxDTfKUnmDGznwlyn9XjBCxK/OLl/98xLhDrlyXoAOfIaZ
         MTBKdzqlKcEi8Yg41n3F5ev4DIFFQCUugd5VfyB2HNWmoU4XikzTEDyANulDHbwvbcGt
         xDbwaS0xj8NvMvT+e/hpqaCLf8gOoFmdK/P02ME8aqM1f5ZIJy6RTYY9NhG5l3KDA+Wz
         PKOJOKmxd+5yxjo8fgNIlhqZK0EwwkMOR65hNLRR3VHbZAkOsiDGtqkOuLP1c2k9yL1F
         S4Ldyo5DpLfVAkoXEkLbUX6dB4/D40XNuTz48F2pAWJ0Ju6Z3ObFK2KYX4cDHUyK++vo
         VXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5J/Ofk6ylx2fNP9WdzIRZXeA0e3ywJAg5ijroGTIp5E=;
        b=EjTpKjWLstFWy5XBwmQgneeFnR5F7SFoRgqH7GQeZIeIWF75gQle/wZEnR5MmdK8/w
         LY5FdZQsuaO6WIyC/R0NpqqkLrbQqluXkQDGvDI/0wIYb5fveu52y7NheYy9NZppqOwL
         v86Z549SDYoCX9kwxBGQ6090ieZ9NbP4l5G+/yHHTdz6AD5IfrdaUwWvVSDWasD7WMce
         gZRjs562HUMlhmmGu8QgHwd5DILb1zkE2COI8+dnXD90aaKB0A2jH8NHSY3s/w3Nj3f7
         onMh9CMFY4LONJeNSZQsrBSj9WyCcaKIrHs6UOQ9gSq1mS8d1GWy2l55xFVZuTVBKmWJ
         ZW2w==
X-Gm-Message-State: APjAAAW8hNLdq35nHkQwgOQTBwH22j3NhHs7QQYdrQgA1WOSa5rVLzPY
        6yT6K+0bftjH3ygFXSRCOyfyWA==
X-Google-Smtp-Source: APXvYqz5N5+MuHewN3HtZf0o/tcihZPJ2fkIuNFxsMWdBRetpBqj57Ix1x+D/JGw4/oRNCMLLNTfOw==
X-Received: by 2002:a7b:c925:: with SMTP id h5mr2938042wml.115.1573049602083;
        Wed, 06 Nov 2019 06:13:22 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:21 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/10] Improvements for random.h/archrandom.h
Date:   Wed,  6 Nov 2019 15:12:58 +0100
Message-Id: <20191106141308.30535-1-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During patch review for an addition of archrandom.h for arm64, it was
suggeted that the arch_random_get_* functions should be marked __must_check.
Which does sound like a good idea, since the by-reference integer output
may be uninitialized when the boolean result is false.

In addition, it turns out that arch_has_random() and arch_has_random_seed()
are not used, and not easy to support for arm64.  Rather than cobble
something together that would not be testable, remove the interfaces
against some future accidental use.

In addition, I noticed a few other minor inconsistencies between the
different architectures, e.g. powerpc isn't using bool.

Change since v1:
  * Remove arch_has_random, arch_has_random_seed.


r~


Richard Henderson (10):
  x86: Remove arch_has_random, arch_has_random_seed
  powerpc: Remove arch_has_random, arch_has_random_seed
  s390: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Use false with bool
  linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 27 +++++++++-----------------
 arch/s390/include/asm/archrandom.h    | 20 ++++---------------
 arch/x86/include/asm/archrandom.h     | 28 ++++++++++++---------------
 include/linux/random.h                | 24 ++++++++---------------
 4 files changed, 33 insertions(+), 66 deletions(-)

-- 
2.17.1

