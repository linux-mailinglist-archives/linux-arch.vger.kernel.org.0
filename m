Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889D6204478
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 01:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFVXaX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 19:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgFVXaW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:30:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80FC061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:30:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so3736640pgc.5
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UWqQV2fZB9OmDJeh5A7wKzCKjHubm13ivYyuz+dxo9g=;
        b=bUbfuxxz8CX/dO63xH28vPKUiPOsVTJi9AgkinEsU/PHv9FcsY3GO+vCXKz6K7ZbcH
         K17+Z5IlfGvcQ7NoKcWU37Zv59d5kOdufCLXPoi2hdIPl8dViI5OgYVS5wGxiWhCEutS
         yEuRbcSn+crkX1SvyLPKtSWr1vMP8MCwwci0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UWqQV2fZB9OmDJeh5A7wKzCKjHubm13ivYyuz+dxo9g=;
        b=P59ojsD7LTX6r10cFProUWInWtCF2bYgDw2ExYa2nYB7v5AA/vWRfNy+7RlEHzbayS
         RdXphV28RWApmSDXm+7HwWQdweAJ2WcolgxxjrlyIgWnGOuU3MSjiVGjJ6w6WGh4wgiO
         5ZoFEtZmUYrDq2i/QKBhVszXAP2rE3FqindLL82LMA8YL+b6IEr1qwgmJRUeMPWILOUf
         TyLTHMArUOGh+YMf4LbLjupUsYpI4sz0Y8mlqJ0z/dWnwJzaIYvxOU8dWJgRgHSKvgTu
         u6xkxvf67R0xx0Z1r29Xem5JgBY5WtVxpL60yytUjDjrB4bxLLerhtpnSCRyMB811QIb
         rqFw==
X-Gm-Message-State: AOAM533XvTk56iameeY5a66j80vjUzCV2ieF/XHM/dt3MnemWvTN2pkw
        GSZzzjwkvEGItfEajWaciw37xQ==
X-Google-Smtp-Source: ABdhPJyz2KvnmiiXZnfO//qQzAjGi3z8nzDMFB/UOoUeMpTq5NGsoYoqJSyavjLf8Sf2USB8VlglUg==
X-Received: by 2002:a05:6a00:801:: with SMTP id m1mr22967569pfk.200.1592868620568;
        Mon, 22 Jun 2020 16:30:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b5sm14968992pfg.191.2020.06.22.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:30:19 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:30:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221629.5C8CF8AE2@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook>
 <20200622225237.ybol4qmz4mhkmlqc@google.com>
 <202006221555.45BB6412F@keescook>
 <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 04:04:40PM -0700, Fāng-ruì Sòng wrote:
> On Mon, Jun 22, 2020 at 3:57 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > > > And it's not in the output:
> > > >
> > > > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > > > No version information found in this file.
> > > >
> > > > So... for the kernel we need to silence it right now.
> > >
> > > Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> > > sections come from?
> >
> > It's not reporting it correctly:
> >
> > .gnu.version_d  0x00000000008966b0        0x0
> >  .gnu.version_d
> >                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
> >
> > .gnu.version    0x00000000008966b0        0x0
> >  .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
> >
> > .gnu.version_r  0x00000000008966b0        0x0
> >  .gnu.version_r
> >                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
> >
> > it just reports whatever file is listed on the link command line first.
> >
> > > If it is a bug, we should probably figure out which version of binutils
> > > has fixed the bug.
> >
> > I see this with binutils 2.34...
> >
> > --
> > Kees Cook
> 
> :( It deserves a binutils bug
> (https://sourceware.org/bugzilla/enter_bug.cgi?product=binutils ) and
> a comment..

https://sourceware.org/bugzilla/show_bug.cgi?id=26153

> With the description adjusted to say that this works around a bug
> 
> Reviewed-by: Fangrui Song <maskray@google.com>

Adjusted, and thanks!

-- 
Kees Cook
