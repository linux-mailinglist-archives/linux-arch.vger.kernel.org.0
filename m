Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14673A461
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFVPK6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFVPK5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 11:10:57 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B7E9;
        Thu, 22 Jun 2023 08:10:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A09673200906;
        Thu, 22 Jun 2023 11:10:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687446655; x=1687533055; bh=kS
        XI+uQYHYT8Q1kKiqztNgYBfy24UhpC3AiD8ORZzxM=; b=se6zjqV6CdQJdKuGhf
        faZk9MDhVtJffoT2bC4EQ2cFwn1svcGmJCCPihk13VJO2trC7X6O0NZqjCSVAIaA
        QUfrPFKcPM988sd8PlRydcH5cimUwqNLOkmH9a5CrjGOHeAgQ4S2jjWyCK/i/qWQ
        oV0NjaydskKaEd2vzC1oqCg8RFG5ArRNIujo73mhhlfVkej2BWaY+urKLKoFpSeI
        HTJePBf60nkXcmY8G/BzaeIuyPTUWrucidj6xLEqovC8ClXyHtRVHN4RcmFj0uK6
        1ASngYo+cq8UzhlD/fBj2qMsRMj3S5YOge2Viw0R6uPMSM4KbRLfy1uzpMB9KHYb
        la1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687446655; x=1687533055; bh=kSXI+uQYHYT8Q
        1kKiqztNgYBfy24UhpC3AiD8ORZzxM=; b=Lt++QUV810u20rxuZGi6AZYNz+5/S
        VTW5LnfFNJ9CxuFK31wEjel0AJSqU7noxBK9mo+FyTNtZuXzFStU4Yd+yPsQZLqH
        fPcd1hSdn2Oh2hGfp3pOUFMQTwuLJ2H+mdfMuhaWbXUeo5Whmc2+Zt4de0FALiym
        0BFpphQJeF2sb9DhBjC3bcZMuVorI9bE1t/mjZfq1TT6W7AdskPahE4FLjoI57Hu
        Aqn+UT7mRRuJ/uWI8X+eaMP5hhQnK9Fz5M2ykSJTe339Kmwp5zlkPTYZK1hUl4Jm
        0i7FC/PYcLZWi5QWnUy2IBHH7z2ihxeMLlWOz3EK2hYZ5b0qSuE3WET4A==
X-ME-Sender: <xms:fmSUZBrjTesmxWlKOcnFidiiblDaY9b1NJjjqG3CnFFmZjc28R0l_A>
    <xme:fmSUZDoqIVoU9EFZyTF-d_siHHbPrdf-EXH9jLZnESoUywHOnLYb729Ej0XYRwjEI
    JeuV9aqmB_oFDUovUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fmSUZONu51x9nccl-pi6e1bqti3C_CeyDcpFJyeCymPp1M65ykySlw>
    <xmx:fmSUZM6UUdTzZS05_OiqaGnAhOxQ2NKIQbGle9QUhwsaGGp4VPO1aQ>
    <xmx:fmSUZA40mcA4Qq66bkA4wph7qn9tvt5mOkDc5PV8sxNlSBsy_LZHYw>
    <xmx:f2SUZOQrDZnvq2vVWlyzYquhyDSBjg_4_sscJ0QOP6VvVzLOEs9xKg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C9DC4B60086; Thu, 22 Jun 2023 11:10:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <388c9fbb-2782-4990-b432-eeb999308869@app.fastmail.com>
In-Reply-To: <20230621223600.1348693-1-sohil.mehta@intel.com>
References: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
 <20230621223600.1348693-1-sohil.mehta@intel.com>
Date:   Thu, 22 Jun 2023 17:10:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sohil Mehta" <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] syscalls: Remove file path comments from headers
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

On Thu, Jun 22, 2023, at 00:36, Sohil Mehta wrote:
> Source file locations for syscall definitions can change over a period
> of time. File paths in comments get stale and are hard to maintain long
> term. Also, their usefulness is questionable since it would be easier to
> locate a syscall definition using the SYSCALL_DEFINEx() macro.
>
> Remove all source file path comments from the syscall headers. Also,
> equalize the uneven line spacing (some of which is introduced due to the
> deletions).
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  include/linux/compat.h                  |  82 ++------------
>  include/linux/syscalls.h                | 140 +++---------------------
>  include/uapi/asm-generic/unistd.h       | 129 +++++-----------------
>  kernel/sys_ni.c                         | 110 +------------------
>  tools/include/uapi/asm-generic/unistd.h | 129 +++++-----------------
>  5 files changed, 85 insertions(+), 505 deletions(-)

Applied to the asm-generic tree, thanks!

   Arnd
