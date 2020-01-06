Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61885130C94
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 04:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAFDip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 22:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDip (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 22:38:45 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3216C24650;
        Mon,  6 Jan 2020 03:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578281924;
        bh=O3Dvl8/RPqanNc/oF5iRxca2DGo6j2tFFgB+VTxc/CU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F4PY9b+Me5Lbem1Xg2FIpqhMxsBLj6rzozZaT/R9ffJLm3LMxbXk5R5OrzbgW/2WD
         J0r0ZUM1rHvSeZKQiVXmAtWIi1aTsjJkyk69Yqc/Cw2hRW/3Q2t2I+q/9cKkbLLESb
         3h43ovSpw5qidcDjrzJQ3WzwhctKGTRTbXQ9hPdY=
Received: by mail-lf1-f41.google.com with SMTP id 203so35411207lfa.12;
        Sun, 05 Jan 2020 19:38:44 -0800 (PST)
X-Gm-Message-State: APjAAAW5aiPAvqfw5XhydLINXGmnIQIMEnmVLolBE3IxwVjMqzOzGxu9
        gMlZCuZ89WZhed8p5K8P6M4qw/+6kno1K0PHXgM=
X-Google-Smtp-Source: APXvYqwfABJmKgGEdlXcyjmnMqo9GN8Gpupb78k3NfRvlm0T8E/FA+jpdPW8sh2OqqkeHCTL1Rfds477FHZCZ64x8Uk=
X-Received: by 2002:ac2:4476:: with SMTP id y22mr55934808lfl.169.1578281922348;
 Sun, 05 Jan 2020 19:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com> <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
In-Reply-To: <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jan 2020 11:38:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ8-b2w7-v1giYN_UYcNMaeju8yv0ksUu2=g5YJtk1rdw@mail.gmail.com>
Message-ID: <CAJF2gTQ8-b2w7-v1giYN_UYcNMaeju8yv0ksUu2=g5YJtk1rdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     Anup Patel <anup@brainfault.org>
Cc:     Alan Kao <alankao@andestech.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <ren_guo@c-sky.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Anup,

The purpose of the patch is to talk about abi for linux & libc.

The most confused me is how max vlen (128/256/512/1024 ???), we should
put it into sigcontext. I need people's suggestions, thx.

Anyone help to review the patch are very helpful and we could
co-developed together, Thx

On Mon, Jan 6, 2020 at 11:00 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jan 6, 2020 at 8:15 AM Alan Kao <alankao@andestech.com> wrote:
> >
> > Hi Guo,
> >
> > On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > > 128bit-vlen and it's based on linux-5.5-rc4.
> > >
> >
> > According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
> > that "we plan to only accept patches for new modules or extensions that have
> > been frozen or ratified by the RISC-V Foundation."
> >
> > Is v0.8 ratified enough for now?
>
> As-per the patch acceptance policy, we cannot merge it now (just like KVM
> patches) but we can always review and get the patches in final shape
> by the time spec is frozen or ratified.
>
> I think we should continue with the patch review and get this series in
> good shape.
>
> In fact, having this patches early on LKML is very helpful for people working
> on RISC-V vector extension implementation in HW. On this line, this a good
> contribution coming at the right time.
>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
