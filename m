Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA036C3089
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 12:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCULlK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCULlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 07:41:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66A2170E;
        Tue, 21 Mar 2023 04:41:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6782021C90;
        Tue, 21 Mar 2023 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679398866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwTj1oxYQNef9fyW1y1b6zGbRy/MsPXVId7UhSbxGHo=;
        b=PKV3JR3WSlhF3QR+TaeAlwtUggs2deWrLqNLbNztOzVlTqPHbHCD2S22muGH8UAsbytSCU
        HwKieIj/PsmbG/SLsuW4fwrr+ngHvqcqP/gStK0HeUpk1jsc6Tq0t5iocR1HGJIRCilPTp
        tIcb0OOPPiMNvc0/nTwbn9hO0jaBUi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679398866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwTj1oxYQNef9fyW1y1b6zGbRy/MsPXVId7UhSbxGHo=;
        b=CWZ8vl7U0gaxKv/IxIhWPeI1F3rphj7OJKaqjGufGdo+v8qg1QqDR+dQcIeI1D/AT6XQJn
        pxhAG8WcUFpP1pDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3518D13451;
        Tue, 21 Mar 2023 11:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5zO6C9KXGWTyAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 11:41:06 +0000
Message-ID: <38b82ca1-29c2-4ce5-b7d6-bf1b7dcc365b@suse.cz>
Date:   Tue, 21 Mar 2023 12:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv2] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/21/23 01:24, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when MAX_ORDER is larger than pageblock, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.

Looks like the problems with migratetype were why commit e780149bcd4b ("mm:
fix set pageblock migratetype in deferred struct page init") switched it
from MAX_ORDER to pageblock_order. This should work better.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But I think you'll have to rebase on mm-unstable that moved some of the code
to mm_init.c

