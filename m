Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF924DDBC1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiCROgc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiCROgc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 10:36:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51A2D4D4B
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 07:35:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a11so3039342qtb.12
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V7P4GZK3e6fyTq1pakb6Rzu6ZJgSaONaWTDE6DcGFrE=;
        b=Z8bs2DWUWGLhWdOjyWlnn9HNRwNSjCyVUcQwAOiEKwFsEEBGPZoaf84h5nMF6qt5zR
         7kb0mvD3zpe4gHTDcRv2+uUbN05ibi1sBC9y1YzAtE2cvQZ/kpD1DCjsBJlPwgXRJGxm
         DnBROXIz5vhznVTym7m9zNChFlxun94xZI1j6sOEMN9AUFGd5JVe8mBYpCyvu7uEpCpc
         fFCUPZjO4cPBKgqXGFY7pW7CVObso2wbO9F7yS5IPtSINUkqlDFHj6H/IxVTFzzFqyI8
         bnCxb4XelWAKG8/zXQElVRTxW2/5b8bwZPkqUpuEbFfH4286/0fiRHe+p0lJ70yg0Ta9
         L2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V7P4GZK3e6fyTq1pakb6Rzu6ZJgSaONaWTDE6DcGFrE=;
        b=zdL3jVFHple1oh7Hz9Heu2Qf9magnL6HC21LRrU0uR9xLGQbIyJEm4wdyBPcAa7BuY
         FemOWWe+VX0x3hlVErSWsYAchJOkOMtkCX7kT+wJbEuam8GllDgSZo1WpoyVE72No8u8
         jDQ6liGcmWnI787fBny5cQzNim1KCQdlJOgJyBMSHFNCQSbJheAqA1ob1++EKX275fO+
         alwjq7XpV09CwOkYxqweHZ4QKIZwGQHP49rxC7fUEe6DwJ6vS+w80xIWZC1jFOKr4WhL
         GwA4LNZ6WJBEv75HeXBup+g8Scuwzh8mHkSAq/t5XS+w2h+j3Ft4rgz2ZbokECsVMdiS
         UF/g==
X-Gm-Message-State: AOAM533cYANtid1dCWoIqfdfhjSH3TngjKX/41Nn99v8CmEVGohqR3yu
        QdAn18VoWvMhHYUOPZwefZaL7ekcHOc8iQXBfRnw3Q==
X-Google-Smtp-Source: ABdhPJwf+MEW47SH6CFA80X1s0ccNAZNyAoYqKtZ7oSbtZn2ydv7N6dD6IDjj6RCMmalJ+GCbbbNLtvE1RbOEg+mDqk=
X-Received: by 2002:a05:622a:15c5:b0:2e1:cdc9:dd1c with SMTP id
 d5-20020a05622a15c500b002e1cdc9dd1cmr7596184qty.79.1647614110831; Fri, 18 Mar
 2022 07:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-13-glider@google.com>
 <Ybnuup0eMnhrwp8e@FVFF77S0Q05N> <CANpmjNNLG0F9WzNnQkJX+QEqdxnhWstuag_9jrid7zdJgivHyw@mail.gmail.com>
 <Ybn/DZb32ujokTnJ@FVFF77S0Q05N>
In-Reply-To: <Ybn/DZb32ujokTnJ@FVFF77S0Q05N>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Mar 2022 15:34:34 +0100
Message-ID: <CAG_fn=U96hVmJxk17z+N8yFxxGABy4vE-FHJUGYNMZYbHG_hyg@mail.gmail.com>
Subject: Re: [PATCH 12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 15, 2021 at 3:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Dec 15, 2021 at 02:39:43PM +0100, Marco Elver wrote:
> > On Wed, 15 Dec 2021 at 14:33, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Tue, Dec 14, 2021 at 05:20:19PM +0100, Alexander Potapenko wrote:
> > > > kcov used to be broken prior to Clang 11, but right now that versio=
n is
> > > > already the minimum required to build with KCSAN, that is why we do=
n't
> > > > need KCSAN_KCOV_BROKEN anymore.
> > >
> > > Just to check, how is that requirement enforced?
> >
> > HAVE_KCSAN_COMPILER will only be true with Clang 11 or later, due to
> > no prior compiler having "-tsan-distinguish-volatile=3D1".
>
> I see -- could we add wording to that effect into the commit messge?

Will be done.

> > > I see the core Makefiles enforce 10.0.1+, but I couldn't spot an expl=
icit
> > > version dependency in Kconfig.kcsan.
> > >
> > > Otherwise, this looks good to me!
> >
> > I think 5.17 will be Clang 11 only, so we could actually revert
> > ea91a1d45d19469001a4955583187b0d75915759:
> > https://lkml.kernel.org/r/Yao86FeC2ybOobLO@archlinux-ax161
> >
> > I should resend that to be added to the -kbuild tree.
>
> FWIW, that also works for me.
>
> Thanks,
> Mark.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
