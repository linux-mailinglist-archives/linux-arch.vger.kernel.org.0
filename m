Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19137A2248
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjIOPZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjIOPZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 11:25:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550CE50;
        Fri, 15 Sep 2023 08:25:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CD585C019B;
        Fri, 15 Sep 2023 11:25:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 15 Sep 2023 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694791520; x=1694877920; bh=Mm
        iG1fFMBZESasl+E/nlKHsDfhZk018GSCCYvSifnsw=; b=usemp1XCinjM9TBLyG
        k0lMNS/iwrIVBAou4JxaNh7dlBSx1guLGUC2br2y7IbGVs2qCSmj/RexUD7sM6X9
        xh4xMkYpZPUA0e1OibhaZ5WjIneBmdVKmiiqcAQJ9/KZwJDct6FvkaYEu/5ZNXYz
        +5d8QF9sPN9WV3IaogdA0GDTJcnSoBIPTNxeVIUTOoPwSlFL7WmSGO1c3OBXG4yx
        MOp01ip0hPfFqr8G0VDsyUlcniU0+vmKZnt5d4PWBAJUXSB1Ck2YWhJAfrcsekxD
        4YeVGjPnpJ2CWqYcnApEzbv4AoPqTip/GLzOADSRIsaUH9dLPiDagucMaRLkBGrZ
        3Ejw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694791520; x=1694877920; bh=MmiG1fFMBZESa
        sl+E/nlKHsDfhZk018GSCCYvSifnsw=; b=F+q12g6PxRXIEalA2SteqQO16wIdz
        1KTqKgNMepLWnEtDxOxoocuZQILTUFqKvTZuHJAMexsABKU/GmgCTqTUTKhfHJ9e
        ezELJb8IJwgxMdXyFgEh0XqJg876KJ4SIeITD99lGnXv8/My09vKdO0aKaiv/5aZ
        0usKCw1S/znF0HpEbECccbb0dntZtvclewI8gaR3sH3GHkN5cRTuAYxMq7Ofsier
        rIiJeGsqzEQJCHCqwplTDHhs7/5PACnj23AVOugAAu9QRJd6nIXP4SXeKnj1IFys
        t/5EfjS9J/EQ5G+57Wyu53Pw7hERnkSJy6UFSF5LivIONIeGKUUgDHS0Q==
X-ME-Sender: <xms:X3cEZVfPnfVqzBs4MdMx_N4U-apzRDOW0bxjcoR0H6GT26KDJOCvxQ>
    <xme:X3cEZTOOozqInY8Pycpw0aluD6XBa95Qm2oD1b2zPVTJT-urTX1oxvJDXgS-oDJ9J
    TE6TVb7iDJF5uYWFlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X3cEZei1yTH0hE3ZBRayXze3I2V6O8oqmR6QpTnTANjqy525pVv9ZQ>
    <xmx:X3cEZe9PFJMhy_0KDhgwHYmnNxOKX8OS8mDrLN_hMiUEOsB1z0b-pg>
    <xmx:X3cEZRuHDg6hg0bkDRoXfg5zVCEU6soW9KvHBMFfbpZvYSVbRBRzFg>
    <xmx:YHcEZbLAKs41Tq1kWSPfLYLMjN-fy7z1fdmVk3R2z4XuCxSXX3oj9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21E73B60089; Fri, 15 Sep 2023 11:25:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <6ae23c62-d2c6-4efa-a989-e04c01288dd7@app.fastmail.com>
In-Reply-To: <20230911163129.3777603-2-ardb@google.com>
References: <20230911163129.3777603-2-ardb@google.com>
Date:   Fri, 15 Sep 2023 17:24:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ard Biesheuvel" <ardb@google.com>
Cc:     linux-ia64@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>
Subject: Re: [GIT PULL] Remove Itanium support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023, at 18:31, Ard Biesheuvel wrote:
> Remove IA-64 architecture support
>
> Fix the IA-64 build before removing the architecture support completely.
> This makes v6.6 LTS the final Linux release with IA-64/Itanium support.
>

Merged now into the asm-generic tree, thanks a lot for getting this done!

     ARnd
