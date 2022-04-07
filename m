Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C14F79E6
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiDGIg0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbiDGIgZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 04:36:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20124A74E;
        Thu,  7 Apr 2022 01:34:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A93533201D51;
        Thu,  7 Apr 2022 04:34:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Apr 2022 04:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OrAVdtI06jlWzu77P
        ZjIBfUVfDfo5qupQAsNYfVHmic=; b=REyfza793XvLwCmAbyDR3j41ku76wmjj9
        t8ZPCQN8csyCmQMKvB42XV1AmWwt4wNNrxmwPC81RF5b8fAADR0pQalFI8qXYPT0
        7/q14rkEhdtYWx6Ir/coc19eP4KQ2iDLO5MNs9cjC74Tfci0AMnCeGRILehn1Tbg
        zdS1YIVs1JnZtUmSbl0qDXyVGx7RDN2AtppERAi3Ke56NSptXrFZhqEyJaH0jf/o
        R7Q19bQDBPRh9KMpteNmIHQXlpkVdxrVY6aYJfkMqCrUCBayiLSBrdr/ZXf3zR2b
        tu/TkEybMrURbop9YitH5hmy4TK32Gu+HMKnytWHiS9lprsHPdZhg==
X-ME-Sender: <xms:C6JOYtK2DPSocN3KHcYO1iOuhmb_8QucNUitWsEdflBe5SjkWL3z7w>
    <xme:C6JOYpKfOENfQGi6p5TQEf0B56wNDQN0OEWecppa37hMLlUM4UeTRwUsN7v5_uWR_
    gdivHGWAWTeZwKzFeM>
X-ME-Received: <xmr:C6JOYlt1cSyCTnjfVsxU4pZWO98PYUdKI639jzGKmXtOWFI39-wzOshV4dfyZO2-z4mumNSVWnPG-KabALraSf6EYOe47AA-Ns0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:C6JOYuYlhjomGYyc5L-B0gj8YiRk3ocqfwcnhRXyBdTdBjBsqf4E2Q>
    <xmx:C6JOYkaLdhGJWMS4ZendpX0uu_pT9copGfWauEd59dUXQNsKrfWXUA>
    <xmx:C6JOYiDNCIq3SX3-pZu8JnT1DvO4ImNd48uhrFtgNYCkYCD6b3A6Qg>
    <xmx:DKJOYhL6uTbYkgTwgpQB8D8qsnBrmU8mlCw4mwAwA48dlrIgR419LQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Apr 2022 04:34:17 -0400 (EDT)
Date:   Thu, 7 Apr 2022 18:34:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
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
In-Reply-To: <04c0374f-0044-c84d-1820-d743a4061906@physik.fu-berlin.de>
Message-ID: <ca79546d-4e64-b8a-b63a-dfd0ebce8fed@linux-m68k.org>
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com> <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com> <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
 <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net> <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com> <04c0374f-0044-c84d-1820-d743a4061906@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 7 Apr 2022, John Paul Adrian Glaubitz wrote:

> On 4/7/22 09:17, Arnd Bergmann wrote:
> > On Wed, Apr 6, 2022 at 11:25 PM Rob Landley wrote:
> > 
> >> I'm interested in H8300 because it's a tiny architecture (under 6k 
> >> lines total, in 93 files) and thus a good way to see what a minimal 
> >> Linux port looks like. If somebody would like to suggest a different 
> >> one for that...
> > 
> > Anything that is maintained is usually a better example, and it helps 
> > when the code is not old enough to have accumulated a lot of historic 
> > baggage.
> 
> But if it's not a lot of code, would it really accumulate a lot of 
> cruft?
> 

Where you see "TODO" in Documentation/features/*/*/arch-support.txt it may 
mean that an architecture is preventing the removal of an old API.

You're quite right, though, it is incorrect to call this an "accumulation" 
of baggage. It is actually the failure to remove cruft. (OTOH, shiny new 
things can be said to "accumulate". That's how cruft gets made.)
