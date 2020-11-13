Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED0B2B24F3
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 20:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKMTyZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 14:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgKMTyZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 14:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605297263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYOZqfS1DftClANj54I945kAOQfBrrvPepHj2JAwlgE=;
        b=cggOs85/ww5AaqlPb8qiak6PG9flhntBSCnMe5cW6nbwNBFSSNX05zpHOzYQPmSfoyB6rH
        GFvphvnsjFuLTF3HWTeaM0ssJlXWzvgaD+W6hdgcwtNqQSwzW9up6YguWl2aTK9p+HOl9X
        yFAyChpgAvoB6zzP0mnsZCiIZvAqqBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-o3eHZUV6NbaT1cJ-TJ4RWQ-1; Fri, 13 Nov 2020 14:54:18 -0500
X-MC-Unique: o3eHZUV6NbaT1cJ-TJ4RWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F5778730A8;
        Fri, 13 Nov 2020 19:54:15 +0000 (UTC)
Received: from treble (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54ADF62A16;
        Fri, 13 Nov 2020 19:54:11 +0000 (UTC)
Date:   Fri, 13 Nov 2020 13:54:08 -0600
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
Message-ID: <20201113195408.atbpjizijnhuinzy@treble>
References: <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com>
 <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble>
 <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 10:59:55AM -0800, Sami Tolvanen wrote:
> On Tue, Nov 10, 2020 at 9:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Nov 09, 2020 at 08:29:24PM -0600, Josh Poimboeuf wrote:
> > > On Mon, Nov 09, 2020 at 03:11:41PM -0800, Sami Tolvanen wrote:
> > > > CONFIG_XEN
> > > >
> > > > __switch_to_asm()+0x0: undefined stack state
> > > >   xen_hypercall_set_trap_table()+0x0: <=== (sym)
> >
> > With your branch + GCC 9 I can recreate all the warnings except this
> > one.
> 
> In a gcc build this warning is replaced with a different one:
> 
> vmlinux.o: warning: objtool: __startup_secondary_64()+0x7: return with
> modified stack frame
> 
> This just seems to depend on which function is placed right after the
> code in xen-head.S. With gcc, the disassembly looks like this:
> 
> 0000000000000000 <asm_cpu_bringup_and_idle>:
>        0:       e8 00 00 00 00          callq  5 <asm_cpu_bringup_and_idle+0x5>
>                         1: R_X86_64_PLT32       cpu_bringup_and_idle-0x4
>        5:       e9 f6 0f 00 00          jmpq   1000
> <xen_hypercall_set_trap_table>
> ...
> 0000000000001000 <xen_hypercall_set_trap_table>:
>         ...
> ...
> 0000000000002000 <__startup_secondary_64>:
> 
> With Clang+LTO, we end up with __switch_to_asm here instead of
> __startup_secondary_64.

I still don't see this warning for some reason.

Is it fixed by adding cpu_bringup_and_idle() to global_noreturns[] in
tools/objtool/check.c?

-- 
Josh

