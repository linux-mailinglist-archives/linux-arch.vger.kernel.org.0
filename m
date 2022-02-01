Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06414A5951
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 10:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiBAJgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 04:36:24 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiBAJgX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 04:36:23 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOi1H-1msSJG0SSd-00Q90s; Tue, 01 Feb 2022 10:36:21 +0100
Received: by mail-ot1-f53.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso15643149otj.2;
        Tue, 01 Feb 2022 01:36:20 -0800 (PST)
X-Gm-Message-State: AOAM531B6GP+sAbti7j76I8SBKnoM2jHz44p7JE5MHJaJB5u97394Gqu
        ZeCVQm6CD2x0ScFdYN8FTMS+9gmU6TO21eUrb8E=
X-Google-Smtp-Source: ABdhPJzjYk9dm3bFjvGFwtGU979wMDH3XPeFI40ue70UVOPzI4lwptcfGFngzaOKSdB77TE70F1nIEDki5MDfbq8Q+A=
X-Received: by 2002:a9d:654f:: with SMTP id q15mr13934011otl.119.1643708178915;
 Tue, 01 Feb 2022 01:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
 <20220201074457.GC29119@lst.de> <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Feb 2022 10:36:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com>
Message-ID: <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Dss/hQcpyoQ9LK0DQLr4S64wC5sUkNcGn5pdHdtfMvNlA055rj+
 vFbHhYZYtgY2ZJ7jtkbKuFqHiY1R0EhGcQWychOD24M2idxklhQUOajbJopi0j1ZE16bCdj
 eoyF+64TCqY+SB5ulT6XFBC25PC0AGfNgwGLxAhtXsXdg1R5F38vOLdABlPAAITZhzQsfKa
 4aihhhoBYfUVuqffgK++w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y+PGQ35CyuQ=:DUoBAnlZIJDPeISHcpL4UT
 yyFP9ZuiBAfpunfCm8tHw9twiJRqSKJEZdWWh7ynE50muo4kso8X8Vsk9tL0oRNkP9n/8UFno
 j/DOJz7T6W+hHTrVDIFdWdnEBP9bgF/yTQERGd+wpPbhiSsKVNYKsN//ALAf/JNUUDH4rqwNc
 qwsRr8JurWeOZpSLHZaM2soJrmS+B92291jQ3+CHsd7lyYJ4bENBkjkMZYiGoTjG60SiEm5CL
 S/3uYNEzTbO6ufQaucdHwhOtYUVDFx/N+83AhH+uH/qZCXBNprs+w1nD3KkLyo7v62+gGR6xS
 t+FCGvu3FYv1YrtL4bqRz46efpe3eFErlkaK+9tE7jo53HCsbiybM385tR6Yh9mk/WuPaB/xq
 OJchjWPzu23PhCRDsFBJeil+RTHcjGpDYJgBgCZbmamnSEFUpzzE29GcNFEZwgXQhUawvdQM/
 R/jUjm6Tvxv1RIl8oJEXytlgyEf8oSdopLgKYXt40MAuVhsxuVLfKj8UXjvoBQQAShIFDz88F
 50IKeXBX3dXj18w3HrLbk6a+uUL6OOvGFe0guTuNMElJmsLAst1bLk7LjfhnXF6nxppO4vEy/
 U5NCmtDWTMHBuZELEjHBMx3YHId2eoLoU1y2X9RRbhMIvdnczQfi71v0SfYGb3YjtHV6Q/qZc
 0stn6Kijv7oHbDGiXdnagsDJG65jkWrOOskeRqb+9wCS+IZtbBXAhxntuPyI0LvjH/giCLum5
 yKKRv2uFBp0qWZ9KYslsAqyeiLE6J0DvsM4ynQH6egqjnfzPazAvBgAn+gDp56Z+PxITGi1EY
 nAe2Rf0RjdbDhrPWNik6bu1TD1K9zZfbAj+hYpZwiKqU5cvQro=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 10:13 AM Guo Ren <guoren@kernel.org> wrote:
> On Tue, Feb 1, 2022 at 3:45 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Jan 31, 2022 at 09:50:58PM +0800, Guo Ren wrote:
> > > On Mon, Jan 31, 2022 at 8:26 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > Given that most rv64 implementations can't run in rv32 mode, what is the
> > > > failure mode if someone tries it with the compat mode enabled?
> > > A static linked simple hello_world could still run on a non-compat
> > > support hardware. But most rv32 apps would meet different userspace
> > > segment faults.
> > >
> > > Current code would let the machine try the rv32 apps without detecting
> > > whether hw support or not.
> >
> > Hmm, we probably want some kind of check for not even offer running
> > rv32 binaries.  I guess trying to write UXL some time during early
> > boot and catching the resulting exception would be the way to go?
>
> Emm... I think it's unnecessary. Free rv32 app running won't cause
> system problem, just as a wrong elf running. They are U-mode
> privileged.

While it's not a security issue, I think it would be helpful to get a
user-readable error message and a machine-readable /proc/cpuinfo
flag to see if a particular system can run rv32 binaries rather than
relying on SIGILL to kill a process.

        Arnd
