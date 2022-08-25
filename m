Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C95A0B16
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiHYIJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiHYIJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 04:09:52 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57A2BD2;
        Thu, 25 Aug 2022 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661414988;
        bh=Ey9GW0PV5iG2eKxKqte4kaBuQ9z7RLnssn2v4uBnuIE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UsqsoMRKTq44PTH9LXGKRrjAFo0QlgSWy8k+pvMx7kNR+xyR320PQ4CF153ciVAzK
         VY0buArQ9R02ARFWWWvIcHC4rrNqwjoaDXKH4rPcIIPDb5KZSAexd8Tm55PvvXAFHb
         lJbOrcXWsXMObhUsj4gMHHGvr52T6NNM8xBzZ1r4=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C0F0266850;
        Thu, 25 Aug 2022 04:09:43 -0400 (EDT)
Message-ID: <c02a6b7e4f8e377178b25c30d544420906346816.camel@xry111.site>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
From:   Xi Ruoyao <xry111@xry111.site>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alex Colomar <alx@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
        Florian Weimer <fweimer@redhat.com>,
        glibc <libc-alpha@sourceware.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linux API <linux-api@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Date:   Thu, 25 Aug 2022 16:09:42 +0800
In-Reply-To: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
         <20220824185505.56382-1-alx.manpages@gmail.com>
         <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
         <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
         <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
         <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
         <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
         <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2022-08-25 at 09:48 +0200, Alejandro Colomar wrote:
> Hi Xi,
>=20
> On 8/25/22 09:28, Xi Ruoyao wrote:
> > On Thu, 2022-08-25 at 09:20 +0200, Alejandro Colomar via Gcc-patches
> > wrote:
> > > I don't know for sure, and I never pretended to say otherwise.=C2=A0 =
But what
> > > IMHO the kernel could do is to make the types compatible, by typedefi=
ng
> > > to the same fundamental types (i.e., long or long long) that user-spa=
ce
> > > types do.
> >=20
> > In user-space things are already inconsistent as we have multiple libc
> > implementations.=C2=A0 Telling every libc implementation to sync their
> > typedef w/o a WG14 decision will only cause "aggressive discussion" (fa=
r
> > more aggressive than this thread, I'd say).
> >=20
> > If int64_t etc. were defined as builtin types since epoch, things would
> > be a lot easier.=C2=A0 But we can't change history.
>=20
> This would be great.=C2=A0 I mean, the fundamental types should be u8, u1=
6,
> ... and int, long, ... typedefs for these, and not the other way around,=
=20
> if the language was designed today.
>=20
> Maybe GCC could consider something like that.

GCC already have __UINT8_TYPE__ etc. but again telling all libc
implementations to use "typedef __UINT8_TYPE__ uint8_t" etc. will make
no effect expect annoying their maintainers.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
