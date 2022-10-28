Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D76106EF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Oct 2022 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJ1AmN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 20:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiJ1AmM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 20:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F99C7C9;
        Thu, 27 Oct 2022 17:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65AA62595;
        Fri, 28 Oct 2022 00:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F286C43142;
        Fri, 28 Oct 2022 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666917731;
        bh=OqTqHR7aJNAlusR5J+bbP39YaIgwBQNV5K4n8/o5iU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBkF5ACowgKO/BUd0E9ckrOCWw55Mr+LwyFbwkfKwwGttn5bR5ndai2mdIU2TTwQ7
         4WPgq6lUwCHEwpIeSrPx6coCs1TIrSy+l94FGMakEnxd9Msum16RdXDAnPOM/zUdAc
         yWcIx0ZdULGx3svDd0xz61HkiwrCH4T2bPm/eJv0W5b2WEP0heFPdrONptYrAD/Ocf
         eAxs9nBbbtNyXuSLOh9BeSv/yEd2hvrOePRYqMM43giQTg4aJOiIJSU3jjiA/a11TJ
         hALbPACUcU53NneZD7jwVU3v93wL2fGSwXetNFclxRSN+ry+zpMX47fiid6vf1Idnc
         qgEFk522Pjv0g==
Received: by mail-oi1-f178.google.com with SMTP id g10so4583778oif.10;
        Thu, 27 Oct 2022 17:42:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf241QrzYX/LRbVobrsyeXbp0Jc4j+XYWRNyQOtS+2hCAc/DDCnh
        ct4cHxwUTPeRQyLer02dU8i8A4v3lGeCqdFiwHE=
X-Google-Smtp-Source: AMsMyM72Nk5qQhNJoO1pbF8ISKZnODY9wB5JhxG1/d8B7XGjSHXoSz2fy7ZE2vRZMglqil2HmBMzIREAH67JlKut7sI=
X-Received: by 2002:a05:6808:f0e:b0:359:b055:32ea with SMTP id
 m14-20020a0568080f0e00b00359b05532eamr5745735oiw.112.1666917730449; Thu, 27
 Oct 2022 17:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220804025448.1240780-1-guoren@kernel.org> <Y1qlRlncUqTtwzE2@invisiblethingslab.com>
In-Reply-To: <Y1qlRlncUqTtwzE2@invisiblethingslab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 28 Oct 2022 08:41:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQs1Y4RR+ZYB17oW0beWfbpEF+7Wxnk91z=R14LSEqhjQ@mail.gmail.com>
Message-ID: <CAJF2gTQs1Y4RR+ZYB17oW0beWfbpEF+7Wxnk91z=R14LSEqhjQ@mail.gmail.com>
Subject: Re: [PATCH V2] uapi: Fixup strace compile error
To:     arnd@arndb.de, Wojtek Porczyk <woju@invisiblethingslab.com>
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 27, 2022 at 11:35 PM Wojtek Porczyk
<woju@invisiblethingslab.com> wrote:
>
> On Wed, Aug 03, 2022 at 10:54:48PM -0400, guoren@kernel.org wrote:
> > Export F_*64 definitions to userspace permanently. "ifndef" usage made it
> > vailable at all times to the userspace, and this change has actually broken
> > building strace with the latest kernel headers. There could be some debate
> > whether having these F_*64 definitions exposed to the user space 64-bit
> > applications, but it seems that were no harm (as they were exposed already
> > for quite some time), and they are useful at least for strace for compat
> > application tracing purposes.
> >
> > Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h"
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  include/uapi/asm-generic/fcntl.h | 2 --
> >  1 file changed, 2 deletions(-)
>
> Hello,
>
> Is this patch getting merged for 6.1? Will it be included in stable 6.0?
Em... It seems it hasn't been in Arnd's tree for next. It should be in
stable 6.0.

>
>
> --
> pozdrawiam / best regards
> Wojtek Porczyk
> Gramine / Invisible Things Lab
>
>  I do not fear computers,
>  I fear lack of them.
>     -- Isaac Asimov



-- 
Best Regards
 Guo Ren
