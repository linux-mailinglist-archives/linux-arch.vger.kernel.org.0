Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207C8484C2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2019 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQOAw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jun 2019 10:00:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40377 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jun 2019 10:00:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so8393216otl.7
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/0AosDiq0XlRMBf8oBwjVIp/eynr9o30+abHU130tU=;
        b=QfGwVzUyw61eYELwxKAlY9/Qm6Aj9QSJ0n+dIVkf8/4yeJfiVbarVyCC4XbKUh7zyA
         TB4mJQ/4WDEFdFlP9q8qfUxerum3OAS9kJIC9HkWocd6c82xelhC5lUZ8KGeL7GIc9b2
         Vn2SIVgDQO8hQMwPHS4nOTl0lopwU7OuI/SKFbVXrGvgWTzn57ByfbFw3uFr/5eqy03z
         O/40JUT3OWHkoJhC5IIKY/lFAiriQzdivbyM4D4bt87oTbTSaLBLA/VBa+dUA9Qn7Q8O
         AgESDbDnLQa9ZvaNVt9qijL0DoPw8QB7RGDJ+rCIOi5DiwTJKQQpi0xCcP/5ARb5gi6O
         48XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/0AosDiq0XlRMBf8oBwjVIp/eynr9o30+abHU130tU=;
        b=TQzKEhZ/W5VnSGsvlBlzQ7dgPdIr3RGg1wcEfsHvhMCUXV/RBKTD4YciTwnyMgObQk
         zhjBTAjrsgdyQa0qexZ3WRci6SzJK19heJ4fOJzttuZINBtzvZ5UJr1s4o7eclp0ZJB0
         v5D0xsNsWIBHrG1RJbIAY3dlbeErisNC47n3B3LiouhiU/e1u6kWBmrITKdYU0m9s7xD
         vsUphqIDCDXSXMCM8uVm2l4V7LNo8agW5h/wdBQQJkC1qIknkxRJ0RMHubgKLbF5Fj2F
         VM/LLsGFKCt3Eb82FucCzToTt/+QMlWXw1krSwiGGMgAe/bzCHYYps/wTwyOdVCgw4o6
         lAeg==
X-Gm-Message-State: APjAAAWHQdO8CuT7Q7znekKZNMmTj4DfFDl8ehRnGEyQCeCbUvlmi0w2
        IQHCk/De2HUkZq9K8Pwu9FAXTAgR4tuxL2l6/FawMA==
X-Google-Smtp-Source: APXvYqz5F9NBThJnsQ+gL+ZpGjjXfOmWdrkG2sLPN0k3OAALt6m/XyHFzA0l3LB9J01pkclLKo1k7HRwqBHaHCOQM+M=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr9743899otr.233.1560780051018;
 Mon, 17 Jun 2019 07:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613125950.197667-1-elver@google.com>
In-Reply-To: <20190613125950.197667-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 Jun 2019 16:00:38 +0200
Message-ID: <CANpmjNMCmcg8GS_pkKc2gsdtd7-A2t27mOXATY9OLb1vQW5Lsg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All 3 patches have now been Acked and Reviewed. Which tree should this land in?

Since this is related to KASAN, would this belong into the MM tree?

Many thanks,
-- Marco




On Thu, 13 Jun 2019 at 15:00, Marco Elver <elver@google.com> wrote:
>
> Previous version:
> http://lkml.kernel.org/r/20190613123028.179447-1-elver@google.com
>
> * Only changed lib/test_kasan in this version.
>
> Marco Elver (3):
>   lib/test_kasan: Add bitops tests
>   x86: Use static_cpu_has in uaccess region to avoid instrumentation
>   asm-generic, x86: Add bitops instrumentation for KASAN
>
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/ia32/ia32_signal.c               |   2 +-
>  arch/x86/include/asm/bitops.h             | 189 ++++------------
>  arch/x86/kernel/signal.c                  |   2 +-
>  include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
>  lib/test_kasan.c                          |  81 ++++++-
>  6 files changed, 382 insertions(+), 157 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
