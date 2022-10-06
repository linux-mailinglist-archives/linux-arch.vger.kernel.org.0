Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5B5F6F3D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 22:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJFUfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJFUfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 16:35:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF149A9C3
        for <linux-arch@vger.kernel.org>; Thu,  6 Oct 2022 13:35:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x6so2715647pll.11
        for <linux-arch@vger.kernel.org>; Thu, 06 Oct 2022 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YrAC23faud15zS6eHd6bC3i2jrrjB6ysFBkxCYV0DUg=;
        b=VnvmXZkP0hhSETFJ7/rWObNvgVlwQNsO9Q6Wr+CY5AhJLWqAxw5ymAu+d5E1rrq4qi
         xtkMwQ6YDrHzIZayo7ZRhSzrDOrrFPnJhOXk4o7evz5s7x30Hn8I9naaZ0i069dQB/ph
         cnMQ55FQ011gtIYFCTqyzmJZqzabfBru2us/cJbxwS7Jb7TSyZcJOK7aqO0uOmoTQAcH
         GYFiGgWnKQU+ZbebJkkLcDLzUIDh8oQka9cmqiqC2XG21Fq/3L0j06kv3/yXoiZzN3Dc
         NqeD9ebVrKYIEEnneSVmz+ISDsgVMRU1uRoqaUUyEVUz6KnTZG9lz9xnlm/sH0mgGJ4X
         k7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YrAC23faud15zS6eHd6bC3i2jrrjB6ysFBkxCYV0DUg=;
        b=r2dvIErKSAmfxKf0PP87t0XS0XGyfy2mIbmcojD5yNSIRTLFx11Uwq9df8W3elcteS
         Hv8OFUJ/qnRupHI4oJFcDcSv8ZBQtAdSCzsvWSXxypr78wCJtbvtHdRAVf5Vpoaxnr2X
         Ol/arVpqDqLgFAJszBM86Zxbg4oF56YrW+0Ie1UGZADAr1MPR342kZfxc9OfEaw1yf+M
         q1lIl95HeLY0yccSO7MIdHM4z/NfhQ20C1/xiAyYg1RB3r9QCIrbeF8qdTuDa7rWcAu7
         cfIYHnOdXWsmxPrEe35yU4ltzO4OQMM3qfkYhiAJoJh3WzzFvLEtCE5Zg+xD7xa9HX8K
         jbNQ==
X-Gm-Message-State: ACrzQf1KV8X/LllpeGbL4DnVPoNHW/IewrX5c7U0i+/lhz9mWwvXinAP
        L4GJCDNj3xrUbJjzwGjlhLQxkaq6/bYdxwNme5Gc5g==
X-Google-Smtp-Source: AMsMyM4v3+jebTsx8rta3oTKTPbj+0QFRpgOMqqHaIV7tcXGfBpXOUbUwwIMLxbH/aI5igVtVyqUZJViZkQhI48Gf94=
X-Received: by 2002:a17:902:7404:b0:17f:7fe6:7197 with SMTP id
 g4-20020a170902740400b0017f7fe67197mr1565798pll.94.1665088515406; Thu, 06 Oct
 2022 13:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <202209291607.0MlscIht-lkp@intel.com> <20220930211505.209939-1-ndesaulniers@google.com>
In-Reply-To: <20220930211505.209939-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Oct 2022 13:35:03 -0700
Message-ID: <CAKwvOd=0p31f-Yya6S-9xKEv6CtUWpOCRxHO=jG2uk-hZgZ1bQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: kprobes: move __kretprobe_trampoline to out of
 line assembler
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 30, 2022 at 2:15 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
> EABI stack unwinder")
> tickled a bug in clang's integrated assembler where the .save and .pad
> directives must have corresponding .fnstart directives. The integrated
> assembler is unaware that the compiler will be generating the .fnstart
> directive.
>
>   arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
>   .save or .vsave directives
>   <inline asm>:3:2: note: instantiated into assembly here
>   .save   {sp, lr, pc}
>   ^
>   arch/arm/probes/kprobes/core.c:412:29: error: .fnstart must precede
>   .pad directive
>   <inline asm>:6:2: note: instantiated into assembly here
>   .pad    #52
>   ^
>

Chen, I noticed that your patch was discarded; it's not in linux-next today.
https://lore.kernel.org/linux-arm-kernel/YzHPGvhLkdQcDYzx@shell.armlinux.org.uk/
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9231/1
How would you like to proceed here?

I think moving this out of line, incorporating Ard's feedback, then
putting the UNWIND directives on top might be the way to go. What do
you think?
-- 
Thanks,
~Nick Desaulniers
