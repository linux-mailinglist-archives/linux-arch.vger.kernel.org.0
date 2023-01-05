Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FD65E792
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 10:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAEJVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 04:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAEJVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 04:21:18 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08897544FA;
        Thu,  5 Jan 2023 01:21:12 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Nngv62wn5z1s89H;
        Thu,  5 Jan 2023 10:21:06 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4Nngv558R4z1qqlR;
        Thu,  5 Jan 2023 10:21:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id BAUSzBWqsYNC; Thu,  5 Jan 2023 10:21:03 +0100 (CET)
X-Auth-Info: ULmWuHDbYpDzw7fgn9yZLoIMWYSx2BoKlnKiH1/oFq17cjDTOLj3zE3OV4yRXdz9
Received: from igel.home (aftr-62-216-205-97.dynamic.mnet-online.de [62.216.205.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  5 Jan 2023 10:21:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 881052C126D; Thu,  5 Jan 2023 10:21:03 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
References: <20221226184537.744960-1-masahiroy@kernel.org>
        <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
        <CAK7LNAQ-MWhbiTX=phy3uzmNn+6ABZmi49D6d1n1-k-jxcQzgA@mail.gmail.com>
X-Yow:  BEEP-BEEP!!  I'm a '49 STUDEBAKER!!
Date:   Thu, 05 Jan 2023 10:21:03 +0100
In-Reply-To: <CAK7LNAQ-MWhbiTX=phy3uzmNn+6ABZmi49D6d1n1-k-jxcQzgA@mail.gmail.com>
        (Masahiro Yamada's message of "Thu, 5 Jan 2023 12:22:50 +0900")
Message-ID: <87fscp2v7k.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jan 05 2023, Masahiro Yamada wrote:

> I do not understand why 99cb0d917ffa affected this.
>
>
> I submitted a fix to shoot the error message "discarded section .exit.text"
>
> https://lore.kernel.org/all/20230105031306.1455409-1-masahiroy@kernel.org/T/#u
>
> I do not understand the binutils commit either,
> but it might have made something good
> because EXIT_TEXT appears twice, in .exit.text, and /DISCARD/.

I think the issue is that the introdution of a second /DISCARD/
directive early in script changes the order of evaluation of the other
/DISCARD/ directive when binutils < 2.36 is used, so that the missing
RUNTIME_DISCARD_EXIT started to become relevant.  As long as /DISCARD/
only appears last, the effect of EXIT_TEXT inside it is always
overridden by its occurence in the .exit.exit output section directive.
When another /DISCARD/ occurs early (and binutils < 2.36 is used) the
effect of EXIT_TEXT inside the second /DISCARD/ (when merged with the
first) overrides its occurence in the .exit.text directive.  The
binutils commit changed that because the new /DISCARD/ directive no
longer affects the order of evaluation of the rest of the directives.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
