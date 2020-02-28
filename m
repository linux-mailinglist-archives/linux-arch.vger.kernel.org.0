Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA0172E24
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 02:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgB1BU5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 20:20:57 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:36842 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbgB1BU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 20:20:56 -0500
Received: by mail-qv1-f73.google.com with SMTP id b3so1263427qvy.3
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UxlFvDl+mYUOihiySIoFvbuwiyqTD12ewe+CWWzU0ro=;
        b=Cc0JuZTfhaIDHKNZM37wEYgZzqrbvgr4Kpn3pNKsq4dpXHFoVOP/Iy5EaG8MPe0qHM
         fqaKBpOtGroaVggoO0eF0KR+YehCClaj/Fe6Id9L8BwOyhmJPWqN9SqFrmwV1nMGBhYG
         3By6Lr+I1WyhWZyW9wmCgDsFO7Rxty9/jcF6ClbLWK9kpirrBKtj1cNL9AN8bXAhQtTl
         iBWN4ey/UqpntnkjYAfHHiMifGNshfQBWvKDt1AlkCaOsbEk/qxvpEVWm3gdz8Z47PdR
         CVNrCbYHxZXcU6vawXUsmqm9jUqvKhaV6R3SAMk2XWXdWBznnf4nrx5vUJyFAgtSyPzD
         0lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UxlFvDl+mYUOihiySIoFvbuwiyqTD12ewe+CWWzU0ro=;
        b=i00U0BJtFHjXYfedYR4WBt+9E7Ih5BiH/e34U1vgvrOCoWGe7NU/FduhO6Suqel4Vp
         FtaXVH389GJNXL/2CUv3A9PaYB6UEeiYCh7MaddH85lj/FINnpeGO0pKwKjW0bb3iUdF
         XlERKtJ0flVOISs/1H1C2nxKz6zUbAft6ZTZhw1nbbNg89r5pgIAuwuw7DnKUkGnykZ4
         L+mquAbsTncEU3KkuKZhnFCiiZqhgkF+fdEdznuNLa9bNxQNsoTUZTRAwDfNIepX2pi/
         f/nI/bYrRo1F7wLll9OE0fdgQ0dCtkSkN6fildOBPZDyhmwQhzhZTtp3P8/MREPLT/3U
         Wpvw==
X-Gm-Message-State: APjAAAWmR0DMGbexvFaqAa5vbHrQ2qhBoOyctrjzA41Nwgzp4gn45lID
        SVChoMiNvkZnAKSfg3dGPJBl7+5uD3YD5AqVlDScNg==
X-Google-Smtp-Source: APXvYqxBgrAvVVUr+eI3w9pSyj8Z2/ifloxhO80OhuCfxDoH9J4UCvD3tbTVrS4n5PAVeq88ixanzwm/QJ1cJqGp96pfXQ==
X-Received: by 2002:a05:620a:2288:: with SMTP id o8mr2477361qkh.368.1582852855324;
 Thu, 27 Feb 2020 17:20:55 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:29 -0800
Message-Id: <20200228012036.15682-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 0/7] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
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

Also, sorry for the delay in getting this new revision out. I have been
really busy for the past couple weeks.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The last two of three patches in this series add features which depend
on this:

PATCH 5/7 Prints out a test plan[1] right before KUnit tests are run;
          this is valuable because it makes it possible for a test
          harness to detect whether the number of tests run matches the
          number of tests expected to be run, ensuring that no tests
          silently failed. The test plan includes a count of tests that
          will run. With the centralized executor, the tests are located
          in a single data structure and thus can be counted.

PATCH 6/7 Add a new kernel command-line option which allows the user to
          specify that the kernel poweroff, halt, or reboot after
          completing all KUnit tests; this is very handy for running
          KUnit tests on UML or a VM so that the UML/VM process exits
          cleanly immediately after running all tests without needing a
          special initramfs. The centralized executor provides a
          definitive point when all tests have completed and the
          poweroff, halt, or reboot could occur.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
- On patch 7/7, I added some additional wording around the
  kunit_shutdown command line option explaining that it runs after
  built-in tests as suggested by Frank.
- On the coverletter, I improved some wording and added a missing link.
  I also specified the base-commit for the series.
- Frank asked for some changes to the documentation; however, David is
  taking care of that in a separate patch[2], so I did not make those
  changes here. There will be some additional changes necessary
  after David's patch is applied.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (5):
  vmlinux.lds.h: add linker section for KUnit test suites
  arch: um: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: Add kunit_shutdown to kernel-parameters.txt

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |  8 ++
 arch/um/include/asm/common.lds.S              |  4 +
 include/asm-generic/vmlinux.lds.h             |  8 ++
 include/kunit/test.h                          | 82 ++++++++++++-------
 init/main.c                                   |  4 +
 lib/kunit/Makefile                            |  3 +-
 lib/kunit/executor.c                          | 71 ++++++++++++++++
 lib/kunit/test.c                              | 11 ---
 tools/testing/kunit/kunit_kernel.py           |  2 +-
 tools/testing/kunit/kunit_parser.py           | 76 ++++++++++++++---
 .../test_is_test_passed-all_passed.log        |  1 +
 .../test_data/test_is_test_passed-crash.log   |  1 +
 .../test_data/test_is_test_passed-failure.log |  1 +
 13 files changed, 218 insertions(+), 54 deletions(-)
 create mode 100644 lib/kunit/executor.c


base-commit: a2f0b878c3ca531a1706cb2a8b079cea3b17bafc

[1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
[2] https://patchwork.kernel.org/patch/11383635/

-- 
2.25.1.481.gfbce0eb801-goog

