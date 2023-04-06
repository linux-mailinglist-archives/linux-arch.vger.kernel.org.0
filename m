Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362776D9145
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjDFINg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjDFINf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 04:13:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830C6581;
        Thu,  6 Apr 2023 01:13:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F3CF5C00DC;
        Thu,  6 Apr 2023 04:13:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 04:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1680768807; x=1680855207; bh=sC3OcFARCK6wqn3B9SU+8yo+b
        Z6jV1elvr18iH9YA44=; b=jfIQrCC4W93F7GUUr15gh2UlzM+Ji/wULzYDTudF7
        1j4NRroit0TwW8EdXv7m7IMfS/gpFJhNKBC90/h++Y3RQeKLGOX7grAycNSKvErF
        6JUjWkYn5K+RTIT7t5iJ2mvs1ln1Sd5w77x+vNikcwyNHjFefvOtsV2DF0xZQ/dH
        o1QuQoA+nLYndw/noTE8TTQFhTQ5mQlnLiXypMhOQae4uXFYAbLnTA19ImY78x7u
        Fbt+LrACPoXoiVJQWi8X1XPNJrkw7UfjMFMY1IDORLeU0Iszd/Q/S5yHZx6rnGt9
        mMdssk8tQypvlvgrpxJbNx2EFemeWPd13enC8pc+5Ni/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680768807; x=1680855207; bh=sC3OcFARCK6wqn3B9SU+8yo+bZ6jV1elvr1
        8iH9YA44=; b=tgtKQ6fpnUVCyNa+j5riZz0tRDmguh/7FoOSWAe3whmaMkOGOVP
        dFx3JkfdP6IjGJvnImxDZiNojZxYqmeKesiP3Bi35RF7RA00F4UcGjibN2AX94tI
        RdCeQRRpW2AyzPyDhsHmvbbqaE7alcPbbXzwWxIjZVOFDE4oDcntsDbrh/kbbZ9A
        VHIQWkt/ZcZU2OKQZQPzlIiOhl+Qc5CgSuFkl2svnfhfM6nwx4MBAbmMAhzX6Wqn
        9kJJWYCrN2sH1m6SjmZHpMozwYA3rf/1fY0qpjlk4ZO85miOYwmuWs+wwrZU1LHW
        Ka07dH5SbJ7egUTLHRrF/vG98gy8JtaX5pQ==
X-ME-Sender: <xms:J38uZKaBHdFKwk-BSK6A0zfnVz024pv5D3fFuDMAwNk7RgqAKKm62A>
    <xme:J38uZNZzCU24OxXAokr-xiDkoKLqlFFafSoE7jcFwP-THfsP6_NlXk6lzKSwcI6du
    z6PH0AX0FCpeigj1p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:J38uZE_uwJ_gkkDdjm03tsFUtQOGcpLsNzypHoPk-eZyB20H0OleSQ>
    <xmx:J38uZMrd99LBbF_GOSB9Oqcc3YY7bD0-_iH6u87XB5d1r73xDB6lWQ>
    <xmx:J38uZFqvSGOastlpoKRTHku5VbHnQCeEPe3Q76fQbwGBmtQuRmHaKw>
    <xmx:J38uZM2NFOwA3IJoaYbJ1JsMqPfcbN7h2IA_m5PHJCC5ThGaMZm6og>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 439FDB60093; Thu,  6 Apr 2023 04:13:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
Date:   Thu, 06 Apr 2023 10:12:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir Oltean" <vladimir.oltean@nxp.com>,
        "Matt Evans" <mev@rivosinc.com>
Subject: [GIT PULL] asm-generic fixes for 6.3
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.3

for you to fetch changes up to 656e9007ef5862746cdf7ac16267c8e06e7b0989:

  asm-generic: avoid __generic_cmpxchg_local warnings (2023-04-04 17:58:11 +0200)

----------------------------------------------------------------
asm-generic fixes for 6.3

These are minor fixes to address false-positive build warnings:

Some of the less common I/O accessors are missing __force casts and
cause sparse warnings for their implied byteswap, and a recent change
to __generic_cmpxchg_local() causes a warning about constant integer
truncation.

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: avoid __generic_cmpxchg_local warnings

Vladimir Oltean (2):
      asm-generic/io.h: suppress endianness warnings for readq() and writeq()
      asm-generic/io.h: suppress endianness warnings for relaxed accessors

 include/asm-generic/atomic.h        |  4 ++--
 include/asm-generic/cmpxchg-local.h | 12 ++++++------
 include/asm-generic/cmpxchg.h       |  6 +++---
 include/asm-generic/io.h            | 16 ++++++++--------
 4 files changed, 19 insertions(+), 19 deletions(-)
