Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC46B971D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCNOCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCNOCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 10:02:17 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54245C67D;
        Tue, 14 Mar 2023 07:02:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 955F52B066D3;
        Tue, 14 Mar 2023 10:02:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 10:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678802525; x=1678809725; bh=WB
        d+C/j8mhtp5c0TjlJPF0SPoxCyIV7iwJxcnNxLZcM=; b=VdWyKhvTv+jdEziETx
        TV6HzY5PNvrm28K8j6ibWmCVeXd0xqM6Psq8BQVnESUXoFhma1kaLgJLY0yBj0ko
        XJ5jABaaZ8OT5VZJEzNEWKw8kDmD19/UtQ6YKjT6Ev/UX8tsDbeSj8jP7YLtcJKM
        TjtRMvU0UqLT8wtSSk+A3TDDBlCBr+VAHjwlNUl+47Wbs3pThzYJrwJK9pzw4BgD
        Wze8nol1pyPQvzr/oJh6K4DQUp+zo5yoAx6SnXFtOZapfOqGCQdoenABzo4Wpgxq
        6fwishU8mAqqDG6Zt7942fANAJeNw4WZuQSCW8UJwNpOEAg992CLDP6HSXg/LQDM
        feYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678802525; x=1678809725; bh=WBd+C/j8mhtp5
        c0TjlJPF0SPoxCyIV7iwJxcnNxLZcM=; b=leiXa8uUtrsDEf7ocWr9zpMIL8y6C
        Y3fT2UdEF+mdYoPhhnHZ0azz4rgHBDQj8TykHxLTIdwIFs8VfmsP9ri1DvisxXoO
        oElyfP042Uyhl30u3E8sq7+iHVkHQ0ihL4vbYJ6AFNOUCMbYJFK4vb93SRLgVclS
        CuQ5tO8xqhwelZ8o4P1GQflIk0ILvwXLNEvwUDr3/cXvYuujr7lZWIrjOZgFbudn
        P5iqr1hhJs8jfCmPfdSWs9z7AaoOEGzzOmDSp/SCbP/dmXLTed2NKLi3nsrWCf3N
        QWmYIDO+YX88MQP6aQYOuF2QAbsJqDyI992Yo3NJS32qf1HBBMi5qk6Lw==
X-ME-Sender: <xms:W34QZKUkdQoiFofWS4wO5wecLFitlY_ndcfd-ILsPPReIIRskgj03w>
    <xme:W34QZGn03tim2vbgsy8RWA4iQN2lI3a6cYbYZ4eYgpbF09wsY4OEoLrTvOb8PawEI
    J1gOf1bgPW07ONDvAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XH4QZOa-sPwA4xCUdN4i0KCJY1TMhvHGXZ3yPxfpgpp83g_vSuon-w>
    <xmx:XH4QZBVYrxeB0UavIeMECCMa0kBgn9G_i2zyAlaTA75261X3DyXOPg>
    <xmx:XH4QZEkja0R9uKoVaitsZuFK6o4KDmq17kT4jDd7GdnlsZixCm9l6g>
    <xmx:XX4QZDfPfGL1xaIKXaXm4G-RdvAtBx9ntyK3bFkg6JPfPmlERZacjdC2n-M>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0465B60086; Tue, 14 Mar 2023 10:02:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <2bdbd094-c16a-43b4-a8ac-c5d8f28cd9aa@app.fastmail.com>
In-Reply-To: <ZBBmqKDh97KexRH9@kernel.org>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-4-schnelle@linux.ibm.com>
 <ZBBmqKDh97KexRH9@kernel.org>
Date:   Tue, 14 Mar 2023 15:01:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Corey Minyard" <minyard@acm.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
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
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 03/38] char: impi, tpm: depend on HAS_IOPORT
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 13:20, Jarkko Sakkinen wrote:
> On Tue, Mar 14, 2023 at 01:11:41PM +0100, Niklas Schnelle wrote:

> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Who should pick this?

All patches in this series depend on patch 1, so either I merge
them all through the asm-generic tree, or I ask Linus to apply just
patch 1 for now, and then each subsystem can pick up their own
patches based on top of that.

    Arnd
