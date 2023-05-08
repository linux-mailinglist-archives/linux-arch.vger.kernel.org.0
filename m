Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E245A6FB7DF
	for <lists+linux-arch@lfdr.de>; Mon,  8 May 2023 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjEHUBh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 May 2023 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHUBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 May 2023 16:01:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48635FE;
        Mon,  8 May 2023 13:01:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B08E832001C6;
        Mon,  8 May 2023 16:01:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 08 May 2023 16:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683576089; x=1683662489; bh=QU
        QkTnENhrfBa9ubk2/q4iUrKmZQKHxJLJOAa5BrEmc=; b=jcqrNw6Ykug/YvDA9J
        MOPuq1dJrHSxqM8bpD900hYQW1OCztQnWttlEzgQY1Pc5noZnQT1WlG1E8TiiwsL
        RIsarXKGToA+IqE/i2Sx1209g5EUx2msUf0Cj7hxbXVjM7gs4QiUNLoU+3orQFF8
        sOfMIbi3aq0T8LtjEObwoC/9otJjEdNJokXaWx8CxyZ46kpBOgWZIEmLIin7Zv0y
        mvliNdO2Z6qZunVxOfCAYMJvEJEG+IMS63uBLyrmaOgaBAoB16mLTREj9hmeSguC
        ZGMScbfA4aUGkPt/cnPkatO8yqIZX7+oUDbiBn0iiP3cwYbCOLf3XtFGuhXu401D
        2raA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683576089; x=1683662489; bh=QUQkTnENhrfBa
        9ubk2/q4iUrKmZQKHxJLJOAa5BrEmc=; b=Qbg9VrSZXCOFqoCI16TSXZqEePtj7
        pWR18NFl9sE/iAYJnQ/uB2IsYhmeYF4mIzG+jKPsHQUThW01kN/zNR/mpwi1X/gC
        vauLga0YTsQma7LVeMEodEzYnszYhLeZdSnEDCXKTOYjGWc97dl58+vJal5RM7s4
        6J0G8lqJf4cc+Cyod2eQmaTVIOXe3dthelyf6DPdN9zGh5KpOSNDxkap9lJC5tnE
        BwEYJKfu1rX2+yB81lhhvTEmcPq+B+QTYYltglRKSg4BU73p2Ah0426BIMNi9qNF
        brAuJpyMuTEc8uL5O/uLpKj6f18TIcshG9KTobZBkyz7s9ChWNH87XlmA==
X-ME-Sender: <xms:GFVZZPH62Q4CxnknfZ8ydmbapfj7xFrMQ1FtzhYKpdr39tpjmf21zg>
    <xme:GFVZZMV6ZsbU0mEJ3JwozQQRd-lWNKgS1fMwWcR8_SrgI8-PIAnvIbvdzts6mt79i
    TjlPYoemOYYQpyWxp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefkedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GFVZZBKc64a7QxBJGkw6nl5eMQuW04B4BAxvoSXZrOZlrLsPJ4PB2w>
    <xmx:GFVZZNELBeKG0dPXRH7vaVhuZN9iCHWU_ewo2oGCtKkiwoFZrOQFCA>
    <xmx:GFVZZFWSsyNqkBVrFjpXsKb4V_2DVMCCma_O0cmsZOcsNbvDmTj9XQ>
    <xmx:GVVZZGWz2-XXIEBPHUyMWsi15jDm43yhJyd5W7EB0JI-9lHMPl7lTA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77D63B60086; Mon,  8 May 2023 16:01:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <b7017996-b079-4534-a24a-080003772a66@app.fastmail.com>
In-Reply-To: <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-29-schnelle@linux.ibm.com>
 <202303141252027ef5511a@mail.local>
 <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com>
Date:   Mon, 08 May 2023 22:01:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     "Alessandro Zummo" <a.zummo@towertech.it>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
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

On Mon, May 8, 2023, at 17:36, Niklas Schnelle wrote:
> On Tue, 2023-03-14 at 13:52 +0100, Alexandre Belloni wrote:
>> Hello,
>> 
>> On 14/03/2023 13:12:06+0100, Niklas Schnelle wrote:
>> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> > not being declared. We thus need to add HAS_IOPORT as dependency for
>> > those drivers using them.
>> > 
>> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> > ---
>> >  drivers/rtc/Kconfig | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> > index 5a71579af0a1..20aa77bf0a9f 100644
>> > --- a/drivers/rtc/Kconfig
>> > +++ b/drivers/rtc/Kconfig
>> > @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
>> >  config RTC_DRV_CMOS
>> >  	tristate "PC-style 'CMOS'"
>> >  	depends on X86 || ARM || PPC || MIPS || SPARC64
>> > +	depends on HAS_IOPORT
>> 
>> Did you check that this will not break platforms that doesn't have RTC_PORT defined?
>> > 
>
> From what I can tell the CMOS_READ() macro this driver relies on uses
> some form of inb() style I/O port access in all its definitions. So my
> understanding is that this device is always accessed via I/O ports even
> if the variants differ slightly and would make no sense on a platform
> without any way of accessing I/O ports which is what lack of HAS_IOPORT
> means. From what I can see even without RTC_PORT being defined the
> CMOS_READ is still used. Hope that answers your question?

I think the m68k/atari and mips/dec variants don't necessarily
qualify as PIO, those are really just pointer dereferences, and
they don't use the actual inb/outb functions.

On atari, it looks like HAS_IOPORT may be set if ATARI_ROM_ISA
is, but on dec it's never enabled.

    Arnd
