Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E292BB6D0
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 21:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgKTU3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 15:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgKTU3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 15:29:40 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9761C0613CF;
        Fri, 20 Nov 2020 12:29:38 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so8112755qtp.2;
        Fri, 20 Nov 2020 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWEyiKtLOwc5BKH8g+Q/g+4/sPbOaRfc0dXxralt2Mw=;
        b=slPQ//pemKZh9f5kkjudlch0CBWhSXQy2VCSu7HRkD1RW0Ao5+0ftQM2E6UPD3hccj
         qjQNNmRuGGdK3qOvq5NYurgRaP3hJJuevD4jAH/fmKo+acNl1pILRNLqMDFd7QZ+2prZ
         tmcUlDky6roTiagY+1Ks0VwGJwggfgRDYhMNyjlvUprVonMn9YqbkCKWYuYbATXQn2JP
         H9tN2HQsAdXChUj0afdmZW/4fCcfq/VPLcHKF5jmoDMHeF6P0ZDz4TumaSvPvAlnmbSp
         9HEAzto9pPBh3Vc65NGET29HWmFU7wMfbtObL4BW7Zce7yCYVt0G+SkyUa9ICW+0aIqa
         CMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWEyiKtLOwc5BKH8g+Q/g+4/sPbOaRfc0dXxralt2Mw=;
        b=c4pVaR9D+CoUU7W6+5RJsHy6xekr8zhxscgYuRaG64gQ74mjIU2J1YnG/4XloCL4Do
         f8o90Bml3Ce/nyIqsK6sS+m8oSx4Z34a7MhigyGJyi7nYEURwOq2VGZ18r4x5F/KVrI2
         yi5nkE38it1Pq9Ja4ClZnfdqefEYyIcyEbyeQP5/pbw5LjzMdrQgo7QFaUxRMHy5UVDW
         FroqbFARRjaHpwYwvN7S4+3MyvIi7EdNWkj7WJdzuRKAS8KJzptxNCs9M8MViwsMpojC
         FKEUgFg/3MxvMkqQ9v+o7/35wPifH4otpBw+1cs4ykHJEn+T78lvcHYv8dVaxB+fjMH4
         1lrg==
X-Gm-Message-State: AOAM533dD/CiJFobC4S8vncNo3dO0PzjSIayCbFSD7R+Zqj4TyKZRwe5
        FEZWd0bsoMOtU0Ux5ifcpko=
X-Google-Smtp-Source: ABdhPJyeXkg7uuNpc9skA29Vf8QCCxes8SLhmi9OBG/8zRZ22lxtrFLvm4CI1/fXBFji9v0sjbaDkA==
X-Received: by 2002:ac8:3496:: with SMTP id w22mr17736541qtb.222.1605904178000;
        Fri, 20 Nov 2020 12:29:38 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id v32sm2850385qtb.42.2020.11.20.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:29:36 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:29:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 02/17] kbuild: add support for Clang LTO
Message-ID: <20201120202935.GA1220359@ubuntu-m3-large-x86>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-3-samitolvanen@google.com>
 <CAKwvOdnYTMzaahnBqdNYPz3KMdnkp=jZ4hxiqkTYzM5+BBdezA@mail.gmail.com>
 <CABCJKucj_jUwoiLc35R7qFe+cNKTWgT+gsCa5pPiY66+1--3Lg@mail.gmail.com>
 <202011201144.3F2BB70C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011201144.3F2BB70C@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 11:47:21AM -0800, Kees Cook wrote:
> On Fri, Nov 20, 2020 at 08:23:11AM -0800, Sami Tolvanen wrote:
> > Changing the ThinLTO config to a choice and moving it after the main
> > LTO config sounds like a good idea to me. I'll see if I can change
> > this in v8. Thanks!
> 
> Originally, I thought this might be a bit ugly once GCC LTO is added,
> but this could be just a choice like we're done for the stack
> initialization. Something like an "LTO" choice of NONE, CLANG_FULL,
> CLANG_THIN, and in the future GCC, etc.

Having two separate choices might be a little bit cleaner though? One
for the compiler (LTO_CLANG versus LTO_GCC) and one for the type
(THINLTO versus FULLLTO). The type one could just have a "depends on
CC_IS_CLANG" to ensure it only showed up when needed.

Cheers,
Nathan
