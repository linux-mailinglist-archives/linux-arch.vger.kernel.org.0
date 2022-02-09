Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4424B0152
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 00:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiBIXbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 18:31:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiBIXbL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 18:31:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D37E0513B7;
        Wed,  9 Feb 2022 15:31:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id qe15so3594670pjb.3;
        Wed, 09 Feb 2022 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dWppND9NpqLN1Tp3iTkqAOomYZbs0nhNFIMKosCdxW0=;
        b=X94PRxzNF33Qcxf5R7s1lyX/ieIFiROBat+v/E4ngT3Odpkh9IKlR4fxWP1VYIrCzy
         ozOqXf6GSFDXHUe7rvn4IBGuOCM6xR+FzvUrkdE96nd7yVwND98TGu+9mJbK6d1y88kJ
         PIYbe3CGPu6/vsRQasrjLRhHwrvEP0GIIJJxll8Nd51FSVCFHXVraqzlENB/40ezxQxy
         aodM+l0wzOVJgjX6G7Agh6rlvLnpOHloK6oEunEM9sbQ/GI7zhweq5VLWV7Z00A0PGPH
         6kgbBqGb1YssY/LM/ixONLNSoIOL98zJGStFaJWdOykRb41oJOtDPGyV+5OkP7GOuWRv
         Dt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dWppND9NpqLN1Tp3iTkqAOomYZbs0nhNFIMKosCdxW0=;
        b=lLmIcFhmbznSP5SnbfG3hDe0e0HesmiTSmtf6x0AInHCB1a5Cpud7Gs4DBvbwOE0Zg
         TauS353ubxlR7h2jOFB99Ui3ml2EzR4g3mwSBl18iexV3rNzpt8w4sNOljCel0i/wM41
         95RV/Gny2xjIpredij8u0KLsH8gApzj0ddyVhioCgE1G+qsHlJ8eJKjXcExaojGA3LK9
         H2Xj9LFD5IhJiLaM5e8cHWunnUHQA6y4KhlzoYzyY9d8z7kOwAv3pMR4MUStx4lHefS7
         +X8LBHP8huA1MnF48VVb46jv9aQ67ec3gG7/JX4S6H+Gwe9Rk9bETChvpHKSpIZ8+qfW
         CNaQ==
X-Gm-Message-State: AOAM532ORWQgl0IeTKZQVTVDUUcwGfspvNWhUC77lEZwwDXbXPF7thtW
        LlB43JcRuwIWMvPbSC3HytY=
X-Google-Smtp-Source: ABdhPJymWHfD5zV4TBaM54z3IyhOOM+m+Ywq+QOSHiGqiXBoSdS+KUj7KSZelEFmMHnzP0xNqzFH+Q==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr4816228pll.160.1644449467530;
        Wed, 09 Feb 2022 15:31:07 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id mn7sm6974530pjb.8.2022.02.09.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:31:06 -0800 (PST)
Date:   Thu, 10 Feb 2022 08:31:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgROuYDWfWYlTUKD@antec>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
 <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 09, 2022 at 03:54:54PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 9, 2022 at 3:44 PM Michal Simek <michal.simek@xilinx.com> wrote:
> > On 2/9/22 15:40, Arnd Bergmann wrote:
> > > On Wed, Feb 9, 2022 at 2:50 PM Michal Simek <monstr@monstr.eu> wrote:
> > >>
> > >> Hi Arnd,
> > >>
> > >> po 17. 1. 2022 v 14:28 odesílatel Arnd Bergmann <arnd@kernel.org> napsal:
> > >>>
> > >>> From: Arnd Bergmann <arnd@arndb.de>
> > >>>
> > >>> I picked microblaze as one of the architectures that still
> > >>> use set_fs() and converted it not to.
> > >>
> > >> Can you please update the commit message because what is above is not
> > >> the right one?
> > >
> > > Ah, sorry about that. I think you can copy from the openrisc patch,
> > > see https://lore.kernel.org/lkml/20220208064905.199632-1-shorne@gmail.com/
> >
> > Please do it. You are the author of this patch and we should follow the process.
> 
> Done.
> 
> Looking at it again, I wonder if it would help to use the __get_kernel_nofault()
> and __get_kernel_nofault() helpers as the default in
> include/asm-generic/uaccess.h.

That would make sense.  Perhaps also the __range_ok() function from OpenRISC
could move there as I think other architectures would also want to use that.

> I see it's identical to the openrisc version and would probably be the same
> for some of the other architectures that have no other use for
> set_fs(). That may
> help to do a bulk remove of set_fs for alpha, arc, csky, h8300, hexagon, nds32,
> nios2, um and extensa, leaving only ia64, sparc and sh.

If you could add it into include/asm-generic/uaccess.h I can test changing my
patch to use it.

-Stafford
