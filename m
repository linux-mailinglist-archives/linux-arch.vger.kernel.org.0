Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9074273E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjF2NWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjF2NWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 09:22:05 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A52707;
        Thu, 29 Jun 2023 06:22:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id D62232B00081;
        Thu, 29 Jun 2023 09:22:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688044920; x=1688052120; bh=sQ
        O+tpzU86Ruad95sakzckO3PnIV53aaJirVNNGwiuo=; b=4uqnQG/Z1UuyNyyAek
        0XEemltl5YoKfbuyK7idzOfGbk2sj8tW5sPhftwy7vAcMTe/lNT1CqLxPHHTqxXl
        b+N4aIXSme583rtEDLHRQQE5RZfTFsD+lTdYY9RefCbOfAlhciUTlKT5u2JXw4I4
        ztOXsWSrHvNADHnJ68PH1ClsbIkWEIcWMVseJvPUcBCt/bCpX9x+rZSZZO6oAAQb
        x9SWYdHJXxBC2SICSWUYB8JczQyliaPFo8FiWTtVLKrXWw/KnLs9i/+IAnqxZm8k
        yqkPPTEwfMl+/IelpxRjc4jeyf7SfLboZoIPnpuMmrGUGm6Jvxy4MC7RByrwgGdC
        yACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688044920; x=1688052120; bh=sQO+tpzU86Rua
        d95sakzckO3PnIV53aaJirVNNGwiuo=; b=IbgfMem7uDuQxpPEGhflBncHobvLW
        vpdJgB9HlfrxSWZohr0Jpjmu+TTjCXIaQB0uQ+13MlfVT0itNPNX4vwmIqNieKC6
        gPv4iflQLslU6lXHYDAvAm799+KHkiXlvXfZM777AHY2iwxEls+3U9z2bO1yeOef
        wFpfTxWZmsHuvogMZSyJmnFyjemy8yi74cXqbPUy2ZTBAZ4KqNqWtoYlOjGYmlQy
        PMPbNhtV1XvXdYg2lSN5WBQIEaNfObSZgMdkW8nfVQEunQCLpApHo/cwzRobpAQN
        ZuHALvp9USqwqc7dcNooNTZaYpKwAFukGjJYFDScEYkfK4BGpwxbvs5wA==
X-ME-Sender: <xms:eIWdZK2mhUMZoeD5ScJng_-Mw9sdRxOEu_Lgqc28dk7bZK70NYedTw>
    <xme:eIWdZNGBGclYv6j7-IGwscmhWxPIRk4Bebhe_u_lemBUmyA0MfekuVd4tn5XkkmLX
    tzaa5AupcGn4LfNDF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:eIWdZC5kimzqKYQ1BPs7CvQbOgpGEss3M0RxRwWrIroNsq9V3om0TA>
    <xmx:eIWdZL1nORBRiFJwbEufwbgzn_wdP_V0r9RSWhxWObhMpewEM8zlHA>
    <xmx:eIWdZNG9JECFzRVSW1lGw4WP0yMQisPFaCR0eAsEec1IlVvAdRAh7Q>
    <xmx:eIWdZPlLPgVMB-Zms1gBZ7XMicph5Ie9iaKcHZPRTF7XioY1Fsly84JuoI4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F305FB60086; Thu, 29 Jun 2023 09:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
In-Reply-To: <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
Date:   Thu, 29 Jun 2023 15:21:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>, "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
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

On Thu, Jun 29, 2023, at 15:01, Thomas Zimmermann wrote:
> Am 29.06.23 um 14:35 schrieb Arnd Bergmann:
>> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>>> The global variable edid_info contains the firmware's EDID information
>>> as an extension to the regular screen_info on x86. Therefore move it to
>>> <asm/screen_info.h>.
>>>
>>> Add the Kconfig token ARCH_HAS_EDID_INFO to guard against access on
>>> architectures that don't provide edid_info. Select it on x86.
>> 
>> I'm not sure we need another symbol in addition to
>> CONFIG_FIRMWARE_EDID. Since all the code behind that
>> existing symbol is also x86 specific, would it be enough
>> to just add either 'depends on X86' or 'depends on X86 ||
>> COMPILE_TEST' there?
>
> FIRMWARE_EDID is a user-selectable feature, while ARCH_HAS_EDID_INFO 
> announces an architecture feature. They do different things.

I still have trouble seeing the difference.

> Right now, ARCH_HAS_EDID_INFO only works on the old BIOS-based VESA 
> systems. In the future, I want to add support for EDID data from EFI and 
> OF as well. It would be stored in edid_info. I assume that the new 
> symbol will become useful then.

I don't see why an OF based system would have the same limitation
as legacy BIOS with supporting only a single monitor, if we need
to have a generic representation of EDID data in DT, that would
probably be in a per device property anyway.

I suppose you could use FIRMWARE_EDID on EFI or OF systems without
the need for a global edid_info structure, but that would not
share any code with the current fb_firmware_edid() function.

     Arnd
