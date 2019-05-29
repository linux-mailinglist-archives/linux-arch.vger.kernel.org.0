Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E082DF96
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 16:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE2OX0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 10:23:26 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:43384 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE2OX0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 10:23:26 -0400
Received: by mail-yw1-f74.google.com with SMTP id t2so2240456ywc.10
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PLHql6HuZD0bzmA8PfaTdvUizoR7LXyZ6UL9cOmZOnQ=;
        b=Guy5Xjr5Wholvk2wwpj43VueywLu/AoMNYGYxpgCWt0djZBOVn5FgcePWoupL6XXsj
         7IPSG1wBXeae7XBJIn7bzmUq8mJ9wuBxmhbor+E5UQqqV2K7PEeEDgWhrtOEFMi8cHUG
         VUrxUug7tZaBxJoM+N3GXVlsx6vGe+QFZ/l76oKzcR1wyxSC7jXJxYr8+RaJHSEDq8uX
         DP98R4+p+DEeSThMxTKmQwKbeqViUNQty3XNKqErwgKL0Q0E5ScNtJuO322XY0yhLcuM
         Ze8YkXH+MMzFzPo/7YnKbKetJ4TLvtyCIlNAKD+IKXQmcSIL+tRecQXIiCW9eYpJfTZr
         Tq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PLHql6HuZD0bzmA8PfaTdvUizoR7LXyZ6UL9cOmZOnQ=;
        b=qAgKjyuk1cHPGKr9ZyOuwm5nnr78IIDvxQUVJilpOnY8cLEOm6P2s2kNOII8iFrMuC
         ebHOPDuyDn0e4HNXa5ue4GHPvLHx//X3CYSeql7mPDs7OZjLPP47mZm39UedB62r4b6K
         4DtuOIfbglQFMWOL6lDBRwEwHv7BX2KRyqnrGEKtvFSXv5rH7WFu7YY6GZGOww+v4KPR
         ajlCPgz/vkol66WDu/ZxJ49oihsRKjlG5JF71S7EbAW94NcMCNeevegrnVc3L1A8ypkI
         P6Ucjbj4BLFNWKBKNwzeqn1popM3i5ekZBKr5Z1+s7/MIWan/uK+p/Za0cWnKs913NwU
         FQHg==
X-Gm-Message-State: APjAAAVm3JXdQjuLOS3mf3UZEFC8oOFsU5JoIav1+cPRixnGO0p+f2pJ
        OOfASPGcR9ywBbMRaAOuR3oVYqcvMg==
X-Google-Smtp-Source: APXvYqxLC6zyJv0xSSACzvKIA6nLKuJm7cRRhTv9ht3NB5WR/ekCb4ojh+2GmRIqJexYFBRx2sWzsjgesw==
X-Received: by 2002:a25:c0c6:: with SMTP id c189mr43131422ybf.339.1559139805383;
 Wed, 29 May 2019 07:23:25 -0700 (PDT)
Date:   Wed, 29 May 2019 16:14:58 +0200
Message-Id: <20190529141500.193390-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v2 0/3] Bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The previous version of this patch series and discussion can be found
here:  https://lkml.org/lkml/2019/5/28/769

The most significant change is the change of the instrumented access
size to cover the entire word of a bit.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Move CPU feature test out of uaccess region
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   9 +-
 arch/x86/include/asm/bitops.h             | 210 ++++----------
 include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
 lib/test_kasan.c                          |  75 ++++-
 5 files changed, 450 insertions(+), 163 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc1.257.g3120a18244-goog

