Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D168893D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 22:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBBVuU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 16:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjBBVuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 16:50:17 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29754C0E1
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 13:49:36 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DDBF5C00C9;
        Thu,  2 Feb 2023 16:49:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Feb 2023 16:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675374543; x=1675460943; bh=5t
        umJ1v1RegHftfj9mx4MPAJ6ECH6Mai+PtUbbz63BE=; b=V5sNeS7VK8NmBgS4on
        GkvUlLlfqxKz9vrPbjkeQPbvXI5XbUVF2m4dkcjz+zyyxb1OkdD3NEe7Bn4myCdc
        4qXUqmGuZf/IrtUBAMgGaxrN6Yj0Hh+wOF0du8Vw+Vos115sEjlMYHgd30mXrUoa
        PI8zI2MPsGV2Ngkulk69R4BXbGSeisKCTfYih/3nOvKzIq05vNIAzUdWTeBnsVIc
        A79lH3V0K0AEyGLcWN5DtGPDLf01rjKln+TwxDC/yAKgqdQyrCeXMsqAqXGl9mS9
        1GVX32KWDHSrf0T94tix5ro7rHJ9t7CVKUXCbNJ0jCSBo3w8dqy7sksQ4wR4luRn
        Qmfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675374543; x=1675460943; bh=5tumJ1v1RegHftfj9mx4MPAJ6ECH
        6Mai+PtUbbz63BE=; b=J4noaTFIDMU8BCO9APXDYDJv31z2zllwBcbnZ/4n+UDK
        9s8K+aKozm54zmvwcvYS5NqdgGwdsDDt7e/inEwe+9pC93AAjI3PqHbnQ21ohDN7
        Q6rDAcKJ1WKC1yLr3jULKIMnuEupBMEg4njY56SE6iQbsrpZc3Xqmx+Okme1G0a3
        YCrZwycUxkW9AfSJprRcpd5/D8B43NtKqmexbfvH7kEKR1glJbr4JHJ9wLbfAR+q
        +c6ho7YKfpMZlLoVKt80Q54nrB+CBZBEBVB36m//icBGthmZoQAWxrpuODXinMk2
        gFqO38q9zP1F0jI6NVapV0TUm/Ra7V6zYf1y6uYF4g==
X-ME-Sender: <xms:zi_cY04e5nq7YCyuKo2sWTwEaVDb__QMNBPGWRZJ05YLLm1CVsOQug>
    <xme:zi_cY14XE-8B5CW8WXNiMBTlXl7F3huDo70SVJjf8ID9mmxRPNDJD-mUfMHDPfZnp
    wWhB43dZwNP69grK8Y>
X-ME-Received: <xmr:zi_cYze_J_hTDBpDhU4pX-zBUxHvmDSToIcUa5tGLpvNqIl-3nIsImeJ3N_LoD67PZkDOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnheplefghfefteelhfevffelveffgfetffefleef
    udduhfejudetgefgieehfeetheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:zi_cY5JAT5yWC_yYguaQNcMdpoQ--qAL91Y9CVsxWPbiQqnlx4zblA>
    <xmx:zi_cY4JunSA59xIOdK0tdqQ8X3xSJ9G50t0UY1S2q4ogP8toR8FDig>
    <xmx:zi_cY6x1D3GiNAyESIOel-oFSv2Wti7iqsQbbvi4nHpGx1W6YjkIIw>
    <xmx:zy_cY_UJg2-37tr6Teb6oJMt98PDAjMeZuZTvznjwgcasA6iwoeMNQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 16:49:02 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 049AC10E387; Fri,  3 Feb 2023 00:48:59 +0300 (+03)
Date:   Fri, 3 Feb 2023 00:48:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, Yin Fengwei <fengwei.yin@intel.com>,
        linux-mm@kvack.org
Subject: Re: API for setting multiple PTEs at once
Message-ID: <20230202214858.btrzrcevzxjfk6wg@box.shutemov.name>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
> For those of you not subscribed, linux-mm is currently discussing
> how best to handle page faults on large folios.  I simply made it work
> when adding large folio support.  Now Yin Fengwei is working on
> making it fast.
> 
> https://lore.kernel.org/linux-mm/Y9qjn0Y+1ir787nc@casper.infradead.org/
> is perhaps the best place to start as it pertains to what the
> architecture will see.
> 
> At the bottom of that function, I propose
> 
> +       for (i = 0; i < nr; i++) {
> +               set_pte_at(vma->vm_mm, addr, vmf->pte + i, entry);
> +               /* no need to invalidate: a not-present page won't be cached */
> +               update_mmu_cache(vma, addr, vmf->pte + i);
> +               addr += PAGE_SIZE;
> +		entry = pte_next(entry);
> +	}
> 
> (or I would have, had I not forgotten that pte_t isn't an integral type)
> 
> But I think that some architectures want to mark PTEs specially for
> "This is part of a contiguous range" -- ARM, perhaps?  So would you like
> an API like:
> 
> 	arch_set_ptes(mm, addr, vmf->pte, entry, nr);

Maybe just set_ptes(). arch_ doesn't contribute much.

> 	update_mmu_cache_range(vma, addr, vmf->pte, nr);
> 
> There are some challenges here.  For example, folios may be mapped
> askew (ie not naturally aligned).  Another problem is that folios may
> be unmapped in part (eg mmap(), fault, followed by munmap() of one of
> the pages in the folio), and I presume you'd need to go and unmark the
> other PTEs in that case.  So it's not as simple as just checking whether
> 'addr' and 'nr' are in some way compatible.

I think the key question is who is responsible for 'nr' being safe. Like
is it caller or set_ptes() need to check that it belong to the same PTE
page table, folio, VMA, etc.

I think it has to be done by caller and set_pte() has to be as simple as
possible.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
