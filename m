Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873AC639644
	for <lists+linux-arch@lfdr.de>; Sat, 26 Nov 2022 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKZOHc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Nov 2022 09:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKZOHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Nov 2022 09:07:31 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD3EA8;
        Sat, 26 Nov 2022 06:07:29 -0800 (PST)
Date:   Sat, 26 Nov 2022 15:07:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669471647;
        bh=yXORdDaM5IB4Oq8We4CxZr/JSohcHmOU7RYUv4Jkuwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAzqgy9nLteY56ElyaMCWe7M0VeqKwuE4Yd4UaIwW6TDirWAo8dfzmY8MSsg3O3cx
         DU2AUxUNbUv9HSqWmJxYPWtfy2PlP86FYrC4VHOI9bjZNPBt82jYV5u2OuiBaWJPGt
         H37qirgRdVgY8R2HN5aKq7uJgGFZhs0EsN4VoNLU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
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
Message-ID: <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
References: <20221126051002.123199-1-linux@weissschuh.net>
 <20221126051002.123199-2-linux@weissschuh.net>
 <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-11-26 07:36+0000, Christophe Leroy wrote:
> Le 26/11/2022 à 06:10, Thomas Weißschuh a écrit :
>> Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/compile.h>")
>> removed the usage of the define UTS_VERSION but forgot to drop the
>> include.
> 
> What about:
> arch/powerpc/platforms/52xx/efika.c
> arch/powerpc/platforms/amigaone/setup.c
> arch/powerpc/platforms/chrp/setup.c
> arch/powerpc/platforms/powermac/bootx_init.c
> 
> I believe you can do a lot more than what you did in your series.

The commit messages are wrong.
They should have said UTS_RELEASE instead of UTS_VERSION.

Could the maintainers fix this up when applying?
I also changed it locally so it will be fixed for v2.

> List of files using UTS_VERSION :
> 
> $ git grep -l UTS_VERSION
> [..]

Thomas
