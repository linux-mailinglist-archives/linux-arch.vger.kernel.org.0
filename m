Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05370742854
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjF2O3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF2O3o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 10:29:44 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B03596;
        Thu, 29 Jun 2023 07:29:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 9B6A02B000A4;
        Thu, 29 Jun 2023 10:29:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 10:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688048978; x=1688056178; bh=nG
        nJsyAJyrvJkwnkSe1+RvyafOFNiNiqyHMsPO1u6Xk=; b=2EcylAr+2IQK5P7b6p
        /vjLbGIHf8i+8rzMt8chAuFq+c5T2nXA6rNsTNzOdtksQ6e0sAw9/eRHtOar+WHl
        hAsaWivSScicHRc+IOwIVIkXzMKCHS/A9Ffztx8GB0RJptxk+yUbu3OXBw/f3KTQ
        oPUWqOApNqupZeOxA1+KamV7Y1R9j5wdLjjMttKjfSUmTUPTzRkr/PbCf7BFCJf4
        mDKkwIwEguDSpZs+nb5nQ5ZSuOg9qrQBVpn/A0WtJOxqM4NA4/h3SXbcRbNONYzA
        I5y/p+xe7tbFRUhSHoYPvHtNe3/fi0gTCERIIZJ9/fLQnFzpbVcymrZbyXkaYBBK
        ODIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688048978; x=1688056178; bh=nGnJsyAJyrvJk
        wnkSe1+RvyafOFNiNiqyHMsPO1u6Xk=; b=qcZu2F7J3I03fwrcSPg8dsLuhFIrS
        ucycm657dud2E6uYWskFVqcIfgSe/dBt8fFB6+XQTy/fANN6a1BuztN45oTSanNT
        XxVMQih8LW415rbF6tRZPCXSpwn+ekET+YIRIH1036pYAwUd1Fb1ijQRv3N+j2GN
        AxU6byz7HLauD8dLGeOrAT3BJrYb8oPjklQK9FEAS/EPJOPUSZb+pzy/zrsduOA2
        IVQQiY6wMEEkf+oC5juPiNw0sDEEHj+C7FUzhU16m7yof5koi7/AUsQnx7vi7hIE
        YvfD9R33aPOCag5rTXjki4uvznKy226FqetZdturkKSXU4rXB99QQtsyg==
X-ME-Sender: <xms:UZWdZPQFtBYsPdlXlUSdNixOakdgSk0rQ0sJEW2WMk3NI57JBkFXZA>
    <xme:UZWdZAzd5cSzTnb4-3WR64AVGeqojUQ8_r8RCWCNfeGwQuSKyph38WHIvHfKtGQ9D
    iuBERCaWpz0v8yUOfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UZWdZE0-6IC7fBNDeGBvpnGm2Zr-dhEGRLTF93khPbJEJ5EkVp6Jfw>
    <xmx:UZWdZPAguwQt8yn2qe__L5Yzs-USfTNjeEYazXWLDNvlZmzvvwKQYg>
    <xmx:UZWdZIhqyNx_om12J_mIvSUHmK-q2dXchnc5mILhG3AL8P9Et1GMBA>
    <xmx:UpWdZB0EDG72hkx-t3BFD4YV93ZdrsN0Q1V64IlAbDxvxvOYULKpsP-j2j8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C13A1B60089; Thu, 29 Jun 2023 10:29:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0783a7ec-b779-4033-9877-f6eacc65c575@app.fastmail.com>
In-Reply-To: <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
Date:   Thu, 29 Jun 2023 16:29:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>, "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 29, 2023, at 15:31, Arnd Bergmann wrote:
> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>>
>> Future directions: with the patchset in place, it will become possible
>> to provide screen_info and edid_info only if there are users. Some
>> architectures do this by testing for CONFIG_VT, CONFIG_DUMMY_CONSOLE,
>> etc. A more uniform approach would be nice. We should also attempt
>> to minimize access to the global screen_info as much as possible. To
>> do so, some drivers, such as efifb and vesafb, would require an update.
>> The firmware's EDID data could possibly made available outside of fbdev.
>> For example, the simpledrm and ofdrm drivers could provide such data
>> to userspace compositors.
>
> I suspect that most architectures that provide a screen_info only
> have this in order to compile the framebuffer drivers, and provide
> hardcoded data that does not even reflect any real hardware.
>
> We can probably reduce the number of architectures that do this
> a lot, especially if we get EFI out of the picture.

I tried to have another look at who uses what, and here are
some observations:

- EFIFB and hyperv are the only ones that are relevant on modern
  systmes, and they are only used on systems using EFI, so they
  could use a separate data structure that is defined as part of
  drivers/firmware/efi. This would likely mean we don't have to
  define a separate screen_info for arm64, loongarch, ia64 and
  riscv, and could separate the legacy vgacon/vesafb stuff on
  arm32 from the efi side.

- FB_SIS can likely be marked 'depends on X86' like FB_INTEL,
  it seems to depend on x86 BOOT_VESA_SUPPORT.

- FB_VGA16 is currently support on powerpc and enabled on
  one defconfig (pasemi), which I'm fairly sure is a mistake,
  so this could be made x86 specific as well.

- VGA_CONSOLE has a complicated Kconfig dependency list that
  lists platforms without VGA support but I think this is better
  expressed with a positive list. It looks like csky, hexagon,
  nios2 and xtensa should be excluded here and not provide
  screen_info.

- arm and mips only need to provide screen_info on machines
  with VGA_CONSOLE. On Arm we have a dependency on
  footbridge/integrator/netwinder, while on mips the
  dependency can be added to the platforms that fill
  the info (mips, malta, sibyte, sni).

- DUMMY_CONSOLE only uses screen_info on arm, and this should
  likely be limited to the three obsolete machines that
  support VGACON. Almost all Arm machines use DT these days
  and won't ever fill the screen info dynamically.

      Arnd
