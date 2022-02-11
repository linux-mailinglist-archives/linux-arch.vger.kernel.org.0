Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D784B3052
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 23:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbiBKWV4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 17:21:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiBKWVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 17:21:54 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C8D48;
        Fri, 11 Feb 2022 14:21:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 9so15722476pfx.12;
        Fri, 11 Feb 2022 14:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gp/zsuHKYh5My8PR8Z8zMLkl9KcvlSL8qBfbEmgIsWo=;
        b=FbC+aa/JuHHGAUA0o4a7ARROkYlUgtF89jqqv1971NAcrPrUSBCHntXAKxWKY1qSQE
         AFVRvaMiLhFaWVq4PK+cScT+HTjVT3B+3FYvmez6AKToFoigGVn2E9A3a642mY2KMEj4
         5/0tuPl72S/A1jO943oZMmvPk9oa7cBAhbvSI5HhcdfggrFAkt6tK0wEiKe90MFWuKYS
         0HDbNhFEBCn7hewZSU0mhtre4vrbPav2md7HpiW4LtrZzxCgBHalGEmdN67mq/xeWXRy
         U2JluWcMTCjoX1ZOKDB+b1e5XJiTbnrxj+l36UkSk+7fxf9MNZVo8UxJppvmMDayZFro
         ufOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gp/zsuHKYh5My8PR8Z8zMLkl9KcvlSL8qBfbEmgIsWo=;
        b=hPl7DGfSnQWChC+ZGUeLukhiapy1QoNSK0Ud0w7+KGw0HD5b2R4n/tYwOR7lTDq/N/
         4SmQkEMw1LRskN4JO4+4d8xMoEQtBLbJX/f8lY7lANm5q1t3ytIOfVlll6KZHfLDX7vQ
         +v6S9iivozQNzv9G90YxygdBw5uI5sZjWg3MrFT+DkeA2kR8iXzAwF2EajjCTdqh1I8X
         qZhaiWjj2eSlA6pttR62Qqb/ySdVkkq18RlPs3EZOn+hImru8G8vMr7aq4nuczZd+GLX
         BxH/BgyVvZsV6o3e4g61+OjJ7nbiBkoYxLyO0IAS3+vTZTZKOYhms+H/07o2vr7P5AM3
         VoHg==
X-Gm-Message-State: AOAM532+/9j+bixYQ58DlN0+fTCM7k+AWxp7Ej6twxlNGTe1vKVRIsyI
        r7ST+1qtOoxDqfKRZzAym6I=
X-Google-Smtp-Source: ABdhPJzgUOwow1Kw0Nqi3SZXj+CluzcAukjRqtFGLhJHuV04lh6TJBYGd6gfq9E4miw55l9+syK/tw==
X-Received: by 2002:aa7:8d08:: with SMTP id j8mr3616091pfe.68.1644618111742;
        Fri, 11 Feb 2022 14:21:51 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id a12sm24442962pfv.18.2022.02.11.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:21:51 -0800 (PST)
Date:   Sat, 12 Feb 2022 07:21:49 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgbhfZ4tlWByxm+B@antec>
References: <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
 <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec>
 <YgWrFnoOOn/B3X4k@antec>
 <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
 <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
 <CAK8P3a22q+vTb3cEurhA0zXzw8-9+jKJRotC0oWMncS3sb-7zA@mail.gmail.com>
 <87a6exxg7h.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6exxg7h.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 11, 2022 at 03:10:10PM -0600, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
> >
> > I had previously gotten stuck at ia64, but gave it another go now
> > and uploaded an updated branch with ia64 taken care of and another
> > patch to clean up bits afterwards.
> >
> > I only gave it light testing so far, mainly building the defconfig for every
> > architecture. I'll post the series once the build bots are happy with the
> > branch overall.
> >
> 
> Thank you so much for doing this work.
> 

I'll echo this.  Thank you, the changes look good.  I test built and booted the
OpenRISC architecture and it works.

I can drop the openrisc only patch for this from the openrisc queue now.

-Stafford
