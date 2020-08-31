Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB625816F
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHaS7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgHaS7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 14:59:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD0C061755
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 11:59:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so1141284pgb.8
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3gvdeLLkLMj6sDEkcPB4/tK2fV8l3UXQaxnpiPHbxk=;
        b=f5jljmQ/Tzl+5/kQmFEzbbT1v88qGePnYEgl5N300ns0wx1IJw8gl5o8we5HmlsNUO
         9OrnCQ5fnN7H0lecCflIqYgo4ZUYtfwMqXbVvCJBuNQ1mJd81VwgdMaQcZbmrLK8giNW
         2Vo8kgN9OndT7YWtpzTDv+UrOpYqludP78QE72eW5t6EduVt1DYYwD4f9gxj96skYZgU
         2RuAvVCUUbVW/1OVhcepCZVYJkSeyH/GIwRjOjpPuppwNQvYBVoEcdmCoC7AymmQrk09
         DwGmrHquG9eF6ITSLT4smoZd7wD0MueAzRjsBbzuZu191A3lkHuWi7MG7JgGaoRMly6m
         D3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3gvdeLLkLMj6sDEkcPB4/tK2fV8l3UXQaxnpiPHbxk=;
        b=JOMUn6EC5v5NbUz5d9nuEXds76x8j1rNUP6Z7EoWn/O+6q2dWvE9PZDNKxoV4G5G08
         bgJ9rj9FN+idyM2ZYPQIQ9LRWWJwTKCWVfxJAJnq3D5WSWPum42PzgUhE4JNSZpZlUM8
         ufqylIwmaQS8eo99F8Y6VQVSTy2T62qoAs6Ns4HLyDHHBlNnHZJ4Q+TByEQFkBLw0g2B
         3uK8z18JX+gnR3WijxwsG8dNPL+Dx+aKn3wZlU1qwsOt4Q+bknLX04K2UFbfDsKPQ//Y
         f/rrofRU7wOUi2VG5YlF0529fXOTMe9jsbm5eIfDYh9D72GqfkvRf1GmdJw8B4a6GAc+
         y2TQ==
X-Gm-Message-State: AOAM533IQ0pMNzI3bZUqrN/tmpuusZPZ7JT0nZLIibx9kXOu9oNc1S0i
        rOEquic0haHxj5GIiaY7MY+iAi9AUSiuFb+2M0dWyw==
X-Google-Smtp-Source: ABdhPJxZdxUKTq0Gc3Lf2zRRjEfPyDXVNK6R9eATwLEDG7sxtcGbnWRGarQFHP/X/n7i91gf4i6j4xi1w7XQ868l7qg=
X-Received: by 2002:aa7:8e8f:: with SMTP id a15mr2350429pfr.135.1598900355921;
 Mon, 31 Aug 2020 11:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200831171733.955393-1-alinde@google.com> <20200831113238.b6b38076bb02076458592a3d@linux-foundation.org>
In-Reply-To: <20200831113238.b6b38076bb02076458592a3d@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 31 Aug 2020 20:59:04 +0200
Message-ID: <CAAeHK+z9xVfW_W1u=ZatPXQ+2UH9khuW2yM96BcgLmm8ENzymg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] add fault injection to user memory access
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     albert.linde@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>, akinobu.mita@gmail.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 8:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 31 Aug 2020 17:17:30 +0000 albert.linde@gmail.com wrote:
>
> > The goal of this series is to improve testing of fault-tolerance in
> > usages of user memory access functions, by adding support for fault
> > injection.
>
> Does anyone actually plan to use this feature, on an ongoing basis?
> It's the sort of thing which the various test robots could exploit, but
> I'm not sure that they are using fault injection?

Hi Andrew,

syzkaller/syzbot is using the existing fault injection modes and will
use this particular feature too.

Thanks!
