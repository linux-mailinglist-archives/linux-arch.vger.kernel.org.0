Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFA2B28D6
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKMW4b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 17:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbgKMW4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 17:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605308189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXuUO/jzK6PC0ArsPRfFmIFBybv98p5k0ll08mBK9vw=;
        b=U9Pli40NwWQRepbitv4YCZsEAM77o6qhj1hOBLr3VZzEfI94FF5413vLM2wo4B1oS9Y6E7
        v8SBULUFzVH5LYx9Q+rYqlBAHI7gl4zSyp3F7OGcgQGR0vUw2Br33b8H3SzYFGw+Ucn3Ep
        aSzBT2suv+yDgl2rvpWoLceP8t8/Kpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-gA0AbIuzMxWJynkYsYRo7A-1; Fri, 13 Nov 2020 17:56:25 -0500
X-MC-Unique: gA0AbIuzMxWJynkYsYRo7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C331A87309E;
        Fri, 13 Nov 2020 22:56:22 +0000 (UTC)
Received: from treble (ovpn-117-69.rdu2.redhat.com [10.10.117.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C611A3D6;
        Fri, 13 Nov 2020 22:56:16 +0000 (UTC)
Date:   Fri, 13 Nov 2020 16:56:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201113225614.ry73o4knb6mvv4dq@treble>
References: <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com>
 <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble>
 <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
 <20201113195408.atbpjizijnhuinzy@treble>
 <CABCJKufA-aOcsOqb1NiMQeBGm9Q-JxjoPjsuNpHh0kL4LzfO0w@mail.gmail.com>
 <20201113223412.inono2ekrs7ky7rm@treble>
 <CABCJKufBEBcPPrUZcAvh1LXX_GwRG1S1sg2ED2DPZ53MPy_VbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKufBEBcPPrUZcAvh1LXX_GwRG1S1sg2ED2DPZ53MPy_VbQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 02:54:32PM -0800, Sami Tolvanen wrote:
> On Fri, Nov 13, 2020 at 2:34 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Nov 13, 2020 at 12:24:32PM -0800, Sami Tolvanen wrote:
> > > > I still don't see this warning for some reason.
> > >
> > > Do you have CONFIG_XEN enabled? I can reproduce this on ToT master as follows:
> > >
> > > $ git rev-parse HEAD
> > > 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > > $ make defconfig && \
> > > ./scripts/config -e HYPERVISOR_GUEST -e PARAVIRT -e XEN && \
> > > make olddefconfig && \
> > > make -j110
> > > ...
> > > $ ./tools/objtool/objtool check -arfld vmlinux.o 2>&1 | grep secondary
> > > vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with
> > > modified stack frame
> > >
> > > > Is it fixed by adding cpu_bringup_and_idle() to global_noreturns[] in
> > > > tools/objtool/check.c?
> > >
> > > No, that didn't fix the warning. Here's what I tested:
> >
> > I think this fixes it:
> >
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] x86/xen: Fix objtool vmlinux.o validation of xen hypercalls
> >
> > Objtool vmlinux.o validation is showing warnings like the following:
> >
> >   # tools/objtool/objtool check -barfld vmlinux.o
> >   vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with modified stack frame
> >   vmlinux.o: warning: objtool:   xen_hypercall_set_trap_table()+0x0: <=== (sym)
> >
> > Objtool falls through all the empty hypercall text and gets confused
> > when it encounters the first real function afterwards.  The empty unwind
> > hints in the hypercalls aren't working for some reason.  Replace them
> > with a more straightforward use of STACK_FRAME_NON_STANDARD.
> >
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/xen/xen-head.S | 9 ++++-----
> >  include/linux/objtool.h | 8 ++++++++
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> Confirmed, this fixes the warning, also in LTO builds. Thanks!
> 
> Tested-by: Sami Tolvanen <samitolvanen@google.com>

Good... I'll work through the rest of them.

-- 
Josh

