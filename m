Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5347D3D11
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjJWRIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJWRIf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 13:08:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73AFD79;
        Mon, 23 Oct 2023 10:08:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBAEC433C8;
        Mon, 23 Oct 2023 17:08:24 +0000 (UTC)
Date:   Mon, 23 Oct 2023 18:08:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
        akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
        pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZTaohewXhtkqoLZD@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
 <ZS0va9nICZo8bF03@monolith>
 <ZS5hXFHs08zQOboi@arm.com>
 <20231023071656.GA344850@tiffany>
 <ZTZP66CA1r35yTmp@arm.com>
 <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 23, 2023 at 01:55:12PM +0200, David Hildenbrand wrote:
> On 23.10.23 12:50, Catalin Marinas wrote:
> > On Mon, Oct 23, 2023 at 04:16:56PM +0900, Hyesoo Yu wrote:
> > > Does tag storage itself supports tagging? Will the following version be unusable
> > > if the hardware does not support it? The document of google said that
> > > "If this memory is itself mapped as Tagged Normal (which should not happen!)
> > > then tag updates on it either raise a fault or do nothing, but never change the
> > > contents of any other page."
> > > (https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)
> > > 
> > > The support of H/W is very welcome because it is good to make the patches simpler.
> > > But if H/W doesn't support it, Can't the new solution be used?
> > 
> > AFAIK on the current interconnects this is supported but the offsets
> > will need to be configured by firmware in such a way that a tag access
> > to the tag carve-out range still points to physical RAM, otherwise, as
> > per Google's doc, you can get some unexpected behaviour.
[...]
> I followed what you are saying, but I didn't quite read the following
> clearly stated in your calculations: Using this model, how much memory would
> you be able to reuse, and how much not?
> 
> I suspect you would *not* be able to reuse "1/(32*32)" [second carve-out]
> but be able to reuse "1/32 - 1/(32*32)" [first carve-out] or am I completely
> off?

That's correct. In theory, from the hardware perspective, we could even
go recursively to the third/fourth etc. carveout until the last one is a
single page but I'd rather not complicate things further.

> Further, (just thinking about it) I assume you've taken care of the
> condition that memory cannot self-host it's own tag memory. So that cannot
> happen in the model proposed here, right?

I don't fully understand what you mean. The tags for the first data
range (0 .. ram_size * 31/32) are stored in the first tag carveout.
That's where we'll need CMA. For the tag carveout, when hosting data
pages as tagged, the tags go in the second carveout which is fully
reserved (still TBD but possibly the firmware won't even tell the kernel
about it).

-- 
Catalin
