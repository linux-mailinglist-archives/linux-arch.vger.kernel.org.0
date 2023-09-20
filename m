Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9D7A77B0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjITJhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Sep 2023 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjITJhK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Sep 2023 05:37:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7ECF;
        Wed, 20 Sep 2023 02:37:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D77E6320034E;
        Wed, 20 Sep 2023 05:37:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 20 Sep 2023 05:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695202621; x=1695289021; bh=JN
        1ZzaiwVFExq/3/5UGUuW9E0CnaSmXvojZmxi01Kcc=; b=Pm8O1gOEIViOo1Budb
        3EuwADD286hOxA3J0GYhoMDrkIH2t+PFfEvg0aXIhz0gunW1x4kkTzPTdL6SYqwP
        51VKokd80Hj0RKh5FRGxLiBRHUzF9obSnYMI9afTQHdZ1rTx4fisINLeMvhCevFd
        Bj8hrQ7WU4yFBfMYTG8mPuf/f7xJpGFXIszmhFNUvkuQN9ZqWeIcnQzxlMusZEUJ
        bk9Hmaio42ziipwIOrrQ8eV45RBWqhlD8mJVj2SEcSsnmMrInFbhuUGxsXWfWw8e
        v6/Fy91qyfbQJaZ8SBcAC88Oj4dTC5X+ZfBwcUZ/E/ATPWljbBKmwdAY+G9nhfgm
        tVPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695202621; x=1695289021; bh=JN1ZzaiwVFExq
        /3/5UGUuW9E0CnaSmXvojZmxi01Kcc=; b=oTLvY1yG2kMqEXf+HxPvuLCeLFu2a
        yc7o2PutX7FVP+lscX+cfS/PXM4eaUK4e0tOpFtx7QeQ3xBfgEZY+Ld0bSFQlKUm
        7pWSMhxBJGuFH161aX1ClZtZfOuohRiYr0D05oEyaO5CGJfNw91UhzmngSsmGccX
        70O7NCkbEpnCUFi1QUkbNbHX7cUQeCE9aQkF6+VrYJIu7CowvpblQkkIP54GteUS
        rXnSxAxt7/L0ReZMCDvZmbo/dEayKb6f/cq0HA49K1BFEi8D8cZW5BKmU04V3McE
        BqPA/P5oypt8f0hu3unvgt0vtaIXK2BRC8a3oJKSnkmzHm/2Vm83ywBUQ==
X-ME-Sender: <xms:PL0KZb6lhtH46k9GGSDj5yk3j3mZCRrBS_Y1L90S1ZtH339ksLcHiw>
    <xme:PL0KZQ5iWwZ1otcgXt1LERwxEL9Pnw5fYYFBdfbcKEZGIAuEoxrteY-4aE83qCFLt
    r0ChJoV6Gf7daf8cFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PL0KZSesSU9ywtQ-tngRXbTJzPcxuA5Y4tWyJOpAnBc3oR4QgLSlUQ>
    <xmx:PL0KZcLC4L0R3ZVR_u8sCugVuSFd1G8xcy7oRTLxNHilU6r7CSCTZA>
    <xmx:PL0KZfL8yMrsJ4QfdwTs9P7QEPSw5txNRgGXNKJysQ6QXmT5ii8DIQ>
    <xmx:Pb0KZZBQfFXY91QZ2moim8ARvgr9ZxEf03fqNy_kz4cHxc8rreKIhQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14CB2B60089; Wed, 20 Sep 2023 05:37:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <e43c9fb0-1869-4328-a984-33b35caf58ba@app.fastmail.com>
In-Reply-To: <20230919230909.530174-2-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
 <20230919230909.530174-2-gregory.price@memverge.com>
Date:   Wed, 20 Sep 2023 05:36:39 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, x86@kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [RFC v2 1/5] mm/migrate: fix do_pages_move for compat pointers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023, at 19:09, Gregory Price wrote:
> do_pages_move does not handle compat pointers for the page list.
> correctly.  Add in_compat_syscall check and appropriate get_user
> fetch when iterating the page list.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>

Looks correct to me, thanks for fixing it!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

You can also blame me for breaking it in the first place

Fixes: 5b1b561ba73c ("mm: simplify compat_sys_move_pages")

      Arnd
