Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0C3AA394
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhFPSy5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 14:54:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38166 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhFPSy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 14:54:56 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by linux.microsoft.com (Postfix) with ESMTPSA id 35B1A20B83F8;
        Wed, 16 Jun 2021 11:52:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35B1A20B83F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623869570;
        bh=rYJD4cBG4CEPoLnWdqiYM4HuZXVnGRaKOU6m/YkZifA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=akaKzAH14Q5cfSsaQe5MAfT+HU+9bU7yDZ1IavJWmRCRwbI9fkfO8hll3j+cUr6NM
         qPDCwQRYlpb8oHYWTaucsJLQ2fDZjoWJuB5HCnY/P53X6iLScTa3jKYckyawGmwZ75
         9Ppouaulgc8S8TBQ1Do2QAWq5jdf3f+oXffIDdkk=
Received: by mail-pj1-f47.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so2325737pjn.1;
        Wed, 16 Jun 2021 11:52:50 -0700 (PDT)
X-Gm-Message-State: AOAM530W/CIeBTrn2my4daxhlU10J8NlU8za6iT/1B5OaW8wemV+Po/V
        Zu2Gwfkq0KU0dDV6+eiNpAplc7P8ja07yytBFCg=
X-Google-Smtp-Source: ABdhPJyyWuopcbCWOsO0GJU76XEW1aKeFZlbubNuh6Kr6/8+/OZoAm8ypz7lE/h+CigtdKqhxy0qyAvQlapQgjB1/Qg=
X-Received: by 2002:a17:90b:109:: with SMTP id p9mr12340022pjz.11.1623869569699;
 Wed, 16 Jun 2021 11:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <CAJF2gTTreOvQYYXHBYxznB9+vMaASKg8vwA5mkqVo1T6=eVhzw@mail.gmail.com>
In-Reply-To: <CAJF2gTTreOvQYYXHBYxznB9+vMaASKg8vwA5mkqVo1T6=eVhzw@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 16 Jun 2021 20:52:13 +0200
X-Gmail-Original-Message-ID: <CAFnufp1OHdRd-tbB+Hi0UnXARtxGPdkK6MJktnaNCNt65d3Oew@mail.gmail.com>
Message-ID: <CAFnufp1OHdRd-tbB+Hi0UnXARtxGPdkK6MJktnaNCNt65d3Oew@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 1:46 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Matteo,
>
> Have you tried Glibc generic implementation code?
> ref: https://lore.kernel.org/linux-arch/20190629053641.3iBfk9-I_D29cDp9yJnIdIg7oMtHNZlDmhLQPTumhEc@z/#t
>
> If Glibc codes have the same performance in your hardware, then you
> could give a generic implementation first.
>

Hi,

I had a look, it seems that it's a C unrolled version with the
'register' keyword.
The same one was already merged in nios2:
https://elixir.bootlin.com/linux/latest/source/arch/nios2/lib/memcpy.c#L68

I copied _wordcopy_fwd_aligned() from Glibc, and I have a very similar
result of the other versions:

[  563.359126] Strings selftest: memcpy(src+7, dst+7): 257 Mb/s

Regards,
-- 
per aspera ad upstream
