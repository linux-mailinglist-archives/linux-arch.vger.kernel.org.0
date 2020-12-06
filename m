Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF12D0153
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLFGvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLFGvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:51:18 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA8C0613D0;
        Sat,  5 Dec 2020 22:50:32 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so10168285ioo.7;
        Sat, 05 Dec 2020 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xEFX9m1tSvdSJQ3/EiaRpiuUqPA/jqJsIXCgLkJIHTI=;
        b=DzK6LtMphXGVMKUPACceGTUsVVmN1cNs/QClR/+YjCKMnWe4BnLQBIJsKr7tKxkNyY
         w8fYOkrp4AJry9LpefYGu1ZK0PRDfStCJRHpd340BZOhkyFknzV9Qv1a8xkVOdyY9zFf
         gj6zMq1tQBs9MJGB2si/iNyk8qcAPb1OkxqdQ0kknvb2P9OxzdM9jt0tLWQNa3/KRgUW
         26EXDEONiip05JtUgT3RheVciiRVzO2cil6qzk6OBDikvUihqXg+enkPIQLrcSwu//N1
         F9oG7BK1bIa+jJndHBOVysL6/gUrP1m+nsgJWeLkzCRdImG92pho9jGdEKn0kHXouQT4
         KWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xEFX9m1tSvdSJQ3/EiaRpiuUqPA/jqJsIXCgLkJIHTI=;
        b=U7GtvkKDm7TRWA95HV5KbJYsyVb4eET/SBEyYuQLmyureDm5cZADZuMXbBgmIYXBzZ
         Tse6wUSKxXp7ymv3aS2rEwRPj7FvZZ0nEq4zKclEixBKBypaYe84eTWsCB3sD20X1o/k
         cA5Cj/mo6A1HqWx+B4NPis5EEuvvLa44XxVqom8UrznYcFORrPus3tMPWM25FuWaPd/E
         jOWkC+GWS7HMeK/BpmYSUn+H+cB5G8aGFu79QLKSDCom76sutIV4eLrDG/BCCDHbOXKz
         ahdxoS2XzW/skNbjSgtrqZQ6bLtgxSSTGrgEpXxgdtbhyl7dTqPTdZeGImOcktzHazCf
         BSHQ==
X-Gm-Message-State: AOAM533MFKHfzni8Ou4ZDNIP/0pIL9jOZxihVn0KYQp4A0JH13aZTyP5
        FpnsihFuMpI2HrqphV8xPkI=
X-Google-Smtp-Source: ABdhPJwZVi5tRrvxZ13o7P0VRkdeEgYwBAdwWzBfj6NClRTOtnOrrhmD5vISX/qn43sceqJ+Sz+PdQ==
X-Received: by 2002:a5d:958b:: with SMTP id a11mr13034197ioo.160.1607237432100;
        Sat, 05 Dec 2020 22:50:32 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id v23sm4068308iol.21.2020.12.05.22.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:50:30 -0800 (PST)
Date:   Sat, 5 Dec 2020 23:50:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
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
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
Message-ID: <20201206065028.GA2819096@ubuntu-m3-large-x86>
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck>
 <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck>
 <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
 <CABCJKufgkq+k0DeYaXrzjXniy=T_N4sN1bxoK9=cUxTZN5xSVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufgkq+k0DeYaXrzjXniy=T_N4sN1bxoK9=cUxTZN5xSVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 04, 2020 at 02:52:41PM -0800, Sami Tolvanen wrote:
> On Thu, Dec 3, 2020 at 2:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > So I'd recommend to Sami to simply make the Kconfig also depend on
> > clang's integrated assembler (not just llvm-nm and llvm-ar).
> 
> Sure, sounds good to me. What's the preferred way to test for this in Kconfig?
> 
> It looks like actually trying to test if we have an LLVM assembler
> (e.g. using $(as-instr,.section
> ".linker-options","e",@llvm_linker_options)) doesn't work as Kconfig
> doesn't pass -no-integrated-as to clang here. I could do something
> simple like $(success,echo $(LLVM) $(LLVM_IAS) | grep -q "1 1").
> 
> Thoughts?
> 
> Sami

I think

    depends on $(success,test $(LLVM_IAS) -eq 1)

should work, at least according to my brief test.

Cheers,
Nathan
