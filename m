Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217EE634535
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiKVUJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 15:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiKVUJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 15:09:37 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0676A84E6;
        Tue, 22 Nov 2022 12:09:33 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C3965C01B2;
        Tue, 22 Nov 2022 15:09:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 15:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669147770; x=1669234170; bh=/1t1FbCpWI
        u7ruZovKPeTw7zgstj/KkekNCrdfNU2Qg=; b=dKwiV6MGSuXUGuu3+/eqSyaq/N
        TnBEHF7lk5aEKtPFZnM1IUwlO2vzaszZgYQr7vGhxmk9dNqbIuasW5Ols4OvQicN
        qmjyc6y+LZ2XkqU6HpkzZLIhYyREolU2psHWpKwZZ9pQIN2FSdRIjNwrVa4jRU+h
        uZWVP3VH2CfH0cNpsKTjVuQ3WenRHtVGgYKpAfZjFYar2KwfwMpNtBgfbnbdWm8W
        S3AU83d10lOty+Zas0Dc1Cn9Ya+5ACybYXEJhSpCcb1JMi2E3fCqJIVrHLfX1JyK
        Ccb6uouUP0sEEZk3FK3wsxi+S5knLOgtI+3RG/f5rGRyg8PWax1wZAHEwSzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669147770; x=1669234170; bh=/1t1FbCpWIu7ruZovKPeTw7zgstj
        /KkekNCrdfNU2Qg=; b=v35EiftiHAMlAFtRxDqT/mOrnk2ldnDdvDsx1t/r2mak
        kDWIDbqPSNYloEo+a7Aa0KkkIhExsHLL9i4InRzsidDHB0kDH+4IYpNisIG0SRon
        HjSXik1hEsUGmSuC1FBt74hlHbKQgNE1kG5KC+s6XIauew/cYnmVww4kJYfkaqNb
        1eY+x0ib4mEsAWVO2lYLdy4IwSCFHI3IRfP8sYh3Rx+IM/8cR4tnXEzg666/xuyN
        pUSgPF8AjRHc7E6Gip9+OGzkv7N8Bk6iVLeMTPjVV/et8oPgvsqwR/z+Cvenw+hp
        VO8dBLAVHkRTEakTxSsiRJ9O/qnQErv3D1C/qESiVQ==
X-ME-Sender: <xms:eCx9Y-uDSeyPd7_zGhf3DTX9NuTz_Ijg0U1y-HM8ByeztS-75jVadA>
    <xme:eCx9YzdpbFaM3fPctf936fhL_tgo-dAMgu5mC8WngwQf7jwoqRd3IIvZPlqhsr4Eo
    8_wQjwVxuaKjmGJAKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eSx9Y5yOxNqC27LUyxV2iBXVUZoyGfAvORuF7S_eH6xQM9WgmwNuUw>
    <xmx:eSx9Y5NMhMI0h2Pdv1A9Q2vs_snNWaNRJNtWzhvM3elmiy4uCzDeTA>
    <xmx:eSx9Y-9w6PykeLLh1lQLOU0gU78twQJhHiWC5ALOOPgzTwbAQON4yQ>
    <xmx:eix9Y-PgSVoJtb1F7TnqqvQ7J9em_h0G__VdIQSyzqHSDz2TXGSaTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E551CB60089; Tue, 22 Nov 2022 15:09:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
In-Reply-To: <20221122195329.252654-4-namit@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
 <20221122195329.252654-4-namit@vmware.com>
Date:   Tue, 22 Nov 2022 21:09:08 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nadav Amit" <nadav.amit@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nadav Amit" <namit@vmware.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
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

On Tue, Nov 22, 2022, at 20:53, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
>
> Functions that are marked as "inline" are currently also not tracable.
> Apparently, this has been done to prevent differences between different
> configs that caused different functions to be tracable on different
> platforms.
>
> Anyhow, this consideration is not very strong, and tying "inline" and
> "notrace" does not seem very beneficial. The "inline" keyword is just a
> hint, and many functions are currently not tracable due to this reason.

The original reason was listed in 93b3cca1ccd3 ("ftrace: Make all
inline tags also include notrace"), which describes

    Commit 5963e317b1e9d2a ("ftrace/x86: Do not change stacks in DEBUG when
    calling lockdep") prevented lockdep calls from the int3 breakpoint handler
    from reseting the stack if a function that was called was in the process
    of being converted for tracing and had a breakpoint on it. The idea is,
    before calling the lockdep code, do a load_idt() to the special IDT that
    kept the breakpoint stack from reseting. This worked well as a quick fix
    for this kernel release, until a certain config caused a lockup in the
    function tracer start up tests.
    
    Investigating it, I found that the load_idt that was used to prevent
    the int3 from changing stacks was itself being traced!

and this sounds like a much stronger reason than what you describe,
and I would expect your change to cause regressions in similar places.

It's possible that the right answer is that the affected functions
should be marked as __always_inline. 

      Arnd
