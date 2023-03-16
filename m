Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294D6BDCE8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 00:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCPXa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 19:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPXa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 19:30:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A419E066;
        Thu, 16 Mar 2023 16:30:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EE46D5C0003;
        Thu, 16 Mar 2023 19:30:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Mar 2023 19:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679009455; x=
        1679095855; bh=mWjnFNvzepxM90lSc+OOQwduG8sRnhr4PdJP/q1hvoQ=; b=C
        Y7m2Kt2AcPEeMIc9lF8vV7fzv8FuxtG1ugefnXwzUBQd4FEyQX24p0GZfctzEkaJ
        SCr+lF7u+Edq1Ao2utuvGI1ibzp/YfHTr0vqu418BFfQSmZbnyvpXii0IQrkfx7v
        N6PISxC8KmfFK7Us8H2CuHkO98BN6pb5CM+liuwgOiY6iUllAGSg1TsVA7dUAHe0
        N+jXOUHqEepWaTc/wcRsIwKysEAsRPSwoJaveQs05Rsy6F06CJWYhZH3bD05w4EO
        Sac/ifu28oaHeqexZgieYwW6M7AOdhyQsPKFJiYDFWBGta9JkDFIfsMr4Nx3A26H
        5Ohi5ddr4inW6xmRWuNlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679009455; x=1679095855; bh=mWjnFNvzepxM9
        0lSc+OOQwduG8sRnhr4PdJP/q1hvoQ=; b=KiE1iVJ3JifNjDNCeVPeEhzreHnj3
        LXVvywWxEhHfyMeQvna8NgxoUudcCQgxRM5G8jpUpFFQwKk4ye7AVc125mzBZdLr
        10wa+IXcjBCQZ0JIi6J+loG+u93b4R+7EchczP/kPyPiKoLtstjJQ0vD7vKrV6CJ
        9AQuqqPMURqIthmjxRtr2iQ0oPA/qivNRnGPFjR/MC/TQLx630pKNmImDuDE55E2
        FjFN3akAfMhoPbGeoUThph6qY4UIviGAFWOr+EGCAm309wGwN9jSCNg4hjnE8vAw
        ukmyxiskbj1ty2LMnGjPR7xZmoF7sG08dwxUvjp3Pu9kjOe1ZBBdh6GnA==
X-ME-Sender: <xms:r6YTZPR_AslS4vjkGifCEMZKqkvy7GL6b_13ovWtEn5OdBOF6WaPrw>
    <xme:r6YTZAzP66nWeiJuG8ekR6Rq40iyisIV3gCFzRH6hPqv2ERUilHO2beVyhk9Wy-lx
    0k4hQ65wJMxJNTSEtI>
X-ME-Received: <xmr:r6YTZE1I3HPhbgyFRthg6W2KTW1hCAWDoX5AdO5ipB9I4GQB2rSOgRBhX3fVtk9MTplA-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:r6YTZPBin-_siT6DcMMsJkztuAouFd9LD5gaBRt5nWW1_x1cE5-4Qw>
    <xmx:r6YTZIiERMs1sKnYMDgJSe2Xzs1JoBgQpVSkPtsEpzITRxP5dVukQw>
    <xmx:r6YTZDo6hbli4-M0wF3f4U9uECoqUh3dmCJEicXI0AdSEl4S2KBuCw>
    <xmx:r6YTZBXeEf7XE932DJAfIVHXxy94rJnV_COUPPNFrppB_9rhr_Qs-A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 19:30:54 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4B65910C9F7; Fri, 17 Mar 2023 02:30:53 +0300 (+03)
Date:   Fri, 17 Mar 2023 02:30:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230316233053.iwsffmfxzzacnkuy@box.shutemov.name>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <20230316181547.GA6211@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316181547.GA6211@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 16, 2023 at 11:15:47AM -0700, Mike Kravetz wrote:
> On 03/15/23 14:31, Kirill A. Shutemov wrote:
> > MAX_ORDER currently defined as number of orders page allocator supports:
> > user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> > 
> > This definition is counter-intuitive and lead to number of bugs all over
> > the kernel.
> > 
> > Change the definition of MAX_ORDER to be inclusive: the range of orders
> > user can ask from buddy allocator is 0..MAX_ORDER now.
> > 
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
> >  
> >  config ARCH_FORCE_MAX_ORDER
> >  	int "Maximum zone order"
> > -	default "12" if ARC_HUGEPAGE_16M
> > -	default "11"
> > +	default "11" if ARC_HUGEPAGE_16M
> > +	default "10"
> 
> Is this Kconfig file wrong (off by 1) today?  It seems like it wants MAX_ORDER
> to be sufficiently large to allocate 16M if ARC_HUGEPAGE_16M.  So, seems like
> it should be 13 today?

+Vineet.

Hm. I think it is okay as long as CONFIG_ARC_PAGE_SIZE_8K=y which is
default, but breaks for other PAGE_SIZE.

Looks like ARCH_FORCE_MAX_ORDER calculation should involve selected page
size.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
