Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397D65E99F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjAELOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 06:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjAELOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 06:14:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA14E429;
        Thu,  5 Jan 2023 03:14:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnkPn2PdWz4xyp;
        Thu,  5 Jan 2023 22:14:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672917269;
        bh=H58PB5dB0RHrhFpgNYwPMvKuMcKWPpw8G9iLJXZd65A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j/cwOOWYJWVodOQKWxwA65hoiWL4SWeIvVb4ffTACF3VKkA3elmaJ1hYI+wZXwx9L
         RJ8aLHL842B7PawFJSpXS1qAYC9xwNFOV8u7rmFvlQO7LJk/Wwp3W8tO/xES+41iMV
         7mOwnQhFKX0M/lIRco+2PSiXUa28qRGAU3HnP78MWuRaw+0+pwWQ01XnpelZX/NpC4
         MfHAlNtln3QY7tMEcO2VhEKgPhkJFZwH/aZcLHMO77/gEXnpJPVJPk5h3IAQbX/wKC
         VXb38ngZxmv8RGPyOx8tTFiTtLmMVwSUMs8gztUA0pKa5j1o26PlSFhzs4RJ6rVJOY
         3RocSLreOfmbw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
In-Reply-To: <CAMj1kXGD3wQUPsRhvD7bO9xBJ6NR=Z+y8wXmKSCs57Oeh3MzGw@mail.gmail.com>
References: <20221226184537.744960-1-masahiroy@kernel.org>
 <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
 <CAK7LNAQ-MWhbiTX=phy3uzmNn+6ABZmi49D6d1n1-k-jxcQzgA@mail.gmail.com>
 <87fscp2v7k.fsf@igel.home>
 <CAMj1kXGD3wQUPsRhvD7bO9xBJ6NR=Z+y8wXmKSCs57Oeh3MzGw@mail.gmail.com>
Date:   Thu, 05 Jan 2023 22:14:20 +1100
Message-ID: <87y1qh2pyr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:
> On Thu, 5 Jan 2023 at 10:21, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Jan 05 2023, Masahiro Yamada wrote:
>>
>> > I do not understand why 99cb0d917ffa affected this.
>> >
>> >
>> > I submitted a fix to shoot the error message "discarded section .exit.text"
>> >
>> > https://lore.kernel.org/all/20230105031306.1455409-1-masahiroy@kernel.org/T/#u
>> >
>> > I do not understand the binutils commit either,
>> > but it might have made something good
>> > because EXIT_TEXT appears twice, in .exit.text, and /DISCARD/.
>>
>> I think the issue is that the introdution of a second /DISCARD/
>> directive early in script changes the order of evaluation of the other
>> /DISCARD/ directive when binutils < 2.36 is used, so that the missing
>> RUNTIME_DISCARD_EXIT started to become relevant.  As long as /DISCARD/
>> only appears last, the effect of EXIT_TEXT inside it is always
>> overridden by its occurence in the .exit.exit output section directive.
>> When another /DISCARD/ occurs early (and binutils < 2.36 is used) the
>> effect of EXIT_TEXT inside the second /DISCARD/ (when merged with the
>> first) overrides its occurence in the .exit.text directive.  The
>> binutils commit changed that because the new /DISCARD/ directive no
>> longer affects the order of evaluation of the rest of the directives.
>>
>
> Exactly. The binutils change mentions output section merging, which
> apparently applies to the /DISCARD/ pseudo section as well.
>
> However, powerpc was also affected by this, and I suggested another
> fix in the thread below
>
> https://lore.kernel.org/all/20230103014535.GA313835@roeck-us.net/

I'm working on powerpc fixes, which I think are all improvements
regardless of whether your change in the above thread is merged or not.

I'll try and get them posted tonight.

cheers
