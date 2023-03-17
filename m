Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE396BF225
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCQUJB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQUI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 16:08:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A38298E9;
        Fri, 17 Mar 2023 13:08:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C932F5C006E;
        Fri, 17 Mar 2023 16:08:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 Mar 2023 16:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679083733; x=
        1679170133; bh=3QWgEiDb3A7ZhMIEvI0tzxFEGhvDtOx1RahjR/6QWNA=; b=M
        GedoY5aaxFV/mxmaayuthUUl708xNdt3fmxwD8GMviApKv8EGOQ27s3VEMbrSc8A
        Mk3SW+nqtcMKZGul3h2VmMXpGqUEhpOJOrkASe/Dzm5o37oIXzDwdJpTkjDgM7f0
        nY0QlEcXBVw7TZmWQ5hP76SE2wSAxomWiYpNKrCdyHM015TviE/5AKP4BgJcRo8p
        1xehc70tD01HTWJATU/fcxKwsHeCyLwTnWKJyF4j42tla1KFUMCDUxbJhHKPvgP3
        Qrai2nW/SYF70PHUSPBALw6ELzRTJ2oKvEdu6lqnnB+F34/eWdL3cO89kkSJz6lo
        CWgRQcnjzrd9/GtjgepCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679083733; x=1679170133; bh=3QWgEiDb3A7Zh
        MIEvI0tzxFEGhvDtOx1RahjR/6QWNA=; b=IEBSeC5Y04frThJ8YmLFURABMT5i/
        v7iaesDsL4BNVRj3nNHDCejUjFlNW++QaLptLFf13aK0Gcn148RlM8Gsmb3KubwZ
        hM0OSiE0BdmQPBKrBptDfX9iaTdUL+Ob4aPClpkIEHOGk3SIhLRtzn/KiQDLyviK
        gqlqNBp8IsBmRj9Al6+jVmI1QjN6FmL/hvTqSdFJx/+qKUJBvlsxXrlmHi+46N0h
        xshyF15xOBgj/WUmXydXIVjdvP9ffyhyH7VZagS9U8SSfh8dqt0e1pXSFus8NLz7
        Dk18k/9knbt/tyudCCflaNJYXZGqsFQAEDf4McBcpokwQIfdXUgB0mseQ==
X-ME-Sender: <xms:1MgUZCnov5xBHYDqBtdbjPLV7Gts6BI6yLhHTjJhNLvIk3snQQZhZw>
    <xme:1MgUZJ3LDARXClcCX5bChW6c6OM8p0yuzjZWO5C-PU9Vh0j4P9YxwyJARbF8hi9tI
    -tac6hTCDUWZD6H7Q8>
X-ME-Received: <xmr:1MgUZAoYfgozDiu6uJQBH7en08guN7vr0tjJH_ktrtmQg8tGipBgL-e1kgPrMrmdt44V8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:1MgUZGmkZNvcBgBVi-TY-AxFcIZIon_LUO2heD5RokRbo65wN8VXBw>
    <xmx:1MgUZA0boLDyqqvd5b0opN7sJ0cSaY6UoNwmuGt8A0DyiVE23uiQEA>
    <xmx:1MgUZNvOW8PLIa34MBOLCSxCLFR46vK1MlPn39rNclzOgtk9bhnEuQ>
    <xmx:1cgUZKqpi4rqyZryffE7fNGa_kaeKgvtPKGVUMSvvpRjC4mJ4p9hZQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 16:08:52 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 54A6410D47D; Fri, 17 Mar 2023 23:08:49 +0300 (+03)
Date:   Fri, 17 Mar 2023 23:08:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Message-ID: <20230317200849.gjqezmeaiqkfz7so@box.shutemov.name>
References: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
 <373b22c7-9162-eff0-1f0c-0a8d79a8b372@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373b22c7-9162-eff0-1f0c-0a8d79a8b372@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 06:50:17PM +0100, David Hildenbrand wrote:
> On 17.03.23 16:35, Kirill A. Shutemov wrote:
> > Normal page init path frees pages during the boot in MAX_ORDER chunks,
> > but deferred page init path does it in pageblock blocks.
> > 
> > Change deferred page init path to work in MAX_ORDER blocks.
> > 
> > For cases when pageblock is larger than MAX_ORDER, set migrate type to
> > MIGRATE_MOVABLE for all pageblocks covered by the page.
> 
> See
> 
> commit b3d40a2b6d10c9d0424d2b398bf962fb6adad87e
> Author: David Hildenbrand <david@redhat.com>
> Date:   Tue Mar 22 14:43:20 2022 -0700
> 
>     mm: enforce pageblock_order < MAX_ORDER
>     Some places in the kernel don't really expect pageblock_order >=
>     MAX_ORDER, and it looks like this is only possible in corner cases:
>     1) CONFIG_DEFERRED_STRUCT_PAGE_INIT we'll end up freeing pageblock_order
>        pages via __free_pages_core(), which cannot possibly work.
> 
>     ...
> 
> How should it still happen?

I got the sentence backwards. It suppose to be

	For cases when MAX_ORDER is larger than pageblock, set migrate type to
	MIGRATE_MOVABLE for all pageblocks covered by the page.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
