Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0402F310F4
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaPLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 11:11:36 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36067 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaPLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 11:11:36 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so8177372qkb.3
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DHrqTUytQArIdQz1xxPzRVqqz8q7l/i/jn+bESY1v40=;
        b=VT0VhU5diy4D7S+PBFYFmWJZM3wQFT034TEzFtXa79nkY7mFiZqAq66rqbZ2BEasQY
         5qvLyitDkcYkM3+HCUZP4WUEQoxkk7wsTF9szzHwKRKaG30oy4uWB2jkUBQ3lwq8+0N5
         G8EH4PAeV0fONz/+Z99fpGrpxrRrGs8huirgP5uF4ArUup/88PAiT4olJKtbbuw6XDYi
         nwbs/PxRd0NEru5t9bQoAW57/dXGO4cj3DPuM3ZdtDwZu+oOdHGeC3zI2yNeJpJYuOC1
         o7KL7K3LHGmWoU1HEWi4ZvKAHB+dAXmVd0U8GDVMwggw6HqBTqvEMS3ig3GxdlYf5aCi
         /0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DHrqTUytQArIdQz1xxPzRVqqz8q7l/i/jn+bESY1v40=;
        b=IlD6U8nwxUgZwjDtCi7gfx2t+F2kpQLh7Y2NX2FK++snqgRQP3n4TRTCdd7ABR5WMQ
         I6rdXTwUmHV8VHu+EQ17er4e1crc7T4+2dIQdINDw0JEkVsS0qDok3Uir/IecO8ohSaO
         oH2Fb5CPZW/FW0YboMNc2M2cgccDQjW4seUazPuJNtvtmdCJ/zLVOGex5Qsi+FDoLMAz
         2k/UvdTz/HIHcQ/VnMbwmlrNb3Tdf2AdPTDStILJWCbD1mPod9myaDCT65NV3eUb/5F9
         cIOrYql4mbp9RXFQ0KtkzrzLxqE7rqsVpyD20sENr6JXhrIGFF32ggdhS0q8yqSvpIQ6
         K8pw==
X-Gm-Message-State: APjAAAXJH1KukvIxPEQosc7sMT8ggYqdL+95RtpDZSFwyIRItfRNSfkH
        naILuiyNLUqZvhhtUTinLMSgEfHjbg==
X-Google-Smtp-Source: APXvYqyege0R4wshcAYIiWymm6vQUMPjgKiKC5GhEGj/WkXa+ttPqmEB8FQ7p/IStQzHMpf7y+eHFZsQDg==
X-Received: by 2002:a37:af03:: with SMTP id y3mr9056184qke.296.1559315495561;
 Fri, 31 May 2019 08:11:35 -0700 (PDT)
Date:   Fri, 31 May 2019 17:08:28 +0200
Message-Id: <20190531150828.157832-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 0/3] Bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Previous version of this patch series and discussion can be found here:
http://lkml.kernel.org/r/20190529141500.193390-1-elver@google.com

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Use static_cpu_has in uaccess region to avoid instrumentation
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 arch/x86/kernel/signal.c                  |   2 +-
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 lib/test_kasan.c                          |  75 +++++-
 6 files changed, 376 insertions(+), 157 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc1.257.g3120a18244-goog

