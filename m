Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786AD327442
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 20:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhB1Tud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 14:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhB1Tuc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Feb 2021 14:50:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B57D664EBB;
        Sun, 28 Feb 2021 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614541792;
        bh=dZgO6FxYn+Uq8d8DXJml+c02cu3lM6vLbO249U6mLVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T7dOAml4L2aCFNfxPIFfdL2AfmnxuOTXjR6aAOKStuybawYGkl72lGpNNDArawWRE
         bIzt4cIP80LbjLcdubGhfvSv0Zd08pAsDTQJ/MBH3LpTi9ar922/ro8F+bAj2xQEpw
         BQd/4ikx+OeYPfVRGPjnpBgWIYPkUlFetLMMSNT49CG5pocXxEvCVP8CoYA5Hy6H+p
         nMnKfyS2ZjmfwmzAjP12GroQGZo5WTRL42MRtL7mHBH4bs+1U22Au2m2ztAm08/rI5
         VqrFZrh/MID2xLhGxjrIrrZgiYlmVcekSpHEbTlvn4iDN51e2APDcPtfknV1agK+9E
         U2HAmMZxv4szw==
Received: by mail-oi1-f172.google.com with SMTP id l64so15898961oig.9;
        Sun, 28 Feb 2021 11:49:52 -0800 (PST)
X-Gm-Message-State: AOAM5317/1MtcIbwk1U/Bqvn911XI4tECxEBF2LEu60LXpDlzPNGeDEO
        NUsBOe7bG8Qlbgua+IakGbymrdYKrY7C8/UbwBc=
X-Google-Smtp-Source: ABdhPJzVPe+JDSbwJJu/9VPn9RXrwOYg1LrMfh0qSgg3xP2rPMpeZECKgNVZJpcXwleef24vg9C08sq7NdoQ9DPgneM=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr8851896oia.67.1614541790992;
 Sun, 28 Feb 2021 11:49:50 -0800 (PST)
MIME-Version: 1.0
References: <tencent_2CB9BD7D4063DE3F6845F79176B2D29A7E09@qq.com>
 <CAK8P3a2TEc4CzE5Wg7pNy9Oq2p=HKNO7k2y2SmeD1mamqJ3Z9w@mail.gmail.com> <tencent_2B7E37BD494059DF7D6845F641769CD28209@qq.com>
In-Reply-To: <tencent_2B7E37BD494059DF7D6845F641769CD28209@qq.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 28 Feb 2021 20:49:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2o=GfLCBiQh=fuRor3yKd0h7zKDZoqj8bsReoQNEA1eg@mail.gmail.com>
Message-ID: <CAK8P3a2o=GfLCBiQh=fuRor3yKd0h7zKDZoqj8bsReoQNEA1eg@mail.gmail.com>
Subject: Re: [PATCH] ipc/msg: add msgsnd_timed and msgrcv_timed syscall for
 system V message queue
To:     Eric Gao <eric.tech@foxmail.com>
Cc:     "catalin.marinas" <catalin.marinas@arm.com>,
        will <will@kernel.org>, geert <geert@linux-m68k.org>,
        monstr <monstr@monstr.eu>, tsbogend <tsbogend@alpha.franken.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        deller <deller@gmx.de>, mpe <mpe@ellerman.id.au>,
        hca <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        borntraeger <borntraeger@de.ibm.com>,
        ysato <ysato@users.sourceforge.jp>, dalias <dalias@libc.org>,
        davem <davem@davemloft.net>, luto <luto@kernel.org>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        bp <bp@alien8.de>, chris <chris@zankel.net>,
        jcmvbkbc <jcmvbkbc@gmail.com>, arnd <arnd@arndb.de>,
        benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
        hpa <hpa@zytor.com>, linux-alpha <linux-alpha@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 28, 2021 at 5:16 PM Eric Gao <eric.tech@foxmail.com> wrote:
>
> > Is there something that mq_timedsend/mq_timedreceive cannot do that
> > you need? Would it be possible to add that feature to the posix message
> > queues instead?
>
> the system v message queue have a mtype parameter both in msgsnd and msgrcv which can be
> used to implement message routing(mtype as the target id. For example, I filling the target thread
> id that waiting message). It's the most important.
>
> but mq_timedsend/mq_timedreceive in posix message queue don't have this feature.

I'm not sure I'm following here. With posix message queues, can't you just open
one queue per target thread? That would seem simpler and more efficient besides
also allowing the timeout.

         Arnd
