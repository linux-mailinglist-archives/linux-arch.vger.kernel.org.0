Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62795799D76
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjIJJVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjIJJVP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 05:21:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AB197;
        Sun, 10 Sep 2023 02:21:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E04FC433AD;
        Sun, 10 Sep 2023 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694337671;
        bh=AlyEU5ZmUJpXNyW6VvERlx1GXg+wiqJaSqdE/H8q0SE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dviYAmRowpTZs8iTDclyQhazyZEdoVHJE1rcEbdqY5ipcQfvm6hU8pKE/O5Lz3z7G
         Z9aEoEc29zD5SpNs2CMSeVl0Jif+Jyr5BjexOeQWwsNUaglD2SFFLfgpNBVhSTehzm
         hctVm3dmLkmvdhGFQPRqpXrhIDMMAQyuk563+4buwYIPXPDM/xtsjWsEHkXp9mttrx
         6Lm5iVDLfiAclK5pHVbn3uQl4eHyaAAXbJoVPIecZ0prlzWW6MbcveasUKN593DfFA
         8ch/AXxImjkMOGy6sZ7eyWv6Ne8OPVVl9uB6PM1VEu0zTetBir9chJaDCMzrFc5tWX
         yaqXRMF0LGqdA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so4549536a12.1;
        Sun, 10 Sep 2023 02:21:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz0UMBfK9aaHR/IWgoucZeuY7AwXi0p6ST4CD9OfrUkPxKVOsI2
        dfYSBY2yhYZiZfMqywhViISO1/4Jj4RxHlXHVC8=
X-Google-Smtp-Source: AGHT+IHDx5Z78daTy57oiBDgIHdhGAgHNt80St8yuq4TUxSMbDnzstsa/h7QWOtF1DxMV7X1XMgkpqZGKZeGSZA/jp0=
X-Received: by 2002:aa7:d6c8:0:b0:526:9626:e37d with SMTP id
 x8-20020aa7d6c8000000b005269626e37dmr5860593edr.37.1694337669530; Sun, 10 Sep
 2023 02:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 10 Sep 2023 17:20:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQz8Hea=8SL2X_CVKd+14V+VDL=d5oRDrTjDNmew+0aQA@mail.gmail.com>
Message-ID: <CAJF2gTQz8Hea=8SL2X_CVKd+14V+VDL=d5oRDrTjDNmew+0aQA@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 5:16=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
> >
> > > Changlog:
> > > V11:
> > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> > >  - Remove abusing alternative framework and use jump_label instead.
> >
> > btw, I didn't say that using alternatives was the problem, it was
> > abusing the errata framework to perform feature detection that I had
> > a problem with. That's not changed in v11.
> I've removed errata feature detection. The only related patches are:
>  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
>  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
And this one:
 - riscv: Use Zicbop in arch_xchg when available

>
> Which one is your concern? Could you reply on the exact patch thread? Thx=
.
>
> >
> > A stronger forward progress guarantee is not an erratum, AFAICT.
> Sorry, there is no erratum of "stronger forward progress guarantee" in th=
e V11.
>
> >
> > >  - Introduce prefetch.w to improve T-HEAD processors' LR/SC forward p=
rogress
> > >    guarantee.
> > >  - Optimize qspinlock xchg_tail when NR_CPUS >=3D 16K.
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
