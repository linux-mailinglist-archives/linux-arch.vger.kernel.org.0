Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F26C3744
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCUQpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCUQpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 12:45:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C76151CA6;
        Tue, 21 Mar 2023 09:44:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CEA320261;
        Tue, 21 Mar 2023 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679417094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPsXbsCSQsx4+31OHg2F79XEhh3WwJBis5RlDbou0ik=;
        b=m0EBA+mOapmgHDChG6dDD83Bg1A1gYYPvGbZbx+ve8KTAcv75Gn6fqTby7n6jhn+3OP5TT
        FVGYy3gOo21uCvlUxyvf/Tzhyh0u5+xsUB6B+FbUrIKo8Tp1qs06cQzAS1X2dMtuq63xPe
        DA4NcH52+Je1W4FhUY1QQWEVJwk6j6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679417094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPsXbsCSQsx4+31OHg2F79XEhh3WwJBis5RlDbou0ik=;
        b=f1//10OGnUmC7VAUfZFT3EIVe/DqgqMxn+eNaPwvJ3te8uI0VD+rWAwWpnB4YkZbF9v2dy
        6BND9QsYW94hSlBg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7BF882C141;
        Tue, 21 Mar 2023 16:44:53 +0000 (UTC)
Date:   Tue, 21 Mar 2023 16:44:51 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Message-ID: <20230321164451.wtv5okhfyxdxklsq@suse.de>
References: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 06:35:01PM +0300, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when pageblock is larger than MAX_ORDER, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.
> 

The problem with the sentence was pointed out already.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Otherwise;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
