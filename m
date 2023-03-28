Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2F6CC861
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjC1Qs0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC1QsY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 12:48:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4428A49;
        Tue, 28 Mar 2023 09:48:22 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q88so9523243qvq.13;
        Tue, 28 Mar 2023 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680022102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Tvv02beQxw04P5UwgN8lsFSBfOGArfLL4YIiRjeVg=;
        b=QGbyQ2OVm/JaefeGmkoM3bQ/pmorQVe+oX3slbncUyNgKcdrd60ZjraMe1BEkNahlB
         LgUjx2vqbj+WcIOnxuYL+llvGJekVUkO3WQduZTR+gKtSkUuN8BgOUD26cyQ2HIXkIuX
         cC2tW7bsjEpSeW6wlb1oJEiJm34Y71NuHA9JJb/GaH7bFSTeWlCyBat8Cp+H4mDcg53k
         3ftrJBL0RYv5yfq/8mcLri7EOkcX64JGTY0xTeaIjJMPoe2vG0ya3A09FR8cptyfHc0H
         lsvSu5EgejkesFf85yUFHHta8T/39f0j4kubbyLcTNPbMzdj9329B8u5g9lTOzegvv8o
         jm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5Tvv02beQxw04P5UwgN8lsFSBfOGArfLL4YIiRjeVg=;
        b=sOxaqTqw9kdhECjphbJkRk8qrkVY0Na4SSTnqoQ+mNqOyYlCNbACHvEWlEScy1VvOw
         drWqMhLc8LdFjz9QMr8upj4FWGkQePt9vq+buTM6owrM2QmEUZ7LdL2SVdbU5PwxUPSY
         W1kd+FCPGKn797Pa73xmu2yP7S/Ptr+Q6HiSSTQcnoGoqLB0tDEXey7YGg3RYeP2PUpQ
         3oUshyzSzBEUl96Gf+gfmC1rjJMPGyIS+/EFeT8xmazBfuTWuc1yjU6vh0rWPHSf01ry
         iSbd26hl2qL7WIS28UsvHKfel5yUfA01IVralljGprR8P5AKyfr44R49UdohVgP+3tvM
         bBuQ==
X-Gm-Message-State: AAQBX9cc06cYa1Di+9GGyo3qHoMUwOcG94BszFQFpDVpM5mDRYTudcgP
        HHtYJJli0vehEZui9tO/iOL0fw6n9pSk+bM=
X-Google-Smtp-Source: AKy350YOkL74vRK61mRi1pJPqckixB4oEN5zmCmx5upWbMccNyntAe/H6RyfQGuqJMXUJOrCLBj4AA==
X-Received: by 2002:a05:6214:130b:b0:56f:fb19:1650 with SMTP id pn11-20020a056214130b00b0056ffb191650mr29277713qvb.2.1680022101920;
        Tue, 28 Mar 2023 09:48:21 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id qh16-20020a0562144c1000b005dd8b93457bsm3938206qvb.19.2023.03.28.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:48:21 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v14 0/4] Checkpoint Support for Syscall User Dispatch
Date:   Tue, 28 Mar 2023 12:48:07 -0400
Message-Id: <20230328164811.2451-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v14: implement task_access_ok variant for cross-task pointer checks
     patch 2/4 changed from access_ok to task_access_ok

v13: sizeof consistency and cosmetic changes in patch 2

v12: split test into its own patch
     change from padding a u8 to using a u64
     casting issues
     checkpatch.pl

[truncating version history]

Syscall user dispatch makes it possible to cleanly intercept system
calls from user-land.  However, most transparent checkpoint software
presently leverages some combination of ptrace and system call
injection to place software in a ready-to-checkpoint state.

If Syscall User Dispatch is enabled at the time of being quiesced,
injected system calls will subsequently be interposed upon and
dispatched to the task's signal handler.

Patch summary:
- Create new task_access_ok which leverages the provided task's
  information when validating userland pointers.  For ARM64 this means
  MTE tags are accounted for.  For all other architectures, this simply
  reduces to access_ok (presently).

- Refactor configuration setting interface to operate on a task
  rather than current, so the set and error paths can be consolidated

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.

- Selftest for the new feature

Gregory Price (4):
  asm-generic,arm64: create task variant of access_ok
  syscall_user_dispatch: helper function to operate on given task
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
  selftest,ptrace: Add selftest for syscall user dispatch config api

 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 arch/arm64/include/asm/uaccess.h              | 13 +++-
 include/asm-generic/access_ok.h               | 10 +++
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 67 ++++++++++++++---
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 72 +++++++++++++++++++
 10 files changed, 213 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

