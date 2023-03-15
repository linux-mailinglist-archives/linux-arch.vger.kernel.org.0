Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E56BB815
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjCOPjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCOPjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:39:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D678D321;
        Wed, 15 Mar 2023 08:38:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 984835C0526;
        Wed, 15 Mar 2023 11:38:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Mar 2023 11:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1678894738; x=
        1678981138; bh=ush8ME0jEakHYg80k1g2osTICDPTTulGFVSfscZli7k=; b=c
        5Ff4yD36w41DKPma3HDdgIFg7AtVNZDC60XK8998GcBVLO3wL4D6I/qIcLyXh27m
        bCyrvJblAbOvAEEjc/iwujurPhajGIdERxogM81s+14yitqMHYsP1CR6D4ZxS1o+
        t3hKAZLVygO9+IBOcs1oIuG59Jp088hOUBLEEcCNGbi7QIXwZ8gu2vSC9YrgiaKA
        Bix70JCboKiS3pisEPsPOp4zoMWUDjkBtxmQRj1ClZWQVwl9zoWuZJKUMRRfLyMi
        qITlkCycukFLeztfi4ZaIusDLJ5wrDdVrPBuS2qG4qEBTNW79wp13mhX5i+1/v9T
        BkE9s4yGHUmlO2Q60jVvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678894738; x=1678981138; bh=ush8ME0jEakHY
        g80k1g2osTICDPTTulGFVSfscZli7k=; b=Uq4dZKnF9dgnEFNEmwMyZFcFO6mXZ
        kVXn0skZTXHybY4KdfGC06+UK7lLMT+Vw9Tl6JQtlNmAJvmwdomjy/Kvk5GCj7+s
        Gcn5ZM4WxrwOjvcVjYimycPoQRGb78xXeIDy+gUHzBlPdrQfHiOAqgtFEC0VtdaA
        g4piQpywGHLOT28nSauuYgOnbIog+gUPnwu99L3PDFQsqhQU2Erhw3ltS+dVTq/6
        +5bhAVuGrhLc7uE8LsTXovTTByBP0gnxgvSYHiwvVkg4S4VO2rlhNpGy191akjiA
        tFcYQdJz6S1P3pRo+9M7AC0nUEfhYSaEb/0h3fH+gb+LJEnkv8/HKtorQ==
X-ME-Sender: <xms:kuYRZCZPNVKxy8JdY_SUlBBKvVTeeiyPNQ4JyfovSXlWjvWrHF7CHQ>
    <xme:kuYRZFbzzBhSD1NkcPoCyMbWE96ajnWV3Hc5UjHM49iHcYfoD_r0DkJEGqtUJ_E7L
    Gv_bNxomPexNTKDQWc>
X-ME-Received: <xmr:kuYRZM83i5AKR1Caw_VOT7Eiqic8FIxbiX0WKpfIaeh8bk_fKVM3h1ELzs3w0CSXXJV6Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffhedvveeuheeljedtkedtkeeiieekgedtveeu
    tdejkeevudffudfgveeggfduvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:kuYRZEopItkGYrL6IIGySAjVWezH9MlSN8jgx1O7_c2YFSIN9hD8Ww>
    <xmx:kuYRZNrUH53VhAGRLN2gOl8oWsYThdrJV3kaeFBJoRXi8ugkiMTlkg>
    <xmx:kuYRZCQZqEUlEop_si72X5ZlyFqZKZW--89VTNJhu3nQtB9ZdJFfpA>
    <xmx:kuYRZKhR7ee2WQSpCp0DBU8AHMZUNuoan0kCt71IwXo_b2AiFQ2p_A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 11:38:57 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 05A9A10C8DF; Wed, 15 Mar 2023 18:38:56 +0300 (+03)
Date:   Wed, 15 Mar 2023 18:38:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 04/10] drm/i915: Fix MAX_ORDER usage in
 i915_gem_object_get_pages_internal()
Message-ID: <20230315153855.aeqyxncf3k6yqipl@box>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
 <7fe9a4a0-9b30-38db-e739-1dc1f7a8f74e@linux.intel.com>
 <20230315152802.gr2olzji5zhu6vdo@box>
 <f2f35037-d662-19c4-722a-02ec10f86f85@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f35037-d662-19c4-722a-02ec10f86f85@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 03:35:23PM +0000, Tvrtko Ursulin wrote:
> 
> On 15/03/2023 15:28, Kirill A. Shutemov wrote:
> > On Wed, Mar 15, 2023 at 02:18:52PM +0000, Tvrtko Ursulin wrote:
> > > 
> > > On 15/03/2023 11:31, Kirill A. Shutemov wrote:
> > > > MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> > > > can deliver is MAX_ORDER-1.
> > > 
> > > This looks to be true on inspection:
> > > 
> > > __alloc_pages():
> > > ..
> > > 	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
> > > 
> > > So a bit of a misleading name "max".. For the i915 patch:
> > > 
> > > Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> > > 
> > > I don't however see the whole series to understand the context, or how you
> > > want to handle the individual patches. Is it a tree wide cleanup of the same
> > > mistake?
> > 
> > The whole patchset can be seen here:
> > 
> > https://lore.kernel.org/all/20230315113133.11326-1-kirill.shutemov@linux.intel.com/
> > 
> > The idea is to fix all MAX_ORDER bugs first and then re-define MAX_ORDER
> > more sensibly.
> 
> Sounds good.
> 
> Would you like i915 to take this patch or you will be bringing the whole lot
> via some other route? Former is okay and latter should also be fine for i915
> since I don't envisage any conflicts here.

I think would be better to get it via mm tree.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
