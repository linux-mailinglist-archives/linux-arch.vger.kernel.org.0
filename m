Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814B227CFE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGUKad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGUKad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:33 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C2C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id o13so828941wmh.9
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PTq4pBrZslvVrftV71rNSLVaaKAAwjQ/mh+57cb51SY=;
        b=v3lpyN+v5uiSgtKl83T3bJDY0Dgu6WCaffNU5GUJwTq+G5OsfVU6qOuHzw859TpfUe
         A994HP607x7re+wDCAV0Y5FFVKbTZaRjaQsWRzYdfHuo/jJQv9l+Mwtkwu7yQGg4uHV0
         eq25QzEUFXWXO53AQVIDwdleYGfgbffrjVCoLcYrx1L8C7E+cQlZvNdI3G9ZN/RUwRjN
         ogkLuUeWDgkbszWbrbcu4ay3e1o5ZTWduDxzhwkEIZHDlOK6c3RIId/CWHgP9Qy74sO2
         TnYVqB+/5F7rVFGgJYEgLHF4X6AXGKs9mxbsBdc+d7X9nbLuSlia5Yq1AzKf3RkPyfDD
         311g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PTq4pBrZslvVrftV71rNSLVaaKAAwjQ/mh+57cb51SY=;
        b=li3qZ2OMhaAlGsQpf5XHce6rt/svfwzCeM0lpfoxVEyc2JBOTL3VSjdF0hQWSWBXHI
         e3C2/ZgNNamfdNicifm/yJS+zbs83pB3te1Mj+ilgZmjpUJVoBURpPP4rH8S9XDprfS6
         eurBVfzosL/v3wZlN1AE2jdP0lsRKfq0AV2DAMF4FCt8irtpkpwJeJzo7npU7mnsYZc7
         oTxu6LBze2+z2mYUNq82wRiJCYX5fETqqn/7QI8/aaoFu9FmZCOUMylwO637xqfrvQAS
         aBKON8OjR4kVi0HA9pZc6E2Ap1Yyr/8EGlNx4Tq9Atoc5yPujM9tgiZVFTohLHx9VVqq
         QYCw==
X-Gm-Message-State: AOAM532YmRuP2uRo6PKITooGcvKXM5pYDSVD4aDYAiAnItvBxbNiQ6ZF
        r4+G4s9kmPA19hW0K6/Sp10cdOCoDA==
X-Google-Smtp-Source: ABdhPJxpNlMs+cKmlZhsXDdcELP5hZqBFrXH0KSdu+z91oR4PxGPuvtmv/czs2p0r4bS4SA5PtNEnDu3LQ==
X-Received: by 2002:adf:b74b:: with SMTP id n11mr13648048wre.310.1595327430479;
 Tue, 21 Jul 2020 03:30:30 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:08 +0200
Message-Id: <20200721103016.3287832-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/8] kcsan: Compound read-write instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds support for enabling compounded read-write
instrumentation, if supported by the compiler (Clang 12 will be the
first compiler to support the feature). The new instrumentation is
emitted for sets of memory accesses in the same basic block to the same
address with at least one read appearing before a write. These typically
result from compound operations such as ++, --, +=, -=, |=, &=, etc. but
also equivalent forms such as "var = var + 1".

We can then benefit from improved performance (fewer instrumentation
calls) and better reporting for such accesses. In addition, existing
explicit instrumentation via instrumented.h was updated to use explicit
read-write instrumentation where appropriate, so we can also benefit
from the better report generation.

Marco Elver (8):
  kcsan: Support compounded read-write instrumentation
  objtool, kcsan: Add __tsan_read_write to uaccess whitelist
  kcsan: Skew delay to be longer for certain access types
  kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
  kcsan: Test support for compound instrumentation
  instrumented.h: Introduce read-write instrumentation hooks
  asm-generic/bitops: Use instrument_read_write() where appropriate
  locking/atomics: Use read-write instrumentation for atomic RMWs

 include/asm-generic/atomic-instrumented.h     | 330 +++++++++---------
 .../asm-generic/bitops/instrumented-atomic.h  |   6 +-
 .../asm-generic/bitops/instrumented-lock.h    |   2 +-
 .../bitops/instrumented-non-atomic.h          |   6 +-
 include/linux/instrumented.h                  |  30 ++
 include/linux/kcsan-checks.h                  |  45 ++-
 kernel/kcsan/core.c                           |  46 ++-
 kernel/kcsan/kcsan-test.c                     |  65 +++-
 kernel/kcsan/report.c                         |   4 +
 lib/Kconfig.kcsan                             |   5 +
 scripts/Makefile.kcsan                        |   2 +-
 scripts/atomic/gen-atomic-instrumented.sh     |  20 +-
 tools/objtool/check.c                         |   5 +
 13 files changed, 348 insertions(+), 218 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

