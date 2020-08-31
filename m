Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69793257F6E
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgHaRRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgHaRRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 13:17:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0019C061573;
        Mon, 31 Aug 2020 10:17:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so219353wmb.4;
        Mon, 31 Aug 2020 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=omJSdCF9LRUBeNyaGVZgAUdyoa7g3/hayiLS3eL5rO4=;
        b=ovQaFw6MStTL7zQNrwrv32uyIcT3QBZewRcBGHIKTU91Kvmcp0UeM5SnYjoBlxZ9g0
         CG7iotmjXdApbyLTgU3N22mlRyzfnQpnLHWrlKjpbhpSM4SIpmz5DkQ7Ht5MkcJFk3SS
         kJ3dkwRAFPB1jxokkWKyJKQkwjbfMuVu9JgvUVEbVvAbBZgUqxlbPrV6S7cZGZ+S2XdZ
         c0ll0hneR6CfkyqyfLZFDZMqXKPhKGgdIWNonzpuW4Yh501gdKXhB9yLyC3QGjpuSGef
         XhW4LqP63sIAbMKCJXeD3egYqHe4At70MMYtvClD8IOMNDDtcY9nCOZ0ufN8T50dLFjv
         B8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=omJSdCF9LRUBeNyaGVZgAUdyoa7g3/hayiLS3eL5rO4=;
        b=Dqq14TkNry0yeKD7Y1cyzwmYyP/6RpaVCsp7qiir/1jAEdGCZN5E/RSUvFpBQNB5ic
         uw2bxYd8v+FPPEr9RD0SZ4wYGsXeuxSpswfhWqF8xm9oRlDPO+xEXDGMsOnm6MhdLqJs
         wC9RqkemKuoG56y3+CzfT0qiOp2x2H/r/90vnV28aIg8cxseZNhH/H9R42VAKXOC9DgU
         83mL9nKDI+h/QIJqWxAC+apcegRIn1GqFT7sSDrjS2r96XGUset1BfkXxr/wwFPTW/jd
         hNaCcQHFY3YfizMl0Gls3lZx8b7TEfHt6Th/Iy+ZkIbU9EHanu4MFCNdHk5jZh/kViPY
         rKUA==
X-Gm-Message-State: AOAM532nUXva2w3l0vYT+Lsi06ELT4FiHuYaawnq2Mu6qbv+yhb+EQ/e
        V9AzYGWAgoJJqYzYgaz7oyA=
X-Google-Smtp-Source: ABdhPJyCPVYfee4Yt6tGFRPtof/saTvALDLQfLvOCz779mNzoFYwjcimba4qKJCdjyhbFLfqBbyv/g==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr262941wmu.156.1598894261488;
        Mon, 31 Aug 2020 10:17:41 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id w15sm840978wro.46.2020.08.31.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:17:40 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de,
        peterz@infradead.org
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v3 0/3] add fault injection to user memory access
Date:   Mon, 31 Aug 2020 17:17:30 +0000
Message-Id: <20200831171733.955393-1-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

The goal of this series is to improve testing of fault-tolerance in
usages of user memory access functions, by adding support for fault
injection.

The first patch adds failure injection capability for usercopy
functions. The second changes usercopy functions to use this new failure
capability (copy_from_user, ...). The third patch adds
get/put/clear_user failures to x86.

Changes in v2:
 - simplified overall failure capability by either failing or not, without
   having functions fail partially by copying/clearing only some bytes

Changes in v3:
 - adressed comments from Peter Zijlstra: fixed inconsistent ordering
   with might_fault()

Albert van der Linde (3):
  lib, include/linux: add usercopy failure capability
  lib, uaccess: add failure injection to usercopy functions
  x86: add failure injection to get/put/clear_user

 .../admin-guide/kernel-parameters.txt         |  1 +
 .../fault-injection/fault-injection.rst       |  7 +-
 arch/x86/include/asm/uaccess.h                | 68 +++++++++++--------
 arch/x86/lib/usercopy_64.c                    |  3 +
 include/linux/fault-inject-usercopy.h         | 22 ++++++
 include/linux/uaccess.h                       | 11 ++-
 lib/Kconfig.debug                             |  7 ++
 lib/Makefile                                  |  1 +
 lib/fault-inject-usercopy.c                   | 39 +++++++++++
 lib/iov_iter.c                                |  5 ++
 lib/strncpy_from_user.c                       |  3 +
 lib/usercopy.c                                |  5 +-
 12 files changed, 140 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/fault-inject-usercopy.h
 create mode 100644 lib/fault-inject-usercopy.c

-- 
2.28.0.402.g5ffc5be6b7-goog

