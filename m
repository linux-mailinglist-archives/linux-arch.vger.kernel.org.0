Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE66535D1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 19:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLUSFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 13:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUSFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 13:05:24 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Dec 2022 10:05:23 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B57B3A;
        Wed, 21 Dec 2022 10:05:23 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Ncgts6Wckz1r154;
        Wed, 21 Dec 2022 18:49:41 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4Ncgts3RKdz1qqlR;
        Wed, 21 Dec 2022 18:49:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id YKZ62LcI-vuN; Wed, 21 Dec 2022 18:49:39 +0100 (CET)
X-Auth-Info: RUeEdR2v+0VYKIaXr5A64sVWt0B2HWulD7p56icvinptvxfKIQlp85Zh708IX0IE
Received: from igel.home (aftr-62-216-205-97.dynamic.mnet-online.de [62.216.205.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 21 Dec 2022 18:49:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 578EB2C01FE; Wed, 21 Dec 2022 18:49:39 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
        <20221019203034.3795710-1-Jason@zx2c4.com>
        <20221221145332.GA2399037@roeck-us.net>
        <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
        <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
        <20221221155641.GB2468105@roeck-us.net>
X-Yow:  Let me do my TRIBUTE to FISHNET STOCKINGS...
Date:   Wed, 21 Dec 2022 18:49:39 +0100
In-Reply-To: <20221221155641.GB2468105@roeck-us.net> (Guenter Roeck's message
        of "Wed, 21 Dec 2022 07:56:41 -0800")
Message-ID: <87mt7gve8c.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Dez 21 2022, Guenter Roeck wrote:

> The above assumes an unsigned char as input to strcmp().

That's how strcmp is defined.

See <https://lore.kernel.org/all/87bko3ia88.fsf@igel.home>

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
