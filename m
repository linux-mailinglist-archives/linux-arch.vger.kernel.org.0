Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DC65EDE4
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjAENyW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 08:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjAENxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 08:53:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5E60CD8;
        Thu,  5 Jan 2023 05:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA53461A8B;
        Thu,  5 Jan 2023 13:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A3C433D2;
        Thu,  5 Jan 2023 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926623;
        bh=9rsuUbz5CFNU3FwjG7vhE4crM2pZKjhb8A7QPVly1mA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMNHJLA1AOuvHY4rKQLB05My6d9puPX+E16ZcLmQYery0xzrUtkasYGUUvZSw/2Gq
         iP8FseZ8M+ZTiyBokv3MfF+UUnVR6GdBzMg1R+wIqcwCqhWdc9pqu7YKFhmuxUM/uI
         RfZ9f8U4Vt07XRsdueVEO7W4zf0Uc781pkqLmYk/W+bQgZ/5XZs938GEhXCk3UXKSQ
         RptMX4nmwUyj0pZdhCir3ZuMs3E7r5NrwqQ3TqAGGmsvLYlFtLTBrxYLPTdbYXMtL0
         17Oi+YHcFv4pATeaiVhmhiUW/nZF4uAPDfc8ojr1giiRRAc6OlytnhbZOQSEp/Lk4C
         615SVG6DEl1DQ==
Received: by mail-oi1-f176.google.com with SMTP id s187so31964215oie.10;
        Thu, 05 Jan 2023 05:50:23 -0800 (PST)
X-Gm-Message-State: AFqh2koiiTAylMQFAL9v9q/GWFSz5bQLHFhjn5Sv55bnyPFap6KhxxY3
        At1J0xlc8H00o47hsJbW7fMoxj6s7ayaN12kBN8=
X-Google-Smtp-Source: AMrXdXsQ8eHuE5T9wbS/TSFR1VCmUEYQReFWODFWTDVkrBErc+HlOKeIJraKJb0jPNiJNVbMRBUU85Biyah+tr4UtiE=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr2913154oia.287.1672926622568; Thu, 05
 Jan 2023 05:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20221226184537.744960-1-masahiroy@kernel.org> <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
 <CAK7LNAQ-MWhbiTX=phy3uzmNn+6ABZmi49D6d1n1-k-jxcQzgA@mail.gmail.com>
 <87fscp2v7k.fsf@igel.home> <CAMj1kXGD3wQUPsRhvD7bO9xBJ6NR=Z+y8wXmKSCs57Oeh3MzGw@mail.gmail.com>
In-Reply-To: <CAMj1kXGD3wQUPsRhvD7bO9xBJ6NR=Z+y8wXmKSCs57Oeh3MzGw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Jan 2023 22:49:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASX4oJO+ciA6RRW35qDgD+39iWDVhW0LX_eQne+PDBVgA@mail.gmail.com>
Message-ID: <CAK7LNASX4oJO+ciA6RRW35qDgD+39iWDVhW0LX_eQne+PDBVgA@mail.gmail.com>
Subject: Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 5, 2023 at 6:27 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 5 Jan 2023 at 10:21, Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Jan 05 2023, Masahiro Yamada wrote:
> >
> > > I do not understand why 99cb0d917ffa affected this.
> > >
> > >
> > > I submitted a fix to shoot the error message "discarded section .exit.text"
> > >
> > > https://lore.kernel.org/all/20230105031306.1455409-1-masahiroy@kernel.org/T/#u
> > >
> > > I do not understand the binutils commit either,
> > > but it might have made something good
> > > because EXIT_TEXT appears twice, in .exit.text, and /DISCARD/.
> >
> > I think the issue is that the introdution of a second /DISCARD/
> > directive early in script changes the order of evaluation of the other
> > /DISCARD/ directive when binutils < 2.36 is used, so that the missing
> > RUNTIME_DISCARD_EXIT started to become relevant.  As long as /DISCARD/
> > only appears last, the effect of EXIT_TEXT inside it is always
> > overridden by its occurence in the .exit.exit output section directive.
> > When another /DISCARD/ occurs early (and binutils < 2.36 is used) the
> > effect of EXIT_TEXT inside the second /DISCARD/ (when merged with the
> > first) overrides its occurence in the .exit.text directive.  The
> > binutils commit changed that because the new /DISCARD/ directive no
> > longer affects the order of evaluation of the rest of the directives.
> >
>
> Exactly. The binutils change mentions output section merging, which
> apparently applies to the /DISCARD/ pseudo section as well.
>
> However, powerpc was also affected by this, and I suggested another
> fix in the thread below
>
> https://lore.kernel.org/all/20230103014535.GA313835@roeck-us.net/


Thanks for the pointer.

(and sorry, I did not notice that thread, and missed to reply promptly)


Your fix will work globally.
I left some comments in that thread.




-- 
Best Regards
Masahiro Yamada
