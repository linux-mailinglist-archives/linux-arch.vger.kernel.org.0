Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FC4B5C64
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiBNVQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 16:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiBNVQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 16:16:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9581133C8;
        Mon, 14 Feb 2022 13:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 778A16115B;
        Mon, 14 Feb 2022 19:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FFAC340FD;
        Mon, 14 Feb 2022 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644867624;
        bh=5szbHF9etsKpvbwWwwc9H/Y1QakuvzjKYGUIBcYFA80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e8SkA3FlLGu70hI/WgHcE1Xcld6ahEqgd/8aP3tnN+Ui+6c+MZmJxArGum1LdtmAc
         TVm8LqkWXJbpel0WqJluZlN0q2Rc8pObOFXCjWsE1d3haVSN1sOjQ5hKRVHWsZ71lN
         9Hnj9zqBHSBBx6qUNlA6sc7rmD8pMbOGHJ9SDDCXuRY9FNQ7binWt4bsfA/Yof8Egb
         Ksm8rfkNmn9T9/rsBeFI1yBap4xnb6nVmSKUusmotl5Q02Llm+mwF8WcKWget2RALt
         X3B6AavEfyIeX6XUTomqUIV78jVQAYplU/28sKTs9My6dabsF705ywSdaO+p8h0D4l
         JZS2fHyItMkuQ==
Received: by mail-wm1-f54.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso96481wmj.2;
        Mon, 14 Feb 2022 11:40:24 -0800 (PST)
X-Gm-Message-State: AOAM532dvZbtvOPm1OVJdRP6UdnKTYMjhyzK9noTSPV4d2TnlmwY4VjK
        c6zphPR526O7Yd9rGGuLi8qjsl/2HmGocLZjIrU=
X-Google-Smtp-Source: ABdhPJzTYqCeBLA8ZZTCXfIkkUBrupnk+RLzKXVQdywxm2I/SfNIqW0R0tvlKvR6EMssd+gXW/CMf7zH4TFa2LGJB14=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr252362wms.82.1644867623104; Mon, 14 Feb
 2022 11:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-11-arnd@kernel.org>
 <YgqL/NJ3YHEAhj4i@infradead.org>
In-Reply-To: <YgqL/NJ3YHEAhj4i@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Feb 2022 20:40:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3eOw=QpxWFnODE61EFt8oGPJ7dcusfbPSD1vdEsUmekQ@mail.gmail.com>
Message-ID: <CAK8P3a3eOw=QpxWFnODE61EFt8oGPJ7dcusfbPSD1vdEsUmekQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] uaccess: remove most CONFIG_SET_FS users
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > On almost all architectures, there are no remaining callers
> > of set_fs(), so CONFIG_SET_FS can be disabled, along with
> > removing the thread_info field and any references to it.
> >
> > This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
>
> Wouldn't it make more sense to just merge this into the last patch?

Yes, sounds good. I wasn't sure at first if there is enough buy-in to get
all architectures cleaned up, and I hadn't done the ia64 patch, so it
seemed more important to do this part early, but now it seems that it
will all go in at the same time, so doing this as part of a big removal
at the end makes sense.

        Arnd
