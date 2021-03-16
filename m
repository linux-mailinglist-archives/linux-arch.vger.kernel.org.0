Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257F433DEDB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCPUej (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhCPUeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 16:34:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA09C061756
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 13:34:05 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id v123so18960996vsv.9
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrwjt/kZB1RxVC21J+b2Rv85znrbxBlQ2xQVtgXaL8Q=;
        b=po1Ywby6SU2VWLEUyZ5fNbrtGcCnRgD8+IOMID+GlXWQNN/3aWjrKopHkVgecJy3yJ
         khd4+NGMXkdhaRRLq7oIG7sqA93cOIbt85nnBMxjdoTTob9e2Am24an2yQVbG1o0V5H8
         7GVzuReTWAlfbF1CAQXu39fgGvH5SXGbKyaDGdlbOZBsDb8/16qHOkbAClu4ucjVnnpq
         puCa2KojBGupypPIcNHF88u0nBc0j5j5wmxJB5QqbuzbcGhuC3bdhL35d8XTmOmAH5Ze
         Rv/YonPUJZL/28fPFwgGqtGza8PZ38b3S3xCK35A47xteLDq+UaKkUNMlUmMa3ohiIUa
         It1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrwjt/kZB1RxVC21J+b2Rv85znrbxBlQ2xQVtgXaL8Q=;
        b=WUO3B6fK6mCKQVof8INktnrbljsTebRHAG66vorgom191ZHo6svT2u/tr9/ZCDKlHb
         QAZ65nmTVgSD9+sybGhoPvEOHe5xPZl3KLT3+MB0k6zihjV9a8lPcmyHhTRUdWu3SV8p
         WGHOrKUetPLpuHuksDSywTKuag4eoQfqFq/Bf/jZbbfKjKrLKhcZuWpQBcE8YZfhp+tf
         TkSs3wONjYfPMPk0+W8R1oaH8WWQ8pqIMlhBq6LiXUafbf7kipNuVf31rIQZ6lieks/8
         T3ItXhwZ+D/g1Ba0n1deFHrGZT4EJN4vDtv7Fx6+fjlW6oZRFHcj+6FHuo5ChUY9vMcZ
         jozA==
X-Gm-Message-State: AOAM531KrB2BA/yrlr0IHDEsW54hz7tqt+J8wmOmVZB6UHphjVWi63AV
        rqNB1ExFUZnUZFUO2ZKjoYq2mTavtBDE7GUru/9nsQ==
X-Google-Smtp-Source: ABdhPJwadRPiAKyB9trsaH6fnnn3nCM/AdtJrbuHIQFIQoIMgPzfKSpazXNSL6neJgetXYxyVdUJ7AZv1KZY68p3ujw=
X-Received: by 2002:a67:2803:: with SMTP id o3mr1486279vso.36.1615926844137;
 Tue, 16 Mar 2021 13:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-8-samitolvanen@google.com> <202103111843.008B935F8@keescook>
In-Reply-To: <202103111843.008B935F8@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:33:53 -0700
Message-ID: <CABCJKufMb_VFwXLkxjdvN6Y92v-Nc4Z+kThbi7SOkVgGhdFz+g@mail.gmail.com>
Subject: Re: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 6:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:09PM -0800, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> > of all static functions not marked __used. This can break userspace
> > tools that don't expect the function name to change, so strip out the
> > hash from the output.
> >
> > Suggested-by: Jack Pham <jackp@codeaurora.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> (Is it possible we could end up with symbol name collisions? ... though
> I guess we would have had collisions before?)

Yes, these are static functions, so name collisions have always been possible.

Sami
