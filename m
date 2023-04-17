Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B016E447D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQJ5q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 05:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQJ5p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 05:57:45 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70525659D;
        Mon, 17 Apr 2023 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681725043;
        bh=O/cKAdPP1ntH7IK9e/3cclJfPJoYfiCKYcnR1FDS28c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E5ZnmxxoCi42LLMmO5z0FR3DlqAoAY5yiajei+fCHQX57j4JBVZRuMDZiTncJykyh
         MqkIeXj9QPaMbH2TEpJA+cyEtEDz72q/MhY7nble68s8WYuOCo6UfpWh6gtX/oQqyZ
         EjNGC9LdHmSREBfn9zK60G0/Qx4weomdm7z9QWL4=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2A3F865C4E;
        Mon, 17 Apr 2023 05:50:42 -0400 (EDT)
Message-ID: <f54abfae989023fcfdabb4e9800a66847c357b85.camel@xry111.site>
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Apr 2023 17:50:40 +0800
In-Reply-To: <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name>
References: <20230416173326.3995295-1-kernel@xen0n.name>
         <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
         <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-04-17 at 15:54 +0800, WANG Xuerui wrote:
> On 2023/4/17 14:47, Xi Ruoyao wrote:
> > On Mon, 2023-04-17 at 01:33 +0800, WANG Xuerui wrote:
> > > From: WANG Xuerui <git@xen0n.name>
> > >=20
> > > Hi,
> > >=20
> > > The LoongArch-64 base architecture is capable of performing
> > > bounds-checking either before memory accesses or alone, with speciali=
zed
> > > instructions generating BCEs (bounds-checking error) in case of faile=
d
> > > assertions (ISA manual Volume 1, Sections 2.2.6.1 [1] and 2.2.10.3 [2=
]).
> > > This could be useful for managed runtimes, but the exception is not
> > > being handled so far, resulting in SIGSYSes in these cases, which is
> > > incorrect and warrants a fix in itself.
> > >=20
> > > During experimentation, it was discovered that there is already UAPI =
for
> > > expressing such semantics: SIGSEGV with si_code=3DSEGV_BNDERR. This w=
as
> > > originally added for Intel MPX, and there is currently no user (!) af=
ter
> > > the removal of MPX support a few years ago. Although the semantics is
> > > not a 1:1 match to that of LoongArch, still it is better than
> > > alternatives such as SIGTRAP or SIGBUS of BUS_OBJERR kind, due to bei=
ng
> > > able to convey both the value that failed assertion and the bound val=
ue.
> > >=20
> > > This patch series implements just this approach: translating BCEs int=
o
> > > SIGSEGVs with si_code=3DSEGV_BNDERR, si_value set to the offending va=
lue,
> > > and si_lower and si_upper set to resemble a range with both lower and
> > > upper bound while in fact there is only one.
> > >=20
> > > The instructions are not currently used anywhere yet in the fledgling
> > > LoongArch ecosystem, so it's not very urgent and we could take the ti=
me
> > > to figure out the best way forward (should SEGV_BNDERR turn out not
> > > suitable).
> >=20
> > I don't think these instructions can be used in any systematic way
> > within a Linux userspace in 2023.=C2=A0 IMO they should not exist in
> > LoongArch at all because they have all the same disadvantages of Intel
> > MPX; MPX has been removed by Intel in 2019, and LoongArch is designed
> > after 2019.
>=20
> Well, the difference is IMO significant enough to make LoongArch=20
> bounds-checking more useful, at least for certain use cases. For=20
> example, the bounds were a separate register bank in Intel MPX, but in
> LoongArch they are just values in GPRs. This fits naturally into=20
> JIT-ting or other managed runtimes (e.g. Go) whose slice indexing ops=20
> already bounds-check with a temporary register per bound anyway, so it's=
=20
> just a matter of this snippet (or something like it)
>=20
> - calculate element address
> - if address < base: goto fail
> - load/calculate upper bound
> - if address >=3D upper bound: goto fail
> - access memory
>=20
> becoming
>=20
> - calculate element address
> - asrtgt address, base - 1
> - load/calculate upper bound
> - {ld,st}le address, upper bound
>=20
> then in SIGSEGV handler, check PC to associate the signal back with the=
=20
> exact access op;

I remember using the signal handler for "usual" error handling can be a
very bad idea but I can't remember where I've read about it.  Is there
any managed environments doing so in practice?

If we redefine new_ldle/new_stle as "if [[likely]] the address is in-
bound, do the load/store and skip the next instruction; otherwise do
nothing", we can say:

blt        address, base, 1f
new_ldle.d rd, address, upperbound
1:b        panic_oob_access
xor        rd, rd, 42 // use rd to do something

This is more versatile, and useful for building a loop as well:

or            a0, r0, r0
0:new_ldle.d  t1, t0, t2
b             1f
add.d         a0, t1, a0
add.d         t0, t0, 8
b             0b
1:bl          do_something_with_the_sum

Yes it's "non-RISC", but at least more RISC than the current ldle: if
you want a trap anyway you can say

blt        address, base, 1f
new_ldle.d rd, address, upperbound
1:break    {a code defined for OOB}
xor        rd, rd, 42 // use rd

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
