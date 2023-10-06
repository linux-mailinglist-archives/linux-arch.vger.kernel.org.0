Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15967BC05F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjJFUb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJFUb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 16:31:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85DBE;
        Fri,  6 Oct 2023 13:31:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 12AB15C029C;
        Fri,  6 Oct 2023 16:31:26 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 16:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696624286; x=1696710686; bh=TE
        jfaMeYHcib8Xw0tECSLaDw+nvGzaQ8DdiMNTVke70=; b=TLtPOzqexax31+DnSL
        B/Lk0GlMM5k6sqRrypQy7hStmK82R6yHWbeITuagK68z/q7DXcvNB+BZZ67nOOoF
        ZrFS9wjmjR/dksz4m1Nb6QSfiESg+fRh6S/QNtM5dJ1LRvCKn+mm3vO6s6T10c04
        HrTgKkVQhz2O0cqmNOGRtHmNcc+xs440zX48L5PPYKkmVBdH8NYEQOrqPWLJwR7v
        u+/J/YSDgokd1H28pf/U/Fso5q65MHOCp5gBNzoNMXuz0/1yNvqRbB/X6s2ApV+y
        KRPxz/EIM9luIj6G6YbTIIj3LHx4VAlL6QRU8VH6OxPr3kblV2avBUA2i4wDPXgZ
        NTbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696624286; x=1696710686; bh=TEjfaMeYHcib8
        Xw0tECSLaDw+nvGzaQ8DdiMNTVke70=; b=QO/duo7w4ZwBzpw/I0MQ01HbQ0zBn
        2PTVqzUaQDnF1kEPh/NbDWVW9QrW+cSCw4PHVL6QHtDP4QBvtVhJ8suHc6P9F4eo
        /CUnOB+jtq2u4HmR6bfn+D4jQB/ppBpo6+6nQ4QpBPvpx4kTzK3rIursoBwyqD4u
        DOmZadk6JVd6hAM8m4BJclN6r4xdsLuS4Ds+TsrhZfCcvWg4VUE53EznF9Uj0GWV
        hS1qOdb5u5r27vZX2l1mGAso/LufEkJ15EZCP52mawAs0nYSeabG8AV1DZRgkuA1
        NCSmteNu4jn2TPq0ZI0plyKzmG/MV2uHPL1a1erYw/H4iHD3oB2VAIdqQ==
X-ME-Sender: <xms:nW4gZcvUkuwS5KgX6wiFM_6-djJTAnRamidJ9We1iO38C24P_NPeIQ>
    <xme:nW4gZZcYzSI4U0OsH_z6_kcHjjZNzgK2FNCoNLy7KnenHyaboahVxc2ApWXSotd4A
    DGOV9DKY_p4Qd2BFuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nW4gZXx6_6nqaoGuZeJs_GRfeZWor0dKttAi-ombTkShtXScK7ca1Q>
    <xmx:nW4gZfP6BaGfP5QvR3ExECYzCf2a3lpzuyGEKHNlldhm1qgcm1ojJA>
    <xmx:nW4gZc_vST3DiKylMAgomgTEakFKG0rUcRnBVzSNOGBl6GEpyNcb7Q>
    <xmx:nm4gZalRGMa_dbE_ytCnHyHFYMuG2fu9z-lRF7fizcs2dcZObHGWNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88ECA1700089; Fri,  6 Oct 2023 16:31:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <cc43f8c8-5361-4c0f-9402-aa3c45c5f8e6@app.fastmail.com>
In-Reply-To: <ZSAiueycCL067TrJ@smile.fi.intel.com>
References: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
 <ZN+V7P6srKrAelUQ@smile.fi.intel.com>
 <3a5898a1-71b3-7377-cf46-94149e53cbce@infradead.org>
 <ZSAiueycCL067TrJ@smile.fi.intel.com>
Date:   Fri, 06 Oct 2023 22:31:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] asm-generic: Fix spelling of architecture
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

On Fri, Oct 6, 2023, at 17:07, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 04:08:13PM -0700, Randy Dunlap wrote:
>> On 8/18/23 09:01, Andy Shevchenko wrote:
>> > On Mon, Jul 24, 2023 at 04:43:01PM +0300, Andy Shevchenko wrote:
>> >> Fix spelling of "architecture" in the Kbuild file.
>> > 
>> > Any comments?
>> 
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thank you!
>
> Arnd, is it possible to get this applied?
> Or should I use another tree?

Merged for v6.7 now, thanks for the patch.

     Arnd
