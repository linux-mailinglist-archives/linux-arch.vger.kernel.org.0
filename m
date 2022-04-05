Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DB84F2190
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 06:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiDEDZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 23:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiDEDZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 23:25:48 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297047063
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 20:23:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t19so9468902qtc.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2022 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qApr9GrihVbOuWIYXrsrRfMhvE7Z9/nCtDMkcpQr1HA=;
        b=OUL2erKbptx3OSEXn+FNiSDEclLx26+4Q9s4Yc0HFFg2NowwbEnAZPwFjtfFoQXFSD
         HGr3WZcWj0bwCYYGq+VQH3lNm19kHiCLCcgHpy3MWFLUkJdqXzzsA6T3FCzHLz4UT2GP
         u+NVUKCBFvqmXaoDydp6uOSzgkS3i+tqmaGAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qApr9GrihVbOuWIYXrsrRfMhvE7Z9/nCtDMkcpQr1HA=;
        b=GPimDTebbnJy3jSqgBhIQPDuueG3Pxi7jh2yAfe7108EQFs0M9bo+2P/dP9PgdWzjp
         nfuNxuQXvs5TfJjmRcZohr6JnGsUDYwnCN+G1DnGv+gHeq4UYitgWnrBHTRCdQEnNBP2
         KzkTiuJAXmrgA9xhSergXelfMkt1eMLhZ6mOuBD674jLj+cO4/7mcotnRCbKXMxCFjNk
         zt8CKWOa7LBu1X2LUekEtUTHgrxj94nroD8xXW4LXi7SfMVQJdkwVd8h9wvhy3+h1OrI
         Eu7YvzuAG5BmH2ky2bgYNH2NwHXPhswbiqUU8G+EhdjU9PEaGsDJFAVmjxT/xkYZ2LW6
         FBjg==
X-Gm-Message-State: AOAM532xk3lpz2KLJ3gDfSoyC1CNPGkJ0ZOdxk2Z5BwVoZbp+e12fMfh
        IgaQ0LQoyjuo644fLbBEI5p8HsaLHQUKiD4fMHqJUQ==
X-Google-Smtp-Source: ABdhPJwynqhZqs8C04npxIC6XvYVeW6E//MMWg7Ai+dGctLoCRwKSkiHu3j/uCEqqA2vWJ4U1/uhkuomufhsrlhjYio=
X-Received: by 2002:a05:622a:110c:b0:2e1:fe6b:2f26 with SMTP id
 e12-20020a05622a110c00b002e1fe6b2f26mr1251546qty.201.1649129029903; Mon, 04
 Apr 2022 20:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
In-Reply-To: <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 5 Apr 2022 12:23:39 +0900
Message-ID: <CAFr9PXkk=8HOxPwVvFRzqHZteRREWxSOOcdjrcOPe0d=9AW2yQ@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg,

On Mon, 4 Apr 2022 at 22:42, Greg Ungerer <gerg@linux-m68k.org> wrote:
> But we could consider the Dragonball support for removal. I keep it compiling,
> but I don't use it and can't test that it actually works. Not sure that it
> has been used for a very long time now. And I didn't even realize but its
> serial driver (68328serial.c) was removed in 2015. No one seems too have
> noticed and complained.

I noticed this and I am working on fixing it up for a new Dragonball
homebrew machine.
I'm trying to add a 68000 machine to QEMU to make the development
easier because I'm currently waiting an hour or more for a kernel to
load over serial.
It might be a few months.

It looked like 68328serial.c was removed because someone tried to
clean it up and it was decided that no one was using it and it was
best to delete it.
My plan was to at some point send a series to fix up the issues with
the Dragonball support, revert removing the serial driver and adding
the patch that cleaned it up.

Cheers,

Daniel
