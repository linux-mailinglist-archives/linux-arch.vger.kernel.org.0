Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CA705552
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEPRrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjEPRru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 13:47:50 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD399EE4;
        Tue, 16 May 2023 10:47:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9F99D581012;
        Tue, 16 May 2023 13:47:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 13:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684259259; x=1684266459; bh=7R
        Tlb4yPLwyEbMekf/kZ3q59ewoUpiiohu1ETmUvaCM=; b=tjSVD2GDDI6vJ83hu2
        J0wG8DQCFOFbtD4wryKKIsm8NrKyYWw9AxEpnAygm+AGD4nEF+j2mlJ4DdXq8T7f
        5QNxCwjCLFwN4LQVkqurLDF0jW1A9Zzz9wuP8KmJ+dOKMC7ySN2l+XD2DB+vAURd
        6HwY0kPm0vBIX61vZDEmsG6v4odA+Wveqknzg8HJe84D9+Q/i7EzXkxjhIOGsu4K
        Bn3sr+SEQpMQKfLLbdVTMEAMgMrfED9RHqZwlTkKYfdLgHhBCfQNds8ESPs0wA5+
        2AzSXtwnhzkb+RBCBVRlsb6shv5c3exsHtDbboEghfnX3UvEDusXCS9pSl0ALX42
        +Xyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684259259; x=1684266459; bh=7RTlb4yPLwyEb
        Mekf/kZ3q59ewoUpiiohu1ETmUvaCM=; b=ciFx69qJrZA7yv8A1zotpocAWV1mM
        DnUP6xkiq9u2k7Phst28yF9pOYB+p24imZJrUwwQF6DaQRUyeCdMCHTN6yVxU/vW
        Zix27X67pchamsczOqs7J0fQmHu0V5swPms3kpa35adfR5aXURViqtvoRoUWTY5a
        VGrXwUFJRCfHN/YuNMUZDl9wn8yBTKr7VBmb16uia+BCMsXDlQJp7yj7UMvHEfiR
        Ebny8zc51oZx4GRbyjokzwqbrXLiBKtObXTWrW3CD5SJCpHHNRnP+f9Dsand+SZT
        dzhYqpvdJUL8oVoDvA2y4v+/D77Af1UZoXejTAWumnmNa1AN9KFpUQmtQ==
X-ME-Sender: <xms:usFjZCA3j9sz5nEwWZIq3UmHGzVX3xq8hC-A-CyhlzVMMgSHRPetnQ>
    <xme:usFjZMhU9wDkNkUa9Ko0jRxG-mz1cmyQTN0VunBG3IHeRNAXPCCPbQ8JGk1HmTj-P
    f3ZVSWUacwY2BBQoXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevveeggeffjeeuieduheefhfehgfdujeetjeelueejjeffueeiudefveff
    hffhffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u8FjZFkhOy80RxQ2BWUV-rzLx8Zo0OByuLOXpQ4jyTEMZULNY_5y-w>
    <xmx:u8FjZAyVEm27DrMzOgnM0JctyZqlH4gGlGXk57isUu1T4RYHJk6Jhg>
    <xmx:u8FjZHQCJi6yyLlJWVSjFUgZE57E9obBOYfWMJ-aSBO-TYSVuDEPwA>
    <xmx:u8FjZIQ8wbnEjbEjDbQYJgfmKy2oTUwCRajab8gsJFAROe09ddfnLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E6956B60086; Tue, 16 May 2023 13:47:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <0d6d0620-ab14-47ba-90cd-5bce317ac1eb@app.fastmail.com>
In-Reply-To: <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-8-schnelle@linux.ibm.com>
 <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
Date:   Tue, 16 May 2023 19:47:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Dave Airlie" <airlied@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        spice-devel@lists.freedesktop.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>
Subject: Re: [PATCH v4 07/41] drm: handle HAS_IOPORT dependencies
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

On Tue, May 16, 2023, at 19:13, Thomas Zimmermann wrote:
>
> Am 16.05.23 um 13:00 schrieb Niklas Schnelle:
>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them. In the bochs driver there is optional MMIO
>> support detected at runtime, warn if this isn't taken when
>> HAS_IOPORT is not defined.
>> 
>> There is also a direct and hard coded use in cirrus.c which according to
>> the comment is only necessary during resume.  Let's just skip this as
>> for example s390 which doesn't have I/O port support also doesen't
>> support suspend/resume.
>> 
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>>        per-subsystem patches may be applied independently
>> 
>>   drivers/gpu/drm/qxl/Kconfig   |  1 +
>>   drivers/gpu/drm/tiny/bochs.c  | 17 +++++++++++++++++
>>   drivers/gpu/drm/tiny/cirrus.c |  2 ++
>
> There are more invocations in gma500. See[1]
>
> [1] 
> https://elixir.bootlin.com/linux/v6.3/source/drivers/gpu/drm/gma500/cdv_device.c#L30

GMA500 already has "depends on X86", so I don't think
any changes are needed there -- x86 is already highly dependent
on I/O ports for a number of reasons.

     Arnd
