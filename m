Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A8130C45
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 04:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAFDAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 22:00:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44619 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgAFDAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jan 2020 22:00:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so9178271wrm.11
        for <linux-arch@vger.kernel.org>; Sun, 05 Jan 2020 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IObTHxdSrTA+4cLb5d5XPNdt7irAzNjJT7xEv05gP2U=;
        b=LnGpe1iKssm4K/tw4IaseYnzPu1obNeWgBStdi3fyjqrOwhDsmG++a+dykUHhdYihU
         i+GaQuNbafyCm5T395xfJ9txQmqWd/nT+d3cLKza7wjhP8HL30ulU8teKkLqRGG6k1O5
         LEHSkt0zzGx3h09dQKoc7bcz5AotP0dRi0fhwA4VcqSG2mkHKCV/z7Z1hfmwKxlnA3Eb
         /8EuTfEsmGNxdKJx6aZvyBGA8oPzi3wWrmRrqJcdjDdlGdxwIYC5lUbUDGMG+stbPqAn
         /FcKYATNIps5xBq84LLZLv5baHL5wQTOG1wIOYiODet0TP3rCqkMcLPGmcCuopuWdFGJ
         aocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IObTHxdSrTA+4cLb5d5XPNdt7irAzNjJT7xEv05gP2U=;
        b=TOb7DN2QyapKMHmSdGYH0lmr8xBKeVtxOik5MUxXirX6Pv0U7cvsBWzW8PgqHbgEXJ
         mFxWCmTW8idU4ujkhDt6Sm4PSgkagScA9LRiosg7H0HMOEVhU6g7miLYeBs4mPg5rup4
         FHf2OWDS/25Os6WyNru6bjELNTkLB65FslVpih9yGrwVcWW0SBuaPULC4fh4ohkv1ktO
         UgNI0mPbhTN4LriO47kgsV0SPtM2maudf4XwbvxQ65X8tCkFQYhKWQCB7+pZNWN3Pu5W
         HhH5R0YkRpYuhlBVY93UAncMBsuMFYPWTnG3eIPIcUsSW5S6etbOK6DsWNDOZqcgBt11
         I2SA==
X-Gm-Message-State: APjAAAUteMUD8WoBw0S4Cry3YFaoOcka9gwWnSqHsVyRAzbjo/4qsb1J
        0eg1iwI2BYqOz4/lHY+Vbxrt/aOHTBrjJtEY+L6q3w==
X-Google-Smtp-Source: APXvYqwKkrzknw/83vnmM3PEodvoeLd8EHhzBeNAPpBu/M+mPCRybjaV4kVYmIXB2Q9S7tjmgF8MkKKLUPUbNNn+RnU=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr97661644wrn.251.1578279639876;
 Sun, 05 Jan 2020 19:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com>
In-Reply-To: <20200106024515.GA1021@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 6 Jan 2020 08:30:29 +0530
Message-ID: <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     Alan Kao <alankao@andestech.com>
Cc:     guoren@kernel.org, linux-arch@vger.kernel.org,
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

On Mon, Jan 6, 2020 at 8:15 AM Alan Kao <alankao@andestech.com> wrote:
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

As-per the patch acceptance policy, we cannot merge it now (just like KVM
patches) but we can always review and get the patches in final shape
by the time spec is frozen or ratified.

I think we should continue with the patch review and get this series in
good shape.

In fact, having this patches early on LKML is very helpful for people working
on RISC-V vector extension implementation in HW. On this line, this a good
contribution coming at the right time.

Regards,
Anup
