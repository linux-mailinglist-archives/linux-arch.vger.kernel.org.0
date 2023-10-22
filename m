Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB307D2549
	for <lists+linux-arch@lfdr.de>; Sun, 22 Oct 2023 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVSY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Oct 2023 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Oct 2023 14:24:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1BEE;
        Sun, 22 Oct 2023 11:24:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7B5C632004ED;
        Sun, 22 Oct 2023 14:24:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 22 Oct 2023 14:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697999089; x=1698085489; bh=dq
        cmurJHJpbEDznKktmTniWDWxYiu+GAKYZlbCh8gqw=; b=bytpAUQzep9joP4TvJ
        kD+2hGEBzcw/hZTsTTazdK/LsvrVyGHdb0SuFKwSk5zub2SHuJFVZCQ21gvkeyqB
        3ppKBiujU3aOGxtYZFlmE3uxyE7yxtwPtsQRCZXP2J7yTd3cFaSdWrL5renKbFHg
        aUlQG/q85m7z4xXv3nOjQH5q/W1xYPP6BMyLzhNvus1GxAia2UiHDUcEja9E1a9G
        JDYtSc3eq3bo9UHIlAdLC+hpw35+MrCRrwnrDcg2X++lCSJbNDTHgE+VgASrsSgL
        oao3wna9OWbHXEUZbYkATgo1pHE2Wp7o3l/4LPQsWH/Gy42TOJIzZkCPB07a4LMH
        ojmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697999089; x=1698085489; bh=dqcmurJHJpbED
        znKktmTniWDWxYiu+GAKYZlbCh8gqw=; b=VN/AYAXtgU0ZTFj2aauVHVibnL81v
        b3hX37ei2OmxdrwPaMNOQSgMCEzpfHoUEtDWAfXXByWwTQF7LUpHzgKp3Botl0f3
        MzzAn6Or5t8x+hTDeWzHHfhLC78UOsfPrp/QV+9v5YzQUl1d5Gucs4GJXG4G5RgD
        RRHrSJIvVqEBjO8XXp8IZ9FYlTwAd32etOsKr8IJPF4m5+d8C7sJEHXAfaHa1yTN
        +/YhoZTiBfIJP/nnMREetM5tNVKuq2mvifxjYQb7fKjjxGC7AGfErESN814bxWY1
        A5hqw4uv0EIFpHgCc3tt1iJH7qgY0rgfHTXVaA8WjCC/UZ2POl3RWYDTQ==
X-ME-Sender: <xms:8Gg1ZU01ZcCzK4FmlHE3qoSsHkRk2PllygdjG2n-Y2hjxavvkVxeGA>
    <xme:8Gg1ZfH77AlDCplufzxrMTzdtcPqpVRuuP_MjvfPpUNijCYNuZepVAIt-4q6dhGf_
    ICg8VSDjL2PC6jizlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8Gg1Zc4jzlvx_bb9xulfyHWWZC3q43bBn5nbXGZkc9RTVb4ualt2jg>
    <xmx:8Gg1Zd2-uzVbn7kFwXBuPsSP9E8ys2wmbpGnHHfUSg79kiNPY_hIAg>
    <xmx:8Gg1ZXGWamQDRKlSXDY7pZA4ncRhra3RBIs4cEODzHe4voBFM8Cmlw>
    <xmx:8Wg1ZbipnszmIWquuFpy2_o3CZDJGp_-2sxlVUgRHl_e-VXbpzR12A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7FD73B60089; Sun, 22 Oct 2023 14:24:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <3e2a6ec0-43af-455a-a0de-e53c3b94222a@app.fastmail.com>
In-Reply-To: <20231022170613.2072838-2-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
 <20231022170613.2072838-2-masahiroy@kernel.org>
Date:   Sun, 22 Oct 2023 20:24:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 02/10] linux/init: remove __memexit* annotations
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 22, 2023, at 19:06, Masahiro Yamada wrote:
> We have never used __memexit, __memexitdata, or __memexitconst.
>
> These were unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

For asm-generic:
Acked-by: Arnd Bergmann <arnd@arndb.de>
