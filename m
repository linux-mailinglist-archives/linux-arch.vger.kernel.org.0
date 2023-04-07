Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769C6DB176
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDGRS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDGRSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:18:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF96198D;
        Fri,  7 Apr 2023 10:18:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso22363583oti.8;
        Fri, 07 Apr 2023 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887921; x=1683479921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl5wDUuARmyoFd8Z56SKQS2g88l5WRk3p231dzZGw/A=;
        b=EgrHYYOnypawW3295OTKPr5IFXNpjg9oyPcveiY3ZxQO613+zGOiSArayLh2R4GIXB
         p7JUKFI+r+UP6mrBjGlBIR8d3SCOzwxRbB67EtGtmDfr2cOnPD9i2CFynw8qDT/X2o6k
         cfjSGae1pz9OUmMmifOTQ66G9VDV6TmxyEovv4rmqI+bok2WPQEG5HQAdkNJUQgh+ViQ
         64sXNvciawC10b5zg34dRshn4EU4YbFmehu6ux2acLochnOWzNnJnfJGQfws4dYs3xDF
         J+kWe85bYDsb2t75HfmK/8TwWqoCUDb8YcAH4ZNDkBlnSRO3cimA9wthgTe8WPXFctzf
         PxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887921; x=1683479921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl5wDUuARmyoFd8Z56SKQS2g88l5WRk3p231dzZGw/A=;
        b=TIio0FFXshJ5S65hGM06xvRQxruqVSjoCTMS3KC7Fc2GEAFD8OPMAGw4GUy8oHIw/Z
         KfevoTTJVcSjj592K/4o4Frx2DfnHeUSpumy9bP6FSnwWLjD/an97dsfTcpAemiQlYUS
         AowyR27uO2S9H48z9g/JFQK659F7ZHlFVa05FJRVSMIdeqpkoJp/Czw3vdUDL25WH8Vw
         JVk0IXKtFxL43QElEPULsYrVIcE2pJLXcDRz6CXumgF64qlrGZUfMbKtE+iMFwSaTT2w
         kSBHOMvEAuey30rtV83CmMlYJ5fwRXWVLDTRyqZmdV8+d/qw5U5sN3ELEUzzH4rROd6q
         p0xQ==
X-Gm-Message-State: AAQBX9d+NRevsb4dCJGpgMtioZolZ4N769WJVnGryDzyKl8DUep9hXQG
        ejBSo5EAwbMIVEibUBjC/9lSO4wI0e989Tc=
X-Google-Smtp-Source: AKy350Y/JvJlgeLr9NT/ioFvnViQHl/i4UvAE4HjYdH0ENjRgjLXYvUW9g3eDBk9Le1TX3MxQYQIvQ==
X-Received: by 2002:a9d:6f01:0:b0:6a1:3cc7:170d with SMTP id n1-20020a9d6f01000000b006a13cc7170dmr1359625otq.10.1680887921246;
        Fri, 07 Apr 2023 10:18:41 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm1816730otk.78.2023.04.07.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:18:40 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v16 0/4] Checkpoint Support for Syscall User Dispatch
Date:   Fri,  7 Apr 2023 13:18:30 -0400
Message-Id: <20230407171834.3558-1-gregory.price@memverge.com>
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

This appears to be in a good state now.  Not sure which branch
I should seek to have this pulled through, or what else needs to
be done to push this forward.

v16: pick up review tags, mild comment change

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
 include/uapi/linux/ptrace.h                   | 29 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 74 ++++++++++++++++---
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 72 ++++++++++++++++++
 8 files changed, 199 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

