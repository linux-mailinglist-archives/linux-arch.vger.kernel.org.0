Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAED779BE2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 02:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjHLAY3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 20:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHLAY2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 20:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5530FE;
        Fri, 11 Aug 2023 17:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D1E166713;
        Sat, 12 Aug 2023 00:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F7CC433AB;
        Sat, 12 Aug 2023 00:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691799867;
        bh=jhgYu8MJh1qa3T7KkFqRcAa6o5bbnrkYuVvKruWBUmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHX/Je8TBmBEQyq5tvyzKwN44lRflfAmfGdV+8nG0SGW87vcz68BvPXuwcEfSrfoa
         UJGJm03DegglVeohu68ot9KYVyyHv6DC+icq2mPV5iFdaALUqmND4uxCPJM75Mi8iH
         2vF/FJ82RrII72tI/KAf3ioQ/5FoZHYjobpDFbe8obvlyARMwlUhflHwehTZ+WskOB
         hjgDsA66T/XdyYvLq7c9lP1/ukpHIMYKCGGmOuYahNSB8e1lQqNqudYxs0L0NN9UoQ
         1SglrDdWx6yrrHAu9ywlwpnV3zCMu6oYQjAcw5bpQ/mIO7CzdDCTAGH4wMsKSBFfP5
         ktKhWxf9LKQag==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3187178a12.2;
        Fri, 11 Aug 2023 17:24:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0SJVWPMGYaST+T0Q0jxryombaDMjyjfHuKPn5WULKVCzaevYS
        amRev5YvY8PnTwwplTYJuBcPrpJ97pmPwTmmUSE=
X-Google-Smtp-Source: AGHT+IEqaTqaAtAhCmcGnNvIeNuoOUng8kNkaL94dQUaCSqUdRXJ4J/UpnpZeNm/RT3qQaiZQWX91614H1XSKE3q1F4=
X-Received: by 2002:a50:ed06:0:b0:523:10fa:e132 with SMTP id
 j6-20020a50ed06000000b0052310fae132mr2789289eds.23.1691799865757; Fri, 11 Aug
 2023 17:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230802164701.192791-1-guoren@kernel.org> <20230802164701.192791-19-guoren@kernel.org>
 <5cf1117c-d537-703c-cdcf-f43c5bd9ed1b@redhat.com>
In-Reply-To: <5cf1117c-d537-703c-cdcf-f43c5bd9ed1b@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Aug 2023 08:24:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
Message-ID: <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
Subject: Re: [PATCH V10 18/19] locking/qspinlock: Move pv_ops into x86 directory
To:     Waiman Long <longman@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023 at 4:42=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 8/2/23 12:47, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The pv_ops belongs to x86 custom infrastructure and cleans up the
> > cna_configure_spin_lock_slowpath() with standard code. This is
> > preparation for riscv support CNA qspoinlock.
>
> CNA qspinlock has not been merged into mainline yet. I will suggest you
> drop the last 2 patches for now. Of course, you can provide benchmark
> data to boost the case for the inclusion of the CNA qspinlock patch into
> the mainline.
Yes, my lazy, I would separate paravirt and CNA from this series.

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren
