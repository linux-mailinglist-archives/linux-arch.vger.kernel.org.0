Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68B6BB7BE
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCOP2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjCOP2I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:28:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED01E1E5;
        Wed, 15 Mar 2023 08:28:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 36B075C0066;
        Wed, 15 Mar 2023 11:28:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1678894086; x=
        1678980486; bh=mq6wnsfPg0Odxi6RseqaQNbi52OOC00lXDJeDSSRChg=; b=J
        QxJcaeDyhRKiBj9ppkvxKjaAhrkCmGHIQtVoMv/tjuvtAotXd2QLfORO0Tf+hoJJ
        IvUCrtI3aCkLsY1DT/0UpKOaW5/FQXT4Jb1LnN34cnmE1jQW6NDohCtbtSRuh6Bf
        HtfXrfpAKM5nX3r645vrAEDGp37LNNbFCVNgZr361/+ScHDhjavITGOQJEEGAksU
        vUUtuT5iM4S8677QHUQhw534xSy+gM4lRWM9sF/f62Q5E6lC/ivkWLRBlgLxrgfs
        AZpperNaChHqWwjxMU47ISLMlexrdI8am0/2fjGswjfkOVAYCCnF1nwFk567vUIt
        csJYQrlCUmjewdHStk9pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678894086; x=1678980486; bh=mq6wnsfPg0Odx
        i6RseqaQNbi52OOC00lXDJeDSSRChg=; b=ST/65M3FFprhfEUaQr/SVj9lFWvJw
        uIrYbfaWB4bx2hQxXkcBMyVKKbotWr2nEZLmNNm7v5/l23wqMP9LhRGkTWwWzYR7
        UhJMKE89z6Z6GTW8NjUCUJRXESPfXTrIk6lhPKtj/VrqQ525e5oZ7YWfU7gWy43i
        cVze9TIsuzH3xGU3jPgw/nZgeTwV0ycfSIMCSZ41/6LAds/PUzgGjsg0//AS/TaF
        xFmkM6taSL7cp5lJPGK67MN8iRmcy5m64f5MwPQeksm7pCddH8lhAYzfXaLy+Bmx
        qzVemwOZuFrOYNaVvZkWJ4i/bDQUT3K4+ZZVauluxY4d2sV74XxKSCbnA==
X-ME-Sender: <xms:BOQRZKny0DA-LroCyLKEJm1m9hTf2wOcbs8J_xrSCcCEWMx7YFu5uQ>
    <xme:BOQRZB1EvQxcWFquT9XLpQuWLOygW4kp7M2v7r3dX0y9UZY42mGh4yQhDHghBFqpF
    hxUKZJ5qDLJGHJjg1M>
X-ME-Received: <xmr:BOQRZIpm5F8v9alfeYlWziB-AhfAx2BPN4HMrnEQyAgTt0rL6fGej_ULi-KpUGHn9L7__A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffhedvveeuheeljedtkedtkeeiieekgedtveeu
    tdejkeevudffudfgveeggfduvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:BOQRZOkQe4CCceMuB1wNop5izbZuLukCQMqS0q6aExFgKt2ntpaoIA>
    <xmx:BOQRZI1NpyY6Leho32MzN4eTypOwOpP02ZLrezziGmuqzLGizmZc7g>
    <xmx:BOQRZFtPywkGsYaPABbdBjSwnHSfkTtGunYIS8C_7e5dl7NQLXWHqQ>
    <xmx:BuQRZBtdYLOqKtk5PoEhUA5K2B6150o-2RZWiRyt_uHH5hF65Kq1Jg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 11:28:04 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 81B6710C8DF; Wed, 15 Mar 2023 18:28:02 +0300 (+03)
Date:   Wed, 15 Mar 2023 18:28:02 +0300
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
Message-ID: <20230315152802.gr2olzji5zhu6vdo@box>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
 <7fe9a4a0-9b30-38db-e739-1dc1f7a8f74e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe9a4a0-9b30-38db-e739-1dc1f7a8f74e@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 02:18:52PM +0000, Tvrtko Ursulin wrote:
> 
> On 15/03/2023 11:31, Kirill A. Shutemov wrote:
> > MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> > can deliver is MAX_ORDER-1.
> 
> This looks to be true on inspection:
> 
> __alloc_pages():
> ..
> 	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
> 
> So a bit of a misleading name "max".. For the i915 patch:
> 
> Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> I don't however see the whole series to understand the context, or how you
> want to handle the individual patches. Is it a tree wide cleanup of the same
> mistake?

The whole patchset can be seen here:

https://lore.kernel.org/all/20230315113133.11326-1-kirill.shutemov@linux.intel.com/

The idea is to fix all MAX_ORDER bugs first and then re-define MAX_ORDER
more sensibly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
