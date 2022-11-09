Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734AE62273A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKIJj2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 04:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKIJj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 04:39:26 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85D2BF9;
        Wed,  9 Nov 2022 01:39:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3B7D73200A3A;
        Wed,  9 Nov 2022 04:39:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 09 Nov 2022 04:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667986759; x=1668073159; bh=NpsmjvsBTz
        hpwQCLdpO9eNf2m8EollUjKMXDHLKCidE=; b=gvF8qv5cqmaHarp/HWp00Re2Uh
        cCJEUlqXB4JCAhzNI8NZqKQAK324f+3zPp7NJuf8sKaau/CKUdotgOyyLhmbx2UP
        MvvwgmnjJIZfexrKabAIcbD7b6Xsfe8KSeSkFfml0uM4St5kaVIQr4HsRKilvivw
        vNOX9HBNRW2aLHBBBv2h9XJXX0R2MA00nx+t/mP/7Zty65i4Q3qlGdR+zJg8AF88
        xWlzPSxvtPQnf/zPTaBTGJAjmOWdZHU+8G08INX2sLFKqeeq5EwyfVrG2NQSBaEE
        saxawtMquuORGmYbAN1k+EPqhi5Cms+hen0nR8eZ/0gb8O8PeNnCIrxdtCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667986759; x=1668073159; bh=NpsmjvsBTzhpwQCLdpO9eNf2m8Eo
        llUjKMXDHLKCidE=; b=DOW7dQzDU+GRSlSpYohLzS/yQkAI4PHCkazTlDAom7cV
        cwgCuUDiGWqxM5QWjY3TCsxTx7fpoHqErfFuCAEM/AeWnziBwZ6WEDteEeMrie4v
        StWjANF4WfuoaHL/1+vBf9Xoh8Q+pT+0SrSzmQRyH0CahLRplXhqGq/CFLoVYx9D
        cgdS5m4A3+JnJjTftt8H8J1I/suZPg4V7oyeYF0alxZ94VVNEkqwsO7zf7vvKUuf
        K4zUVAbjanOOfYS4vAfcCj/msrLRLX64qa8BRCTvbDSEPUmOH6BWk3+fC00J5op3
        L4NTg9ODbnkaK8eWLjnUqVTDrviXIXb56tZJsUbrww==
X-ME-Sender: <xms:R3VrY-UQI3Mrc6VEx5HC4hNYMK_bAM_MY9bi9VcQqDfCS4ZZL-2Uaw>
    <xme:R3VrY6kLLvhyZxovIbmkmCHGIceH3UE-cuAhRv7uekFDNLz87AXTYQwNzEh61b7B0
    Kzv4fGWVHfVBtvB65Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeekhffftdfhgffgtdevtedujefhveetudejudffueevkeetgeevtddvffdvgedv
    leenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghrtgdrihhnfhhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:R3VrYyYlQU9VAov6WKFGCOZeiPZBjyurs2XAGZrrey0BZ8i-LeYPJA>
    <xmx:R3VrY1VhCL7VobLDO6PuBS9IG0aclayqiu2xKxjzrottX6BQC_cj-g>
    <xmx:R3VrY4mTox3WAbCT3xx3opyeWezKB3_bMTpkuhCEZmxa4LbAUeBq2Q>
    <xmx:R3VrY9_noMGfPN6l1nLwaPA7pGnrrLJExTrQHXuj8FBl0IqIic9Fbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 12F31B60086; Wed,  9 Nov 2022 04:39:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <488b4fa6-c146-4c0b-9fdf-ff1ef56e5448@app.fastmail.com>
In-Reply-To: <e43b20a4-58f9-1f0e-cd08-9defd494c49f@gmail.com>
References: <1924eda8-aea6-da64-04a7-35f3327a7f4f@cybernetics.com>
 <bb6dfd57-0a46-9aa5-050f-40e207bd44f4@cybernetics.com>
 <e43b20a4-58f9-1f0e-cd08-9defd494c49f@gmail.com>
Date:   Wed, 09 Nov 2022 10:38:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Akira Yokosawa" <akiyks@gmail.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        "Will Deacon" <will@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>
Cc:     "Alan Stern" <stern@rowland.harvard.edu>,
        "Andrea Parri" <parri.andrea@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jade Alglave" <j.alglave@ucl.ac.uk>,
        "Luc Maranget" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Daniel Lustig" <dlustig@nvidia.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: io_ordering.rst vs. memory-barriers.txt
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 9, 2022, at 01:28, Akira Yokosawa wrote:

> From quick glance of io_ordering.rst's git history, contents of this file
> is never updated since the beginning of Git history (v2.6.12.rc2).
>
> Which strongly suggests that you can ignore io_ordering.rst.
>
I managed to track the origin of the document further to a bitkeeper
pull request and a patch on the ia64 mailing list:

https://lore.kernel.org/all/200304091927.h39JRob0010157@napali.hpl.hp.com/
https://marc.info/?l=git-commits-head&m=104992658231313&w=1

While the document that was added here (and survives to this day)
talks about MMIO (writel), the code changes in this patch appear
to be only about PIO (outl), so I suspect that it already mixed
things up at the time.

> PS:
> Do we need to keep that outdated document???
>
> I think Documentation/driver-api/device-io.rst is the one properly
> maintained.

I think we need to have one location that properly documents
what can and cannot go wrong with posted writel() vs spinlock.
At the moment, device-io.rst refers to this one saying:

  "Note that posted writes are not strictly ordered against a spinlock,
  see Documentation/driver-api/io_ordering.rst."

The same document recently gained a section on ioremap_np() that
explains some of this better, and it also contradicts io_ordering.rst
by saying

   "A driver author must issue a read from the same device to ensure
   that writes have occurred in the specific cases the author cares."

which I think implies that the "problem" example in io_ordering.rst
is actually fine as long as "my_status" and "ring_ptr" are part
of the same device: while the writel() can still leak past the
spin_unlock(), it won't ever bypass the spin_lock()+readl() on
another CPU, right?

      Arnd
