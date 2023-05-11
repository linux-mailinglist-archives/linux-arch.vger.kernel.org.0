Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFA6FEC42
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjEKHFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 03:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbjEKHFq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 03:05:46 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D47A81;
        Thu, 11 May 2023 00:05:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id BAB925802DF;
        Thu, 11 May 2023 03:04:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 11 May 2023 03:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683788699; x=1683795899; bh=jq
        n9+i6S4uqktD4A+W4DhCnytpnr+GsOBOt4qhEN0dg=; b=VWXFys/0BV6m5RpZl2
        THPKXeF4YwHBhmXGHtHdIdnvjgDSIkVaQiJODFgiAPc6l5ALQz6E1fsfw32O/PsQ
        Bjk+gtazbYhFvNTmKslA+aFPzOW+HvaQwWgGV7Na81W2yU1L9NnA2fg3WeMXz5GE
        seZASc3hhKXbYSxv6BT00t4r5/jFufhxtUqnoyoM5fYQyu+iVj8XHbFVJX64byjq
        X8M78d5TZi4FoEjvjWM2+Yjxc5p1KvKkvnFT5I+nby5e/OvMn0j3dy5hHF6jwP1B
        WL9/ZS/4j9Evjonx35W4rZQP3CZS0VRTQE9LK5pSVKPmpajZqYawAxnBGYZJcaow
        rlyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683788699; x=1683795899; bh=jqn9+i6S4uqkt
        D4A+W4DhCnytpnr+GsOBOt4qhEN0dg=; b=WQV9C5RAcekZyjyo8xQuUDMSKPBcY
        lnbfOsB99ZwjDrX/avO6/64hJ07wRRy8asTMoAKht5Urd8CwUSv01sBXRoYk1YkO
        hJ9L5X9LWOshcTwUqt1dAKQGXHQ/VIUZaBvXt4uYksyjKQhGEL1UnmoQYxwNZTXE
        AcpPd+6kgB+AsxEpB3TMneh9RB90w1AwzVNkf4uNd+/sn/PKZus8T8lb55Cba6iX
        v0pISulFuCDCHfbzIbQAd7FrOIOh2QwFWiSbA6qGO84EVcbXRHj5m3P5yvClkjOw
        jsNeUuXoCisohtsWIuNct7oH+Ek6wgaiB9J4sCYoLQH1FK2GhWVigTe6g==
X-ME-Sender: <xms:mZNcZMUVOPS4KvcrRFNAUSa7IhpzQkn3-W3hyAEcPGpjW6pJ8ZQctQ>
    <xme:mZNcZAlfAo8XRJjQBaLVMGz0HL8UQpYnJl5dNRBxac6llOmbhPzHdgXWj6mjLJvW4
    KxSpT7vo52hd1yTgto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mZNcZAblEGdGOum33TRaQz934Sm_cmG_AI3VZKduIfaYNrprT_rPsw>
    <xmx:mZNcZLVTYKpBRbcCBg5nj9ItxXjR4zYy3HG8RCbl6-xzXtwc279zkw>
    <xmx:mZNcZGkGWHPsPEaCdU8I9oPufVmlwrerXOSIA-mLSRWqjLYl3av57Q>
    <xmx:m5NcZAtSj8fgu7jGjAdf6t_duFJ2eK_SSZv24q6pAyzIgRcskr8CYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F8D1B60086; Thu, 11 May 2023 03:04:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <0d8e2503-5d4f-4b60-84ff-01a23bcf557f@app.fastmail.com>
In-Reply-To: <20230510195806.2902878-1-nphamcs@gmail.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
Date:   Thu, 11 May 2023 09:04:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nhat Pham" <nphamcs@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, Linux-Arch <linux-arch@vger.kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, "Sven Schnelle" <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>, chris@zankel.net,
        "Max Filippov" <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
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

On Wed, May 10, 2023, at 21:58, Nhat Pham wrote:
> cachestat is previously only wired in for x86 (and architectures using
> the generic unistd.h table):
>
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
>
> This patch wires cachestat in for all the other architectures.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

The changes you did here look good, but you missed one
file that has never been converted to the syscall.tbl format:
arch/arm64/include/asm/unistd32.h along with the __NR_compat_syscalls
definition in arch/arm64/include/asm/unistd.h, please add those
as well, and then

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
