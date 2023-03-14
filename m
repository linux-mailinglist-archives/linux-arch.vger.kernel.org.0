Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C046B9CE6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCNRUI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCNRT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 13:19:58 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8C86DD7;
        Tue, 14 Mar 2023 10:19:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5818332007F1;
        Tue, 14 Mar 2023 13:19:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678814394; x=1678900794; bh=f2
        kuFxnIY96/eRVz9DcVTAjN6Y4RzO1AJtCfHPZg11c=; b=gfCgeBXFK+Co8QX3Au
        2ahZs7OKsfn08pGOjk7kWyZ6KPNjFmwWw8TZvrHipzxt3WS12t32la5MG/MTIYkF
        ITD8vrZVDCjIgxKSaMF6qgpgVxrJ31xELNL9nElBfI9sjJ9gPusi0gf0PN+zE5LN
        GH+NHFXq0J3v9maToOzX+LJdcas6KklwkRLaYNvu1k4SiIFQ2Ik3Qiw9iXul7yDz
        xnWb3Qw81+qNXKRbT0ww2guSXZ56CxEdh7Ylc8V+QaAuw6IOE+X7ocyOHCBZfHU5
        9Nj4tPueHd/0dGzTQ6ny+qOrOZrLF1Fn+e73buoK2X7UW91GCHzHqU3wtFx3VWOV
        VVkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678814394; x=1678900794; bh=f2kuFxnIY96/e
        RVz9DcVTAjN6Y4RzO1AJtCfHPZg11c=; b=pHIQuao2zCwmjVU642T5/GPfuSdOU
        93ExunLOjQKwwpaeaPgQWkMUauLcxxiimsICl2plbSV3DZP0dVaeuDL0+HmFnWV/
        D0kkvTg1rTVubz5DtEuEj3pgUpmrQsC0M/NP+f5bE6N7z44n6rW7+zc2u5osUzaB
        6Hqbop36P62Plgi1nDJaRS1SbjQWJjueQn5T0eAReSdq9VmEuOZWiROHwI4zpxz8
        Sfcexkx0zyYIfY+8CAS24bKv/Tm6RMbXot97oQjQlRO7f/hZbSjX4cRbhA+uwD4b
        CTxZmHi6tXz7Dxi8FKqVhbL5BnVytTv/Cu7ztNpx1pAgSE6aWZNvGsrpA==
X-ME-Sender: <xms:uqwQZM_cTJ0rHVh63nLQ9cxV7YdvQ4-tQo7JVdad95YY5S9s5eAN8w>
    <xme:uqwQZEsa5mC1Xtzx56GanxhUL-qQSn3fvb-SD1NwXKQISf7PI-BzXZp20D1gWRYDH
    iEIoIBiIcCT8RZC4T8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:uqwQZCDsHDy63kJr1IAzjrUWPkL6XaQd0sI_Cdr0PSzWmeTQdHmhGA>
    <xmx:uqwQZMe12EZZBKd9QBKDgYB8CPiCFC8CLhPqBqgiWur07USVYbaaHQ>
    <xmx:uqwQZBP0TT85yoYJZnDEyRIX_ItdHlYIveggwmf0fqGHMnP4Kr-MQA>
    <xmx:uqwQZFmrl007XzFLKVqWxQyoYY86RubRZPswTwNtqv5G80V7w_Ki_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7B08FB60089; Tue, 14 Mar 2023 13:19:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <3fd94bd7-ab10-4d50-bcb6-7c13a3346d6a@app.fastmail.com>
In-Reply-To: <7f39daad-05b0-46f8-bc89-185b336d8fd4@gmail.com>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
 <20230313175521.GA14404@alpha.franken.de> <ZA/iZHEHaQ2WR+HL@MiWiFi-R3L-srv>
 <20230314153421.GA13322@alpha.franken.de>
 <7f39daad-05b0-46f8-bc89-185b336d8fd4@gmail.com>
Date:   Tue, 14 Mar 2023 18:19:34 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Florian Fainelli" <f.fainelli@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Helge Deller" <deller@gmx.de>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 17:31, Florian Fainelli wrote:
> On 3/14/23 08:34, Thomas Bogendoerfer wrote:
>> On Tue, Mar 14, 2023 at 10:56:36AM +0800, Baoquan He wrote:
>>>> In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
>>>>                   from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
>>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
>>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
>>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
>>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
>>>>                   from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
>>>>                   from /local/tbogendoerfer/korg/linux/init/version.c:17:
>> 
>> already tried it, but it doesn't fix the issue. I've attached the
>> config.
>
> I had attempted a similar approach before as Baoquan did, but met the 
> same build issue as Thomas that was not immediately clear to me why it 
> popped up. I would be curious to see how this can be resolved.

I think this is the result of recursive header inclusion:
spinlock.h includes lockdep.h, but its header guard is already
there from the include chain.

There is probably something in one of the mips asm/*.h headers that
causes this recursion that is not present elsewhere.

I think this should fix it, but is likely to cause another problem elsewhere:

--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -13,8 +13,6 @@
 
 #include <linux/errno.h>
 
-#include <asm/mips-cps.h>
-
 #ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>


    Arnd
