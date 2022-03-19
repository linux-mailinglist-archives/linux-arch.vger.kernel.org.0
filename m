Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0284D4DE5D9
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiCSEAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 00:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiCSEAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 00:00:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731AFD1F;
        Fri, 18 Mar 2022 20:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E872B82601;
        Sat, 19 Mar 2022 03:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217DAC340F3;
        Sat, 19 Mar 2022 03:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647662344;
        bh=NCmSYpBpPOqdOKkO2yTy5z2+vGdb8Ya42Eaja7z7Ydo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cy9DNDH8kpFKUG0D8MCkuejTPlgI/3pjlWVoRY7y7BN7QewMSIn9+eCbeVjme0WeS
         YGab4sFB0XxjPwlmiDBOUQLPGcvaTlDRMMY/YpahYaMcVZqs1dhj+fznUaCZRz0JYH
         PeSyiLvyw5io6cUho8+MWOE63voDans1QeL+gxXPZKkPkLYSLIaTHm8AaPpOVZKTfk
         0uvFeEdx14/h6Jf855UACHR8LvznmfGPeMqJQ3oko0dgVRtBbt1f3gZ3Ph9mNyuV8n
         5XPh439oennaLYRCDYcthQPWrO0orKGEWSR/3lXk5SRfQQ5unV2g/cPNMfU6byAAMk
         efqhtvpgz8lyg==
Received: by mail-vs1-f48.google.com with SMTP id 185so958397vsq.8;
        Fri, 18 Mar 2022 20:59:04 -0700 (PDT)
X-Gm-Message-State: AOAM531/nZpsrYwbVv8nah+pD2z1suoqEXskhiWGC7CUZ3gQp+Wpwlnv
        i7pDsFaImuLzsVJyc4UeRcs9kBg37ZDgYKM+d9Y=
X-Google-Smtp-Source: ABdhPJyT2/M7uJmIdHKQUIA0qbp1v0uU+ddahjBl3cmFDN5cF5//qn59rYZQkwQ0ym7E8abdzkfttLhe2OYuc6nxFy0=
X-Received: by 2002:a05:6102:dce:b0:322:b950:4728 with SMTP id
 e14-20020a0561020dce00b00322b9504728mr4363733vst.51.1647662342936; Fri, 18
 Mar 2022 20:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220318083421.2062259-1-guoren@kernel.org> <CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw@mail.gmail.com>
In-Reply-To: <CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 19 Mar 2022 11:58:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR=wTi6G7wFzOyUpQn72b3iKtAjzvBSFHNDgpPFboJs0w@mail.gmail.com>
Message-ID: <CAJF2gTR=wTi6G7wFzOyUpQn72b3iKtAjzvBSFHNDgpPFboJs0w@mail.gmail.com>
Subject: Re: [PATCH] csky: Move to generic ticket-spinlock
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Fri, Mar 18, 2022 at 6:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 18, 2022 at 9:34 AM <guoren@kernel.org> wrote:
> > @@ -3,6 +3,8 @@ generic-y += asm-offsets.h
> >  generic-y += extable.h
> >  generic-y += gpio.h
> >  generic-y += kvm_para.h
> > +generic-y += ticket-lock.h
> > +generic-y += ticket-lock-types.h
> >  generic-y += qrwlock.h
> >  generic-y += user.h
> >  generic-y += vmlinux.lds.h
>
> If these headers are not included from architecture-independent code,
> they should
> not be marked as generic-y, same as for the qrwlock.h header
>
> > +#include <asm/ticket-lock.h>
> >  #include <asm/qrwlock.h>
> >
> > ...
> > +#include <asm/ticket-lock-types.h>
> >  #include <asm-generic/qrwlock_types.h>
> >
>
> So these should all become
>
> #include <asm-generic/...h>
>
> It would however make sense to have the trivial two-line version
> of the two header files and put them into asm-generic/spinlock.h
> and asm-generic/spinlock-types.h, replacing the current version.
>
> If you do that, then you need a 'generic-y' line for spinlock.h,
> but not for the other ones.
Thx for the suggestion, I've sent V2 based on Palmer's series to make
the ticket spinlock more generic.
Please have a look:
https://lore.kernel.org/linux-arch/20220319035457.2214979-1-guoren@kernel.org/T/#t

>
>        Arnd




--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
