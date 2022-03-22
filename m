Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F14E4657
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiCVS6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCVS6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:58:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235291548;
        Tue, 22 Mar 2022 11:57:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bc27so13270276pgb.4;
        Tue, 22 Mar 2022 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/C+r+DGfxoX8ATQDf4s+Is3SaexFRtpbLCXDVcWdio=;
        b=kSfHfmNgWSWJBBFWfVDRwsGt99pDFf9+abSF3um81FCUeThZCoB4o7i9fADQsiluTL
         r8VcwMtkwPV6YJeUxjOzY+7jVrj3pEcOaqlYrHks2c+sYaAQsZuRNDwRj5WqeyT/NSTP
         K1jBl8+cDjcZJC0XlKIxgw2G5RHHEZyyfPvWjmp0hdcF/v0IREWtnMGiz9j8fpOIUoao
         NIdUZJFwXF3MhpUTQJ2gOU+htX24hh12s2wf8VSFP061H4YAxbODwx5xVrHr7ME/Aqdb
         3si7wURU5mCd7aGLgRfuSDBukrDxw++G2mXVdE3apZuesLAvAZjv22M4X8KsACSKMwOd
         GNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7/C+r+DGfxoX8ATQDf4s+Is3SaexFRtpbLCXDVcWdio=;
        b=U40oswWIVzcC1lriX3n51LepF73FwQ1jAdoXebZIxBkfYv+K0xUFL6qEdcyBPF804t
         xe4ck53i7KY2+t94ABNKnIbyNU3taz22SIEOv7mAP37w5GaOQ/g6iWNFsa6WY7COCemJ
         0eWz/yr4rINL6XorEPrlvOK8wejqaq6qwVJcF3Dpf/mcVzvgL+Ol6mJwBh/czpCYDXzf
         pEbIG+2E7C0qDxoDXHKfd1b4oV1TDQ6xWj03J4ckdHWkQLG8JWWxE44KY3srhlArISq2
         PtUIDlQYHJrPQQQbYW+PKOdgM47lrxDk8Fr1WDF5jMKHJt8+hyp5oRdyg0ZiI2Q+T2yI
         Jv0w==
X-Gm-Message-State: AOAM530k1/XeYBi7WMyXiNz8AmCfCAybf5GRDuSoi6842/Uf+BcLv9J5
        orY35O93nUFT1KohUYW+mxz/Qm4HXBo=
X-Google-Smtp-Source: ABdhPJxfagjRc+kiSTPP2nVajfWpYTsYr0uvUXeR0af+I1dJ+0wOKYuvefOGneiaCuv7gk2acOP/JA==
X-Received: by 2002:a63:af06:0:b0:378:3582:a49f with SMTP id w6-20020a63af06000000b003783582a49fmr23051758pge.125.1647975432914;
        Tue, 22 Mar 2022 11:57:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:c09f:7727:246c:bda2])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm3772681pfi.149.2022.03.22.11.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:57:12 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/2] locking: Add new lock contention tracepoints (v4)
Date:   Tue, 22 Mar 2022 11:57:07 -0700
Message-Id: <20220322185709.141236-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

There have been some requests for low-overhead kernel lock contention
monitoring.  The kernel has CONFIG_LOCK_STAT to provide such an infra
either via /proc/lock_stat or tracepoints directly.

However it's not light-weight and hard to be used in production.  So
I'm trying to add new tracepoints for lock contention and using them
as a base to build a new monitoring system.

* Changes in v4
 - use __print_flags in the TP_printk()
 - reworked __down_common for semaphore
 - add Tested-by from Hyeonggon Yoo
 
* Changes in v3
 - move the tracepoints deeper in the slow path
 - remove the caller ip
 - don't use task state in the flags
 - add 'ret' field to the contention end tracepoint

* Changes in v2
 - do not use lockdep infrastructure
 - add flags argument to lock:contention_begin tracepoint

I added a flags argument in the contention_begin to classify locks in
question.  It can tell whether it's a spinlock, reader-writer lock or
a mutex.  With stacktrace, users can identify which lock is contended.

The patch 01 added the tracepoints and move the definition to the
mutex.c file so that it can see the tracepoints without lockdep.

The patch 02 actually installs the tracepoints in the locking code.
To minimize the overhead, they were added in the slow path of the code
separately.  As spinlocks are defined in the arch headers, I couldn't
handle them all.  I've just added it to generic queued spinlock and
rwlocks only.  Each arch can add the tracepoints later.

This series base on the current tip/locking/core and you get it from
'locking/tracepoint-v4' branch in my tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (2):
  locking: Add lock contention tracepoints
  locking: Apply contention tracepoints in the slow path

 include/trace/events/lock.h   | 61 +++++++++++++++++++++++++++++++++--
 kernel/locking/lockdep.c      |  1 -
 kernel/locking/mutex.c        |  6 ++++
 kernel/locking/percpu-rwsem.c |  3 ++
 kernel/locking/qrwlock.c      |  9 ++++++
 kernel/locking/qspinlock.c    |  5 +++
 kernel/locking/rtmutex.c      | 11 +++++++
 kernel/locking/rwbase_rt.c    |  3 ++
 kernel/locking/rwsem.c        |  9 ++++++
 kernel/locking/semaphore.c    | 15 ++++++++-
 10 files changed, 118 insertions(+), 5 deletions(-)


base-commit: cd27ccfc727e99352321c0c75012ab9c5a90321e
-- 
2.35.1.894.gb6a874cedc-goog

