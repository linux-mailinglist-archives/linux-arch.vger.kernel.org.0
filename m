Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045FF2D070C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLFUKY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 15:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFUKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 15:10:24 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D55C0613D0
        for <linux-arch@vger.kernel.org>; Sun,  6 Dec 2020 12:09:43 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x4so3787850uac.11
        for <linux-arch@vger.kernel.org>; Sun, 06 Dec 2020 12:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz05We4T6eIjQaXBvxz0eSpPimwSlGMKW8WGflLLLgw=;
        b=iS/yxV/uv33bWygYcp3w94mm68WCg/cooZBDHGRBRFCb+HEVGfBEws+dpr/6P25Mqk
         CGF0txaBIDtDjqi1yLxaRHzbKNu312tAIiWry1c6H2XUemwifDXDJ3xgms3nJQh018Ju
         tSfem3j42gdxUipuE2UCBGdP6HbCXjgyA35rk3ybR2x5sUXsvaX34+w/11PCnDP3wUw3
         VXU3d3GrfxpXDM3mNsWNN8WzS04oerefikrSUgI3Sa41DzU+d/SyYsbVuDLVrcBbBAFd
         TPfpfk+LViEDwCmkthUfnAh26cBtd4O/zl0ILiNY2vgWj3ccwdwRthGGUZbaHtAB4IuL
         4E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz05We4T6eIjQaXBvxz0eSpPimwSlGMKW8WGflLLLgw=;
        b=j/GDafR+rsUDmr+wKwbKmVY4SzLR7K6YxjuF2JY/iZXFjS3YV7jAI28jMfbl17BSps
         kadbNQqzWBpg/ZwehZjKiYVleGLsdsdmS9fwj0iGj529SCJHERZCoW9zu5rIalpdKONA
         T0rD4vGJofTrMHI3mSCIoJf2Cx7RTtzdNFrSZbOEGXAcXiNci95Ing+57bcHxNBT5k/1
         adff8JHJD5YpNqTphlyLyFpYtRx5ELEzQHzRYqGhF6CmVSHzx2j1TJ6kLU9XWCrcwmta
         qe7RklUtRaUAzRNlOGnt1dhssh/bzaEP6Auw7yvEKu48tuxoroPKrnnD4ta0R0XvYYS/
         GYeA==
X-Gm-Message-State: AOAM5306G4QqL2Wtknm8J6f4zyrQLVu735VsXlcHVfgmM17A6acsE1CH
        +Y7V4aMDllePS8lOA7wC8Pu78zQXc9oJFtMBkIUUmg==
X-Google-Smtp-Source: ABdhPJyKCb8VYAdpRAyuT9QnDEa4WUbLFAwf7yIvP0eytyeCFIBxggFhwRm1Itv8d1sjhOU4I4dMU+iMqgn79bJuOn0=
X-Received: by 2002:ab0:6f0f:: with SMTP id r15mr3484878uah.52.1607285382144;
 Sun, 06 Dec 2020 12:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck> <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck> <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
 <CABCJKufgkq+k0DeYaXrzjXniy=T_N4sN1bxoK9=cUxTZN5xSVQ@mail.gmail.com> <20201206065028.GA2819096@ubuntu-m3-large-x86>
In-Reply-To: <20201206065028.GA2819096@ubuntu-m3-large-x86>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Sun, 6 Dec 2020 12:09:31 -0800
Message-ID: <CABCJKue9TJnhge6TVPj9vfZXPGD4RW2JYiN3kNwVKNovTCq8ZA@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 5, 2020 at 10:50 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Dec 04, 2020 at 02:52:41PM -0800, Sami Tolvanen wrote:
> > On Thu, Dec 3, 2020 at 2:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > So I'd recommend to Sami to simply make the Kconfig also depend on
> > > clang's integrated assembler (not just llvm-nm and llvm-ar).
> >
> > Sure, sounds good to me. What's the preferred way to test for this in Kconfig?
> >
> > It looks like actually trying to test if we have an LLVM assembler
> > (e.g. using $(as-instr,.section
> > ".linker-options","e",@llvm_linker_options)) doesn't work as Kconfig
> > doesn't pass -no-integrated-as to clang here.

After a closer look, that's actually not correct, this seems to work
with Clang+LLD no matter which assembler is used. I suppose we could
test for .gasversion. to detect GNU as, but that's hardly ideal.

> >I could do something
> > simple like $(success,echo $(LLVM) $(LLVM_IAS) | grep -q "1 1").
> >
> > Thoughts?
> >
> > Sami
>
> I think
>
>     depends on $(success,test $(LLVM_IAS) -eq 1)
>
> should work, at least according to my brief test.

Sure, looks good to me. However, I think we should also test for
LLVM=1 to avoid possible further issues with mismatched toolchains
instead of only checking for llvm-nm and llvm-ar.

Sami
