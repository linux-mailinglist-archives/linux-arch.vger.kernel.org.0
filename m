Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4694B1A43
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 01:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbiBKARa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 19:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346204AbiBKAR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 19:17:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADBF5582;
        Thu, 10 Feb 2022 16:17:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so10304727pjl.2;
        Thu, 10 Feb 2022 16:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DvG8fCf7KVzHEzIUqrYQD1tXuriXBJ0qnl0qbGDLAIc=;
        b=nEy5oLkL4L5drym9TpX+/BFiMcd0nHRGbmXVu0J02kfiQluOo3aPZtsLV5zqcNZt+e
         T4wxx7FuGQq822ji6IhHS4oHk1xyVMMyQDcMsBQZfw+yoqA2jbJ6S3FjwQyJR1K9ZebV
         Z2PuAgQDrKzKu5/d8koMiw3RuBBN5Ya1uspfz0C/2Dut94an5J5L/9+afRkC4eE7mkOR
         62HY9QX8qf0ueM5JgMMJoaoN2LJddwbrBGoydF8zEGFcEEclzYZwwduJ8GLtL5zRUv4n
         aPvVDR2aj0KUpsQ+SZu1l4Se0yy/agkIGadIwTMaSm3ActvjLdnYgv+ztZPQavGUKlTh
         Z5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DvG8fCf7KVzHEzIUqrYQD1tXuriXBJ0qnl0qbGDLAIc=;
        b=ovDubdjFTGeFf71u9Fmwu91ANO5FZuktsPDPmPx7my1LS/kKu2ncqXzVffQn7YlJ4S
         QXskISUnWykOySg1D9Kd0B21PmflL8zzUooA6Ebupu6GfMkKGsONrkuGqBYgGyZL9FNf
         N7ew9hpqvdQ0kLQdr2Yn8CPnpS/S2cyy27C5dooFLllwgniFVC5wZzXwITpaGd47K3gD
         qpIMcNwwGXZPOJt/aaIX23hN8/snRpZy+8Nesg+v44UFvD0iufEAxx6nPnzAk28f9mKv
         QRJgcFFuJqPxUGU5YMyeUmma5EL6B9uAiuIVcr7YpPjhep99UgtgFVnyLcmNJegZ1p67
         dxdA==
X-Gm-Message-State: AOAM532xHL6IeErj+zFnUHd7tt+OiGS6GMR4KZsByejsqU61OkN1U24C
        UMAaz4zG5gsp6YXVxdYryq4=
X-Google-Smtp-Source: ABdhPJwss/Rqo/3N8BgVugUzuI8IDeqvkGXQv40T+KAvSnupJBsy46Yd2qrJKUvUAWXY8yUrnRW19g==
X-Received: by 2002:a17:90a:c687:: with SMTP id n7mr5465372pjt.83.1644538649108;
        Thu, 10 Feb 2022 16:17:29 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id o21sm25569745pfu.100.2022.02.10.16.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:17:27 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:17:26 +0900
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
Message-ID: <YgWrFnoOOn/B3X4k@antec>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
 <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgROuYDWfWYlTUKD@antec>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 08:31:05AM +0900, Stafford Horne wrote:
> On Wed, Feb 09, 2022 at 03:54:54PM +0100, Arnd Bergmann wrote:
> > On Wed, Feb 9, 2022 at 3:44 PM Michal Simek <michal.simek@xilinx.com> wrote:
> > > On 2/9/22 15:40, Arnd Bergmann wrote:
> > > > On Wed, Feb 9, 2022 at 2:50 PM Michal Simek <monstr@monstr.eu> wrote:
> > > >>
> > > >> Hi Arnd,
> > > >>
> > > >> po 17. 1. 2022 v 14:28 odesílatel Arnd Bergmann <arnd@kernel.org> napsal:
> > > >>>
> > > >>> From: Arnd Bergmann <arnd@arndb.de>
> > > >>>
> > > >>> I picked microblaze as one of the architectures that still
> > > >>> use set_fs() and converted it not to.
> > > >>
> > > >> Can you please update the commit message because what is above is not
> > > >> the right one?
> > > >
> > > > Ah, sorry about that. I think you can copy from the openrisc patch,
> > > > see https://lore.kernel.org/lkml/20220208064905.199632-1-shorne@gmail.com/
> > >
> > > Please do it. You are the author of this patch and we should follow the process.
> > 
> > Done.
> > 
> > Looking at it again, I wonder if it would help to use the __get_kernel_nofault()
> > and __get_kernel_nofault() helpers as the default in
> > include/asm-generic/uaccess.h.
> 
> That would make sense.  Perhaps also the __range_ok() function from OpenRISC
> could move there as I think other architectures would also want to use that.
> 
> > I see it's identical to the openrisc version and would probably be the same
> > for some of the other architectures that have no other use for
> > set_fs(). That may
> > help to do a bulk remove of set_fs for alpha, arc, csky, h8300, hexagon, nds32,
> > nios2, um and extensa, leaving only ia64, sparc and sh.
> 
> If you could add it into include/asm-generic/uaccess.h I can test changing my
> patch to use it.

Note, I would be happy to do the work to move these into include/asm-generic/uaccess.h.
But as I see it the existing include/asm-generic/uaccess.h is for NOMMU.  How
should we go about having an MMU and NOMMU version?  Should we move uaccess.h to
uaccess-nommu.h?  Or add more ifdefs to uaccess.h?

-Stafford
