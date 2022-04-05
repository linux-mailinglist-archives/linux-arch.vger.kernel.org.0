Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839BA4F54E0
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiDFE75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 00:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452874AbiDEWca (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 18:32:30 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77A1BE85
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 14:26:55 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 478E8825DF
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 16:26:55 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bqhTnK58idx86bqhTnk49D; Tue, 05 Apr 2022 16:26:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=etLRv605waIPx1DCrS1r2FtQdxwRWlTwRr0MCFi87mQ=; b=sDX58Fsb0AiIgrUpsTvhohwTrE
        XQ1vZUwbXi1u2XKNWkOabkdtvSY+nJsJnq0jEJWOR2pWup9lL6B1Mma1ENz8pF3G+ncnOQDMBWueO
        XHkI5kIBI84YfYzO74YAyKDyDKe2FjwoGqgSZffJ5D+JJXb2Jq5ETNOBfe4fmt1CjLYkwcQ+vhYYD
        Mp+MjiO2y0hQtXtTYWaQgBv5t2HUUiMwf4OS56xwETZ1BcjgDwyOR2rvANhkO7vmxLAVlqJQlomJS
        A1LWi97vunmvbWJ2N78LVU+fj8RDpGNVebNiU4xgOzx9rtMLQ/EktX2AhgIrfrya8pzpfhsWoBVtB
        klltifqw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57870 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbqhS-003NqP-K5; Tue, 05 Apr 2022 21:26:54 +0000
Date:   Tue, 5 Apr 2022 14:26:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [RFC PULL] remove arch/h8300
Message-ID: <20220405212653.GA2482665@roeck-us.net>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbqhS-003NqP-K5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57870
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 19
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 04, 2022 at 03:07:06PM +0200, Arnd Bergmann wrote:
> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
> > > If there are no other objections, I'll just queue this up for 5.18 in
> > > the asm-generic
> > > tree along with the nds32 removal.
> >
> > So it is the last day of te merge window and arch/h8300 is till there.
> > And checking nw the removal has also not made it to linux-next.  Looks
> > like it is so stale that even the removal gets ignored :(
> 
> I was really hoping that someone else would at least comment.
> I've queued it up now for 5.19.
> 
> Should we garbage-collect some of the other nommu platforms where
> we're here? Some of them are just as stale:
> 
> 1. xtensa nommu has does not compile in mainline and as far as I can
> tell never did
>    (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
> which
>    worked at some point, but I don't think there was enough interest
> to get in merged)

Hmm, I build and test nommu_kc705_defconfig in my test system.

> 
> 2. arch/sh Hitachi/Renesas sh2 (non-j2) support appears to be in a similar state
>     to h8300, I don't think anyone would miss it
> 
> 8<----- This may we where we want to draw the line ----
> 
> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
> changes, but I think
>     Rich still cares about it and wants to add J32 support (with MMU)
> in the future
> 
> 4. m68k Dragonball, Coldfire v2 and Coldfire v3 are just as obsolete as SH2 as
>    hardware is concerned, but Greg Ungerer keeps maintaining it, along with the
>    newer Coldfire v4 (with MMU)
> 
> 5. K210 was added in 2020. I assume you still want to keep it.
> 
> 7. Arm32 has several Cortex-M based platforms that are mainly kept for
>     legacy users (in particular stm32) or educational value.
> 
I do build and test mps2_defconfig with qemu's mps2-an385 emulation.

I am not saying that those are actively used, and I don't mind dropping
them, but they do still work.

Guenter
