Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698471189D
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 23:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbjEYVA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjEYVA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 17:00:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF04195;
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d1e96c082so182195b3a.1;
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048456; x=1687640456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XmugMWm7cWXA1ITs37LAqsWrHs4IVFQcJ9wHH0/mIo=;
        b=pVhWlAb+Q98avGA6FhcopwPwMghDgHVt14nMz/hLQ3CCZbFFI4E5oT4zZEZoyh1eP8
         R9xYOqmy+MmyZ2jvLCekIkzAzki6HJgY7Ik7XIpfv1XkhSLY0FUkDclpsj3dvniw6MR9
         2O/nO0cuDTvtPoXReaXb0gCiEzNEkt6zTB60y5QTPzzm32bMvt5b0MZLdrBxeSYcf/Qa
         17xHkx/Mdf4ugMo4M/kzfkt4KP8O95crEGkJld3Qjbvl629iPP2r2olsg5XLsQzvAGbR
         bcTGPzUo2SOLzYGmrVFylo1/cNziEMG7l512ndR2D6fdUgXasjsf7TcXmggi2sjEQO5P
         gJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048456; x=1687640456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XmugMWm7cWXA1ITs37LAqsWrHs4IVFQcJ9wHH0/mIo=;
        b=DAbA+okgL55sB5zkZzfr2fFxtc9UDDgoQyiSCwzfxMf6cqoTVs+Egr7IdUv0JAPagN
         Z12z9hmJYMPHHlZi+AzXynEQCLAyxnArak8zacdozEtzfYgnAug9d8j/BHLtb8YoeNM2
         AZIyicmkBojvNhI0a7jQ6WQzF9vSDZ9Iyzf+AYMYZtZUXLY9Z6hgUOziQKbSQbD4cBJr
         U0SY0kNdGuOYR/1UifRpserl2JwX/teB3K1Ub/6lTmQws45P0/IG/hprzORCtTzUGEAA
         axE8MLjaRHIxPDEVLljSLwFwf3xbEKOuQsTo/zlUAen0Yf1up1EIBHusyaB8qfPLyfZn
         6q3Q==
X-Gm-Message-State: AC+VfDyHhEOEHdNNhgfhxxHorJcHo9gmaj6t7rADzJzG1cLWVTU5HlZ7
        kDqJ8gmxSmbPK0pb86fcMAo=
X-Google-Smtp-Source: ACHHUZ4lwVbarII9u/uWJGcW9Q1xhF3kITOZ5lfhKz/PKVi/df+4QWSJHuQCVSdOac7t+Ha9zPUzow==
X-Received: by 2002:a17:902:d50d:b0:1ae:6720:8e01 with SMTP id b13-20020a170902d50d00b001ae67208e01mr39350plg.20.1685048455607;
        Thu, 25 May 2023 14:00:55 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae8587d60csm1807673plj.265.2023.05.25.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:00:55 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 0/3] kprobes: notrace enhancements
Date:   Thu, 25 May 2023 14:00:37 -0700
Message-Id: <20230525210040.3637-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There are inconsistencies and some issues in marking functions as
notrace. On one hand, all inline functions are marked as "notrace" and
some libraries cannot be traced. As more users and tools try to make use
of the tracing functionality, it is beneficial to allow their tracing as
possible.

At the same time, some functions should not be traced but are not marked
as notrace.

These patch address issues that I encountered during work on an
automatic tracing tool.

---

v1->v2:
* Add find_bit to tracable libraries
* Improve the change log to explain the reasons for inline->notrace
* Switch the order of patch 2 and patch 3


Nadav Amit (3):
  kprobes: Mark descendents of core_kernel_text as notrace
  compiler: inline does not imply notrace
  lib: Allow traceing of usercopy, xarray, iov_iter, find_bit

 arch/arm/kernel/process.c             | 2 +-
 arch/ia64/mm/init.c                   | 2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/um/mem_32.c                  | 2 +-
 include/asm-generic/sections.h        | 6 +++---
 include/linux/compiler_types.h        | 2 +-
 include/linux/kallsyms.h              | 6 +++---
 include/linux/mm.h                    | 2 +-
 lib/Makefile                          | 5 +++++
 9 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.25.1

