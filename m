Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB35717F35B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJJTv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 05:19:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38151 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJJTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2020 05:19:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so6053546qke.5
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2020 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjCevU/DO8QcnVvhecJsNsvY/Eogkcy8Wp1LUXYrp/o=;
        b=mODK0PqZKz4tb/WcnFSbx2LYpETCoT0ilHjfL3D+Gc1Cvs24FfABK7Y5uTG1FF7S/5
         JSEinOAr9zNhe7uvCxyPvpWevI11zfcqBZiNkCoYR6vfGQuugG9sdnCM+4DY2C7TQ480
         6OSyktiD8UDOJi3QuaoSvnZxqbSx2QZ+cMBlApXYeppkpZsC2T+RXqhUXbTYHytUWasy
         UlPufV8o3KWP7hmxcibzOBnDBBS9GmbuBaWiFAwupUoCbfBxlDCV0rm3OqFkflR3qQ/v
         afQuj4Aq1FB8n3rrZzcbJCfv7itqexXpDYdMW6HMrYr5iWEhNs6iEqjcUFjcxo1bZ07/
         A7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjCevU/DO8QcnVvhecJsNsvY/Eogkcy8Wp1LUXYrp/o=;
        b=aSEMLPU74FzCt6E9gIRTtnhW57k+OGFocFo79LJonyieo9DagAsh8JXWj+cyq+R7ks
         VhvNFQnZk+e2hVsZYPWaY6BCnRzd+s/dafe/NDDMDfwUjpOU8/aKMPG4Rkpmwly+5fDU
         Y6TY0rw+6Xh+kcRQt8MpOG6OXk2fMeYN5l9x29h9ud6KttXdwd1fwMIDeqa47xu40EWI
         2rlKb27UxERVQVb+G7t/bPZPP5CG1eKfw/YPHBsf7aIaXHhPeWglX3yYJEpfRW0Wk16P
         QHGqj1JYyOlOL9Rtd6BeALnFEu+N56rFjluoZKDTPMmXkqciPZwqR5WiuUXPlsvrobzR
         jhDg==
X-Gm-Message-State: ANhLgQ38vphpCsLg1hAeZphpcCmr8pYdV3k3a/q6wmsw6JjRsNDow/9q
        6dSuugEzZDP/fEB7QrDq4hSpJn2j9EpDBaa9m0TW6A==
X-Google-Smtp-Source: ADFU+vsmRWFj6aNZBYLKrp81MYwc1fe87ZUAz4TMoAJhlSk8+/g2pNwyYoaYHhWbyuq4lbGcnJ4gpHmmticmozr+fHI=
X-Received: by 2002:a05:620a:1443:: with SMTP id i3mr9039808qkl.113.1583831988838;
 Tue, 10 Mar 2020 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200308094954.13258-1-guoren@kernel.org> <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
 <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com> <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
In-Reply-To: <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 10 Mar 2020 17:19:36 +0800
Message-ID: <CAHCEehLq5f+DGusL0T4ZUuJ2hTRhSyLSGRpKHhq5b4J3nXfBHg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 10, 2020 at 4:54 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> On Mon, Mar 9, 2020 at 6:27 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> > On 2020/3/9 11:41, Greentime Hu wrote:
> > > On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
> > >> From: Guo Ren <guoren@linux.alibaba.com>
> > >>
> > >> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > >> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
> > >>
> > >> The patch implement basic context switch, sigcontext save/restore and
> > >> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> > >> is implemented. We need to discuss about vlen-size for libc sigcontext and
> > >> ptrace (the maximum size of vlen is unlimited in spec).
> > >>
> > >> Puzzle:
> > >> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> > >> before, and riscv also met vlen size problem. Let's discuss the common issue
> > >> for all architectures and we need a better solution for unlimited vlen.
> > >>
> > >> Any help are welcomed :)
> > >>
> > >>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> > > Hi Guo,
> > >
> > > Thanks for your patch.
> > > It seems the qemu repo doesn't have this branch?
> > Hi Greentime,
> >
> > It's a promise from me. Now it's ready.  You can turn on vector by
> > "qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".
> >
> > Zhiwei
> >
> >
>
> Hi Zhiwei,
>
> Thank you, I see the branch in the repo now. I will give it a try and
> let you know if I have any problem. :)

Hi Zhiwei & Guo,

It seems current version only support v0.7.1 in qemu but this patchset
is verified in qemu too and it is based on 0.8.
Would you please provide the qemu with 0.8 vector spec supported? or
Did I miss something?

489             if (cpu->cfg.vext_spec) {
490                 if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
491                     vext_version = VEXT_VERSION_0_07_1;
492                 } else {
493                     error_setg(errp,
494                            "Unsupported vector spec version '%s'",
495                            cpu->cfg.vext_spec);
496                     return;
497                 }
498             }

By the way, can I specify vlen in Qemu?
Thank you. :)
