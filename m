Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C22B28CE
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 23:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMWyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 17:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMWyp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 17:54:45 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3ADC0613D1
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 14:54:45 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id n189so2480712vkb.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7PN1px9ytV6KoYCs0MN8nIig7IfEqAMiUFMKSdwj8o=;
        b=E/DaHCUsxm9boUEUHR77XASfe1K99YXKl7duBooJylavKxm0tOGa/ZPK6xjyi2fAmj
         OYWDrTJOnFXwWt5S1pKJ6s8UxL+U3rZbepSwCXbZJRMhsO/oaNcGV6l2VgGjr5evZtSz
         yye6NpoiB+nakm0oK6uQ3sQViWHFOTTwEdtfu1R5mD/VgZzVhriCR2Y85MJT5y8nazB0
         NR1BZldS24JnVXgr+Ovb7PrDJwr+3Atcw4eToXXk9DLqZMzDtjrCymZ+KKaYr49Oz2wG
         03mdefjS8C7FER66kGpwiyb+EPHalvUWh8ADfLZXcOqSslaUx80S/cRhipC8ekjXSqmD
         cGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7PN1px9ytV6KoYCs0MN8nIig7IfEqAMiUFMKSdwj8o=;
        b=jU7OfW4/iGM+YaVC86zzto7v8OIhxns4AxM2rlMggr6vS3uMriIiiW13rd8N4iFLi+
         +zo1knF/DQHmOY7ToAZzA6QcjFXzFfOMp+BgX1//v66RPapbcoklC/2JiRAt262dNxNq
         5tnA0ddv5483/CzqvyjFNOJ8I5RESjAksyHiaho7ALDwkIROVDbZ1VJmTkdGADJCtHQf
         nU2KspJrMET0lRaa5pdL4lm24fUXBPYhzPT8dZUn0VvuH5LNTLOsCNvxdp9hhuKKcZ2Y
         zqeWEqyVCTUV7b+TSgOjUCCJMvfEGKD8tHR+EJ4duXe8qi9zUceoIURvi2S2pXX5687+
         j4Tg==
X-Gm-Message-State: AOAM533b//KhLCBSueBgfBtX7MkdAU5j+/cG0gTbULkcHThgqZFDXJTQ
        K3L2mevYF3i31D++cv6vApwDqolaRS7Jv9jwhChLeg==
X-Google-Smtp-Source: ABdhPJygwOP2IUwJzonbqdQUEI4r2KfzeUcxt3t9CVTdz7Ir0TADwtgbrh1R8/xsj+WLPbsqPnxXtDMz7YsGC5N32I8=
X-Received: by 2002:a1f:3655:: with SMTP id d82mr3109788vka.22.1605308083978;
 Fri, 13 Nov 2020 14:54:43 -0800 (PST)
MIME-Version: 1.0
References: <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com> <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble> <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
 <20201113195408.atbpjizijnhuinzy@treble> <CABCJKufA-aOcsOqb1NiMQeBGm9Q-JxjoPjsuNpHh0kL4LzfO0w@mail.gmail.com>
 <20201113223412.inono2ekrs7ky7rm@treble>
In-Reply-To: <20201113223412.inono2ekrs7ky7rm@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Nov 2020 14:54:32 -0800
Message-ID: <CABCJKufBEBcPPrUZcAvh1LXX_GwRG1S1sg2ED2DPZ53MPy_VbQ@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 2:34 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Nov 13, 2020 at 12:24:32PM -0800, Sami Tolvanen wrote:
> > > I still don't see this warning for some reason.
> >
> > Do you have CONFIG_XEN enabled? I can reproduce this on ToT master as follows:
> >
> > $ git rev-parse HEAD
> > 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > $ make defconfig && \
> > ./scripts/config -e HYPERVISOR_GUEST -e PARAVIRT -e XEN && \
> > make olddefconfig && \
> > make -j110
> > ...
> > $ ./tools/objtool/objtool check -arfld vmlinux.o 2>&1 | grep secondary
> > vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with
> > modified stack frame
> >
> > > Is it fixed by adding cpu_bringup_and_idle() to global_noreturns[] in
> > > tools/objtool/check.c?
> >
> > No, that didn't fix the warning. Here's what I tested:
>
> I think this fixes it:
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/xen: Fix objtool vmlinux.o validation of xen hypercalls
>
> Objtool vmlinux.o validation is showing warnings like the following:
>
>   # tools/objtool/objtool check -barfld vmlinux.o
>   vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with modified stack frame
>   vmlinux.o: warning: objtool:   xen_hypercall_set_trap_table()+0x0: <=== (sym)
>
> Objtool falls through all the empty hypercall text and gets confused
> when it encounters the first real function afterwards.  The empty unwind
> hints in the hypercalls aren't working for some reason.  Replace them
> with a more straightforward use of STACK_FRAME_NON_STANDARD.
>
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/xen/xen-head.S | 9 ++++-----
>  include/linux/objtool.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)

Confirmed, this fixes the warning, also in LTO builds. Thanks!

Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
