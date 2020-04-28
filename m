Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16A21BB563
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 06:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgD1EgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1EgY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 00:36:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FFAC03C1A9
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so19993325ljb.9
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSyS91ue6QSNeGHcujNqLf4sDv6GWUKUU7b87h1dlwI=;
        b=T1sHGGHIcDlws2EsAOMwHtaHo6fMU2cwytBuSPDwljmvSXHN2cjJGQJr7oKQd8yI7p
         2NPc8079weDg84X/y5vKiERnNUOYAcwho2XpslbuzmDQEe3cG8XdTAOyVGeBHdfwOz3T
         Nz9c6aNibqCKxiJ4zKRWAbhLvSdOppDkluANY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSyS91ue6QSNeGHcujNqLf4sDv6GWUKUU7b87h1dlwI=;
        b=Oc7sW4uFYJZeFjAESwNnE0Z21ChsbyrTn5v5r88QhDmvrN0nYIMwPM0ENDMSrEct81
         Whyq84CY1hNXZR/YJZfgvErwR1IOQwah/KjgpB2cofqdE0UGFm7wYhqMEaFFgkXtuGnT
         uqWX2KMiP0utj2DYnREJ6iA2jMNVZ46k6bkYevTbbg52VbjKRAfNKPFv/TpIXHvl1HLx
         xPnDnuC38YrxfZzoDd8XkKhS6PlgXhxCp8fn7G/YM58hU6SN4FKmtkxaecoEuDtR9oY7
         oaVq9yn2PpE+Df/ftS3Fl8uZIxpRojSNoIWrg4Vfq0Tgo3di23PXFL/BTWIyqSs4FzEN
         C5iA==
X-Gm-Message-State: AGi0PuYlyNjVhVrVptReyohS17xrsK6vwUT6z3KBJSfM02ljlfyvS7ja
        Hvav9IloPMCo4Cak8/4WE0w/xkECdyU=
X-Google-Smtp-Source: APiQypKN7q8He98bYWpCPkZo63xE4VqRaElKgeaPLr+R03d2mfLJO/WG7UATdmQYabkbjvlCSbPSmw==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr16483909ljc.146.1588048582449;
        Mon, 27 Apr 2020 21:36:22 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h28sm1155665lfe.80.2020.04.27.21.36.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:36:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k28so15726343lfe.10
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:22 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr14918617ljj.265.1588048110408;
 Mon, 27 Apr 2020 21:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
In-Reply-To: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 21:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I hate to say this, but I=E2=80=99m not convinced that asking the gdb fol=
ks is
> the right approach. GDB has an ancient architecture and is
> *incredibly* buggy. I=E2=80=99m sure ptrace is somewhere on the pain poin=
t
> list, but I suspect it=E2=80=99s utterly dwarfed by everything else.

You may be right. However, if gdbn isn't going to use it, then I
seriously don't think it's worth changing much.

It might be worth looking at people who don't use ptrace() for
debugging, but for "incidental" reasons. IOW sandboxing, tracing,
things like that.

Maybe those people want things that are simpler and don't actually
need the kinds of hard serialization that ptrace() wants.

I'd rather add a few really simple things that might not be a full
complement of operations for a debugger, but exactly because they
aren't a full debugger, maybe they are things that we can tell are
obviously secure and simple?

               Linus
