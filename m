Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB453238DA
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 09:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhBXInM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 03:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234538AbhBXImS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 03:42:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8482964ED4;
        Wed, 24 Feb 2021 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614156097;
        bh=2u9wsGlo7sAstFS7alrtBLEQ7jlLQXyGrglLta9pQLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uN0bUfFDBiLVq32hJndalsoZyspL6z2Gf7MwTCrAOCA7wCyr8uHFZYZgce7k3ENP/
         9sRx1JZxii8kHho8sz29USgl8CGuu3cv55cABgdtiuo/hoK92cp2gvcQtANYQrBgPY
         4FxHhg7G9AgPECGkEXPird7yTRXP1sQZtEFiRolv06FSbkbGuq9D85oiqk1gLajm8J
         J+FFJgPDbA0a6P2k0AOVeO3HfEigFrJL1w22oVAEcQJAOfA4pOK30Si7QBpFaWbfp7
         i2GO2XDtlsMGrvtpkEono6KCrIorE93qdcTbu35qbvrcAqKjK/GX1WqkHwHI8kRKQq
         QMIFJFKY6QFkw==
Received: by mail-oi1-f174.google.com with SMTP id h17so1674983oih.5;
        Wed, 24 Feb 2021 00:41:37 -0800 (PST)
X-Gm-Message-State: AOAM531L17iap+oH6YmhvtOA4MfEXjUiuapywiLhgWtm3r3mQkKHUNxR
        D8tI52GonID72p7PwbJYmi+8Jb4oxkZCgpmjnxk=
X-Google-Smtp-Source: ABdhPJwjmKC7+AWmQCirVwXx41S9h7HiL9JLm1CIERTHFkqrhi/RM6Xsksd1ZFcRGTbiNRRmcpDhcWurq8+ZFAP3EMc=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr1917194oia.67.1614156096771;
 Wed, 24 Feb 2021 00:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20210223100619.798698-1-masahiroy@kernel.org> <CAK8P3a1b5Tr8Gt_DcUq9JQj4G6O5ZHf44P2ZdYZRGQY8iPs43Q@mail.gmail.com>
 <CAK7LNAQ3bYfo03i=LBv8S6dyTTAYw17gGht7TR2AWofNn0VP_A@mail.gmail.com>
In-Reply-To: <CAK7LNAQ3bYfo03i=LBv8S6dyTTAYw17gGht7TR2AWofNn0VP_A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Feb 2021 09:41:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34sHv05FYwcmuJzsR4NM4r2TcrhCE8LTDtRtNvhN9hWw@mail.gmail.com>
Message-ID: <CAK8P3a34sHv05FYwcmuJzsR4NM4r2TcrhCE8LTDtRtNvhN9hWw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/ioctl.h: use BUILD_BUG_ON_ZERO() for type check
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 2:57 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Feb 24, 2021 at 5:04 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Feb 23, 2021 at 11:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> My intention is to improve the UAPI/KAPI decoupling
> to decrease the task of scripts/headers_install.sh
>
> Ideally, we could export UAPI headers with
> almost no modification.
>
> It is true that scripts/unifdef can remove #ifndef __KERNEL__
> blocks, but having the kernel-space code in UAPI headers
> does not make sense. Otherwise, our initial motivation
> "separate them by directory structure" would be lost.
>
> So, I believe redefining _IOC_TYPECHECK is the right direction.
> I can add comments if this is not clear.

Maybe using '#ifndef _IOC_TYPECHECK' would help here?

Another alternative might be to find a way to rewrite the typecheck
macro to make it safe to be used in user space as well, and not
have two different versions.

       Arnd
