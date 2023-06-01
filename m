Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED171F0F0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFARjo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFARjn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 13:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D304136;
        Thu,  1 Jun 2023 10:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE33E64860;
        Thu,  1 Jun 2023 17:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D9AC4339E;
        Thu,  1 Jun 2023 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685641181;
        bh=rOyxKwyKoD8JRFg4gUZg/5MsYAzctjBiJEmXXIw+2Pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o/tcJHGXDGK+Cmz0WPMH9eqt4DXVRB87b+bOc4yCFZZx+pNoEHu0L6Kk/WHl5TZCQ
         v4wg++ka5L5/koa89l5lEtczt9Lp/CS49/lq9S/D/gsV6IN2cJNGZcqlW9mzDWtgf8
         kSPa6HE9uQjRqdmZMZGwEA+2H5w1XPFs1bwtf87IXl053GkxGBjbRGWwQEhiSemK34
         SURRDqI9JYl4AuMZSjsgfbIzfuYI4ScXci6h+5ayJwzrwQeS7v4C8WHfjDAbGm6Wt7
         HhKwh2oygRzaHVjZAo7rCNsfYsqW/i3EtbygDwQjD02rjzFKXYyUdDoEjObai2iibs
         UOf6kgrQWTHWg==
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-45c6c6e0ab2so599177e0c.1;
        Thu, 01 Jun 2023 10:39:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDzzxOBgQs22Zp+fPZ5LbXE5al098PVjDPukZSVDJiG9ue70wnq0
        mTIF1LqBegezr4klJ3rP77T6/6P+iMKs1xV/gVo=
X-Google-Smtp-Source: ACHHUZ7saBfaT5uX7NLiJU4LIkIoXw37eBnBmjdUSiEWtD7RMOu14iPsR47csoQHy7I8rQlHKSda/v96q9Noy2qP/FE=
X-Received: by 2002:aca:ead6:0:b0:398:2f7f:a5cd with SMTP id
 i205-20020acaead6000000b003982f7fa5cdmr1228908oih.24.1685641160132; Thu, 01
 Jun 2023 10:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
In-Reply-To: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Jun 2023 02:38:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxpUK+w=VAkhLZserLr4cMk2ffSr+qzzZwuZ6DKWA0mw@mail.gmail.com>
Message-ID: <CAK7LNATxpUK+w=VAkhLZserLr4cMk2ffSr+qzzZwuZ6DKWA0mw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 1, 2023 at 10:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 1, 2023 at 6:32=E2=80=AFAM Helge Deller <deller@gmx.de> wrote=
:
> >
> > I don't think we need to care about gcc-10 on parisc.
> > Debian and Gentoo are the only supported distributions, while Debian
> > requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at lea=
st
> > gcc-12 as well.
> >
> > So raising the gcc limit for parisc only (at least temporarily for now)
> > should be fine and your workaround below wouldn't be necessary, right?
>
> This absolutely sounds like the right option. Let's simplify the
> problem space by just saying that parisc needs the newer compiler.
>
> Right now we have that "minimum gcc version" in a somewhat annoying
> place: it's in the ./scripts/min-tool-version.sh file as a shell
> script.
>
> I wonder if we could move the gcc minimum version check into the
> Kconfig file instead, and make it easier to let architectures override
> the minimum version.

Currently, it is invoked in the Kconfig time,
but not directly in Kconfig files.

scripts/Kconfig.include
 -> scripts/cc-version.sh
    -> scripts/min-tool-version.sh

It would be ugly if we wrote the equivalent code
directly in Kconfig files.


>
> I don't quite know how to do that sanely, though. I don't think we
> have a sane way to error out at Kconfig time (except by forcing some
> syntax error inside an 'if' statement or something horrendously hacky
> like that).

The parse stage can fail by $(error-if ) macro, but
the evaluation stage never fails. I think it is a design.

I think checking the compiler version during the parse stage
makes sense given the current situation. The compiler version is
fixed when Kconfig starts. If the compiler is found to be too old,
there is no meaning to proceed.


You suggested to choose a compiler in the Kconfig time:
https://lore.kernel.org/lkml/CAHk-=3DwhdrvCkSWh=3DBRrwZwNo3=3DyLBXXM88NGx8V=
EpP1VTgmkyQ@mail.gmail.com/

When we achieve that, moving the min version to Kconfig files will be
the right thing to do. Then, everything will be evaluated dynamically.


>
> Added Masahiro to the (already overlong) participants list.
>
>                    Linus



--=20
Best Regards
Masahiro Yamada
