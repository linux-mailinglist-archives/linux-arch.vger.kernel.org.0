Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCF588B00
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiHCLSf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 07:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiHCLSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 07:18:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB441D0E4
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 04:18:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 21so5174075ybf.4
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PSBSqSCCzFolep6UPGhOMMv5cemuy3j+hc8VPw5MalM=;
        b=bMHRKq5scJSaAAH/R+bIAKiVW2q76rsyS5fqChaK2vvP0e6X8lMOJ9fvJpVbuVUJf9
         IChi94VhhfBbdTI2M0D6R0ol52pbvpIWTX5RokondoQu4TASVcmEbumPPXkQwXm+8vUR
         loGd4D/ublp4BotEl4FDKW/8SbxfxgSBIcvBxNCqYCDJTWv1q9v//8OX1NtoVTjBQugp
         FRidMBKH+pYAfWV2DljliF14OLvHW8MohTIvNFWjXrqkVqpwGM8wo1GWYVY+fqTe2ZAK
         XtV8W+6uyL7Ih8Wr0y2ekD6szJA6VlkiENUbAtY64eghDk0gKJXZmOPEvPk/VMtM+HPV
         cqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PSBSqSCCzFolep6UPGhOMMv5cemuy3j+hc8VPw5MalM=;
        b=hmuJTss7+a940Tfh4APhLSWSfGaodtMZyhXl+TVGpW4uUrWGg9XM6unXrGatpyYNc6
         b9LZRAbejGn61aVVxit0v6eFzwVeB8fHVmgvCubFraR3+DkcOaGuAhFFBxeSy2RXrUR0
         HennF3qaxYTE8iBAyOYi8rOcd3Utups1g7QAAQwA9eV3pH3haFzGpvTe9l5ch+Tl/KFl
         LhovpTYnRxbV83aCf2BSF2hudGXAiMVCFVUI2yP1XAAqZVBHAmCdBgop0sRmZ74nNE4T
         fX6byQR4z2glAJq9/3NwZJd5d1FDZPYLePy0AfDEqkcVDTLXbBP+38M7Gk6029tbJYuc
         os8g==
X-Gm-Message-State: ACgBeo1+IZUQNPHXWB2xeB5vUGHAPm8XIL068jfvi4LFuW5+sSOfN+bv
        1xfJJDgpdVIRKHfVIAgjc5uoKva7nuGyol0zmLdiOw==
X-Google-Smtp-Source: AA6agR7nzADdbpq41G4xAhK/5KipIY2zuod2SPum8O77h1V58WRcrWLdk3ucV/uv9E8f8txAcMtuwxqzwLK38mf09ss=
X-Received: by 2002:a25:1687:0:b0:671:8241:610d with SMTP id
 129-20020a251687000000b006718241610dmr19350594ybw.250.1659525511896; Wed, 03
 Aug 2022 04:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-19-glider@google.com>
 <CANpmjNOPJL7WAUh5CUZOYO8hY-dHTHMUMJzd9OGbmWES+smtrQ@mail.gmail.com>
In-Reply-To: <CANpmjNOPJL7WAUh5CUZOYO8hY-dHTHMUMJzd9OGbmWES+smtrQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 13:17:55 +0200
Message-ID: <CAG_fn=W0bfUZBc-tDMFgeEzgZgezse+mOjQnoO3vBALm9+1Q3w@mail.gmail.com>
Subject: Re: [PATCH v4 18/45] instrumented.h: add KMSAN support
To:     Marco Elver <elver@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
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
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 12, 2022 at 3:52 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:24, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > To avoid false positives, KMSAN needs to unpoison the data copied from
> > the userspace. To detect infoleaks - check the memory buffer passed to
> > copy_to_user().
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> With the code simplification below.
>
> [...]
> > --- a/mm/kmsan/hooks.c
> > +++ b/mm/kmsan/hooks.c
> > @@ -212,6 +212,44 @@ void kmsan_iounmap_page_range(unsigned long start,=
 unsigned long end)
> >  }
> >  EXPORT_SYMBOL(kmsan_iounmap_page_range);
> >
> > +void kmsan_copy_to_user(void __user *to, const void *from, size_t to_c=
opy,
> > +                       size_t left)
> > +{
> > +       unsigned long ua_flags;
> > +
> > +       if (!kmsan_enabled || kmsan_in_runtime())
> > +               return;
> > +       /*
> > +        * At this point we've copied the memory already. It's hard to =
check it
> > +        * before copying, as the size of actually copied buffer is unk=
nown.
> > +        */
> > +
> > +       /* copy_to_user() may copy zero bytes. No need to check. */
> > +       if (!to_copy)
> > +               return;
> > +       /* Or maybe copy_to_user() failed to copy anything. */
> > +       if (to_copy <=3D left)
> > +               return;
> > +
> > +       ua_flags =3D user_access_save();
> > +       if ((u64)to < TASK_SIZE) {
> > +               /* This is a user memory access, check it. */
> > +               kmsan_internal_check_memory((void *)from, to_copy - lef=
t, to,
> > +                                           REASON_COPY_TO_USER);
>
> This could just do "} else {" and the stuff below, and would result in
> simpler code with no explicit "return" and no duplicated
> user_access_restore().

Sounds good, will do.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
