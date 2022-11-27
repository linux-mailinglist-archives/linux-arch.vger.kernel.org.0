Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07296639DD6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Nov 2022 23:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0W7n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 17:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0W7l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 17:59:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBDFD105;
        Sun, 27 Nov 2022 14:59:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL3vV0x13z4xG6;
        Mon, 28 Nov 2022 09:59:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669589974;
        bh=n9irktu+jevq7fMe56RmXT6JJ5LT3gsl+oqzr4gohXg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=exVzIoRS3oDlkfs92eXqQcJvt61j+Obqhy6yazv9im5S0aGjM1SC2Qqq95SKRFHqr
         XU8khHre4kB9xsMJMSk8H6WprPmyaGFVZnSHfwd3CUV9xzDKCJKfyf1Jd+iZCorlnN
         9+PBLxobPnUTuImVNCDC8RlLqOTeY0vbFl+M9X0SJaJf61YhoIkhmJrcOMgrCS6GXp
         P6UBkEWHmWDWTYlL1kW5MYfQRCHIqeu47iTHtWB4kuVVuiPt4mFdKvWt4fbpFhIqCy
         ElVR6LaeJDSgFGTxKXo03VI6VvhaVZ9YSm8P2iP7okBZwrZppKKhghSD2zcGqWqtD9
         T3rwnaO0pv35w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
In-Reply-To: <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
References: <20221126051002.123199-1-linux@weissschuh.net>
 <20221126051002.123199-2-linux@weissschuh.net>
 <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
 <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
Date:   Mon, 28 Nov 2022 09:59:31 +1100
Message-ID: <87r0xoatrg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:
> On 2022-11-26 07:36+0000, Christophe Leroy wrote:
>> Le 26/11/2022 =C3=A0 06:10, Thomas Wei=C3=9Fschuh a =C3=A9crit=C2=A0:
>>> Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/co=
mpile.h>")
>>> removed the usage of the define UTS_VERSION but forgot to drop the
>>> include.
>>=20
>> What about:
>> arch/powerpc/platforms/52xx/efika.c
>> arch/powerpc/platforms/amigaone/setup.c
>> arch/powerpc/platforms/chrp/setup.c
>> arch/powerpc/platforms/powermac/bootx_init.c
>>=20
>> I believe you can do a lot more than what you did in your series.
>
> The commit messages are wrong.
> They should have said UTS_RELEASE instead of UTS_VERSION.
>
> Could the maintainers fix this up when applying?
> I also changed it locally so it will be fixed for v2.

I'll take this patch, but not the others.

cheers
