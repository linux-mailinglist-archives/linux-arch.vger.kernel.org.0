Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550E670BF25
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEVNHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjEVNHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 09:07:05 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C1AC;
        Mon, 22 May 2023 06:07:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id C056C5803A7;
        Mon, 22 May 2023 09:07:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 22 May 2023 09:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684760820; x=1684768020; bh=c9
        3SmvLDeC64L51UuCFxKGnCCgmnVKaRqTKgfxWZ1ys=; b=MLCMKmdR20X7i+uMMB
        p+8Bl8mcfuXsoN9oxkaYz9yJqNc+Uq0a0hGJ+SPuV5ZisOoi/9oUJYzVbdJ5mMsC
        wcn+reG+to+Nl024aZdHjvAndkmYyVIRPEooNtirOnocO6hajNyHYRikw3ONMlrt
        fK6766QSCaEUk8QYm+KF2R6aqV7aIN87uGt3Nm7/oHvpscIAfmp5IpMbBEnQvKbW
        w00+4GyOmUgnjxEjFJ73/VxZO6o/hMYs/o8+cSnBiUlZR0fGyZjbRnttT0Ypgy3U
        53ISsGPqwikreb3ymgPcUWlwUVUj8ut0FteHzMfjygw8SVBXfDv4n//c18zDU3b0
        xlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684760820; x=1684768020; bh=c93SmvLDeC64L
        51UuCFxKGnCCgmnVKaRqTKgfxWZ1ys=; b=ZFevDW2W8S7FjKYvqGFg4RabbRy9j
        D0vDK2N3DUtLciR97xwV9tvExxWzTBevblDXEdxtoh9du0rDBkeyR/Dj0zE6gxkE
        XPETVYrImwtFOAPzuQGAptzZraTnVt48wU8sXo7sGpeN4FAfgmG+nMhZCNYfTyE7
        R5xBtnpMmklQ7JOsMBq9AZ70e1+eiPXjsobjzNHLZPFtrfThVW8gSo6Bi0449djK
        FT9mxoQGUq9Vkjm4POE6SYunF4yNYjxEMJhbLKgY3dH1YTkyKxLnVkyrlJSfjt7m
        LtUi3oGh9+57TywxB4t/XDwnQs+mq7oTUyLsNkCe84yqKEfCAJghKJz8g==
X-ME-Sender: <xms:8mhrZNRjH4YYUGSj8UsLoa6o_P2wl1tPwAzXDAmqbW-ZGJfZCSOsSw>
    <xme:8mhrZGwVdHbY2c8bkLkjqHfMOiNlOk8xrLthGbT51RQqALKqbdw66Adh46jQWpM-D
    opwTdT0ne2-h9232PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8mhrZC1_nBlypOTS2fXYV--cUSR2LKArBobBwRH7JJkoFKOMjMVPbw>
    <xmx:8mhrZFAARAra-R85PT2JOAuNpdOCmec_W7XHCctRVRM_hqyCBtavUA>
    <xmx:8mhrZGjGP12Y9RDUaS2okglSFxGWQ4NatOph0oswfIUBU02iLRsGjA>
    <xmx:9GhrZBj_SK5fBJXEYP7q15nX172iDSohGuTzXFd0Mdriur6iRcn-FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6CA3FB60086; Mon, 22 May 2023 09:06:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <5dcf01e7-4378-4b4c-9751-454b16270c69@app.fastmail.com>
In-Reply-To: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
 <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
Date:   Mon, 22 May 2023 15:06:37 +0200
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
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 22, 2023, at 14:38, Thomas Zimmermann wrote:
> Am 22.05.23 um 12:50 schrieb Niklas Schnelle:

>> There is also a direct and hard coded use in cirrus.c which according to
>> the comment is only necessary during resume.  Let's just skip this as
>> for example s390 which doesn't have I/O port support also doesen't
>> support suspend/resume.
>
> I think we should consider making cirrus depend on HAS_IOPORT. The 
> driver is only for qemu's cirrus emulation, which IIRC can only be 
> enabled for i586. And it has all been deprecated long ago.

I tried it out in arm64 debvm, and both the kernel and Xorg drivers
are detected just fine according to the log. I only get a black
screen, which could be the result of a missing VGA BIOS or the missing
unblank Port I/O in the driver (I doubt the VGA ports are hooked up
on arm64 qemu), but there is a good chance that it's currently
working for someone else.

      Arnd
