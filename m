Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478846E400F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 08:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDQGrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDQGrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 02:47:20 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182AA1BB;
        Sun, 16 Apr 2023 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681714030;
        bh=X5Si7Sz3dcckMNDn8ioalIMpIjcJEST+qawKVUbSZE4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FUjhuTwu6euQMt36q/j6P7ioJQ8RRYcFdrR0MmAe6327tp/SP0qd+kj4X6pZeKGqN
         YyCSNs12RerdkjkiU4FyLEJC2x+2dkgjgG+tfNKJR08VdrW16LE2Qv3wzQBXgSUs36
         E2LyOF7TujJ/5MZwS0mpmwJGUIGTMXQsQT2bjer4=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2051065C17;
        Mon, 17 Apr 2023 02:47:08 -0400 (EDT)
Message-ID: <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Apr 2023 14:47:07 +0800
In-Reply-To: <20230416173326.3995295-1-kernel@xen0n.name>
References: <20230416173326.3995295-1-kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-04-17 at 01:33 +0800, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
>=20
> Hi,
>=20
> The LoongArch-64 base architecture is capable of performing
> bounds-checking either before memory accesses or alone, with specialized
> instructions generating BCEs (bounds-checking error) in case of failed
> assertions (ISA manual Volume 1, Sections 2.2.6.1 [1] and 2.2.10.3 [2]).
> This could be useful for managed runtimes, but the exception is not
> being handled so far, resulting in SIGSYSes in these cases, which is
> incorrect and warrants a fix in itself.
>=20
> During experimentation, it was discovered that there is already UAPI for
> expressing such semantics: SIGSEGV with si_code=3DSEGV_BNDERR. This was
> originally added for Intel MPX, and there is currently no user (!) after
> the removal of MPX support a few years ago. Although the semantics is
> not a 1:1 match to that of LoongArch, still it is better than
> alternatives such as SIGTRAP or SIGBUS of BUS_OBJERR kind, due to being
> able to convey both the value that failed assertion and the bound value.
>=20
> This patch series implements just this approach: translating BCEs into
> SIGSEGVs with si_code=3DSEGV_BNDERR, si_value set to the offending value,
> and si_lower and si_upper set to resemble a range with both lower and
> upper bound while in fact there is only one.
>=20
> The instructions are not currently used anywhere yet in the fledgling
> LoongArch ecosystem, so it's not very urgent and we could take the time
> to figure out the best way forward (should SEGV_BNDERR turn out not
> suitable).

I don't think these instructions can be used in any systematic way
within a Linux userspace in 2023.  IMO they should not exist in
LoongArch at all because they have all the same disadvantages of Intel
MPX; MPX has been removed by Intel in 2019, and LoongArch is designed
after 2019.

If we need some hardware assisted memory safety facility, an extension
similar to ARM TBI or Intel LAM would be much more useful.


Back in the old MIPS-based Loongson CPUs, similar instructions (GSLE,
GSGT, etc.) were included in LoongISA extension and the manual says they
raises "address error" when assert fails.  So SIGSEGV seems the
"backward compatible" (quoted because we absolutely don't need to
maintain any backward compatibility with old MIPS-based implementations)
thing to do.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
