Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5375388802
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhESHQc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbhESHQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2021 03:16:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E9C06175F
        for <linux-arch@vger.kernel.org>; Wed, 19 May 2021 00:15:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b7so6070705wmh.5
        for <linux-arch@vger.kernel.org>; Wed, 19 May 2021 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9okw0AivC/GodUAOgdSjrzNrGvlF7i2iJnuU6Q7Ckhk=;
        b=GLdq3bNPUG1jVbmGuXT/73WV/H4ct0JC+JPyO1eIGy+uxrXeIrrgUTBkgOyB79PHc7
         wLFK19VrpLW3+QR7uumz7VfegumO/03BPjeaHthtleLjPv4rR5sZsZKmnwKaMZ0UMMQE
         gr/wpNE/p3phdRl/HBhMBnnG7Ceqfv4Un6Qh9OMLUWnILbaOcsufq7QT6gVJNkALrDj5
         LvEedY1AAT0Wpovo/BsutzLeeNlF70WhAFXjf5wfegQAs7idnoCE+88T76OnTfUMjnqY
         mZBt11ZLbg81ZNLfNeOqHoJde6wljGw5DprysPeWSQuaCaOg7bKP+7E2aaqYKQ3qBy0R
         wFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9okw0AivC/GodUAOgdSjrzNrGvlF7i2iJnuU6Q7Ckhk=;
        b=hozX1VkTC6I2Khfremz40hGHVpPb0pG+BbLNdDU9YQmAqsw27ZnSUILG6cXVmt1UQK
         tKhLJEPmTEjYpGt/iRtUFaNRSVgYraMQ1T4EWgY1YKjq3x6oIF7Y1dsQzDH3ujY9vLrs
         uS/yI3MEstlg/V8S1a3CprphStjXkBAqOHgX43KAuqSNFkClAaB1KZ6LBW8fAxrHKlJ5
         NiBPPTAUbTJ5Yvjy8q9Vwx0Rcc7zv+PLshBP4BX+GurIfKCVnq0j0k0av2WgQoT2ThpB
         A1Cy5O7RU80svw/4hybhRiP8IrYDk6xBbNrJFG8DWY2GxHn4574sBto+XcRfTuPm1nIF
         qgLg==
X-Gm-Message-State: AOAM5325YvNo8/rnCBRMvrCrqsjEGGhlX9gp2zS44ORZc6ShNhq9WSV2
        Alt8/uBtdeX16SOqkg/GmQL6h+A6Bc0vIURZeC7Hdg==
X-Google-Smtp-Source: ABdhPJw/naptBUbx4b3ptbfbXhmKN+TgrAcgi05rNO45VadkiPEcCxSc5SrssSarObHWl3KVpfRHtcRUN81TCIYDW3E=
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr9882524wmh.3.1621408508509;
 Wed, 19 May 2021 00:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
 <20210519060617.GA28397@lst.de> <20210519065431.GB3076809@x1>
In-Reply-To: <20210519065431.GB3076809@x1>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 19 May 2021 12:44:55 +0530
Message-ID: <CAAhSdy3C1owsbY_9gkxkhWfCXnL_noow7F4t=5+j7q+AJO3pZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 12:24 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig wrote:
> > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > > Since the existing RISC-V ISA cannot solve this problem, it is better
> > > to provide some configuration for the SOC vendor to customize.
> >
> > We've been talking about this problem for close to five years.  So no,
> > if you don't manage to get the feature into the ISA it can't be
> > supported.
>
> Isn't it a good goal for Linux to support the capabilities present in
> the SoC that a currently being fab'd?
>
> I believe the CMO group only started last year [1] so the RV64GC SoCs
> that are going into mass production this year would not have had the
> opporuntiy of utilizing any RISC-V ISA extension for handling cache
> management.

The current Linux RISC-V policy is to only accept patches for frozen or
ratified ISA specs.
(Refer, Documentation/riscv/patch-acceptance.rst)

This means even if emulate CMO instructions in OpenSBI, the Linux
patches won't be taken by Palmer because CMO specification is
still in draft stage.

Also, we all know how much time it takes for RISCV international
to freeze some spec. Judging by that we are looking at another
3-4 years at minimum.

Regards,
Anup
