Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B36FC307
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjEIJqm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEIJql (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 05:46:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FE171F;
        Tue,  9 May 2023 02:46:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E4128320093C;
        Tue,  9 May 2023 05:46:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 09 May 2023 05:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683625598; x=1683711998; bh=u9SCxQzR1XRkuaK/HGEsP2C84rfrSTM5IbR
        tH9r44/0=; b=xsuYH3zyc+pyQRCICfLBLOEfXjd0W2cbd556J6ykaf1Lhn7og8o
        HkCo9u+lUzW/HlTtp0TOFC2/5dhlwiT5BZTp3CAixxnAdSbG/oYnOVwMb9+GsOJY
        cR2DWaSOspnaNmfkz2IAueXX+EG2RQmdph+jhOa5UYFGvDfJCZBIH+NsgftbjTEB
        oy6he9tSfhL5QTVpznG6K/YUHUTQzQWNEYdEgtJhVCmES7yfPkYB0r2lEqRxnNIg
        NCwRbdmLomfQM3ZrNAOS8cG60pSgnR/YJifjl5V/ZQDXGSZeYAqHAZHl2mRCK8ci
        PGLkWpbEr6Db7QF7KqvJVB3vJDZ9b9QJzVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683625598; x=1683711998; bh=u9SCxQzR1XRkuaK/HGEsP2C84rfrSTM5IbR
        tH9r44/0=; b=PDYTOJ2FeGFHDtds1EECengCf0mZbivbrCJcuIM7cuwh4uFv2bn
        C6yFjmtjzZcvTrgwvqtOftXKTBo/KNrAnVFZO8fbJ/YwkOGH+zzsNLPKrW5VwjLw
        0VJ60On9uPreuwZO5S3mDSECRMTkqVim9ZioscBfhDQHCQ3IlpzpIP1HgnugWymJ
        iz4qXPFCa5oM6eqnmruN0QYlqF21ltcO8tav7hIWrI0Hn0W2rc3SgzB+PkxAULPU
        QTeNnyGb0KSUL2+tD9uDaQHCKiM/4w8vODRRNMrZ89DgHyijCAENiBo9dnz1OKdq
        huytW+qiET6PfShKNYA+HQvT8TLqBBrGNZw==
X-ME-Sender: <xms:fRZaZF3sviVxEUTjAsp7jOIEuHgOE5L_SUAHRK7W6RJgSp9HPajSyQ>
    <xme:fRZaZMFNWG5C_Ssc9kdo1O1mXRAMMMuCxxJjzZbUuek_NQ-zBzUiPmTfimAkzZLOF
    ix1k0FUfto9GOxSvhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fRZaZF7ZwFT0eAW2DlF9XbAwfrQiKZ_qdrPGLG04wlbd0r7IpQm6EQ>
    <xmx:fRZaZC1t8oQXBmIxq3m_b_3PNJj2IZZ9F8Oq04YBIkitGEHXO_f1KQ>
    <xmx:fRZaZIGuDlHcAuT0F5kNcvqCGfsTBQ7eOy9qlIjO_83rpXPXOQ_kUg>
    <xmx:fhZaZGVG-sKlc8heSc9s9z56UwKusDfj-AEn30QNvqOjEYXM7kMefQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7DE38B60086; Tue,  9 May 2023 05:46:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <e68c7dab-94a2-4b27-8c06-a788510c236b@app.fastmail.com>
In-Reply-To: <CAMuHMdV-CY_foGPY5PZV=W92rnvSa0X3PTsUoBpzQ6vCNLSzEw@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-29-schnelle@linux.ibm.com>
 <202303141252027ef5511a@mail.local>
 <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com>
 <b7017996-b079-4534-a24a-080003772a66@app.fastmail.com>
 <CAMuHMdXJ=hsB=A_umQnPMVSU+BGqeHt3O-2ygr3p_f7pHHvf=Q@mail.gmail.com>
 <552c51fb-41b2-430b-b13c-0e578098dbf6@app.fastmail.com>
 <CAMuHMdV-CY_foGPY5PZV=W92rnvSa0X3PTsUoBpzQ6vCNLSzEw@mail.gmail.com>
Date:   Tue, 09 May 2023 11:46:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-rtc@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 9, 2023, at 10:51, Geert Uytterhoeven wrote:
> On Tue, May 9, 2023 at 10:23=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Tue, May 9, 2023, at 08:38, Geert Uytterhoeven wrote:
>> If you ever want to revisit this, I suspect the harder part here
>> is to detach arch/m68k/ from the RTC_DRV_GENERIC code first, pushing
>> the device registration into the individual machine specific time.c
>> code. It's probably not even worth trying to share the rtc-cmos
>> driver, but it might be useful to share the library code like
>> RTC_DRV_ALPHA does.
>
> Arch/m68k is not that entangled with RTC_DRV_GENERIC, as amiga_defconf=
ig
> does not enable it, but enables CONFIG_RTC_DRV_MSM6242 and
> CONFIG_RTC_DRV_RP5C01 instead.

Ah, I see now, I misremembered this part. The only bit that
is shared on m68k is the mach_hwclk() function that is used
for either read_persistent_clock64() or rtc_generic on platforms
that have one. So any platform could indeed be converted from
mach_hwclk() to a custom rtc driver without affecting the others.

    Arnd
