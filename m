Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F425255C13
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgH1OOx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgH1OOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 10:14:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349EC061264;
        Fri, 28 Aug 2020 07:14:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so1439191wrn.10;
        Fri, 28 Aug 2020 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlt5UNWrrUfldyXAKmHrnUn5NEQ0elR0Vt5Pg2JGln8=;
        b=kzMp7c0AdIAC5mQQZmdYUf6jblzE71CtRJtKTuuwgWIb97aI25qdH9h6CFAj2ozClI
         kjKQ6UKCCcb8VPdBlIBMY4/ApJyKLLvWA0NJxy9gezTKJbO2LmDk5KeUyewNj/LJRhNK
         t0UJSE7FHDYdEl3yfav4iDej5uzWCL+sgLYXkpMHzf1djcwbwUWRxNxg0y7vTf1X799O
         GniYDvB0XjXTT8+FcL+qdX1fXmAGpXUU7uGyqhtdCOaEP0KFCukHlLRXU/VfbednUJJm
         6Ys3pFJXgkq9s8R+7YlfVjIoI1FY3XKcI+jkRrQJzNSm6WItLcCORz7p46G9mqmznhc6
         lw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlt5UNWrrUfldyXAKmHrnUn5NEQ0elR0Vt5Pg2JGln8=;
        b=EyqECl71bDPoWOoMY4SnddUSHAfh258qSU1Sbf2oJhsBuSLvl7Ze8SornnstLoSZTH
         M0w2z+fJoIsmYwhWpIQgFPIhblqGQzz+pE4yc/tnpv6ITpmvylPwzEYV4CY21SlhYT9E
         ruOTdx9bjMVMfHkOYIf6AIt4nLAkjgC0Hlk3WfsAQ9QYfqPlAk3/TIe5fkVBnIPCSAgE
         hrSRw9q3ONELf/IXii0z/KO1pAtCnLrICZTY/8FlZL7JaqPXUcyJGsoPFuG0ZfS/Btkz
         i4e3H1fnACSKtWYRYPjLL734yGMpHV5lQPuy+Y5MfQ+6wgR2bPTWD7qke6rq3LPhw0Hm
         pGUg==
X-Gm-Message-State: AOAM533AYKuvPTl3NlIYfN6RfthIznagvb0UGsCuJfGCQ6zrfF59zJmH
        WFoct0efkPNutA0L8J//Pzg=
X-Google-Smtp-Source: ABdhPJxZMGdWa6syImFZ1Rpg1i8h5r50MIv9UEemFtniL2GpHk/rKW5vb9dDjGmujLjKTbhrW1KHxg==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr1728874wrv.317.1598624054401;
        Fri, 28 Aug 2020 07:14:14 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id t4sm2248235wre.30.2020.08.28.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:14:13 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v2 0/3] add fault injection to user memory access
Date:   Fri, 28 Aug 2020 14:13:41 +0000
Message-Id: <20200828141344.2277088-1-alinde@google.com>
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

