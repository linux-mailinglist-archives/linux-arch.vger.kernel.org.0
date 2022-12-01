Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAD63F3B4
	for <lists+linux-arch@lfdr.de>; Thu,  1 Dec 2022 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLAPXL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Dec 2022 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiLAPXK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2022 10:23:10 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC65ADDE;
        Thu,  1 Dec 2022 07:23:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BC4D5C00F8;
        Thu,  1 Dec 2022 10:23:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Dec 2022 10:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669908188; x=1669994588; bh=qXxod6exzI
        tDk71puiAdMEYCqmAE/fz6LewDbCtyyFc=; b=F7u4M4W3paimrLtZGA4sFiPuNb
        BfKha+bU99J1JaIZCyXH+sAFoDkhkMVa1vbgzQQSK9t1iBgpaS3yFOmlvF8ims8e
        wr51F6HuMhrkobC4NggfJPBLT2mFunVbRNTBkc2feQC2DLk+g1/ZxemuGd9ihK6H
        eIkCClpfvW59QRBPC3bjJmwRmApLtqeXAYYrlrV/ICOZiexvCfrCA6FThCPJo0ih
        Hjhr11zSdiGN9gBdBldDvrxLsyJPf17UDXUyYtoAqOr4f90zPFyt7GPZrP7bb11+
        G/CAAH9BnVKYNqNIHherrn18B3X9sS1yPPE9oDoMiFk/iGIvGTgymFCbweBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669908188; x=1669994588; bh=qXxod6exzItDk71puiAdMEYCqmAE
        /fz6LewDbCtyyFc=; b=AYu9eYaZnr4t1gAJlgtSWZxVoqcafBTD0Ulx1eZ35tD2
        isbm4gqo9i4T+JTIb9pxJsApAGjrUx0cqwF+ISBq1B9eMnExxzFFgV7p4l0OtEGJ
        Ogawl6d2EiyyTgWLHuNxvm9DJftTJzlqVAmOGNqJ4JUUZcDwq0WRcoGnrgc4Tf93
        Dw/M17zbyvpnayneB9OpS90gp0jAkJMhrbAt/C5Fn6ETvSrf37OKic5usmU3UWei
        PnYSQ+tm/6jvWHjcfvUj6ZSfMN7kfvpPXwSX7ZGDqEHyBZvsWyz1ja7QbqVxKDtj
        lDBG9dm1CqwQ+YVox7IzQzML380DZP9dCb/hgX15JQ==
X-ME-Sender: <xms:28aIY3gKFo8zPAr1ItNWZDBBt68KZ1WfeQVJAAm38GwXLDA9RwBK1A>
    <xme:28aIY0BhYLhiDu8tUpq4HyH85XgT1f0TnW7SAqp0gZ9W7PN7F7znHFo0EAAa8fRWh
    OcTpEOZz2-aMeiefiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:28aIY3FAyTaK9R3ZAfVXdm8Wx-OoSi7o_-kYwK7CpXLLrU94DSxXJQ>
    <xmx:28aIY0Ripc6Fh-MwDwIkdLxdfG0FHJnSUXiePu53M1TPnt9OpOSAMQ>
    <xmx:28aIY0yzp10vosd2-SnIFbBs_okrbRSgs3Ypx97WC6I3MFefUB_Z-g>
    <xmx:3MaIY6aambZE1koX-aMOSc4Yy5cuzljSfBYEhOeKUCmdnwKnyRRIkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7667B6008D; Thu,  1 Dec 2022 10:23:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <02762033-8ecb-466b-9f46-03a087b8446c@app.fastmail.com>
In-Reply-To: <075390e2b9c8b57b75b6e479f9d43e4ccd6fb47f.1669221371.git.geert@linux-m68k.org>
References: <075390e2b9c8b57b75b6e479f9d43e4ccd6fb47f.1669221371.git.geert@linux-m68k.org>
Date:   Thu, 01 Dec 2022 16:22:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] uapi: Add missing _UAPI prefix to <asm-generic/types.h>
 include guard
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 23, 2022, at 17:39, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Still valid after 9 years ;-)

Applied for 6.2, thanks!

     Arnd
