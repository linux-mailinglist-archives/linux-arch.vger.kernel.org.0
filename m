Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC5389851
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhESVCl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 17:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhESVCj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 17:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01BEC613AC;
        Wed, 19 May 2021 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621458079;
        bh=HPUf+kT+bmoTegnVvAKxBai2Dzy2bgMgMG0NwDVdbFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p52lxAzjRDlRk5H0cyupEgyG/s/wvmz1DOwXKgHig0/8Zbmjj1RH8iXq0oLDikz/c
         OKyaxKpyZ2rIFZoozBsnpmuFub5QaJ57mfzHjC39xx9H0rq+1cbtR/mk+OkZXhqbb7
         PN9WliBDpU7vcUDntXmxGgaAQDgbWAMG8QC/Xqg6xt3yA8V1nP+DrBLO01g0HICZJt
         yvNl7RHiiymtILIkIf3Ar6s0Jq5zqXTCpUYEf+mhgMCB5sTc9qQnItCrn7eiB23MgS
         46xEd0nOaBa8WbAL6kPv5lPgOnBReodEyPZvaJmKUhMrWElXyeymO7OZBsT9smRGuf
         +OantGSRz9p+Q==
Received: by mail-wm1-f44.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so4013991wmq.5;
        Wed, 19 May 2021 14:01:18 -0700 (PDT)
X-Gm-Message-State: AOAM530hKy6nvNB+KFLKIHq1sI+YcQAUx+akndUxcxSpFLbySOsJECh3
        jA5HkCFE/l6NPrYDi9mkNgPNhwaos/2YT2EDpYE=
X-Google-Smtp-Source: ABdhPJy8Jqwz5h6db1cg71p7uKoZ7HogbtRdnpq9dbBSg0UgdCTCX6yhxlQHb/+HU1db+XwapikKwx/NJqqXjPyM4bI=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr960591wmj.120.1621458077519;
 Wed, 19 May 2021 14:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-5-arnd@kernel.org>
 <87h7iycvlo.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87h7iycvlo.ffs@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 19 May 2021 23:00:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0KULCWrGZt=C9uWDgqNf184KC-uaK9rN8ZXjTG1HAqsw@mail.gmail.com>
Message-ID: <CAK8P3a0KULCWrGZt=C9uWDgqNf184KC-uaK9rN8ZXjTG1HAqsw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 10:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 17 2021 at 22:33, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are all handled correctly when calling the native
> > system call entry point, so remove the special cases.
> >  arch/x86/entry/syscall_x32.c              |  2 ++
> >  arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
> >  arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--
>
> That conflicts with
>
>   https://lore.kernel.org/lkml/20210517073815.97426-1-masahiroy@kernel.org/
>
> which I'm picking up. We have more changes in that area coming in.

Ok, thanks for the heads-up. I'll try a merge or rebase to see how this can be
handled. If both the drivers/net and drivers/media get picked up for 5.14, maybe
the rebased patches can go through -mm on top, along with the final
removal of compat_alloc_user_space()/copy_in_user(). If not, I suppose these
four patches can also wait another release.

       Arnd
