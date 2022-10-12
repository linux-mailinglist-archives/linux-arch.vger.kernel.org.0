Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A525FC3D8
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJLKji (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJLKjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:39:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBF294;
        Wed, 12 Oct 2022 03:39:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6326632007F1;
        Wed, 12 Oct 2022 06:39:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 12 Oct 2022 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665571171; x=1665657571; bh=4NHIBJRK0S
        amuGDP4q/b7eYOgsGuZ3RhmtCcXnkYKHQ=; b=JyJvSThpou28493tlw6idF9HHr
        jR7j9eGMXfbaEhQWp0deYOM6aMjYDcnKvGOGsRiZV/ki6SUFgqbtEKVs9QWoF9DY
        QQxdUDVs9OZjNFzQx6xNXYH8iZt3a9VQ4dXjIbjWS7W4hfkTl6fYKQZADBafwzli
        vb14y4FzTj5tyvVwAhJjw8R7+EY1UkhrrsG3zxfWbYonYFyRVFmc6p0S3SL/BfGI
        K+zxN4IVtjiroMPc3nyyMqnqtY8VUIyf87oN35h1IOihw9AGeXBp0ePDamIyTdLS
        RkfNN28CLkx/uX2RPE5y41zN6hK7g+TP/AVb/wihI7IeBNjso2wkfFCC/E3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665571171; x=1665657571; bh=4NHIBJRK0SamuGDP4q/b7eYOgsGu
        Z3RhmtCcXnkYKHQ=; b=eyFfzN3aKrhmVu115PuUa6ojCuGO4de+k2p5R1YRHXm9
        gb0Cybwe/+3FXYE3u/TMlQP9A/EvFt0rJKYOMoxmjRmODXAX1GN78e0pQj7KNo5H
        5KiwuVGVrg8RerOZOh9VaB6duTPyqhjZGvXurpqbKdkawdrGYi+1U2HWI8jM+an+
        yd3A8UDK4ijszwNYQZoQu3z18mLvwbXBEMHW67nIrEzMjQnxMRG3itGkkHLe0Y3a
        aeMA8nHnWed2XkMySVjQjE4qbkjGsnxB6m+xdCh9tooeeuR1VgWvY1b8TpwvhqMg
        G1F9SC7zCoEacFF1WIYGAJf1U1xitGSwdmex1lsFfw==
X-ME-Sender: <xms:Y5lGY7aZanzJdbn0orApJmyqL_j4ON81DaLdpEnTq1K6GWzuN5f7dQ>
    <xme:Y5lGY6YSO4-N205NwypyYg8AV0B0pFB3sTHkAH-xejLTcBJi1JahJ82s4ri2TEQtm
    HCkExd4Ec-o51jn2mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Y5lGY99sUCtkc-aBjzoqRAzsB7KpJcn5ZAbQcNaF7W8G3K8eAlSggw>
    <xmx:Y5lGYxohhrd7R2czC4-zquXXiffqnCc1EOpBfvtZgSgEJ4dSMmS4qw>
    <xmx:Y5lGY2o4FfKjMMe1o4yJ33cHdwyNB-Pw7loCLMG4qvVOG7RAsCVhow>
    <xmx:Y5lGY128LYJ-NG1X4-lKE7ggEWRHfLg-obAbNe0UO3u79nZAI9UOYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E147B60086; Wed, 12 Oct 2022 06:39:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
In-Reply-To: <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
Date:   Wed, 12 Oct 2022 12:39:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Baoquan He" <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic ioremap
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

On Wed, Oct 12, 2022, at 12:09 PM, Christophe Leroy wrote:
> Some architecture have a dedicated space for IOREMAP mappings.
>
> If so, use it in generic_ioremap_pro().
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

"Some" means exactly powerpc64, right? It looks like microblaze
and powerpc32 still share some of this code, but effectively
just use the vmalloc area once the slab allocator is up.

Is the special case still useful for powerpc64 or could this be
changed to do it the same as everything else?

    Arnd
