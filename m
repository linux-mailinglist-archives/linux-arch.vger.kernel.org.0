Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB49D79CF08
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjILK7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 06:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjILK6r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 06:58:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BF118;
        Tue, 12 Sep 2023 03:58:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC31BC433B6;
        Tue, 12 Sep 2023 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694516317;
        bh=bMazgWjiUns7bxIOW7iDcJXKsG8+oY7C1L0a2QPDtNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5amLBUeuaQQfQrkRGbMQPohZMxyrm/E+1U8aGzLmQkBBe1SjxaKm3mBIDG1j3MB7
         mEelEBPOX/CgAHNU5OpXYjmkc9An28zQLE48MZaqrAk2d1j2J6LiO4u10zUyVtPwxI
         0dD7Os9rGlNUQy5YIVpQnMAFAXwIEfKHXjBzrypBIE/g+a4kKPKv2jy3wWCHQcfED4
         +soa92eXj4Bwepl+2a0I2nUKXZIa/VuBhP0LjZ1cT4PMwY+lVBfLdL/YoYKX+I07iT
         TzenYk+RO9bhdZaKU2TuaZjIPxWPmKt/+hiSYduBOx7DeXFqVWzBVWLz79ChMaiSsn
         YgpE96OaS9lrg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso6913759a12.0;
        Tue, 12 Sep 2023 03:58:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJb1/SHXe2i1qXhrcvdJYqe9/txwPJ/iftQ0KF5SmlAs/z37Za
        h0+DnKY7z9Nu1Tsp00ouMI8VGlBIzsDU2l7wEL4=
X-Google-Smtp-Source: AGHT+IFlJTroWUzDrpNmu1jFhrEOedb4AZCufJm4Yw5gh0F+6q7MG2VcUbiSngUFjwNHEEx8rscVSAFajHlgNpUUEAg=
X-Received: by 2002:a17:906:2d1:b0:9ad:7d5b:ba68 with SMTP id
 17-20020a17090602d100b009ad7d5bba68mr1879773ejk.32.1694516316048; Tue, 12 Sep
 2023 03:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud> <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
 <20230910-facsimile-answering-60d1452b8c10@spud> <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
 <20230911-nimbly-outcome-496efae7adc6@wendy> <CAJF2gTTSDtnc7WRAZ0eLjiwZHZFbOcPZaQ_c8LiLcctBNsKCaA@mail.gmail.com>
 <20230912-snitch-astronaut-41e1b694d24f@wendy>
In-Reply-To: <20230912-snitch-astronaut-41e1b694d24f@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 18:58:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXhjvP3WRDKOJ67Bv+KSB-Dh2LAuSsf0kv12HJCmSL7Q@mail.gmail.com>
Message-ID: <CAJF2gTQXhjvP3WRDKOJ67Bv+KSB-Dh2LAuSsf0kv12HJCmSL7Q@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, paul.walmsley@sifive.com,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, palmer@rivosinc.com, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 12, 2023 at 4:08=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Tue, Sep 12, 2023 at 09:33:57AM +0800, Guo Ren wrote:
> > On Mon, Sep 11, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
>
> > > I added the new "riscv,isa-extensions" property in part to make
> > > communicating vendor extensions like this easier. Please try to use
> > > that. "qspinlock" is software configuration though, the vendor extens=
ion
> > > should focus on the guarantee of strong forward progress, since that =
is
> > > the non-standard aspect of your IP.
> >
> > The qspinlock contains three paths:
> >  - Native qspinlock, this is your strong forward progress.
> >  - virt_spin_lock, for KVM guest when paravirt qspinlock disabled.
> >    https://lore.kernel.org/linux-riscv/20230910082911.3378782-9-guoren@=
kernel.org/
> >  - paravirt qspinlock, for KVM guest
> >
> > So, we need a software configuration here, "riscv,isa-extensions" is
> > all about vendor extension.
>
> Ah right, yes it would only be able to be used to determine whether or
> not the platform is capable of supporting these spinlocks, not whether or
> not the kernel is a guest. I think I misinterpreted that snippet you post=
ed,
> thinking you were trying to disable your new spinlock for KVM, sorry.
> On that note though, what about other sorts of guests? Will non-KVM
> guests not also want to use this virt spinlock?
I only put KVM guests here, and I can't answer other hypervisor that
is another topic.

>
> Thanks,
> Conor.



--=20
Best Regards
 Guo Ren
