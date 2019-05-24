Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD029C5C
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbfEXQd2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 12:33:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42606 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390314AbfEXQd2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 May 2019 12:33:28 -0400
Received: by mail-io1-f66.google.com with SMTP id g16so8232187iom.9
        for <linux-arch@vger.kernel.org>; Fri, 24 May 2019 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRCKBM+pCyV8v4GH3CTPRapygJGCpjV7JmJ/J98K3zo=;
        b=J8z/TZmJDy9YhRyf5wi57/Kbe3Klzj5MlVvfu+WQ0Us/zFKhzhZMdYRSLiR8QfVlnM
         BhDMb3r2G2EioJINzsJPaiotxjiclp4s6knjqW64m7lRSr9W4kKERVv6Vt9qDWLmkZEC
         DFC5hKq4rIB42faqdX5EOqON2w72flSnxf4fXm6naoDbOyRqRaadxGjakJo0iiw4neqE
         fsE6hQQqB/qKs8lbcTBiLOA1utGAPh588nwv9vt+o1l5nguN8NTG8ytSQewhOvXP+0GA
         rdtkiZ/2JRRh7q47q79drEmhjNNQaLy04JdlpB1t3pkW2U6WYoU2/PjqiJb8+jLjOUJz
         ZBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRCKBM+pCyV8v4GH3CTPRapygJGCpjV7JmJ/J98K3zo=;
        b=f8SBt39IFAzQIoB90rORtBsKldtGoI32q22yERwkgv2W1eBaQ3bKmr4UEFqZBPTTfX
         IN2ECQLahTT7+1vOd9f62nUAIUSB/r4/ieUeYUY++K66SFVK7IkU6yqi4gzATaYVJl/j
         /lL/qHH436/S7TPw53kq39vDQ53t4FXjFkkxyrl8C1hXnHm/9/7sAL+ADse1H8sO7z5Q
         kYXIG9lbIqU5Jzue51SOKAZVWKn+/m8PH4iI7Hv/TWegqShTR2KPX0iBm8aKleQBVR49
         6A581ee9YoDw1fS4pCZkSIRWDF+d8UIO8kQ4ZK2V62REWfh5SM8IqPMP40mAjIgZ538f
         4fhg==
X-Gm-Message-State: APjAAAXnRgTiAd8lZTrW0qdnlXl2E61ySGHn6clhVVK6gc08t8CMXeag
        UyS11g7SjtxiiOs+LVjTi6+GHg3fCZBcIo566iorRw==
X-Google-Smtp-Source: APXvYqyTHYDcNRaUasxa/DBWROPgfkAVfxAMWOiWyvhWB7eymVuD3LFodiOO9W45p6SkxuhmUgJEsUMEDRQ2VKWw/Is=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr26693205ion.49.1558715607305;
 Fri, 24 May 2019 09:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com> <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com> <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
 <20190524152045.w3syntzp4bb5jb7u@treble> <CAKv+Gu9DLf9y2uqTo407gLK3AX3pq+HGFxytsoR9C2zfGdUc-A@mail.gmail.com>
 <20190524163104.o6xh54x4ngbihneb@treble>
In-Reply-To: <20190524163104.o6xh54x4ngbihneb@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 May 2019 18:33:15 +0200
Message-ID: <CAKv+Gu9U9pU79EoV02dGSTjuG2qq4NbHL0grO4K=L7P7sHeW6A@mail.gmail.com>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target symbol
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, guillaume.gardet@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Jessica Yu <jeyu@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 24 May 2019 at 18:31, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 24, 2019 at 05:55:37PM +0200, Ard Biesheuvel wrote:
> > On Fri, 24 May 2019 at 17:21, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, May 23, 2019 at 10:29:39AM +0100, Ard Biesheuvel wrote:
> > > >
> > > >
> > > > On 5/23/19 10:18 AM, Will Deacon wrote:
> > > > > On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
> > > > > >
> > > > > >
> > > > > > On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
> > > > > > > > The following commit
> > > > > > > >
> > > > > > > >     7290d5809571 ("module: use relative references for __ksymtab entries")
> > > > > > > >
> > > > > > > > updated the ksymtab handling of some KASLR capable architectures
> > > > > > > > so that ksymtab entries are emitted as pairs of 32-bit relative
> > > > > > > > references. This reduces the size of the entries, but more
> > > > > > > > importantly, it gets rid of statically assigned absolute
> > > > > > > > addresses, which require fixing up at boot time if the kernel
> > > > > > > > is self relocating (which takes a 24 byte RELA entry for each
> > > > > > > > member of the ksymtab struct).
> > > > > > > >
> > > > > > > > Since ksymtab entries are always part of the same module as the
> > > > > > > > symbol they export (or of the core kernel), it was assumed at the
> > > > > > > > time that a 32-bit relative reference is always sufficient to
> > > > > > > > capture the offset between a ksymtab entry and its target symbol.
> > > > > > > >
> > > > > > > > Unfortunately, this is not always true: in the case of per-CPU
> > > > > > > > variables, a per-CPU variable's base address (which usually differs
> > > > > > > > from the actual address of any of its per-CPU copies) could be at
> > > > > > > > an arbitrary offset from the ksymtab entry, and so it may be out
> > > > > > > > of range for a 32-bit relative reference.
> > > > > > > >
> > > > > >
> > > > > > (Apologies for the 3-act monologue)
> > > > >
> > > > > Exposition, development and recapitulation ;)
> > > > >
> > > > > > This turns out to be incorrect. The symbol address of per-CPU variables
> > > > > > exported by modules is always in the vicinity of __per_cpu_start, and so it
> > > > > > is simply a matter of making sure that the core kernel is in range for
> > > > > > module ksymtab entries containing 32-bit relative references.
> > > > > >
> > > > > > When running the arm64 with kaslr enabled, we currently randomize the module
> > > > > > space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
> > > > > > GB range rather than the -/+ 2 GB range of 32-bit place relative data
> > > > > > relocations. So we can fix this by simply reducing the randomization window
> > > > > > to 2 GB.
> > > > >
> > > > > Makes sense. Do you see the need for an option to disable PREL relocs
> > > > > altogether in case somebody wants the additional randomization range?
> > > > >
> > > >
> > > > No, not really. To be honest, I don't think
> > > > CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and the
> > > > only reason we enabled it by default at the time was to ensure that the PLT
> > > > code got some coverage after we introduced it.
> > >
> > > In code, percpu variables are accessed with absolute relocations, right?
> >
> > No, they are accessed just like ordinary symbols, so PC32 references
> > on x86 or ADRP/ADD references on arm64 are both quite common.
>
> Ah, right, now I see some PC32 percpu references.
>
> So if PC32 references are sufficient for code, why aren't they
> sufficient for ksymtab entries?  Isn't the ksymtab data address closer
> to the percpu data than the code?  Do you have an example of an out of
> range ksymtab reference?
>

Not on x86, only on arm64, which uses ADRP/ADD pairs with a -/+ 4 GB
range as opposed to the -/+ 2 GB range of PC32 and PREL32 references.
So when KASLR puts the modules far away from the kernel (but in range
for ADRP/ADD) they may be out of range for PREL32.
