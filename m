Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE56024AD
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJRGoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJRGoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 02:44:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDEE31DF3;
        Mon, 17 Oct 2022 23:44:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1FC0D320097B;
        Tue, 18 Oct 2022 02:44:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 02:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666075471; x=1666161871; bh=u2SaGnC5yw
        r5cuY3ReRbz6hIRErCTTDk96Lbny/ETMo=; b=L7mmMQG0UCaYJ6FD6sQLwpU9ib
        sZmfLxRZrQnOPJOAt6/ucNIKLQzR81Cns1CrcIToHfGWfJz6PTKbNrgNSxUnE6Iz
        UGyPV568LBmYSogcIST5B/4p8U3kfynaMCOfXcefZzO/fyQh17t62QE/vfgCSApc
        VLkkjsayii21BORI4EAPXy7CFMd/qnOxWT3kq5JWtQdHuPIG+6gXOMq7FD5DOQAy
        7LuQY66QJXNnewnLbNaw0D4mNU4OspUma0/d2tcxtYsdCsnfQzzWWCOMYW3kwic/
        6luSxyGU8LqwjcIPb3XZvXtua/yWV0D5aUlrGA8o0PZDZ+Rp8Pr87kCNjyiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666075471; x=1666161871; bh=u2SaGnC5ywr5cuY3ReRbz6hIRErC
        TTDk96Lbny/ETMo=; b=GHRmO7y+iNJQgMAUGEoQeABp071zUnmBadFqtMKBrnjy
        1/+E0m7eksuWGdrqHIRqgHhIsCV0XOxury7/Tk298pkCHnsdnCRcjH2JbOU0MT46
        oSbVk/t4NuRbhKtrT37XE8KytbX5YmcmAogKnINV8FghnqB0vQB8zvTxZd28c/P/
        VPsqu3G4GyTZpbSJOetGMEB5qnM/urt/fylXZ0k5yLgJOtkQkg6GLtvq9su/ptWX
        gHGYXj785HTF2ep4sU3zXduYG1gHzSVOQqNIhbODGqOIfGrv6WlVf7m9KXdFxM9G
        FziPbzVBDLAWC9MeMuM56Sx35BsJ9aCzqT3Ju+hLJw==
X-ME-Sender: <xms:T0tOY0QKHboqStLgocWZ4bx-NvOaOGliaeUL_32xtwrmD3dnEiA9Dg>
    <xme:T0tOYxyTPAwQwJMAn9DrthrNJASn9s07tVy7RbxwlfIHZKwVlhDxrafaDbej4bJJG
    c1VY-PxCMMOjZs6Rq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:T0tOYx0jJn_nLWkRIhjRpJ-ZOmqa_zNPAFgKEBcwzqQIoiGJdaMSMw>
    <xmx:T0tOY4BtaDD9_SMrI8vMcJhmUxgGljSKl2yM8UaZ53SUGlPrlrOHzw>
    <xmx:T0tOY9hjG52WpcU7GXh_PfY1Pi33fp9YMcCaQ0mFWqocxMpa6PHp7A>
    <xmx:T0tOY8ROiwhfbza7UGDsNoRHqSgpU8dM9LlJO5f6oRlYJbEhLqSWSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40EDCB60089; Tue, 18 Oct 2022 02:44:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <12f51033-1461-43f9-8d8d-cd726fbb4758@app.fastmail.com>
In-Reply-To: <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
Date:   Tue, 18 Oct 2022 08:44:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Akira Yokosawa" <akiyks@gmail.com>,
        "Parav Pandit" <parav@nvidia.com>
Cc:     bagasdotme@gmail.com, "Alan Stern" <stern@rowland.harvard.edu>,
        parri.andrea@gmail.com, "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, boqun.feng@gmail.com,
        "Nicholas Piggin" <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, dlustig@nvidia.com,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for writel()
 example
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 18, 2022, at 3:37 AM, Akira Yokosawa wrote:
> On 2022/10/18 5:55, Arnd Bergmann wrote:
>> On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
>
> "a barrier" can mean "any barrier", which can include a full barrier
> in theory.
>
> So I'd rather make the substituted text read something like:
>
>   Note that, when using writel(), a prior wmb() or weaker is not
>   needed to guarantee that the cache coherent memory writes have
>   completed before writing to the MMIO region.
>
> In my opinion, "or weaker" is redundant for careful readers who are
> well aware of context of this example, but won't do no harm.

I think that would be more confusing than either of the other variants.

Anything weaker than a full "wmb()" probably makes the driver calling
the writel() non-portable, so that is both vague and incorrect.

The current version works because it specifically mentions the correct
barrier to use, while Parav's version works because it doesn't
make any attempt to name the specific barrier and just states that
adding one is a bad idea regardless.

      Arnd
