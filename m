Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896217CA838
	for <lists+linux-arch@lfdr.de>; Mon, 16 Oct 2023 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJPMlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Oct 2023 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjJPMlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Oct 2023 08:41:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BD30E8;
        Mon, 16 Oct 2023 05:41:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589ACDA7;
        Mon, 16 Oct 2023 05:42:30 -0700 (PDT)
Received: from monolith (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 547E43F5A1;
        Mon, 16 Oct 2023 05:41:44 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:42:17 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, pcc@google.com,
        steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 17/37] arm64: mte: Disable dynamic tag storage
 management if HW KASAN is enabled
Message-ID: <ZS0vqbWnI-_bA7tH@monolith>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-18-alexandru.elisei@arm.com>
 <CGME20231012014514epcas2p3ca99a067f3044c5753309a08cd0b05c4@epcas2p3.samsung.com>
 <20231012013505.GB2426387@tiffany>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012013505.GB2426387@tiffany>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, Oct 12, 2023 at 10:35:05AM +0900, Hyesoo Yu wrote:
> On Wed, Aug 23, 2023 at 02:13:30PM +0100, Alexandru Elisei wrote:
> > Reserving the tag storage associated with a tagged page requires the
> > ability to migrate existing data if the tag storage is in use for data.
> > 
> > The kernel allocates pages, which are now tagged because of HW KASAN, in
> > non-preemptible contexts, which can make reserving the associate tag
> > storage impossible.
> > 
> > Don't expose the tag storage pages to the memory allocator if HW KASAN is
> > enabled.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  arch/arm64/kernel/mte_tag_storage.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index 4a6bfdf88458..f45128d0244e 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -314,6 +314,18 @@ static int __init mte_tag_storage_activate_regions(void)
> >  		return 0;
> >  	}
> >  
> > +	/*
> > +	 * The kernel allocates memory in non-preemptible contexts, which makes
> > +	 * migration impossible when reserving the associated tag storage.
> > +	 *
> > +	 * The check is safe to make because KASAN HW tags are enabled before
> > +	 * the rest of the init functions are called, in smp_prepare_boot_cpu().
> > +	 */
> > +	if (kasan_hw_tags_enabled()) {
> > +		pr_info("KASAN HW tags enabled, disabling tag storage");
> > +		return 0;
> > +	}
> > +
> 
> Hi.
> 
> Is there no plan to enable HW KASAN in the current design ? 
> I wonder if dynamic MTE is only used for user ? 

The tag storage pages are exposed to the page allocator if and only if HW KASAN
is disabled:

static int __init mte_tag_storage_activate_regions(void)
[..]
        /*
         * The kernel allocates memory in non-preemptible contexts, which makes
         * migration impossible when reserving the associated tag storage.
         *
         * The check is safe to make because KASAN HW tags are enabled before
         * the rest of the init functions are called, in smp_prepare_boot_cpu().
         */
        if (kasan_hw_tags_enabled()) {
                pr_info("KASAN HW tags enabled, disabling tag storage");
                return 0;
        }

No plans at the moment to have this series compatible with HW KASAN. I will
revisit this if/when the series gets merged.

Thanks,
Alex

> 
> Thanks,
> Hyesoo Yu.
> 
> 
> >  	for (i = 0; i < num_tag_regions; i++) {
> >  		tag_range = &tag_regions[i].tag_range;
> >  		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages) {
> > -- 
> > 2.41.0
> > 
> > 


