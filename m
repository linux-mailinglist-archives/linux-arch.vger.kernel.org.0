Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490984F7834
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiDGHyv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiDGHyu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 03:54:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0301C2D81;
        Thu,  7 Apr 2022 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FZp9Ive/VquPf6ObnGVyJces3vL4RIyldFbr1Zsjkoo=; b=y+E42+SZua5mio9/NU+Cbghatk
        H9Ss1en/Hvkc7LLJ2oSa7kA0GIkzq+D0c6JP1/VnkfB+psAfw71vpUnIqSL9bTzLuhHzA41YH7rO9
        2jEcaksVcYlFuAqJvlzei2o+aTox94gmwzrTX++dRWAQanYRr/4TP6Dl8u2/XtNZBqWDsHMoTPpP+
        /eNvBjX7LPZ7zcbYgMX4evGihYIlt3OG0+BHGKmOYv+QuSqlmaEussnUYrOTNrrKBzm5OvrSiAruu
        cHzDr077suP8/Fzui/3ARNWb/0hoEOhTAIPPH93ys2y7WypI2AQCIFY9NfVq7zxdXjhqdqy5eN/qY
        iAYOAqGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncMwY-00A8KX-C6; Thu, 07 Apr 2022 07:52:38 +0000
Date:   Thu, 7 Apr 2022 00:52:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
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
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
Subject: Re: [RFC PULL] remove arch/h8300
Message-ID: <Yk6YRuFYw7ncoIHI@infradead.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
 <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net>
 <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com>
 <04c0374f-0044-c84d-1820-d743a4061906@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c0374f-0044-c84d-1820-d743a4061906@physik.fu-berlin.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 07, 2022 at 09:47:04AM +0200, John Paul Adrian Glaubitz wrote:
> But if it's not a lot of code, would it really accumulate a lot of cruft?
> 
> If the code just works as is and doesn't need much attention to keep it working

Because no one gives it even that little bit of attention.
