Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75EA410D8A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 00:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhISWCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 18:02:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39550 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhISWCy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 18:02:54 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A67B20B7179;
        Sun, 19 Sep 2021 15:01:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A67B20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632088889;
        bh=xYWIsntM1FgbDegCQy3unFGC9gPydIe+qrJh0Z0Vtc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TdAxIFP5QfRLlJBI4QFgRkgDe+6pmn4sD7ppVh2lsIAiDdZPpVel4ZDBcIH6ql6OB
         xlkvtkDYOs0VnYCcs8aq0wtGUW5zpkl8Xu4KJPdkcDvauCt+0dQUQneKW3qmCUlvxa
         UB/t4ASQqrwK/1h5/NdUPpMEQTDDiIMIjXquRWAA=
Received: by mail-pj1-f45.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso6219315pjb.0;
        Sun, 19 Sep 2021 15:01:29 -0700 (PDT)
X-Gm-Message-State: AOAM530AA1+KCU3iEdOlxUQVlpx0JwgWuG16PHocQ9Vj48KDT00+gl2y
        pATvxwdUhnGzwXOQMESIxsIWOCGhOBnESWGmpr4=
X-Google-Smtp-Source: ABdhPJxAHHGLWy2uUvoOGz80IPccXw+Xczr2/1TCm0MbT3xDF9E6xQ7DemEpQaObkix7rBXkffoeXugGB0CHi3exzQo=
X-Received: by 2002:a17:90b:254:: with SMTP id fz20mr34711278pjb.20.1632088888584;
 Sun, 19 Sep 2021 15:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210919192104.98592-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210919192104.98592-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 20 Sep 2021 00:00:52 +0200
X-Gmail-Original-Message-ID: <CAFnufp2CvmwRMotzkoq-ZKCMCh6vCmRFR19aQ3JwHECZznVN6A@mail.gmail.com>
Message-ID: <CAFnufp2CvmwRMotzkoq-ZKCMCh6vCmRFR19aQ3JwHECZznVN6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] riscv: optimized mem* functions
To:     linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 9:21 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Replace the assembly mem{cpy,move,set} with C equivalent.
>
> Try to access RAM with the largest bit width possible, but without
> doing unaligned accesses.
>
> A further improvement could be to use multiple read and writes as the
> assembly version was trying to do.
>
> Tested on a BeagleV Starlight with a SiFive U74 core, where the
> improvement is noticeable.
>
> v3 -> v4:
> - incorporate changes from proposed generic version:
>   https://lore.kernel.org/lkml/20210617152754.17960-1-mcroce@linux.microsoft.com/
>

Sorry, the correct link is:

https://lore.kernel.org/lkml/20210702123153.14093-1-mcroce@linux.microsoft.com/

-- 
per aspera ad upstream
