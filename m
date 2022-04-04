Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A352C4F1D3C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiDDVac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380223AbiDDTQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 15:16:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5506C33E0A;
        Mon,  4 Apr 2022 12:14:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d10so7511250edj.0;
        Mon, 04 Apr 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+espoYszSZp1p1WHrGyTvFNDm47vVsucL53VCJGbNQ=;
        b=hoh3dyC3FDOpHs0Oa9MtXNEdb6T+MPU/rE4E97vtjQ0kFHrfOquVsSfCT02pnpdOSV
         UyvQyXxSUBW3xQaMhklyAsx+cI6YgpDwo6Od5vyv2DXvZJjXbkK+zPEFIo1Kj9WuKE40
         sj0TSnCHCztoC2luqCmQsVaZ9xcMzSpppRbkv6J9Pi7fWZWikcAavtIJ0+2Fj0GavDhK
         N+I/fFIREY/ExKnSiGF4Io2lqewR0hKdHvFw5GsWZrxBzB4D+BbVZKpaqrlipMVNNbLa
         9dYSzYeNIUeFyHb/O/hJUhfcQFnUIA1mrgDYcW6k+UXPwRMZUg9/3SgljqUAVB8jbvRY
         A3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+espoYszSZp1p1WHrGyTvFNDm47vVsucL53VCJGbNQ=;
        b=UkEcYtmquKnuJp1eFkvfCezCwAsE3xM1wP//0y37w1g1Yjh7zgcL7xczBUtP2Q9cMQ
         omp+6H41t0Xscs5GIdNq3cSntcv+VbrhA1Ocb7RAf/KeOqVSZgGp8bqb2+zUCrzWEUMP
         iZzlOn98KKZTFhoMOXffqtBOogwmhEQ5P4GCDgL5MRsnT+dwwq1093HJNPSiUYYXdnDf
         eeVxBEnLpAJ+CZSWFgAbD86gFnIZ1GR9OSyi67BbR+5IzAN0L+vWe5by1cK6ZTlpQSfL
         Oed+GY9gsAKD6BnEJlLEJPu9VtV+funqEG6rMT+SISM8OggUfaMNoJB0jT/mAuGfDcGl
         pcpw==
X-Gm-Message-State: AOAM531L7KCRo0qkPBNFCl4lLjtxmzT5wfY0sbmAR6tLEu/p50R4hz51
        dDa1ryEc+hHZRvbAGMPSR3kxmpRQvhdO/xq7Ujs=
X-Google-Smtp-Source: ABdhPJzQP+hf5SuJlHqDSZUr7Fy6SznLH3ME81HEeqGLMYxs1Q1hlk7PXHj0e2EC/UWg5Jyw7UYqSwUbEdHC+883sYE=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr1704694edz.414.1649099683759; Mon, 04
 Apr 2022 12:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com> <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
In-Reply-To: <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 4 Apr 2022 12:14:32 -0700
Message-ID: <CAMo8BfLT8vMw3aGQPs1+9ry7W63SQphmDc4Tt4A3JvADHJhxiQ@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 12:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 4, 2022 at 7:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > Please let me know if you observe any specific build/runtime issues.
>
> This is what I get:
>
> $ make ARCH=xtensa O=build/xtensa nommu_kc705_defconfig vmlinux V=1
> ....
> xtensa-linux-gcc-11.1.0 -DKCONFIG_SEED=
...
> /git/arm-soc/arch/xtensa/kernel/head.S: Assembler messages:
> /git/arm-soc/arch/xtensa/kernel/head.S:87: Error: invalid register
> 'atomctl' for 'wsr' instruction

Sure, one cannot use an arbitrary xtensa compiler for the kernel
build, the compiler configuration must match the core variant selected
in the linux configuration. Specifically, for the nommu_kc705_defconfig
the following compiler can be used:

https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-de212-elf.tar.gz

If you build the toolchain yourself using crosstool-ng or buildroot they
accept the 'configuration overlay' parameter that does the compiler
customization.

Perhaps the documentation for this part is what needs to be improved.

> I think there were other errors in the past, but every time I tried
> it, the build failed for me.

-- 
Thanks.
-- Max
