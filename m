Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573507791C3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHKOZY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKOZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:25:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6D119;
        Fri, 11 Aug 2023 07:25:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2C42A3200312;
        Fri, 11 Aug 2023 10:25:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691763918; x=1691850318; bh=5c
        6RTvdTmKWpcq36ZI4/Jll0f5FJRONuVWAOVMcdyZA=; b=NV9GVabCdS4Me4GuXY
        u4nvDRWi7muIxDdC4WfKD3LVTcBujZjALzx7OoBGsH6cvj+6EbeAHY3NxOFbtL6c
        D5MwpkTiWXZBR3x58HoY+9+lPgctHmEe3t8cj5nyfyrKV05cL4zQOVwJQX+BU1oj
        gMsDadPtiL61ADa2oTkz5FpIP/QGVT2sFKFZAeMB7nymNJcrBtuyng24nRQKluLL
        2ZEAVIitBskOZdybpJe4mJSy0orPoEcuukWBszQr9ym8oqxPlYKpdbkelqkKsWkO
        ygJt368WM2qj0H8XMhcBc1/7Yb6zu0hm25HdVkz7+/3BgVyrFnp6KWh1FD+QcQSq
        uR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691763918; x=1691850318; bh=5c6RTvdTmKWpc
        q36ZI4/Jll0f5FJRONuVWAOVMcdyZA=; b=s1GYVQER/Rzbazc07DUVxudjSXFS1
        TBORcO1deWZan21mriSHkG3eeoMURqVU1zN9WxRPHyN2+0+yZLTLmx26eZlu0FVq
        rUFZiACLIL1vqwa48Rnj0SJR9snFDbGN91eUXMOVIUMUQGpIUNdLQSmQQCzdRM7I
        3Sot37b+lh7y2pg74d87ieNYn5vT6uCf6xHW4O3eaCbqc7YdS/RLd8o3CXSzNX2d
        +t2nyFVkjoUAtJY4MdcfeJZ3aD0R2mdnULjP+PZdap8Afq0KtrCEfLX4fRCNflSb
        djFqJo0uaef4hKzUqyw4Jmtt967LtPFkjjGNhPjbjXQtnaU4nQpEvpXow==
X-ME-Sender: <xms:zUTWZIZoCxnrN3vDXYZjQbrevkEuxHeSJlgDt-K0jRm08sDvn9yWXA>
    <xme:zUTWZDYBQsF9NmyJPBlx6KiIef3ncEfNmqEoqmbpbRbLNvOFUSYgdvEPqD9RUJ3sd
    07dYsRJM4AeWMFKpeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zkTWZC9gWX-guaLgP-0S2u1O8ycB6wNHVlyEbi2Ajcx4nh0QeIUImw>
    <xmx:zkTWZCqarzeAigWbMacwOuHQ_9uJ5IgOV6FVfVwkIr5LmXYA6YwQog>
    <xmx:zkTWZDokQkGwpt7J8ECwgZZVG3BxPTPX5Wan1pe8iHc76XR4mUnIwA>
    <xmx:zkTWZPJEplSs-jFwiEc-IQgd84vXGeog79RmANVdQSSGemKFMFIOjg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1834B60089; Fri, 11 Aug 2023 10:25:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <9311a5ee-a859-4601-a8ef-b0f95176327e@app.fastmail.com>
In-Reply-To: <20230811141421.GA3948268@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-2-arnd@kernel.org>
 <20230811141421.GA3948268@dev-arch.thelio-3990X>
Date:   Fri, 11 Aug 2023 16:23:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Guenter Roeck" <linux@roeck-us.net>, "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/9] Kbuild: only pass -fno-inline-functions-called-once for gcc
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023, at 16:14, Nathan Chancellor wrote:
> On Fri, Aug 11, 2023 at 04:03:19PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> clang ignores the -fno-inline-functions-called-once option, but warns
>> when building with -Wignored-optimization-argument enabled:
>> 
>> clang: error: optimization flag '-fno-inline-functions-called-once' is not supported [-Werror,-Wignored-optimization-argument]
>> 
>> Move it back to using cc-option for this one.
>> 
>> Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> How can this even be hit with clang, as CONFIG_DEBUG_SECTION_MISMATCH
> was changed to depend on GCC in the same commit?

Good question, I have not noticed that part, but I'm pretty
sure I keep hitting this issue. I'll drop it from my
series to see if I can reproduce it.

Maybe what happens is that this triggers when changing from
gcc to clang in an output directory, the stake CONFIG_*
symbols are still evaluated while parsing the initial
Makefile but then cause problems.

     Arnd
