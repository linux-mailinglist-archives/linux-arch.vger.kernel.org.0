Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0098C368198
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhDVNkV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 09:40:21 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56517 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234429AbhDVNkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 09:40:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 033B212ED;
        Thu, 22 Apr 2021 09:39:45 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute6.internal (MEProxy); Thu, 22 Apr 2021 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=q53ldsbikHHb6JQ5/ycdiGARttDqALm
        XqEGP9AmnoYo=; b=BaDlmMw+9srpsN8CLID6wRRG0FrAxDdN7n9QtF880xijiBs
        s8KOY71s/IhKwxdm6AiglTtGpEDB8C1iJnO6OJkEtjj/ymrwryNeWCWvISi/4Iil
        vYsGpQyNS/ONhq55XSZC72NriGo2QoBGd/VQFm1rafLN4a6KhdkJSSqyCq/y289i
        C9pPXJbaQpSMvCh/+kLTyLAsFBCS7SDnymvdsk7lJrEZt4XdMRg7U/QcvHl9DEj8
        BT5uG+0QPOBwfiexaBoLcaWj15ObQSqkIkQwjW96Nu3OeiUl2kHd4gHUToVG6LhY
        kSrycW6b9+TaMOE76vkaxYSOBMW7Qw5f20YJkYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q53lds
        bikHHb6JQ5/ycdiGARttDqALmXqEGP9AmnoYo=; b=pdYt+sJA0bX+/xFRBq0zqc
        +iG2/z6IgCTAYLBWsEsyQnBK5cFLi2upGbRsWb+7ddNChjW9Ciz/GsgtvviEk4Jz
        RK+M6Ag0wgmFA6avcdXU05CMXmkK1F9p8E/tEn7LwVdBgE9ZENJRghldoYHen9Y5
        mZM0VwnaIgAHqgFsyziMRiZre8t+G2uIdEXg6+7Ek420TTLTLzmKAmk9c2KGzSyZ
        cHHxdHYZ8WoCAgyWN+SlVPYz8JV4pOcYlCnFdHDC8umTuo6ks8gD1F0qs3NDpKzY
        sItfcGQO4gflsMppu7oLUTuNj2xBHndCSyyhy+0J/zqcKSxFLq10yIgOJAdG6V3g
        ==
X-ME-Sender: <xms:nnyBYNJWsO_PS0bzpx8BYSEDrtJCenKgMWA9qbbjM3yJBwBhfgSXrw>
    <xme:nnyBYJK_o-n1Z2tqglhtY_31xY90VTeT7obOvs9pYVJ6WKFPUzCnnh4fWJAcjjoHa
    UM9uIXKP-JYlBcY1WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddutddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhheejleegkeelheetkeelteegleejhefgueefvedtvdeh
    vdeihfefffdtueehueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:nnyBYFsVzsZ2yekOd8jUeAp2f1gYreCHXpVX6kFE8K_B4JYGpg3A6A>
    <xmx:nnyBYOZFtquQgQP1oh6Os1WvHsAEQDzYVOilPmrOPaazXwa0wCIadQ>
    <xmx:nnyBYEYrtP9KGnHa1fDZ0ABxAsuvGkqIwhEvWAiTXL142a4XjH5GJw>
    <xmx:oXyBYJMUCf81scSLSZUelq-apTEzZZotWtsQSS30h7kxIsx9MD_0ig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3466E130005F; Thu, 22 Apr 2021 09:39:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com>
In-Reply-To: <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
 <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com>
 <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk>
 <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com>
Date:   Thu, 22 Apr 2021 21:39:20 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Huacai Chen" <chenhuacai@loongson.cn>, linux-arch@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Thu, Apr 22, 2021, at 1:53 PM, H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 21.04.2021 um 21:04 schrieb Maciej W. Rozycki <macro@orcam.me.uk>:
> > 
> > On Wed, 21 Apr 2021, H. Nikolaus Schaller wrote:
> > 
> >>> In the end I have included four patches on this occasion: 1/4 is the test 
> >>> module, 2/4 is an inline documentation fix/clarification for the `do_div' 
> >>> wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a small 
> >>> performance improvement to it.
> >> 
> >> How can I apply them to the kernel? There is something wrong which makes
> >> git am fail.
> > 
> > I don't know.  The changes were made against vanilla 5.12-rc7, but then 
> > the pieces affected have not changed for ages.  FWIW I can `git am' the 
> > series as received back just fine.
> 
> Please can you point me to some download/pull/gitweb? It seems as if the series
> also did not appear at https://patchwork.kernel.org/project/linux-mips/list/
> 

You may try download raw from:

https://lore.kernel.org/linux-mips/E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com/T/#t


-- 
- Jiaxun
