Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7B5EE200
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiI1QkD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiI1QkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 12:40:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575215B7AE
        for <linux-arch@vger.kernel.org>; Wed, 28 Sep 2022 09:39:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so11885950pfh.6
        for <linux-arch@vger.kernel.org>; Wed, 28 Sep 2022 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o0ZtcGWZNzFvp0wcIHSx/qDwHK3W4cVWO2PGHB1LS1c=;
        b=XZti6DE6WlXyQVPePUhXRgoWOS/rerz9MsFfOVbPOLEEBzIyws5QOPAWcdDUeGhDGE
         u31jUF/c5MBBrGHl4oKgKG4wvvd2rEIOiVIe1k+98ZReRU44SqZqoYlQ2Id6uB089lbj
         HvdnwKrn9UOt8dkrWlxYRLS+g3gwAqz7cK5GR9OtJf60AwnHBf6zTocLO19jgu3J7vo9
         AXRif6rmCyWprHQo6n4mThPtrzEvHBkzEeWV7TF8ci3U2f0dFjjDryn2eHu2+ycXe5D/
         ZfGrsUi9XDUx5x5Lnr02fExY0tVj2w8RJN4ML0c25k2FLxwLyEug4LsvCjLikEmSV+/8
         pjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o0ZtcGWZNzFvp0wcIHSx/qDwHK3W4cVWO2PGHB1LS1c=;
        b=osq7EM1IKcgzCmBfZlIXXfsf2+W+Lkkq8EZriKqnQsKT/n1ePYcP6RL5uaBeIT6Xn9
         GcfLWPHE5CuAFqj4iFGUC5jFTUyPycZRrW7zK3+QeSRTFIkLIbnaHh03+Dzz1zUfUjsk
         gmnssXJxuuLGifFxRbD1+OJyUcYX4m2altS4uXkuwlz3LPZrFZAv360VPgb0eljJAKrT
         ks82ySRq+zwDFjsWVtXC/4CTYtOPIvBHRl69cWJsDm5fA3yqpzAxJNgm8wrVFZLZ2s+v
         UUYqFEyqrirIj8JxaQwcOfJmShE8uSI96LFRvwWSmQhubhOP16JiTdoxUSw4oKuoqBF+
         aPeA==
X-Gm-Message-State: ACrzQf0OwqDoXkoP33wEK3NWgH98nhoKqBHXngez4f0h/QD8Fdg4YSAJ
        ZA6R1xq0fcW9awexAma/gCVrOQ1tw0LP4A2YNUq2Xg==
X-Google-Smtp-Source: AMsMyM6AUXk3l6t7gbTaADsa4xDkK4u+S0bN6AiVVAyB3own/m+Jg36aXqTk6IV6sma1lp9qsIaxjytl2gLCvI9BDNQ=
X-Received: by 2002:a62:1ad5:0:b0:540:4830:7df6 with SMTP id
 a204-20020a621ad5000000b0054048307df6mr34720102pfa.37.1664383198614; Wed, 28
 Sep 2022 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnQ4tb7auWqUoF_Mm-F9hiJotaQnP75ZDd6oPJ_1Z4qXg@mail.gmail.com>
 <20220927222851.37550-1-ndesaulniers@google.com> <YzN6rH6wOiC8a8sN@shell.armlinux.org.uk>
In-Reply-To: <YzN6rH6wOiC8a8sN@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 09:39:46 -0700
Message-ID: <CAKwvOdkg5FccDAKMnBfX9uEw5YoEDpBvSYoBO4Y1dJT+hkGVVA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: move __kretprobe_trampoline to out of
 line assembler
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Logan Chien <loganchien@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
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

On Tue, Sep 27, 2022 at 3:35 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Sep 27, 2022 at 03:28:51PM -0700, Nick Desaulniers wrote:
> > commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
> > EABI stack unwinder")
> > tickled a bug in clang's integrated assembler where the .save and .pad
> > directives must have corresponding .fnstart directives. The integrated
> > assembler is unaware that the compiler will be generating the .fnstart
> > directive.
>
> Has it been confirmed that gcc does generate a .fnstart for naked
> functions?

From what I can tell, the presence of __attribute__((naked)) makes no
difference with regards to the emission of the .fnstart directive for
GCC.

One thing I did notice though: https://godbolt.org/z/Mv5GEobc8
GCC will emit .fnstart directives when -fasynchronous-unwind-tables is
specified for C (omitting the directive otherwise), or regardless of
-fasynchronous-unwind-tables/-fno-asynchronous-unwind-tables for C++.
Clang will unconditionally emit .fnstart directives regardless of language mode.

I don't see -fasynchronous-unwind-tables being specified under
arch/arm/. But there are many instances of
UNWIND(.fnstart)
in various .S files under arch/arm/.

https://sourceware.org/binutils/docs/as/ARM-Unwinding-Tutorial.html
https://sourceware.org/binutils/docs/as/ARM-Directives.html#arm_005ffnstart


>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!



--
Thanks,
~Nick Desaulniers
