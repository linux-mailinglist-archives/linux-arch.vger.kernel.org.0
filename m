Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA86D10B8
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 23:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC3VVg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3VVd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 17:21:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00476A5;
        Thu, 30 Mar 2023 14:21:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x8so15103293qvr.9;
        Thu, 30 Mar 2023 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtOE0UMdyRWqW8gZrFdzTK9tdy2bCuRHI9iq9QcRs8U=;
        b=YFrzgje9+BktWWsfijArlckeFM4ZwzHGvPVl1UoisAE3+PFchEH13Yb4PZaV1vPFQW
         kFZA2kGvPdejGt4uN4dISDfE7lV2T9um8oBoJOwi1jn3mE/Eadx3JQnCL77B6WU/H6wc
         3nosF6elcxP1Ugs66NbPFlmw/uuUDnSTvVB5vSWryTUYKjlbJg0d1eiLaPlp9hD2EM9N
         m/rl1F2XwmqhKNgd4bkzf7Swc3mQb9J2nunymMMarwyAb0fhUL7Gym6M11V2JLS+kOk/
         Bz50CyTRiFrvwSXhXaWCmq5+uJ4Y4PYw9j6TRvl38JwhBQdtu14ObXBe3MhzsOIbb+0U
         qoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtOE0UMdyRWqW8gZrFdzTK9tdy2bCuRHI9iq9QcRs8U=;
        b=JbASzsfkGpEUJjmCy1S23trY2cPFygqLEVCphOBJnf2PJvmrlhbh+E4S9QoLc+wZ0w
         SbUqi7PIy2ciIZ/3/i67cWym21LLhoDWjdYrXs9t0LJJwFRUCJ8pABRvj2pfiFGmOQt7
         FPal1/YFnaGyhJGyhN+Jh2AX/Bjf4y8R2vwS92F2hRKaTn3eXIKm3TxYWLrGAiCvSq90
         pQ2p39M04tF+NSA61DMg9b1uIWsyX773CrLRI1imoDyjrdvSfki2iko3WtCcBFF8pmoQ
         rB+PcLrxvyRCPBoU//aeQaea5dLpYaxBckk5ntyIceM8Tin2JV9tWE+bMXPlImsuZJGA
         isKw==
X-Gm-Message-State: AAQBX9fonrPvSItomr5AdyRcDF5kNSLRyPl2udhCdj2m1ol/qkN3ywEu
        ZJpjuASCOcTvAUYJ4ly0M9fMaec93NoXKcI=
X-Google-Smtp-Source: AKy350YwogZzSCdVnLOQ8xz3NArRj7h88NOMJmHPk6DJwoLdAIK8qFrmrPteEvVqaHqaledt3Qav0A==
X-Received: by 2002:a05:6214:1cc7:b0:56c:13cc:d21f with SMTP id g7-20020a0562141cc700b0056c13ccd21fmr40185191qvd.50.1680211291043;
        Thu, 30 Mar 2023 14:21:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id mx5-20020a0562142e0500b005dd8b9345desm110761qvb.118.2023.03.30.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:21:30 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v15 0/4] Checkpoint Support for Syscall User Dispatch
Date:   Thu, 30 Mar 2023 17:21:18 -0400
Message-Id: <20230330212121.1688-1-gregory.price@memverge.com>
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

v15: drop task_access_ok variant, instead prefer to just untag the
     selector address when validating the user pointer.

v14: implement task_access_ok variant for cross-task pointer checks

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

- Refactor configuration setting interface to operate on a task
  rather than current, so the set and error paths can be consolidated

- Untag the selector address when being set in order to enable an
  untagged tracer to set a tagged tracee's syscall dispatch selector.
  Otherwise an untagged tracer will always fail to set a tagged address.

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.

- Selftest for the new feature

Gregory Price (4):
  syscall_user_dispatch: helper function to operate on given task
  syscall user dispatch: untag selector addresses before access_ok
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
  selftest,ptrace: Add selftest for syscall user dispatch config api

 .../admin-guide/syscall-user-dispatch.rst     |  4 +
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 +++++++
 kernel/entry/syscall_user_dispatch.c          | 78 ++++++++++++++++---
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 72 +++++++++++++++++
 8 files changed, 203 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

