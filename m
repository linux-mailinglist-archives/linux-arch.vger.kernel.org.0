Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6417DDE2A
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjKAJJO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjKAJJN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 05:09:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92144102;
        Wed,  1 Nov 2023 02:09:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E2AD5C04BB;
        Wed,  1 Nov 2023 05:09:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 05:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698829743; x=1698916143; bh=DA
        90ThXbn3roskf8cEXmvsaZgr+/qZjSsxxJDx4CL9s=; b=mXtuiYoKEgS8OqIlji
        qCN62pplqqSLpZbenhSrrZ03PmgoG+vJ+HKbiz5tXo+nkEQL0Tt3y+HCEEiBIEoH
        +K0OOoWBVhC7zlwTiUbHZlIQvoNeOyoXP62FnPV97Kq7wyixtTEmEVVP2hiVQsAf
        MzT1Jkc3zrhtO3o0CLGU4vYU3obDnAQazZuW58zInbdz3iSX65b3eKl1bjCGR8kz
        UtLvGvNwQJ/NoSn6aWkXFTtZBP5PdK+0ZFM0X/SzFym/IzwmN76DnxZvkJ8eI3/D
        r0MT3nbrKWzmBwfaO1IpTFc9TMiEsUCEphmmrk7UQvBgsjsMVszk0/Aqx6+84FLg
        TJwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698829743; x=1698916143; bh=DA90ThXbn3ros
        kf8cEXmvsaZgr+/qZjSsxxJDx4CL9s=; b=Qh9afl8P308HQek+iqNSnNSXON3TU
        DW1TxnC5XsAX6fd1kqkIcLKxMjvA0n446X0DPMyyOdb4fydSoO4LvG4LOLurAb9W
        DLhrg6EJwIYvqI3+eNVCwjlDI/Zk007Nqw/3WK49APqTtV+pU5zE/mO0YRWGiZeg
        5n0y1f92PDeAJO5SCJToRfdNqNh5BjjAA1nP3uw12VEB1xGCaufDm9tl/uqbXIBZ
        XnYxNLotOkoG9+xhpGU+0JZKPdGvJmZ5FfZ6SKy0zasKgJF5ZE+gPSsFMEJ0sOod
        JFEENPEieUAJ5lmc52tOyzg9rDMrrTYbG7bFZ2PoGWf47X1cNLtzdHtsw==
X-ME-Sender: <xms:rhVCZTJ1Vfxh1Ex8omFSBlYtk4ncgW29sMbKcmkwDBCgdkesZ5J72w>
    <xme:rhVCZXLuu-ViQaGfqg4mFStXdCDFBV_LwWLyVDyuWCzJGw3SulV0CY9kjtATbu5RH
    tmt9rl0vZV9lORw-Ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:rhVCZbtKt00OhB6SLS738VL_ZbMrX-6YvdOC2O2YIy-A7mIfc4vHmA>
    <xmx:rhVCZcY_dhdI8f6K_fRECPlbk8-ZghfotehphYM_fEImrvGap8jpEw>
    <xmx:rhVCZabPcPWybQoFZ0sTyRwOLnjg7vdhjl06gjOCQlnF7RHNuFqMzQ>
    <xmx:rxVCZZnrS44Y1aQEugaAESa_dfnxX513GROC7mn8rN8Kqfd4L9DKvg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C32ACB60089; Wed,  1 Nov 2023 05:09:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <f548e9e7-e499-4e26-87d9-c45ce69236a1@app.fastmail.com>
In-Reply-To: <82076999-9346-473d-8841-1480cd70b527@app.fastmail.com>
References: <82076999-9346-473d-8841-1480cd70b527@app.fastmail.com>
Date:   Wed, 01 Nov 2023 10:08:42 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Baoquan He" <bhe@redhat.com>
Subject: Re: Overhead of io{read,write}{8,16,32,64} on x86
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 31, 2023, at 22:41, Jiaxun Yang wrote:
> Hi all,
>
> I'm trying to improve Kernel's support of devices that have ioports
> mapped into MMIO, that involves converting existing driver which is
> using {in,out}{l,w,b} to use io{read,write}{8,16,32,64}, so they can
> benefit from ioport_map and pci_iomap.
>
> However, the problem is io{read,write}{8,16,32,64} will incur penalty
> on x86 by introducing extra function calls (they are not inlined) and
> having extra condition judgment on MMIO vs PIO.
>
> x86 folks, do you think this kind of overhead is acceptable? I do think
> most of PCI/ISA drivers will need to be converted.
>
> linux-arch folks, do you think it will be better if we introduce a
> variant of io{read,write}{8,16,32,64} that direct to PIO on x86 but
> remains the same functionality on other architectures?

I think in general there is not much of a problem here since
the inb()/outb() operations themselves are extremely slow already,
in particular the outb() writes are non-posted unlike writeb().

My feeling is that converting to ioread/iowrite is generally a win
for any driver that already needs to support both cases (e.g.
serial-8250) since this can unify the two code paths.

However, for drivers that only support inb()/outb() today, I don't
see a real benefit in converting them from the traditional methods.

Another question is whether we actually want to keep the ISA-only
drivers around. Usually once you look closely, any particular
ISA driver tends to be entirely unused already and can be removed,
aside from a few known devices that are either soldered-down on
motherboards or that have an LPC variant using the same ISA driver.

     Arnd
