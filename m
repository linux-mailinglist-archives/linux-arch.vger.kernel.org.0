Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98424D327
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHUKux (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUKus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 06:50:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A8C061385;
        Fri, 21 Aug 2020 03:50:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so1201276wrk.5;
        Fri, 21 Aug 2020 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtGTI20ikpo9yrdbtnPeFApzutOhVS8mtXYK+BL9WVU=;
        b=kQQaBmsc8NAj7eee85q/KB7MQrzJhEsxPIgl0oc2lCV9PlaQWsQRMlDNgnbscpFM0Q
         R9PzWtmELthOksGDErUQP3TGYQsdYQ9RGsv63nM4h+iPw5XihXUlHxsgLD6ofrmkJahO
         Zw35o1qmJ/tk2Nomd4lz4CjcAXWMTEzg5hFbJNyUHrVZwVOoU7WRFoCuQdWnCkfylasN
         +SlgojrMgfU7+5eCY5KojU/kLjkXEEPmS9A7Y00T4svQKBFpoYdGpPlxOFYUrt8zTA5C
         6KCFx1yX01hlIbMEqKRZs2u0K1RYYW5spxDUH5y+RyIsAw+f27JjT5QLeh9kC3O1hc1X
         3ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtGTI20ikpo9yrdbtnPeFApzutOhVS8mtXYK+BL9WVU=;
        b=Cxmmbx52EI7dJnYqbMQgWKSK0SEbKm8PaV9LSwOOt4Plf9Gg33WiWx6qQ4+ya8kCmk
         Cug9iUFdGPnP0mSKB46QgGynl9CnGQ7E2+63WuBfcHhJoTgC9GKkYIIHK6dvm0TwBqaT
         un5KRVHXC8kzc1cqEZluMssxn7ylpjJZETOZKbllRR3i79aBUwxQING7KACQHqY0s3gH
         pEydTx7XoXZx37D5VzRD9tN9hfS/e/D/mSIABsDBXpwW3QW//o8OT0iEywnzxWUXQkG2
         rMuRaVuE+N1/Hubwug7Cm+VTGSfT2pNRkyqni8iYq6EiABk7h45IhdG3aeEpFy0u/Zqx
         kZaw==
X-Gm-Message-State: AOAM530hHBwiOxh9KkV7d0tQpDfUxMC18UOsor8WIjiTwvGOvr90Kitc
        dp/2xKjPF2hm8W5CYLJSbXk=
X-Google-Smtp-Source: ABdhPJxRZEHVCFhq/bl553CGJr+hfpGZJdr1FSZRp2OSH3emca/uk8vmFmW3MtQXPUmRZ5adVHc0qg==
X-Received: by 2002:adf:c981:: with SMTP id f1mr2204767wrh.14.1598007046482;
        Fri, 21 Aug 2020 03:50:46 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 8sm3784911wrl.7.2020.08.21.03.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:50:45 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Albert van der Linde <alinde@google.com>
Subject: [PATCH 0/3] add fault injection to user memory access functions
Date:   Fri, 21 Aug 2020 10:49:22 +0000
Message-Id: <20200821104926.828511-1-alinde@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
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

Albert van der Linde (3):
  lib, include/linux: add usercopy failure capability
  lib, uaccess: add failure injection to usercopy functions
  x86: add failure injection to get/put/clear_user

 .../fault-injection/fault-injection.rst       | 64 +++++++++++++++++
 arch/x86/include/asm/uaccess.h                | 70 +++++++++++--------
 arch/x86/lib/usercopy_64.c                    |  9 ++-
 include/linux/fault-inject-usercopy.h         | 20 ++++++
 include/linux/uaccess.h                       | 31 ++++++--
 lib/Kconfig.debug                             |  7 ++
 lib/Makefile                                  |  1 +
 lib/fault-inject-usercopy.c                   | 66 +++++++++++++++++
 lib/iov_iter.c                                | 20 +++++-
 lib/strncpy_from_user.c                       |  3 +
 lib/usercopy.c                                | 13 +++-
 11 files changed, 263 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/fault-inject-usercopy.h
 create mode 100644 lib/fault-inject-usercopy.c

-- 
2.28.0.297.g1956fa8f8d-goog

