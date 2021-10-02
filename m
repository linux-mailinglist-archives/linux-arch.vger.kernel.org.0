Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D846841FB01
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhJBLHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 07:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBLHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 07:07:09 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B67C061570;
        Sat,  2 Oct 2021 04:05:23 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id y28so447443vsd.3;
        Sat, 02 Oct 2021 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOvScWWdsWCsTrT9qAyN9hFCi3UuNxTHx/MbnP0X/8w=;
        b=eDB0oNVafDTVhCe4pMIfJK9Mt77dkoTCfFD7fFEOfugZAuhWkUbHwE0SnYahtcNKh8
         8PY70r5RXCS4Wf+eB3UADhNuyHgLiBmbL5WLpMtloWhunmTW0xDPhKBluAH/+udwYwkE
         aqdDG2ok4sf5/ScKdcIUFrTAf3QUmA49bImqk1AFeCeBk7p+Ez2aHa+xKpgGymSiSQdQ
         FpzcW+w50fPo6ARbHEFcZNh+ktGsic6WAOPm0LPn8k9ARKYVAqd4rvtrb8P4EtRzG6dz
         PHqidp0wulGCdCyl8trZWfNxENS3IR1yVBTNTTRiDaeOd7rjMIOSytI9DzmRRJOpp43e
         tQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOvScWWdsWCsTrT9qAyN9hFCi3UuNxTHx/MbnP0X/8w=;
        b=hQ/U4xDc+UjoS0D338l137a6APgtN7oO7/sea2nHAVLRdoA1KjuxRPauCXQ329Cy9q
         L6N5KfUXfNbMSzq+802f7aNUhV8G9bud4Zs2gbY+pUMQo2rSTG73ZkS1uSMmhcbTsjGg
         2WDyc57eH7/oN6jw6e5OGcw+Eujl5/URponvJ6bZj1QyRd7c5bW8l2xzbXeA5eNhpnJK
         +hyjpTs1TsC7IjH3tFcKpbm04rJfp5bmOCOjvlPvQlcb3VW8dN38IY8KcJ7uYdksnPnn
         GvPBxRGV0fUuC3re5oJ9kWOpBcuxfo4dju5P3q310NR/gLI24Xg94swZ596qP/EdbDFN
         2iQQ==
X-Gm-Message-State: AOAM530QNhub2tTlrFxcqn0HRoUByQqkEd9LriedR0V8QBDIBgtnPOEF
        8Kmt/KoYZJ0kMnfV+7n0dXjwYKB+3LcvKGENZ6Y=
X-Google-Smtp-Source: ABdhPJyYK98qTlp9uh3k6KKGXFm8Vao/jKxUvntwx3UlQqUZMeVdbLPcD3ZJIHUb94lr8wncJBSjP2mk6YHRercHls8=
X-Received: by 2002:a67:ee12:: with SMTP id f18mr8135716vsp.20.1633172723091;
 Sat, 02 Oct 2021 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-8-chenhuacai@loongson.cn> <YVbrPHsDkhTl4FTA@hirez.programming.kicks-ass.net>
In-Reply-To: <YVbrPHsDkhTl4FTA@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 19:05:10 +0800
Message-ID: <CAAhV-H5yA1_63OeYH-6KEgw1m8FUMDGHV0g_sw=F758HJhQ66w@mail.gmail.com>
Subject: Re: [PATCH V4 07/22] LoongArch: Add atomic/locking headers
To:     Peter Zijlstra <peterz@infradead.org>, yili0568@gmail.com
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Fri, Oct 1, 2021 at 7:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 27, 2021 at 02:42:44PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
> > new file mode 100644
> > index 000000000000..2544ee546596
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/spinlock.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SPINLOCK_H
> > +#define _ASM_SPINLOCK_H
> > +
> > +#include <asm/processor.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +
> > +#endif /* _ASM_SPINLOCK_H */
> > diff --git a/arch/loongarch/include/asm/spinlock_types.h b/arch/loongarch/include/asm/spinlock_types.h
> > new file mode 100644
> > index 000000000000..91f258401ef9
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/spinlock_types.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SPINLOCK_TYPES_H
> > +#define _ASM_SPINLOCK_TYPES_H
> > +
> > +#include <asm-generic/qspinlock_types.h>
> > +#include <asm-generic/qrwlock_types.h>
> > +
> > +#endif
>
> Also see the many lkml threads on this, is there big enough loongson to
> justify qspinlock? Have you tried a ticket lock?
Loongson-3A5000 supports NUMA, we have as many as 16 nodes, 64 cores
in total. And we have tried ticket lock which is worse than qspinlock.
Maybe Jun Yi (yili0568@gmail.com) can give some performace data?

Huacai
