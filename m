Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68754C7FFB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiCABFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCABE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:04:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEDDFDA;
        Mon, 28 Feb 2022 17:04:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso778100pjb.4;
        Mon, 28 Feb 2022 17:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxbuS4aazLDL51xW5kf+AQjRVbpgf9TG+em7RLL+8w4=;
        b=dB9Clx8zmHr6yzW3aX6j6WXoTlHrg5n2x0hjgiXerhpzAfxcgU9G/x4d+wNouipXk6
         qSo7DgvVlGzHdH9U7crZwrssu7wRqs8vqpp7VzwbW6E10nDvqHtW31sACoVAIoR856sm
         3B6PK0MVKfR5aC0Rje68dCwbUTiMiQuCprLLHPKjV4MLT+OcogmQpnSzmMv1SQjs1ZYi
         Vq54U7z2JIEkiYgKSW4GzEjyJC/Z1HtcjTQkpd7E/YW5AIvU54clEalIsgYUgBluWuFo
         0q7JFz1ffva/IFpoViX2GYCn7Nch1vWOsZD/a/gLuoYwBwWGW+TJp4erqZAPHJW2vahv
         n+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JxbuS4aazLDL51xW5kf+AQjRVbpgf9TG+em7RLL+8w4=;
        b=gIWTmjPQDKjSAlBr3mmnO18fkgaMCn052vfDtNvVelXC62pxTtImU4K830RBzSRnhl
         0oKPtDHNNjS3eTZvXdQ6NEa8Tk5bzuo0HG4D3BmWW76VyIW9ex5DVQ9yOjC+y/2Yoir6
         A56r1O6+iMvFE2m1EDbV3w62Ydwpf48XqRkQXzxsPs+cWvjMVeisneq89HN6G5uF0R90
         0PVaxpD7MvvvosmZGy3KWMdRAYAfGOnykZvo+BwBlbLIOhWg1KmYBzkBnDf9qNj4Q8wC
         p3ZWg+wRh2UnqTB6GqvVz2KrfWHMdqHQqwi8j+NPonpHbuC97nv/OLhghWU5w9DB6us+
         9Zeg==
X-Gm-Message-State: AOAM531Zvh1mbV70RptIx21G+Gwnq2NTM0fE/sXGliAQ50bnrFcgsR0Y
        yGS8pk4noEpQzg9xPB8mZR0=
X-Google-Smtp-Source: ABdhPJzV+sq8kEU2RDQZxJoEVlhPZjoiXebtB+kHHRMxLRH5EBx23aIIx559emKKm2xLfONZUR8rng==
X-Received: by 2002:a17:902:b945:b0:14f:f05e:5479 with SMTP id h5-20020a170902b94500b0014ff05e5479mr22651166pls.94.1646096658850;
        Mon, 28 Feb 2022 17:04:18 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:726c:585a:8796:a60a])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm83861pjb.57.2022.02.28.17.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:04:18 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: [RFC 0/4] locking: Add new lock contention tracepoints (v2)
Date:   Mon, 28 Feb 2022 17:04:08 -0800
Message-Id: <20220301010412.431299-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
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

* Changes in v2
 - do not use lockdep infrastructure
 - add flags argument to lock:contention_begin tracepoint

As we don't want to increase the size of lock data structure, it's
hard to have the name of locks or their classes.  Instead we can use
caller IP to identify contended locks.  I had to modify some places to
have that information meaningful.

Also, I added a flags argument in the contention_begin to classify
locks in question.  The lower 2 bytes will have a task state it goes
to.  This can be TASK_RUNNING (0) for spinlocks, or other values for
sleeping locks (mutex, rwsem, ...).  And the upper 2 bytes will have
addition info like whether it's a reader-writer lock or real-time and
so on.

The patch 01 added the tracepoints in a new file and two new wrapper
functions were added.  This file contains definition of all locking
tracepoints including lockdep/lock_stat.  The wrappers are necessary
because some kind of locks are defined in a header file and it was not
possible to include tracepoint headers directly due to circular
dependencies.

The patch 02 actually installs the tracepoints in the locking code.
To minimize the overhead, they were added in the slow path of the code
separately.  As spinlocks are defined in the arch headers, I couldn't
handle them all.  I've just added it to generic queued spinlock and
rwlocks only.  Each arch can add the tracepoints later.

The patch 03 and 04 updates the mutex and rwsem code to pass proper
caller IPs.  Getting the caller IP at the tracepoint won't work if any
of the locking code is not inlined.  So pass the IP from the API
function to the internal ones.

This series base on the current tip/locking/core and you get it from
'locking/tracepoint-v2' branch in my tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (4):
  locking: Add lock contention tracepoints
  locking: Apply contention tracepoints in the slow path
  locking/mutex: Pass proper call-site ip
  locking/rwsem: Pass proper call-site ip

 include/asm-generic/qrwlock.h   |  5 ++
 include/asm-generic/qspinlock.h |  3 ++
 include/linux/lock_trace.h      | 31 +++++++++++++
 include/linux/lockdep.h         | 29 +++++++++++-
 include/trace/events/lock.h     | 43 ++++++++++++++++-
 kernel/locking/Makefile         |  2 +-
 kernel/locking/lockdep.c        |  1 -
 kernel/locking/mutex.c          | 44 ++++++++++--------
 kernel/locking/percpu-rwsem.c   | 11 ++++-
 kernel/locking/rtmutex.c        | 12 ++++-
 kernel/locking/rwbase_rt.c      | 11 ++++-
 kernel/locking/rwsem.c          | 81 ++++++++++++++++++++-------------
 kernel/locking/tracepoint.c     | 21 +++++++++
 13 files changed, 235 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/lock_trace.h
 create mode 100644 kernel/locking/tracepoint.c


base-commit: cd27ccfc727e99352321c0c75012ab9c5a90321e
-- 
2.35.1.574.g5d30c73bfb-goog

