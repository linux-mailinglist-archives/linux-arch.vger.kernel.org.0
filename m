Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01365601AA2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 22:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJQUwv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 16:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJQUwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 16:52:50 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD806C75A;
        Mon, 17 Oct 2022 13:52:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A4EB55C0074;
        Mon, 17 Oct 2022 16:52:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 16:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666039968; x=1666126368; bh=EK6ZSPGRW5
        u+wL3hHxk2To9IvybxeoYZAHIzbHwfh2E=; b=hadaflUK8ppdM2LIUY89Phjffs
        5beJBRxoaBA5FSPJsUJgRT3hoVEjT+zJSe809pULnmpSZESJ78donVG7myETWbhQ
        Mq6Bsw7My7yQnBtNxJBb9W+GMlt25bsdlGAGlNOrPDLI/zrgweZsaY4DyP0L9aOA
        Normj4uQkY2Cc4feQSgUUhflOAey26K45KHGxCx5ly1EAsN+mZCknCPgz0K1IAbp
        vR06vM0l70xgk40IUiFCcajp2bAHQw1BmxJAD7x9oITM6AdfIXj0D31hjvm4uCnU
        kylrGEY+YT/vIZPMQ08zzA5ov2fXqNx2wclyLCRp2LWLdIncXT4mxM87Mx1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666039968; x=1666126368; bh=EK6ZSPGRW5u+wL3hHxk2To9Ivybx
        eoYZAHIzbHwfh2E=; b=nqa07KGoBUWgXoZbn9TXvvagIRz0pfYKIQXaVkK/r4+i
        1e+y7YuwqXjn/9y+BzjaQdqudF47YPjh6OJNIluZZzVaWpLO0FLgOsGGLMk3b6cp
        NLUfGwx2bRxEOcnRYKEpCkBfmWsz3sharRFTzrqqn0spo59rkQsT+4J++U1kViai
        NGy2QKcqtq8qIcPFl5dKYMnbUHqSzpO1sSTYK2T+LmspbFq24HJhbXW5Pc01MH7z
        69KTIml41oLLnoUaPXqnWFhcRn4SDhemnKIIB0aQX+klVWCrnAT7EFn5GQzLfZuu
        11Ze+KrCMb/Ol8KHdbZsKect0LYiM8kiaHT2Kpy/Zg==
X-ME-Sender: <xms:n8BNY67gdRWmy0Psk4kv2zbDACgnI-gncRPXMCn_HJIo839kZD8GWw>
    <xme:n8BNYz4aa1e6TYIPQtUt10kIVHwO0qiESEWLaDVnVlTByvorQcMU7rudAvUfpShSw
    gg6tzx2l29a32qZFu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:n8BNY5c4tl4edCU4Ut5Md5b64VGsipZGJzxFG1v5X820DKQyvGanfQ>
    <xmx:n8BNY3IuhWzBa78inli1IiTguU6V_6n0Piwx0C2hRmgPjUssjkJkLA>
    <xmx:n8BNY-L2ysV9KjyOTulepwf02Xpsu9KH4TY4-GcGjEpGC44q363TMA>
    <xmx:oMBNY0yUPezzbK__9xj6q7vpHAP3Sc5O-ZRnbj4y8h9zxDsREbVDaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3E40B60086; Mon, 17 Oct 2022 16:52:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <276d9794-a1b4-4f0d-a9a3-027823038ecc@app.fastmail.com>
In-Reply-To: <87sfjmlim3.fsf@mpe.ellerman.id.au>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
 <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
 <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
 <87sfjmlim3.fsf@mpe.ellerman.id.au>
Date:   Mon, 17 Oct 2022 22:52:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Baoquan He" <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        "David Laight" <David.Laight@aculab.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic ioremap
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

On Mon, Oct 17, 2022, at 2:50 PM, Michael Ellerman wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>>
>> My guess is that there was no technical reason for this, other
>> than having no reason to change the behavior at the time.
>
> I think the immediate reason for it is that on some CPUs we have to use
> 4K pages in the HPT for IO mappings, but PAGE_SIZE == 64K, and we can
> only have a single page size per segment (256M or 1T).

Right, makes sense. Both the original patch, or the variant with
defining IOREMAP_START everywhere seem fine to me then.

     Arnd
