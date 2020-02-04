Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04E21521D1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 22:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBDVSp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 16:18:45 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45409 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgBDVSo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 16:18:44 -0500
Received: by mail-yw1-f67.google.com with SMTP id a125so117768ywe.12;
        Tue, 04 Feb 2020 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJdNxill8piqvMTWCgF4RO24y2zuf2qXqfrV3PzwGbQ=;
        b=QJongeyYsMcOyLwpvXAwz6WVMVDNeXOfV03/lDzb1w++4+APc5JpfERT6/M36Me943
         0TE46okBUMZcgFUSz7/U0eAzS0hX5mwTJET3bF5woubK5iqfFoND5279RcPU1/z5zlPb
         rsEGY4G7wLyc0riOmp5xb5uXALgBpgcoa7r0MZ0AoFidRnrLmIAqWFi9qvO0lbHPW2Uu
         wCzGdGPlQdjgMgk0GRG4oK0LMzL3bqviHeBPaBLVtzc+9OygZQtLKwTj8K8xmed/2Ooe
         3PfWrIz+lloiFGRDybGnlxqoqiIFvInklnmnDLKSJlbd+VeqUAtiDU/qDYlVJDXmD6lJ
         vVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJdNxill8piqvMTWCgF4RO24y2zuf2qXqfrV3PzwGbQ=;
        b=D5Y/1eF0EzYqd7u/7/QrjsR35dtmkuZ/MWl/8B4Rthmageef+2t89CPsIDbadV6uR6
         ulkcXjMaWj2W5itPvGon92UOwSyvFv8W2dxlDqcG325GM7cRqqzQ2IPCg+1wsGa0egv1
         73uWjRQ2munQ9gw7bPsDvSJyZ7NsccdB0WdyRFyhx2xT+DpMBxD0toED/9rkBbIDEw/S
         qlUBH7ALzRPInZeGR27rU4CmX3lbgExJQK5gTDQVFL38rYCmpzSp/7TzfcU0j5NA7Vw8
         C9nFBJUy+IHP9mgsQ70LH5yd4MS1olzvBKzx/FFMMnZPpiF8cyXZwnyEpKlMGT0TggEn
         1kNA==
X-Gm-Message-State: APjAAAXvN+T/P/gpDtS4stI5uPUMK+jRz88KMDbwUf2G9/tLu81nCCNd
        P3mKZQNLOrmgx1G/pGxo3L3u5S0j
X-Google-Smtp-Source: APXvYqx/4pLiWvDN2SSeNNE0WCYREq9BMw/a3Cyz3ZlWWFHi2jbhi1ruHmyqFPzoGZ1eBHqH741jjQ==
X-Received: by 2002:a81:a00f:: with SMTP id x15mr7413542ywg.327.1580851123678;
        Tue, 04 Feb 2020 13:18:43 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 124sm10363570ywm.25.2020.02.04.13.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:18:43 -0800 (PST)
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200130230812.142642-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9e203718-dcca-3145-bc28-28979d41c278@gmail.com>
Date:   Tue, 4 Feb 2020 15:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> ## TL;DR
> 
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

And the "couple of new features" are .... ?

> 
> ## What am I trying to do?
> 
> Conceptually, I am trying to provide a mechanism by which test suites
> can be grouped together so that they can be reasoned about collectively.
> The last two of three patches in this series add features which depend
> on this:
> 
> PATCH 5/7 Prints out a test plan right before KUnit tests are run[1];
>           this is valuable because it makes it possible for a test
>           harness to detect whether the number of tests run matches the
>           number of tests expected to be run, ensuring that no tests
>           silently failed.
> 
> PATCH 6/7 Add a new kernel command-line option which allows the user to
>           specify that the kernel poweroff, halt, or reboot after
>           completing all KUnit tests; this is very handy for running
>           KUnit tests on UML or a VM so that the UML/VM process exits
>           cleanly immediately after running all tests without needing a
>           special initramfs.
> 

> In addition, by dispatching tests from a single location, we can
> guarantee that all KUnit tests run after late_init is complete, which

That the tests will run after late init (and are guaranteed to do such)
needs to be added to the documentation.

-Frank

> was a concern during the initial KUnit patchset review (this has not
> been a problem in practice, but resolving with certainty is nevertheless
> desirable).
> 
> Other use cases for this exist, but the above features should provide an
> idea of the value that this could provide.
> 
> Alan Maguire (1):
>   kunit: test: create a single centralized executor for all tests
> 
> Brendan Higgins (5):
>   vmlinux.lds.h: add linker section for KUnit test suites
>   arch: um: add linker section for KUnit test suites
>   init: main: add KUnit to kernel init
>   kunit: test: add test plan to KUnit TAP format
>   Documentation: Add kunit_shutdown to kernel-parameters.txt
> 
> David Gow (1):
>   kunit: Add 'kunit_shutdown' option
> 
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/um/include/asm/common.lds.S              |  4 +
>  include/asm-generic/vmlinux.lds.h             |  8 ++
>  include/kunit/test.h                          | 82 ++++++++++++-------
>  init/main.c                                   |  4 +
>  lib/kunit/Makefile                            |  3 +-
>  lib/kunit/executor.c                          | 71 ++++++++++++++++
>  lib/kunit/test.c                              | 11 ---
>  tools/testing/kunit/kunit_kernel.py           |  2 +-
>  tools/testing/kunit/kunit_parser.py           | 76 ++++++++++++++---
>  .../test_is_test_passed-all_passed.log        |  1 +
>  .../test_data/test_is_test_passed-crash.log   |  1 +
>  .../test_data/test_is_test_passed-failure.log |  1 +
>  13 files changed, 217 insertions(+), 54 deletions(-)
>  create mode 100644 lib/kunit/executor.c
> 

