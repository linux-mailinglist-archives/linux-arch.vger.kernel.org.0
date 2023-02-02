Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F7687974
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 10:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjBBJsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 04:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjBBJsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 04:48:25 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71805268;
        Thu,  2 Feb 2023 01:48:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B34F5C0059;
        Thu,  2 Feb 2023 04:47:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 04:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675331236; x=1675417636; bh=LFC34TAL9j
        tpDQE+UCn/9sUe6pge8viDh79p+DyhgO8=; b=NJY+AHJV/+n+8tmmq4+Tc+KX7d
        BDhHlSWy50bc+7b4Ka8ZsSz5n1BnCsrz5GbzUYFO2JdJCEFboO6okmfBq6pVO/ai
        pLad/FRWb9osPXLM6fBgBKtY5WlHVnX7SitaanTIC/wlqEUpd+jw6V6jSMqGCzKM
        +JVnf3aJ0kLZoMk04MEQBBqD9gEaoAxmi2hLPn3xZ7zOn3mqB4NP2tmTFv78xkZk
        lrQ+Fu5gKnwxktllpvwYws7BCF8jYknZ3iTxH6iRGlenntNXfpCCKf1p/2RBEIkO
        3I8Pj76BYHikSNmB47jgCEqzX9yJtxoBMp6nBvZglp5t5fPXN0/DJlp8nb7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675331236; x=1675417636; bh=LFC34TAL9jtpDQE+UCn/9sUe6pge
        8viDh79p+DyhgO8=; b=QjIxKxoqmL2q359SmbuioNC+3IHi5M7bW64DEsdA+MU0
        9rgNJx+cTTYMSIHP+P+Tsb/YfRivarH3VTSsjxarkwBCkXYYOn/eQO2FvgS6xsvZ
        mg03DDLv/OxBkeRuAyvvT9ydMSsQdfQz7u+gru+qs2j86NNtdOgVJPCxAjZeVOg/
        ybj3ZL3HkaaxfEMZiCiSVo8fEBbLX7EWlJDN9uO4/CnxrvQQ5d45+VIklbOLItZJ
        3zikSxswjH7LViAgxNSWpewb+v1KnogwOTCsLE4prqkPVyq90IsESdm8KTcnqZ4Y
        j8Uzcd3z5mNIj7IIOLWu6wFZ1E8A5MRFXOjEYKDZeA==
X-ME-Sender: <xms:o4bbYxzLhPw7hLtejZEc1RKXRjtdTUtuZIyc6pggt9364cqB8aNF0w>
    <xme:o4bbYxS_y6BlcgBynek21SvxvCOVrUkavcnwkLSkHnOdpaXce22muRqN0GqJ56e5u
    Bps74GQuko2fDbUXQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:o4bbY7WrPPphmReiUgSWAsAcP9vz_uli01d5WXbt7jkPGIQ4PT6czQ>
    <xmx:o4bbYzgm2ZPuDf8IB2LRfZ7u5m7vnhF3qa7jTpylMhD6TWBFKmLHDg>
    <xmx:o4bbYzBarxOFNOoXh1-dz86yntwhoU7CORrIHNwZrZ1UxxDOAHyqRQ>
    <xmx:pIbbY10va1t_-qxKNBI3FQepGoPNaMGoDlpPVa_YPe35V37PLACqVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC923B6044F; Thu,  2 Feb 2023 04:47:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <ccf74ebd-ccc1-4de5-a425-dcde4ac39a8d@app.fastmail.com>
In-Reply-To: <20230202084238.2408516-1-chenhuacai@loongson.cn>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
Date:   Thu, 02 Feb 2023 10:46:56 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
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

On Thu, Feb 2, 2023, at 09:42, Huacai Chen wrote:
> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> configurable.
>
> Not all LoongArch cores support h/w unaligned access, we can use the
> -mstrict-align build parameter to prevent unaligned accesses.
>
> This option is disabled by default to optimise for performance, but you
> can enabled it manually if you want to run kernel on systems without h/w
> unaligned access support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

This feels like it's a way too low-level option, I would not expect
users to be able to answer this correctly.

What I would do instead is to have Kconfig options for specific
CPU implementations and derive the alignment requirements from
that.
 
> +config ARCH_STRICT_ALIGN
> +	bool "Enable -mstrict-align to prevent unaligned accesses"
> +	help
> +	  Not all LoongArch cores support h/w unaligned access, we can use
> +	  -mstrict-align build parameter to prevent unaligned accesses.
> +
> +	  This is disabled by default to optimise for performance, you can
> +	  enabled it manually if you want to run kernel on systems without
> +	  h/w unaligned access support.
> +


There is already a global CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
option, I think you should use that one instead of adding another
one. Setting HAVE_EFFICIENT_UNALIGNED_ACCESS for CPUs that can
do unaligned access will enable some important optimizations in
the network stack and a few other places.

    Arnd
