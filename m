Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD07C6C6D63
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 17:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCWQZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCWQZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 12:25:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27215F9;
        Thu, 23 Mar 2023 09:25:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 17F065C00D1;
        Thu, 23 Mar 2023 12:25:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 12:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679588735; x=1679675135; bh=qxKKz/kyF1TthF7ot89fFndWn2k6FT/VRNs
        F2VMynU4=; b=T7ajMC4n8Egg4i6pv1PVXwLCLWuIZ6HT0xtDfSh/QE0OEeTs0RY
        UNk9O0+vdmIIqjYYjjz17GDEbUCmj30e/mzNFouK0b0bAXl2aQXTwlCG/uoTurok
        v2rZip8XGC1XTc0YOXrxUG2lLAAnocWYoxkufSpOmVH86UYN/aZYOibTAeX2hQhC
        hi0e3bzbRSttv6EdHBtj+ykn8ZT9dHOhef/Ua5+DoovF1mW34C/PMklrgwPlsaF4
        FoDSKfVuyFjYNcMxnJdEAJSSSf9ibKIAlL7K3Y+naqD1hpDm90S2gD3QcC56PLhm
        LS8Yi84XTZG7M5x2ted7xJJe7rTWlAnwKYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679588735; x=1679675135; bh=qxKKz/kyF1TthF7ot89fFndWn2k6FT/VRNs
        F2VMynU4=; b=Q0vOIsm6Df12ys0R6M6gIUMGuo9llFfTDtiL420+2PWhivw70dO
        lnIXuJUTX082E6J0xXcpTVYXhlIE/xzhDW1P06xuwuXgjTeMe4nda0BKX68/v5ny
        Aeou8FHVSEdwFcXW0MmFG8cLq8LiOA+U3iNp4khqUW0zSKkWIDWadBcBucq15SK/
        E+O3JosIAgkRI4/yGXlzF603p/gBZedrM89TjKVR3Ju3KHZl79vrMMbmBailS9HD
        I2elw1adwG/FM1rukX9MeW07V4VBVTPDgIN/A1GjuB4VgYFwotF1jDWOwsoQ/UqZ
        5nrvy92l0JE1qoyrXEMJylUwu5qbt9IaGIQ==
X-ME-Sender: <xms:fn0cZHFELVcAdJhevtB87iUU843AouiT3MHfgUI7M-l4hxze_JzecA>
    <xme:fn0cZEXG5ScfqPb-U-I72xb0rYKBnyxgpFBkaTCSx-4lYHRUPabnzUIVpOhAvlzwh
    02jDkVDI3tgRfcAsdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fn0cZJLB8wHVti2l62q_wAe6huPY4UYOp7u2VLJ6YioDLhGgyZnB3Q>
    <xmx:fn0cZFEDLigrUXtZfNyUvHFWVKScIYF_Lu_0hM4dLx1NixpagcBr5A>
    <xmx:fn0cZNXzgfv2LrmRvqCkV597p4O-6GQvgFQuH8rFnXw6IxJkFEuy6Q>
    <xmx:f30cZOXObjR-9qIqS96ihHUu3-72ky2n6ouTNk8l4b3ZRvNg1s_zjQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96890B60086; Thu, 23 Mar 2023 12:25:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <c3ad3f6a-39a0-4d33-af11-10593e884917@app.fastmail.com>
In-Reply-To: <CAMuHMdWkV0Ls+hXUB2+2h-2+6s-h5Ufep1BfC--VT27E4Hk=Ng@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com>
 <20230316161442.GV9667@google.com>
 <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
 <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
 <CAMuHMdWkV0Ls+hXUB2+2h-2+6s-h5Ufep1BfC--VT27E4Hk=Ng@mail.gmail.com>
Date:   Thu, 23 Mar 2023 17:25:14 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
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
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023, at 17:11, Geert Uytterhoeven wrote:
> On Thu, Mar 23, 2023 at 2:32=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Thu, Mar 23, 2023, at 13:42, Niklas Schnelle wrote:
>
> Through an immutable branch, else all dependencies have to wait
> for v6.5?

Sure, will do. I suspect that there will still be something
left behind that doesn't make it into 6.4, so the final bit
(dropping broken inb/outb implementations) will have to be
6.5 material anyway, but at least we can aim on getting most
of it into 6.4.

     Arnd
