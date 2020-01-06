Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85F130C8E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 04:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAFDdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 22:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDdI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 22:33:08 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBB121734;
        Mon,  6 Jan 2020 03:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578281587;
        bh=RAivqP6Lc204pepIUJNVEUcohHJoNfajiFio/GMszE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DCJkixNIAx6N/hQEBPBeeiFIpRxC0c4/OoS1rg51bOpMTu44h1posLfP+qCgXMBlT
         XIOWsDKVF5zhYGBZS21T9iopw56c8Be+zqyQBmoOg+wMqFcsfP6tOTwrmMd5z5el9P
         k+Zxmiw36ck+qs/tGqeVA/9jbtWfPSiTL8+86uns=
Received: by mail-lj1-f178.google.com with SMTP id y6so41473963lji.0;
        Sun, 05 Jan 2020 19:33:06 -0800 (PST)
X-Gm-Message-State: APjAAAXRL8AyBU+6ifAzRtv1VAzQ/8THDYgg2pQlB+EmaaMh4hvplBo+
        jMDTm9tFx1GYIhyx2VCTtfuaRVTz+3oS9JFeKYQ=
X-Google-Smtp-Source: APXvYqzL5X4e3S2WYpXmpAiY0PBKY24mqCoVG3XGpDe5FmGNtilugBgiKA2yUQhIeuLRLGsFN50LfS2JMjtDUg5Mlns=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr59668391ljj.208.1578281585149;
 Sun, 05 Jan 2020 19:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com>
In-Reply-To: <20200106024515.GA1021@andestech.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jan 2020 11:32:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRd=PmNAj3T-_pD-k4x7aOgzRr54h_J-HCqUjLvVNCoTg@mail.gmail.com>
Message-ID: <CAJF2gTRd=PmNAj3T-_pD-k4x7aOgzRr54h_J-HCqUjLvVNCoTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, aou@eecs.berkeley.edu,
        Guo Ren <ren_guo@c-sky.com>, Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, vincent.chen@sifive.com,
        Palmer Dabbelt <palmer@dabbelt.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's talk about libc abi for sigcontext and our cpu has the vector
features, so we need start the work to support stress-test.

I think it's the same to andes, because andes also announced the
vector processor. The linux and libc are only small part of vector
ISA, let's work together :)

On Mon, Jan 6, 2020 at 10:45 AM Alan Kao <alankao@andestech.com> wrote:
>
> Hi Guo,
>
> On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > 128bit-vlen and it's based on linux-5.5-rc4.
> >
>
> According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
> that "we plan to only accept patches for new modules or extensions that have
> been frozen or ratified by the RISC-V Foundation."
>
> Is v0.8 ratified enough for now?
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
