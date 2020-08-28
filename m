Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92125597B
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgH1LjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgH1LiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 07:38:12 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0EC061232;
        Fri, 28 Aug 2020 04:38:05 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so578325iln.1;
        Fri, 28 Aug 2020 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkhG0d/qOT3/PWJBg69FZnqsmWy5PRGz7aCU+rLDXxM=;
        b=pjn/h9gD/HjPLZEqJAJsF2uf24PYQdDAWmiD1wPfNvudgPxGPyd4OzHlALIT+VSh5Y
         T1zcvcf/2OMybRQ2gT7gBjFIjjRInfx9UkYnnINep6/pptBICO/GXDmFxw0v7PeiW4wu
         XDkRvqRvF6dHqX/VMJ7Qse/4QKYNFSQJSGuTljEs4hS0CsaRzZHiJRn515VXp64VUyHo
         mUROMmrauEJmNQQXeTDOGVVV/4ge7l3vFWlkNU5rIlNJrK6Y2W9Lp4B2rTeyXqaieX2Y
         nXNYq1z4Vsdd0w5W3dTDzbIzp/Y2343ZT6F4T5GYEDa/0jKrQnYPkFGbTDr0W4yLGmCr
         XMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkhG0d/qOT3/PWJBg69FZnqsmWy5PRGz7aCU+rLDXxM=;
        b=qobOkPolgRwz6XBHweJZq2qYVObyAJizRjhB0srUoh08mGQ6mw6XjhawUF23MAYjs5
         2ciKvZHkw0KAx3QEhUVpXDLBkN2TnPi8SiJF3fEzpnddEB/76DwmqPI3HEpRNeT2GwYh
         G/ng4c1WqlJXJl81bxAjp0d+Qc7Tu/qiPrUpSyn8QuufkpBkjjs2FsCzUOsCFLuJ2eWV
         Sw4LfBvEjtsu4Q9Eku/ajvNk8TvhB1McGb9f8NKrfDKPUmfMW9ptfjLZzySFaMwJxSVm
         n6bjgLQx6Q/Q2xm2oe7HsxxnulIE3FRU+PJEMhaj8ouebE2yUw5JY/j1Iyi09rR3CWJd
         3OeQ==
X-Gm-Message-State: AOAM5301TYOwcegUa9vpG9udVlQ0j0FCyjE4GHzfdRMcnYSCJMplzXro
        lA6EFoYg2kvoK1qyq+2P5huZi+kARj0MuxDyTLM=
X-Google-Smtp-Source: ABdhPJwHi2iqfV/mS52ggNLcex3m9VMBQ2/QGNsUdS0LRP4Op+NbUqXOoljtmaRM1TqvP73cHCEfd4beFso+xHIV+0Y=
X-Received: by 2002:a05:6e02:586:: with SMTP id c6mr1122698ils.13.1598614684703;
 Fri, 28 Aug 2020 04:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net> <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
 <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
 <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com> <87v9h3thj9.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87v9h3thj9.fsf@oldenburg2.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 28 Aug 2020 04:37:28 -0700
Message-ID: <CAMe9rOr=BZw3GyXf0g6tAZnfa8NbamoyBoU9KqoxtHg9c2yZhw@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 11:24 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * H. J. Lu:
>
> > Can you think of ANY issues of passing more arguments to arch_prctl?
>
> On x32, the glibc arch_prctl system call wrapper only passes two
> arguments to the kernel, and applications have no way of detecting that.
> musl only passes two arguments on all architectures.  It happens to work
> anyway with default compiler flags, but that's an accident.

In the current glibc, there is no arch_prctl wrapper for i386.  There are
arch_prctl wrappers with 2 arguments for x86-64 and x32.  But this isn't an
issue for glibc since glibc is both the provider and the user of the new
arch_prctl extension.  Besides,

long syscall(long number, ...);

is always available.

-- 
H.J.
