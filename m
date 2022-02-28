Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDC4C6D31
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiB1MwC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 07:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiB1MwB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 07:52:01 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D67804F;
        Mon, 28 Feb 2022 04:51:22 -0800 (PST)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MvKTJ-1oFX692esT-00rGkv; Mon, 28 Feb 2022 13:51:20 +0100
Received: by mail-wr1-f47.google.com with SMTP id j17so15350943wrc.0;
        Mon, 28 Feb 2022 04:51:20 -0800 (PST)
X-Gm-Message-State: AOAM533j5Gwpt1KJc3MLGO63cDs+7RTgPih1iAaSUZEoN4UNOLafFtfC
        BoeUpflDt2dnP8PjiRW/uEzsMZq1gIKwNhPZp98=
X-Google-Smtp-Source: ABdhPJxqAXtjqyu3XGhO9l+qeiMZpUmH3VvfwpXSNlGORAG+H/kTZ6DoBe9bebMaudh7ucMT2NCbvco6L/QKSBCYl4U=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr8301106wrw.192.1646052680182; Mon, 28
 Feb 2022 04:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-4-guoren@kernel.org>
 <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com> <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
 <e5ee4f6799704bd59b0c580157a05d2d@AcuMS.aculab.com> <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
In-Reply-To: <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 13:51:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ZXuGWO+n2ghxhXmxntZAk_HPDmsk3cigdh2FBMQcKYA@mail.gmail.com>
Message-ID: <CAK8P3a0ZXuGWO+n2ghxhXmxntZAk_HPDmsk3cigdh2FBMQcKYA@mail.gmail.com>
Subject: Re: [PATCH V7 03/20] compat: consolidate the compat_flock{,64} definition
To:     Guo Ren <guoren@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "liush@allwinnertech.com" <liush@allwinnertech.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "wangjunqiang@iscas.ac.cn" <wangjunqiang@iscas.ac.cn>,
        "hch@lst.de" <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B0AtdJlqMXQDEgJHvuqtO1DU4MGLOpbhpQEBpVaQa9DAv4/KSs9
 INCrI+meMd2OjWcOwf1AkmQYwrBDdJa2HE2I/BLnzI0ywmQfbUhjtxMsAhLZmBOCTN5mXbu
 WLPrcYEEuYZR2vty06GMJNUVf1zoSqzf8Qp6kNTTHD87uJoagOquXn0k4gp3zIRqEC22p/i
 8B1bPt/kCnBwGtcK6GD8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eppUcn1u+fI=:gspmD17GQoBvp3XPDmBjBs
 dwrJFXkFnYIFQhGnKqWYlN0c8JjOZWUD8HAPILhcNTkkxZevvFyH23i75fTTa11TS9ths7xR6
 svAsq+geXeo+Jt/dmY5xrcVHO/dTTWNrpoYA0w+xFFUH3oDC8DG21kldBz6t7pgi91g2sNTMv
 1K8V8FZQxbeE02c1poU5aN9vn6VAmVDk1cEpvIjqlTwl/JFJ4VyVvm1kqYuUWsEhn3eNFBeID
 U7ek7bpF3+0NgC/JbFh62Az5clcxVAe0A07TS397IgqaL8/M4VCso4yYuy5i22A9JZ+l8I9tI
 muvStCtNL6Xxi1Y/5kcjpZ9AP1vRbvYsXNLNHopFi7aSoffnNfm2WeSyNaUkYh4xpzErVdom0
 kzmEq/L8rEwPgxoP5bRyAwR113roU/ylN8QG8a1nROpFksPkdIUqo9n8mvRVVmWfv/cRG/tLU
 2syVNzqrkJJ8g7wEIOOl7fr/ZW9FAIOgAY0qTA1bO/liheVGDh8Ksjq1Kmjrqc911ztMDJZ/E
 RhJju6guuXp1h/bpD00q0kVjSBtUk5F8rYjMIOnwY9zhpr0SG8JvyJLETKXs78nXY+HNocS04
 Bi0tJ2LGqaomL5Myhj79KXiQSedb0zT1LFmNsykNlj2LlH3IYJ5a+8Q0EBbPIO7n3kWW4iFq/
 Qc9MhHN6HVMvnQU4iXnXKlDg+JbS9tqrBKypBa7WOpzKhB6uWTrZsbvbivMXGRrgDipjGj0dK
 Av5/geYkcfw13a3ebmngh1AvuFOTCBB4EP3yMTWZG6DBrnsTMUgnXYgHzIi0QudqdxHGVCyeY
 YcoNNR6NmqUKH1nXF4uLYfnmtyHZivcyI+Qhg3xWz1zB0uVo+s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 1:13 PM Guo Ren <guoren@kernel.org> wrote:
> On Mon, Feb 28, 2022 at 8:02 PM David Laight <David.Laight@aculab.com> wrote:
> > From: Guo Ren Sent: 28 February 2022 11:52
> > > On Mon, Feb 28, 2022 at 2:40 PM David Laight <David.Laight@aculab.com> wrote:
> > > > ...
> > > > > +struct compat_flock64 {
> > > > > +     short           l_type;
> > > > > +     short           l_whence;
> > > > > +     compat_loff_t   l_start;
> > > > > +     compat_loff_t   l_len;
> > > > > +     compat_pid_t    l_pid;
> > > > > +#ifdef __ARCH_COMPAT_FLOCK64_PAD
> > > > > +     __ARCH_COMPAT_FLOCK64_PAD
> > > > > +#endif
> > > > > +} __ARCH_COMPAT_FLOCK64_PACK;
> > > > > +
> > > >
> > > > Provided compat_loff_t are correctly defined with __aligned__(4)
> > > See include/asm-generic/compat.h
> > >
> > > typedef s64 compat_loff_t;
> > >
> > > Only:
> > > #ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
> > > typedef s64 __attribute__((aligned(4))) compat_s64;
> > >
> > > So how do you think compat_loff_t could be defined with __aligned__(4)?
> >
> > compat_loff_t should be compat_s64 not s64.
> >
> > The same should be done for all 64bit 'compat' types.
> Changing
> typedef s64 compat_loff_t;
> to
> typedef compat_s64 compat_loff_t;
>
> should be another patch and it affects all architectures, I don't
> think we should involve it in this series.

Agreed, your patch (originally from Christoph) looks fine, it correctly
transforms the seven copies of the structure into a shared version.

There is always more that can be improved, but for this series,
I think you have already done enough.

> look at kernel/power/user.c:
> struct compat_resume_swap_area {
>         compat_loff_t offset;
>         u32 dev;
> } __packed;
>
> I thnk keep "typedef s64 compat_loff_t;" is a sensible choice for
> COMPAT support patchset series.

The only references to compat_loff_t that we have in the kernel
could all be simplified by defining compat_loff_t as compat_s64
instead of s64, but it has no impact on correctness here.

Let's make sure you get your series into 5.18, and then David can
follow-up with any further cleanups after that.

         Arnd
