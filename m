Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED466A70C4
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 17:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCAQWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 11:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAQWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 11:22:36 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E36302BE;
        Wed,  1 Mar 2023 08:22:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DA8FC5C007B;
        Wed,  1 Mar 2023 11:22:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Mar 2023 11:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1677687751; x=
        1677774151; bh=/Mz9AJhEHUo2/l+MPJnTNK9HwQT09yMYewS24cr1Nv4=; b=T
        aaI4ATplJomVE5gGf3A+estTGjdlCeEHSZb0zJQLRcjCvP30QCmGEA3Fz3BqKoBG
        wYiG842ROlKFoO8ilzzhVTdmVjhCJFHBScgXSwYan/hMhsTGd1E1DA3TcEM7PJVN
        /R1WBe0pP0taMvu29Y+1v+s0hzqVcZnxjZirrqzZpGSV423mmIgcorsF9o3FJ5Eu
        NOHQxkbR3VCdBxdwCyGWCTAzAQi18dZTgaqV0Fi0REuUq6bXOvSZVzijKsALENpB
        bRVbtj/naXzC/7DDZkJ0u2bQ1um1MASWO2ZA99dj5xifWsgDH8aSljmTrjimCAin
        LSGIDeDZuKrHOzrdGI9pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677687751; x=
        1677774151; bh=/Mz9AJhEHUo2/l+MPJnTNK9HwQT09yMYewS24cr1Nv4=; b=R
        ag0FGUV2PBO4B6IZ4PR2qOvj2CSLxgyNE6tOXHro3NrJJyCXLyOFS0U2aN2BSsH8
        rsagQrc2BMeuc7LABoNTcTWvsWO0dl+dumKNMWSzo7lB+WtKPdZ+1GK8EioLNEzq
        V/aTHiD+7gX8TaUh1EhxV5mfTiGmzqi/h/BtexQxryhpsskHnp5rFkfEJZ5FDO7F
        TkkXM6j1hgqI6/gxx24Ol64ib6FDJXiPDepB8eUKSVl8EpNf8JjsZBYr8vDaDuAX
        LurBZaJWlWCmPMx0vdrvmVjC1CEcIJ1rgwodFWk6uDBnGW8XCf7xBk5rtivptlS6
        hBN9A0nZ72bqs8HMuJ/yw==
X-ME-Sender: <xms:x3v_Ywp4CzdH8Axb3dBCmbyCgpIJFM9h3sSl6Z70B3pnyTz0mDIa9w>
    <xme:x3v_Y2o06VoopHyiXCZFpmY0C11HWLvoVImB-i9SZJkdYrxXStRz2SLkAzmUIydcY
    Dd0EzHbJKuCEyiQ2JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:x3v_Y1Plem-LTsZ-t_htL-k9_WPhbJIaDObxRQCUGdz4FtFjRltavQ>
    <xmx:x3v_Y36iw4i2WJ5B_KlKKSsTC5fjJElj_GjBAApnWTEDmVEJOiWsPg>
    <xmx:x3v_Y_4ntUsiYXLMm5tfAMvNDCOg7GYZgQz8BPR7L3Ly3aAZtt8lvA>
    <xmx:x3v_Y5Q_sfyR1mBh_KqvYBGujDGiZ8w8faS2kav57fpzef5O3JzdOQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7FD80B60086; Wed,  1 Mar 2023 11:22:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <7b4e8b07-4691-4af3-ae8b-ba612b6af595@app.fastmail.com>
In-Reply-To: <C7DB3543-8DB2-49F8-85A4-E9288843BCDD@rivosinc.com>
References: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
 <e27d184e-2561-4efe-a191-8c0401f815b0@app.fastmail.com>
 <C7DB3543-8DB2-49F8-85A4-E9288843BCDD@rivosinc.com>
Date:   Wed, 01 Mar 2023 17:22:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Matt Evans" <mev@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH] locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare
 against zero-extended 'old' value
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 1, 2023, at 16:19, Matt Evans wrote:
>> On 26 Feb 2023, at 10:13, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Proposed patch LGTM, but one query:  are the casts in=20
> arch_[cmp]xchg()=E2=80=99s args necessary?  The new masks should deal =
with the=20
> issue (and consistency would imply same for all other users of=20
> arch_cmpxchg(), not ideal).

I don't think they are necessary, but I'd like to stay on the
safe side here since there are so many different implementations of
arch_cmpxchg() across architectures that it's likely that I missed
one that has a similar but, or that another one will get added
in the future.

> FWIW (including the casts in atomic.h, if you prefer):
>
> Reviewed-by: Matt Evans <mev@rivosinc.com>

Thanks!

     Arnd
