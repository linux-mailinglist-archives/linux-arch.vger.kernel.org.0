Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34366C376D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCUQxV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCUQxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 12:53:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14B2C66D;
        Tue, 21 Mar 2023 09:53:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A23A4220DD;
        Tue, 21 Mar 2023 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679417597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nBE9GGxWfLZ1oqCJragID3QYPPZTBZkYoUIsyNkXCs=;
        b=OU+t0QCGM2F5DdEv3plMelhxpX+8gj61gzp88vMBUvHy0VHreOBDj8Ob9mJgy3j4q3KvSK
        yid0ZdcmnZP1vs6Rdu4ZnDPeAEC0NVcCxdFDChz+TCMDn0jcJJZ+XTRnbljOD0+tHFv3x/
        Zi0/u3byi5A1lSz2CUbme7BEexPwUw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679417597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nBE9GGxWfLZ1oqCJragID3QYPPZTBZkYoUIsyNkXCs=;
        b=q+TAUk1uL1gaiZgh0k/bXYEjoHAED7RYSQ9lY7B5qiX2ARgnrKvcP0ex33xAEL2Z5JTPIp
        NdsYAXezYbXnwXAw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C1E812C141;
        Tue, 21 Mar 2023 16:53:16 +0000 (UTC)
Date:   Tue, 21 Mar 2023 16:53:14 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Message-ID: <20230321165314.krlhfmko6j52jfze@suse.de>
References: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 03:24:15AM +0300, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when MAX_ORDER is larger than pageblock, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
