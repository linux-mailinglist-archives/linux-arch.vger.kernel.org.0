Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD83121C4C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 23:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfLPWGv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 17:06:51 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53256 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPWGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 17:06:51 -0500
Received: by mail-yb1-f201.google.com with SMTP id g12so7625855ybc.20
        for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2019 14:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eppmz6bMb+izn2RzN3lnlHeodL5pBLSTz1Q/CRKnTLI=;
        b=Ka/YLRaXtmaXZjNlTNPGUBn6yNVXrLBSLTY7QlLmb+pGLBk64G75unoAUKw7ENQh6A
         uN5BE7ghfj4hLmg93Dnjr1XOQx9sqGT0tdRhCq572hnGsODMcX8BJaKgKGcekmQHBOhO
         AT/G6wElDlZ16v6nXSv4LBy5fVRgnz65y56kDJQ63lH+EwqP4r4UCAJCoUmp7jWabH2A
         irCUuf+Ew8cP8BWTuuXQZ7lkAr38ls5Def/i0fnUPPezbu4E1eeS4PwFWlu2NXCQ1HUv
         S/CgWSpEN0xx6SLk+OOe8LLXlhdyBfcgbL4oUC4VSaGDR/NZqrh+rbF0+AzVkdQDf+rM
         tSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eppmz6bMb+izn2RzN3lnlHeodL5pBLSTz1Q/CRKnTLI=;
        b=s29BK7r4tW0lVVthtJ1em9iM7eNnoAWQC6AY9Z2Ofy2KrpfCiym5LdVKoh2qSxSFNN
         +lnLUc0kq2AP5duyyppWJU31tYUUSKus9nHn2qCiupnO+EYwIJfZnwf7Wp/f3D0GRleT
         e/v9ugR9qqnz62EVCkSHjWjuePxmlLzSvG2wjqSPMU6ApjvXWH2fU4aDhI8KLyPEo4YQ
         WIxtJDaDFdsepi2/P/4Epbwqod1ZblCrs+BqvSI/OQdERgAP3HJY56bD3PQRzYb/7rLl
         +57LBVKphpk6W+nKXE/6gqIJl6oZUgXurH5JYs7Car4IUwVJ8f3NUm42fhkQ8OodPbT4
         LeqQ==
X-Gm-Message-State: APjAAAWrZ2pyCbaTv4kQey1BqLVVtLnCW5EyFGVDeQzKRlpAAxZRzR41
        CDgAv0HunTPPhIWXg38Wo6Lkg8MLpKn+zsJYSVyciA==
X-Google-Smtp-Source: APXvYqyw/OZ9oh2P4WMQ92Laluc4AJxvHqFO1NRLPLVu6fYKpIM1zMHeoh4jp2nR813dRQsMDcwHNPAwIm/JNWREsel9rQ==
X-Received: by 2002:a0d:ddc8:: with SMTP id g191mr21773562ywe.335.1576534009902;
 Mon, 16 Dec 2019 14:06:49 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:49 -0800
Message-Id: <20191216220555.245089-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The last two patches in this series add features which depend on this:

RFC 5/6 Prints out a test plan right before KUnit tests are run[1]; this
        is valuable because it makes it possible for a test harness to
        detect whether the number of tests run matches the number of
        tests expected to be run, ensuring that no tests silently
        failed.

RFC 6/6 Add a new kernel command-line option which allows the user to
        specify that the kernel poweroff, halt, or reboot after
        completing all KUnit tests; this is very handy for running KUnit
        tests on UML or a VM so that the UML/VM process exits cleanly
        immediately after running all tests without needing a special
        initramfs.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## What work remains to be done?

These patches were based on patches in our non-upstream branch[2], so we
have a pretty good idea that they are useable as presented;
nevertheless, some of the changes done in this patchset could
*definitely* use some review by subsystem experts (linker scripts, init,
etc), and will likely change a lot after getting feedback.

The biggest thing that I know will require additional attention is
integrating this patchset with the KUnit module support patchset[3]. I
have not even attempted to build these patches on top of the module
support patches as I would like to get people's initial thoughts first
(especially Alan's :-) ). I think that making these patches work with
module support should be fairly straight forward, nevertheless.

Brendan Higgins (5):
  vmlinux.lds.h: add linker section for KUnit test suites
  arch: um: add linker section for KUnit test suites
  kunit: test: create a single centralized executor for all tests
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 arch/um/include/asm/common.lds.S              |  4 +
 include/asm-generic/vmlinux.lds.h             |  8 ++
 include/kunit/test.h                          | 16 ++--
 init/main.c                                   |  4 +
 lib/kunit/Makefile                            |  3 +-
 lib/kunit/executor.c                          | 74 ++++++++++++++++++
 lib/kunit/test.c                              | 11 ---
 tools/testing/kunit/kunit_kernel.py           |  2 +-
 tools/testing/kunit/kunit_parser.py           | 76 +++++++++++++++----
 .../test_is_test_passed-all_passed.log        |  1 +
 .../test_data/test_is_test_passed-crash.log   |  1 +
 .../test_data/test_is_test_passed-failure.log |  1 +
 12 files changed, 170 insertions(+), 31 deletions(-)
 create mode 100644 lib/kunit/executor.c

[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
[2]: https://kunit-review.googlesource.com/c/linux/+/1037
[3]: https://patchwork.kernel.org/project/linux-kselftest/list/?series=211727

-- 
2.24.1.735.g03f4e72817-goog

