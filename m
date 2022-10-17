Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4D601AB0
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJQUz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJQUzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 16:55:25 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC876776;
        Mon, 17 Oct 2022 13:55:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8813B5C01E6;
        Mon, 17 Oct 2022 16:55:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 16:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666040122; x=1666126522; bh=+qBFyhMlkS
        abrrW/8a05Q/4iICjjOB6IvZsreneX9MQ=; b=bNvOlCVpzRp/2uZGEkvUxBx7iZ
        eU50zC56oAzMKdyPfOBkLM1ONdt0j2ao2ctXZBwDgrG5kS+YZnGDz+Nm+6FCONnO
        l8lXigm+EqRajvY0YYIRZVofgboZUr6aSdo1zhf7DT1M3Vo7mRQqjgfgi8vSN3Pi
        Wiy1fIcG5tnzQcKgsocVEB86f7jVVgIslrGkwh8hGZ+WYypHKNdNPjPtLpG/V89g
        oGBI+uuOzdgfhFPFGJhDWnxFNZQjLRCePyhvzw/QhaLpNpOeKgAzpTnnkB5eDWa0
        57JhIWRQINgPxXglDvx2i9RHMWLWBZfxl0oX1iIVu3LlnBKbFWPsu5Ah6yIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666040122; x=1666126522; bh=+qBFyhMlkSabrrW/8a05Q/4iICjj
        OB6IvZsreneX9MQ=; b=U6QVu6Zbk9rUuWnTFnnUiT/EfY+n7O+4l3ylSeogS9Lr
        fZ83IbXktouJ41DegoPQ4HU2G8gJt0NgywqKX2hqaGqSHdzSvQUbJbvT1mt6rsfR
        jMGDzxfVpt0KvsZ+3PAktkbuuYHmz/D3UCBaU2cRxSYbLMOpJGAKwljhilLusUGv
        f8B53D9i8+z73IJZjMayu6pB3jsWNcJJxG7JhYriAoWXOIAatCjTw73vbuzTxtA8
        jjCoFn9plBxcYTnQHPQbQa/loEy6+0DJSBo1YDl07rEYNKZCrSKW0o8DDajIO0L8
        UU2OeDtOyahFz8emUhXFLUuKZBdn0C3ZH5tvhbzmSQ==
X-ME-Sender: <xms:OsFNYxTomr2z_mRWZej7qAJhFWOKtF0_BOBMJ5T3_w67u77KOzrN7g>
    <xme:OsFNY6zk3Hny_4690zfcAy90Nh-Rp4E9PIpU_c52ZpoKl13Pz3ZLBZ4jfEWAbShoH
    JKUaEt9BTBauq352sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OsFNY209cEacU_GyxsjM3yqKiq8MvmUktNw-s0okZt-sIBSv2KvyuQ>
    <xmx:OsFNY5CBWUDagNmN9tSFrLcPVKf44iT07MEM32klWEiDUSilbb26hQ>
    <xmx:OsFNY6hOh12A8ZSw9KHcxhSpyHepGe6KnHoN_7X-RJoCZ4RXVfEucA>
    <xmx:OsFNYxQXrni2pYQ1nilqQl2vvqBSqydOVCTBRazaMQ3VO7FEu6zmng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B047B60086; Mon, 17 Oct 2022 16:55:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
In-Reply-To: <20221010101331.29942-1-parav@nvidia.com>
References: <20221010101331.29942-1-parav@nvidia.com>
Date:   Mon, 17 Oct 2022 22:55:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Parav Pandit" <parav@nvidia.com>, bagasdotme@gmail.com,
        "Alan Stern" <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, boqun.feng@gmail.com,
        "Nicholas Piggin" <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>, dlustig@nvidia.com,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for writel()
 example
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> The cited commit describes that when using writel(), explcit wmb()
> is not needed. wmb() is an expensive barrier. writel() uses the needed
> platform specific barrier instead of expensive wmb().
>
> Hence update the example to be more accurate that matches the current
> implementation.
>
> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. 
> MMIO ordering example")
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I have no objections, though I still don't see a real need to change
the wording here.

Acked-by: Arnd Bergmann <arnd@arndb.de>
