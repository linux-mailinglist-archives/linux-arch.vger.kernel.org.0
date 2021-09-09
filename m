Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1564058AD
	for <lists+linux-arch@lfdr.de>; Thu,  9 Sep 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbhIIOMJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Sep 2021 10:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242586AbhIIOMF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Sep 2021 10:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6FFF6120E;
        Thu,  9 Sep 2021 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631196655;
        bh=QnFWolxfZay1KMpuuJiy3t4+3J08Jw2jb7kKsRqKiRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s8OMagPIG0mUnQ7VETHmYD2RHn+VHA71FedeB9+SRUD+n47dhjv8EAjZzN5gxZXSF
         FdkztBACksqPV5juPjY26iPjASI6s6kPY3WQh7pbw4T6ER8Klr02KYob4VfKAD4ZUg
         +z4esWg7IKBGwHRaAWO10tein74R9UXIt4v7qsu+y6qkXopw+JaAQP+qar7Du9v1u/
         tv6JZ9h2YeEhluZ00HS7l9zEBhtqulrkvr52U813OMocE9Am2eyXxWDnNy0cNLLLCm
         H6wVjcz/euq6fVPlX9sGA5lkqRwCXd0grl0xbm/YkHeyxoP+ffoqlgRPlleXaQpx3q
         6i2ZXqmFq2Gxw==
Received: by mail-ej1-f48.google.com with SMTP id lc21so3882510ejc.7;
        Thu, 09 Sep 2021 07:10:55 -0700 (PDT)
X-Gm-Message-State: AOAM531FzKKcSYj2qWKWlcsCeWF95qNSksCHk0EXk2finC6PMGCehqNA
        hr2XgOb3f8WK7vb0lWu/A7yjvYkQVZNDjdJyXQ==
X-Google-Smtp-Source: ABdhPJx78xiZSPaticSCU5QeXk5UGX/qy1ALDt4dQ95ViMAZspsdbsMUPxdOKI8sScOzdKeEWTPe/Itcz6D9fMwrLU0=
X-Received: by 2002:a17:907:50a1:: with SMTP id fv33mr3650324ejc.128.1631196654351;
 Thu, 09 Sep 2021 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn> <YTjbaz7iea1kwGYb@robh.at.kernel.org>
 <CAK8P3a3sY63WN6Mn6_xNqDYmdhv1PN6CFRfQGNDRO4dHtSjE7Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3sY63WN6Mn6_xNqDYmdhv1PN6CFRfQGNDRO4dHtSjE7Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Sep 2021 09:10:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJh3b9BxRU3ye=Qtmip+XE9gJxUKvPKuKNpxfOvmq08pg@mail.gmail.com>
Message-ID: <CAL_JsqJh3b9BxRU3ye=Qtmip+XE9gJxUKvPKuKNpxfOvmq08pg@mail.gmail.com>
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 8, 2021 at 11:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 8, 2021 at 5:48 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Sep 03, 2021 at 05:52:09PM +0800, Huacai Chen wrote:
>
> > > diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
> > > new file mode 100644
> > > index 000000000000..d6e2f69b9503
> > > --- /dev/null
> > > +++ b/arch/loongarch/pci/acpi.c
> > > @@ -0,0 +1,174 @@
> > > +// SPDX-License-Identifier: GPL-2.0
>
> A lot of this file appears to duplicate what we already have on other
> architectures.
> I would suggest moving the other architecture specific code into
> drivers/acpi/pci*.c and share as much as possible to make it easier to
> make modifications in the future.

Yes. I was sad to see after I replied you already said this for v1.

> > It might be time for default implementations here that can be shared
> > with arm64. The functions look the same or similar to the arm64
> > version in many cases and why they are different isn't that clear to me
> > not being all that familar with the ACPI code.
>
> I think it can be simplified quite a bit if we restructure the acpi pci
> code to behave like a normal pci host bridge driver.

That is exactly what I want to see happen! I'm not that familiar with
the ACPI device probing piece of it or I probably would have done that
by now. I gather there's not a normal acpi_device (or platform_device
with ACPI matching?) so we'd have to create the device(s) based on the
MCFG table.

Rob
