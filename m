Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09D53286D
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiEXK77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiEXK76 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 06:59:58 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF76FA39;
        Tue, 24 May 2022 03:59:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id k13so3578976uad.0;
        Tue, 24 May 2022 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyNGMzB8eRzvXkgcGkGr6qv15WPNXqDuFiVrIoJC1xE=;
        b=hl+MbcoLRG5p6f0tyPfx9hEebKnCInbyfKFlgIhrxiMaZxGo75slJlOpukMI+qmtY4
         vKs6XkrY6enhD9LKHO5yaO5a0YSYrFD8s/80jGcTSCC7zmgoGrXDXaJNVa4gpvJ/DQvk
         DB0DDXIkGH3Oc5mRDsPmISjVD6gCQ0S2fZXivHEKGv/ccLLdlQ6CoX/2cASy2OKUOMoi
         z0LF9lDmcO39Z7WoVQTxyPUk0SMPgoo4VZj0YbXMDaGNwyLLQvqIc1xH5UNs8Gt8TJPw
         PImI4UvFCmWNvCjQbvPp0d0c802Bq6aHQpZ4xcpuupIgfwrXENlxhvuCQjAywT2pxv/A
         3cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyNGMzB8eRzvXkgcGkGr6qv15WPNXqDuFiVrIoJC1xE=;
        b=0XnFRP9du1+hNVfTPdU+uei3hKlS+DHjOKZqSLxDwqZfuAw5BVTMg2VbyA1IW9Ex7M
         dSyg62ZljkKGnmsX01TofECUFHE4fxUA9FU4GPjebegxclDu2RCvktYaXD5hTwy5IXWC
         8027Pwt9VJCikJvHnxpyx1qmAfYJTO37Hov2lmyuxpJX6zZ9X1v9Sbt04h5cTJtA31ml
         ReZCLJQjKidbpgsL5mPeRfB4ebijXaodedbP2H+t0v1H6vbEX2/8fFhB/8EVcbvpKrhD
         5lyZ6EV86QqOVsGwKWGlZ+gRsfmI/AqslB+gWK3wRwxI66Pu6W8k9kwfDIYhg1ANpor2
         k8kQ==
X-Gm-Message-State: AOAM530m1N4+gQpfgZ5I3B0W3hlITLYxFgTg++2JSmtCSUJvunndMhAZ
        qL0Knt1xDGmSje8kaa6bMGIAp6D1pujVvdtPEWg8tfAl8IC9t/RH
X-Google-Smtp-Source: ABdhPJzjHep8EeU03Bdx8UMpAopw7ydL9VNQPgVLtJw/4rEwY7HBf0Z0i+/xdekLJoG+9rVYRDr7nM0cHPOyFMNEYeg=
X-Received: by 2002:ab0:6999:0:b0:368:a1e8:74c9 with SMTP id
 t25-20020ab06999000000b00368a1e874c9mr8496825uaq.21.1653389996991; Tue, 24
 May 2022 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <14f922495a09898017e4db3baed5b434acadac12.camel@xry111.site>
In-Reply-To: <14f922495a09898017e4db3baed5b434acadac12.camel@xry111.site>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 24 May 2022 18:59:50 +0800
Message-ID: <CAAhV-H4BHUTshe2w-KnJ3hLveaFWRJihyDwnOnAbSYWDV_18LA@mail.gmail.com>
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
To:     Xi Ruoyao <xry111@xry111.site>, lichao@loongson.cn
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Tue, May 24, 2022 at 4:27 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2022-05-18 at 17:26 +0800, Huacai Chen wrote:
> > Currently an existing interface between the kernel and the bootloader
> > is  implemented. Kernel gets 2 values from the bootloader, passed in
> > registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
> > non-UEFI firmware, while a1 is a pointer to an FDT with systable,
> > memmap, cmdline and initrd information.
>
> If I understand this correctly, we can:
>
> - set a0 to 0
> - set a1 a pointer (virtual address or physical address?) to the FDT
> with these information
>
> in the bootloader before invoking the kernel, then it will be possible
> to boot this kernel w/o firmware update?
Unfortunately, there is no released firmware for you since we recently
changed the interface again and again. :(
You can contact with Li Chao (lichao@loongson.cn), I think he can
provide help as much as possible (at least provide temporary firmwares
for developers).
We will also provide qemu-system and virtual machine's firmware as
soon as possible.

Huacai

>
> I'd prefer to receive a firmware update anyway, but we need an
> alternative if some vendor just say "no way, our customized distro works
> fine and you should use it".  (I'm not accusing LoongArch: such annoying
> behavior is common among vendors of all architectures, and even worse
> with x86 because they often say "just use Windoge".)
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
