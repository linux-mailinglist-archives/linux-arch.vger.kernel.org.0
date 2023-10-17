Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B57CC0AA
	for <lists+linux-arch@lfdr.de>; Tue, 17 Oct 2023 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjJQK0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Oct 2023 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJQK0q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Oct 2023 06:26:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90804B0;
        Tue, 17 Oct 2023 03:26:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20331C433C8;
        Tue, 17 Oct 2023 10:26:38 +0000 (UTC)
Date:   Tue, 17 Oct 2023 11:26:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>, will@kernel.org,
        oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
        akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
        pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZS5hXFHs08zQOboi@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
 <ZS0va9nICZo8bF03@monolith>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS0va9nICZo8bF03@monolith>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 16, 2023 at 01:41:15PM +0100, Alexandru Elisei wrote:
> On Thu, Oct 12, 2023 at 10:25:11AM +0900, Hyesoo Yu wrote:
> > I don't think it would be effcient when the majority of movable pages
> > do not use GFP_TAGGED.
> > 
> > Metadata pages have a low probability of being in the pcp list
> > because metadata pages is bypassed when freeing pages.
> > 
> > The allocation performance of most movable pages is likely to decrease
> > if only the request with ALLOC_FROM_METADATA could be allocated.
> 
> You're right, I hadn't considered that.
> 
> > 
> > How about not including metadata pages in the pcp list at all ?
> 
> Sounds reasonable, I will keep it in mind for the next iteration of the
> series.

BTW, I suggest for the next iteration we drop MIGRATE_METADATA, only use
CMA and assume that the tag storage itself supports tagging. Hopefully
it makes the patches a bit simpler.

-- 
Catalin
