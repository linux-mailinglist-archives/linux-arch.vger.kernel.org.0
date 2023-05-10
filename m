Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221ED6FE1F0
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjEJPzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjEJPzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 11:55:08 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40B6EA1;
        Wed, 10 May 2023 08:55:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7102A580906;
        Wed, 10 May 2023 11:55:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 10 May 2023 11:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683734104; x=1683741304; bh=SC
        KFLRlOu8wMdidaM2MzVAEF3HdgavF0+zWaNr+e62A=; b=A2W0dNaRkjw2NxKUw2
        y9/WuIWb6k0ZeUb1NuFzsS81Djn7IGJMUkuEFMR7fOflHeNjpOhtvktN1Odc5a0z
        xPeBgoaCSeAf07UyKrt22YgIieCX3VuYjmzsZ7acBcr9Vhsn43rDMIHBy+tup+62
        e+b15zL9TwSOE1pwhAWbOyPIs3zDrZiqpL0xF3vLdAvyOzLuSDBSNUGza0tnoSHo
        GMsx9rsH+NakbnyqBJiDC4rcPPI7eVaCFnr8L802UJnuqWqjK25aunX4hbyjyfUK
        TAeWqnelfG1gYDmfx0Kz6XhPuM40oPbxxV6++qmIkLZLhhFkjR/B8N0W7z0+yWPj
        EhEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683734104; x=1683741304; bh=SCKFLRlOu8wMd
        idaM2MzVAEF3HdgavF0+zWaNr+e62A=; b=eIQYFAE5hZb+cnbQVSJEeeGsDPFhq
        wvSnouTayKkhqt7LWXqhWBFjSVYpoREhn3/6XGgVCsgiUb6sEjigqqvglXS25Pyy
        X8KK1j6AiBuX7bJeATzfhXCIbvweqMnpWjMHFLv6ODWKcvH6eD1oaw/l5FQuDA8J
        8ppL8Q4hETUca4ibTrpNmQ9U9eOdtgSe77XLucvhyxq+bxxWUs/X9wHs2KwYV+0J
        Re8DQdzhPlu/QXxoS/a7Svwl9gcSfF2VIXS6JKfnP6DYDvNYmu863O/WiMzQxNHe
        n/cwLQVAIPwbhFKgrPGUuqey6mWhQOSMQM9kPgIUqsT/4JmMnP/fmlp7Q==
X-ME-Sender: <xms:V75bZI0QCyndvyxZhVbdVguFOeHQt11Pw2iNy0w2g7WiqadNq1Ytlw>
    <xme:V75bZDHWhjp05aUzpFpWCQSYtdCrLKEGuxx9zSEVIglAQacPOJCHfurShIToWBue-
    2trSsWy2DhMgrv4E4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepveevgeegffejueeiudehfefhhefgudejteejleeujeejffeuiedufeevfffh
    hfffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:V75bZA6RZfoG5BTYXRp8gTwgZ97mM-O_9pdcTzrGJBDim0LwUysyjQ>
    <xmx:V75bZB3DXP8AYHeRD6YAVpZW_OGrMUKEYOBMBP0JZqlkMzywaXOVyA>
    <xmx:V75bZLHlylKFiZVp5FEdY30IJbVOcNVUqvyVlYjqsg3FINwqU_kuyw>
    <xmx:WL5bZE11XKy2XwogTzJ8hN3VFODqmdERBDmO_-kO_jNl7o2u12Ii7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BCEFB60086; Wed, 10 May 2023 11:55:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
In-Reply-To: <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
References: <20230510110557.14343-6-tzimmermann@suse.de>
 <202305102136.eMjTSPwH-lkp@intel.com>
 <f6b2d541-d235-4e98-afcc-9137fb8afa35@app.fastmail.com>
 <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
Date:   Wed, 10 May 2023 17:54:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "kernel test robot" <lkp@intel.com>,
        "Helge Deller" <deller@gmx.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, suijingfeng@loongson.cn
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 10, 2023, at 16:27, Thomas Zimmermann wrote:
> Am 10.05.23 um 16:15 schrieb Arnd Bergmann:
>> On Wed, May 10, 2023, at 16:03, kernel test robot wrote:
 
>> I think that's a preexisting bug and I have no idea what the
>> correct solution is. Looking for HD64461 shows it being used
>> both with inw/outw and readw/writew, so there is no way to have
>> the correct type. The sh __raw_readw() definition hides this bug,
>> but that is a problem with arch/sh and it probably hides others
>> as well.
>
> The constant HD64461_IOBASE is defined as integer at
>
> 
> https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/hd64461.h#L17
>
> but fb_readw() expects a volatile-void pointer. I guess we could add a 
> cast somewhere to silence the problem. In the current upstream code, 
> that appears to be done by sh's __raw_readw() internally:
>
> 
> https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L35

Sure, that would make it build again, but that still doesn't make the
code correct, since it's completely unclear what base address the
HD64461_IOBASE is relative to. The hp6xx platform code only passes it
through inw()/outw(), which take an offset relative to sh_io_port_base,
but that is not initialized on hp6xx. I tried to find in the history
when it broke, apparently that was in 2007 commit 34a780a0afeb ("sh:
hp6xx pata_platform support."), which removed the custom inw/outw
implementations.

      Arnd
