Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6456C4A43
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 13:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCVMVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCVMVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 08:21:30 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C83655A1
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 05:21:00 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8D44C242D46;
        Wed, 22 Mar 2023 13:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679487657;
        bh=x6zKmZSNIkH5LKJBa5kynkTRRptRZMcqJv2vXwQmUVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2EUlaWdQuQbxWwtZvUxSmpn0dZVU74T+aJqXx4xiEO4ktZlQHrs+jWXX6fVpPRf+
         C2yseqq5ZVnO3OcnTdu27IhCffNb9PuQexnPkpwoQkdtz2zSN7UNZ4i/Zi9Y+S5OoX
         jRjQ7f3NVMuwYWfmCMMHbsjM1Q3yIL8iXPrnEqotzG5fgYb3XCQy/WBf9JQkTRk4+O
         yDjVIbzBm83vdC7TyxiXFYiNWfQ+Wu/txQ6quKqeQ6Dd8TRbrU55NB3Vae3cnxSwHY
         9kB8631jYn1qUFAmidvClMMuS9wdXnyxje/YSZ4E/71cNgLlhOGBl6LuDShLismRVw
         NWsS4xlVvoRfA==
Date:   Wed, 22 Mar 2023 13:20:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 09/10] iommu: Fix MAX_ORDER usage in
 __iommu_dma_alloc_pages()
Message-ID: <ZBryqPza5Ato+HFT@8bytes.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
 <97aced64-c0ac-6041-41cd-ae3439216089@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97aced64-c0ac-6041-41cd-ae3439216089@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 12:18:31PM +0000, Robin Murphy wrote:
> I'm guessing you probably want to take this through the mm tree - that
> should be fine since I don't expect any conflicting changes in the IOMMU
> tree for now (cc'ing Joerg just as a heads-up).

Yes, mm tree is fine for this:

Acked-by: Joerg Roedel <jroedel@suse.de>
