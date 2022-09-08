Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF585B2134
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiIHOvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiIHOvI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 10:51:08 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A74D4BFC;
        Thu,  8 Sep 2022 07:51:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 060105803A9;
        Thu,  8 Sep 2022 10:51:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662648666; x=1662652266; bh=xPUksezrfQ
        ftp7BCJi4jfaFRFsim1oC+Nm5z/XTwFx4=; b=W8zvVkqSTriTWscLmmhEe374hI
        2yj96Yj14bqtsqKK6plP08lFbZKZRcCFFwZjicui36Fw8gcrWD2avibs7+yRrecF
        BBK5/mA5W8T0v1bTHaCSlRFc1cgZguWoDqOitgFsUmwoNUEm3WdaelV9iBxWBObm
        po7KIaQ8bFhlY5zE2gG/zwTxrLjollxaQKpJUC/PI/Tj8NA0q7QsILUb8Jbmm0M7
        BkHetpt/svfhPFfnHk2xKm53zXxcxPeUzn9Xvhxeja2bxqVSgNufAVfcfyN6SNB5
        x+I7ZcL6/4+dSqZh8uVwRaVD5DBwClw1zvbvDu3SbxRbqUKqIHTsJa8J+imA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662648666; x=1662652266; bh=xPUksezrfQftp7BCJi4jfaFRFsim
        1oC+Nm5z/XTwFx4=; b=0prD3bLmKHrguGQi6sTrt2uU1+uXXdI0p+kAHgFwoPRN
        wQHkJiPGI9sVG5w6uoE4SJbHZGhC5uXJnU1KFmcbyTdT4c+MXd60QAB05qaG0oRT
        ZSHt/5thODtYW1+dQcDdVcWatkNXWlg8h6g/puLo4ErKWBR7R4oI/5AMFfYTFIS+
        VCkKIttBUIb/MFTu7MsChLRiOzUcHlqM4Ver3QaSnl7SYJMxyvpqvAlwR9pc7wnb
        nnsBWpICCgNdugIlYgEX4y21Ejj54SeOhNejKf1sSjwbLLOccXK3/WwfXBnXxRpx
        Bpcpe9I0RFQhxY9Epm5tegbc683Vg1hi8B9isyg60w==
X-ME-Sender: <xms:WQEaYy7FT3dJucbMZMU-ZvPyPj6t3JSi-eS0JOqfd1MZ9JpZGGwP-w>
    <xme:WQEaY75kfGpA9CU4g2BeTBvV1Y9HOOS8AAPNS2vXCT40BBMCuh5T8J6yXNsWYawX5
    tl8YJ2ggEc9KjDInnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WQEaYxfxAbS_WPhEG_s6s7FT6dlCXv9h8VC0irCctQ1RWx8NAFmgaA>
    <xmx:WQEaY_K8hdvV5Su9Hy8S9Xec3HGxfcjT7oX8e4kj8j7bs1lQ-MvV_A>
    <xmx:WQEaY2KjDufffN1YBIo8R1ZC9ZgHjwSJEM_QqMI5-nr2NbB86xLXBA>
    <xmx:WQEaYy00ngNiWX7i_jPCnOBfSqE5pNuzWwdR1eNUByGi2drNzU60PQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8426AB60083; Thu,  8 Sep 2022 10:51:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <7c639355-206f-4682-b12c-9c8258d53537@www.fastmail.com>
In-Reply-To: <20220831195553.129866-1-linus.walleij@linaro.org>
References: <20220831195553.129866-1-linus.walleij@linaro.org>
Date:   Thu, 08 Sep 2022 16:50:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v2] sparc: Fix the generic IO helpers
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

On Wed, Aug 31, 2022, at 9:55 PM, Linus Walleij wrote:
> This enables the Sparc to use <asm-generic/io.h> to fill in the
> missing (undefined) [read|write]sq I/O accessor functions.
>
> This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Sparc64, while being a 64bit platform,
> as of now not yet provide.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.
> Compile-tested on sparc32 and sparc64.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: 
> https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Move defines in proximity of defined functions
> - Test compile also on sparc32

Applied to the asm-generic tree along with the alpha patch now.

    Arnd
