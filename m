Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5973CA1C
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jun 2023 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjFXJ2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jun 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFXJ2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2023 05:28:16 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895CE26B0;
        Sat, 24 Jun 2023 02:28:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3DD9B5842D1;
        Sat, 24 Jun 2023 05:28:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 24 Jun 2023 05:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687598885; x=1687606085; bh=qY
        ntvL1gKhXrmWH0tTXfCuX8ddCTc/3rP2W4LxyKhm0=; b=2fzrhKF90cpXdCJJhX
        LNQ5t74+BoUFAWu2Z9oVvwfRP+G2j+kHetfXDo7jXuv6MZjlVNDYMOe5uMBuCdrY
        tfPOeSOrdnMHi5ExY6XX7AWMG7KA6nVtCTrwrLskcwomUPvEud6GLH7At6wunV8T
        1xjw8VbSHv+R4fEe2U3K0VAbm+xpbPHip2N4n+Wjl5qhwQ5ZCL9UOgj1O/Ev3fUz
        wFoNMcX1DQqOGh3VF3wDQoCuthyjHY5xOlhizC1sa5RpiNIFDzQpiYdpxDZoyaus
        Jb8lK1gCGSw8zq5XV56wA5i2aAdBsF5Nj6taOY18hsohd5+dcepsDuWV8vsh6/Bp
        FnCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687598885; x=1687606085; bh=qYntvL1gKhXrm
        WH0tTXfCuX8ddCTc/3rP2W4LxyKhm0=; b=Ss12EnHU4AcwmUdUHarRTM5S6SQng
        s1jzkZTwt45UxEwaoXOe27PqNaIoImQzAcGstwg5plJ41roH3XuppaxR7+klgqAT
        t2qTaZahs2nvwu7r3H1VhEDI35lYik3jAGEsIHR2BPHNrkn6lrob8XsuLvH5a0nS
        3PctpKkR+/0CA0SYvMYr+Yi8zJioA3pDKC07QmhNdD7FSzOplFMmbgKTCxZsf7qJ
        UiCtm5Hf06e/mrw5KEp0RhzySvecvFKrkEIZ3jIqTxjSlYxkPmMjRGDkZYisUHdp
        Ltzzz1MP7nRj6pHsmgact/qcePRWHX8qnnokQvpv2K8E68y0F1jWwV5xw==
X-ME-Sender: <xms:JLeWZFOBFglxl1i5bI3l1p0oN8XlQzdcdm1l_G7s8_E-sM0HZytL4g>
    <xme:JLeWZH--P5FdBTJ_umdmBwIQ3BaF9UxuoF5B2lSO_XD_aJ1GsWYULUTZ9P4U_i4Wt
    0CGKV6DR5IBfrDLmGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JLeWZESOvtN3WRtL4qcbs1TxlvwwnmscUJ664LO5SZIsEeCM99_NTw>
    <xmx:JLeWZBsXh796y04w6P0GVP04uwY_zKhNkC-ozsUZCaW2YmXR9CpM-Q>
    <xmx:JLeWZNfcbt5O64mkJb1sR3C8x8YFQCpWT18ij9tkQXIoWlLXKJHfnQ>
    <xmx:JbeWZOBhhQ4yvPgqPpUS3E42vsWe4WTrrcu1uDU2wkIyXn5yBFMoWw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03220B60086; Sat, 24 Jun 2023 05:28:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <55130a50-d129-4336-99ce-3be4229b1c7d@app.fastmail.com>
In-Reply-To: <c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net>
References: <20230417125651.25126-18-tzimmermann@suse.de>
 <c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net>
Date:   Sat, 24 Jun 2023 11:27:42 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Cc:     "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v3,17/19] arch/sparc: Implement fb_is_primary_device() in source file
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

On Sat, Jun 24, 2023, at 03:55, Guenter Roeck wrote:
>
> On Mon, Apr 17, 2023 at 02:56:49PM +0200, Thomas Zimmermann wrote:
>> Other architectures implment fb_is_primary_device() in a source
>> file. Do the same on sparc. No functional changes, but allows to
>> remove several include statement from <asm/fb.h>.
>> 
>> v2:
>> 	* don't include <asm/prom.h> in header file
>> 
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: "David S. Miller" <davem@davemloft.net>
>
> This patch results (or appears to result) in the following build error
> when trying to build sparc64:allmodconfig.
>
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> WARNING: modpost: drivers/cpufreq/sparc-us2e-cpufreq: section mismatch 
> in reference: cpufreq_us2e_driver+0x20 (section: .data) -> 
> us2e_freq_cpu_init (section: .init.text)
> WARNING: modpost: drivers/cpufreq/sparc-us3-cpufreq: section mismatch 
> in reference: cpufreq_us3_driver+0x20 (section: .data) -> 
> us3_freq_cpu_init (section: .init.text)
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] 
> undefined!

These all look like old bugs that would be trivially fixed if
anyone cared about sparc.

> ERROR: modpost: missing MODULE_LICENSE() in arch/sparc/video/fbdev.o

I checked that there are no callers of fb_is_primary_device()
in built-in code when CONFIG_FB is =m, so adding the MODULE_LICENSE()
and MODULE_DESCRIPTION() tags to the file is the correct fix.

    Arnd
