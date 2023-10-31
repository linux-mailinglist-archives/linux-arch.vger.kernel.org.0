Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56817DD7D9
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 22:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJaVlv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVlu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 17:41:50 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD338E4;
        Tue, 31 Oct 2023 14:41:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CAF743200AC1;
        Tue, 31 Oct 2023 17:41:46 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 17:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1698788506; x=1698874906; bh=hjsyai0jUrFlQIqxjLWsiIcKE
        WgzJEVZ7XvkZayojBc=; b=wn5F6uE6qga83jtPZKrDEktHeBpkXXGDCOYh+H2iS
        FC/3MeUh/GTPYI8IAcpwxxAoppTdWIwmvRGp03V13uNd2xdxMxplwPy13dhb4AzU
        xJkI0OvRaNBpRPGP6vn9NsdcPwiH8ZmHLHeRs3B/YCArrt6RM+JN3vb+v7rnkU4B
        RdnF837IhyADp5IMp9gJYK9PZyceYI2CfhtWTxHf8Ytew7pZM1r2OmdsCED55kpT
        tYkTcVFFIN/prCTgRKUWouAt3gYJh6ad0TbRw3Y6Gr/Ysm1jAmx7TldaXZ+cii11
        T2c1XxnrWr71mhfY0BiaiRPbYYEJodkETy3Xoh6V9RxBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698788506; x=1698874906; bh=hjsyai0jUrFlQIqxjLWsiIcKEWgzJEVZ7Xv
        kZayojBc=; b=LLaKH0VevwYs1AlR8qViG9amOgqXci46pCbV+zjsbxe4X74pQ3a
        5KpbHQ5+1uesZ4xea/s3DAl4N5dWN9tY6V/H4JeZ7UFnfxXmepiJuNehVBT4JJ5K
        YBPCVWUCGTqJiHTfAmWYrXI2Ww0Rgmd/Kc7x37S1NRAI01SO6j80jyrk/mUkqOrM
        pCtVDGKy55Xh4nIjo9k3j47kCgkVUoNkoXTabzTp93aGOENuFPKEaG1a+OzwFflF
        Pjv9g7n1HzYGKrA0g6O/R7mVc1zTd2ZCLnNSKB6niZtGOvuzquowF8aWAmM5zg3A
        4Wsr2+FREQgXt2Zxe1xR/CcBHVzV09HLiGA==
X-ME-Sender: <xms:mnRBZfdLVmUoBi9lu9vaZJsIbWWim6nZkoYIyEBJcIqK_RkoQqfOgw>
    <xme:mnRBZVNeqC-5B6F64vOYrFWGhFEFCkKTuxyBaJGE54CMiNCqHM6W_OAPQOAzX5Mr4
    AV8c3dOa4uoiJAR-z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvfevufgtsehttd
    ertderredtnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepuefhvdehheegud
    euteefveejtdevledvlefhuefhffffgfehveegffegleeuhffgnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:mnRBZYgTU3XqsyM13Hu02cpnvC6bNHV2NwaAmw1koHHs258qfsUBPg>
    <xmx:mnRBZQ_tLs5ifgZRZo7LObrnVLzZHLqYJfYf43FnfP03HP0v5nTvsw>
    <xmx:mnRBZbstDrv4QRx8eGL5Yu5id5PRkxEiRHHNnnCePvdklcYQEBQMCg>
    <xmx:mnRBZU4XDWl1jadUsUCllTkpTvoreS2SaKf9IwM7l2UNu7X5N_wSiA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1315036A0075; Tue, 31 Oct 2023 17:41:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <82076999-9346-473d-8841-1480cd70b527@app.fastmail.com>
Date:   Tue, 31 Oct 2023 21:41:26 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        bhe@redhat.com
Subject: Overhead of io{read,write}{8,16,32,64} on x86
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

I'm trying to improve Kernel's support of devices that have ioports
mapped into MMIO, that involves converting existing driver which is
using {in,out}{l,w,b} to use io{read,write}{8,16,32,64}, so they can
benefit from ioport_map and pci_iomap.

However, the problem is io{read,write}{8,16,32,64} will incur penalty
on x86 by introducing extra function calls (they are not inlined) and
having extra condition judgment on MMIO vs PIO.

x86 folks, do you think this kind of overhead is acceptable? I do think
most of PCI/ISA drivers will need to be converted.

linux-arch folks, do you think it will be better if we introduce a
variant of io{read,write}{8,16,32,64} that direct to PIO on x86 but
remains the same functionality on other architectures?

Thanks
- Jiaxun
