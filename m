Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFF6738D75
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFURnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 13:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFURnb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 13:43:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4912683;
        Wed, 21 Jun 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369388; x=1718905388;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LVptCrukcCrf+ulAXv9iJ2UzZRi1STprNI7mWSySJig=;
  b=fCEMW8Pv79l+5VjM3UXkHi80A8kTMJtGyELw8Am/KWZ3Dz7X3oeaD+P8
   RvKHDQIrg2Z8Cao83ZDt9z4r8+k+xIGNSHxrFQgna0m9qFVTFCfdeblKi
   zTWkwXD+6Y+7ntwZoonr7gDAji2eC1OyNdITkzvtEZFujGIBkB2QhPtJ6
   u8L2C8p90A69bKzAXXQ5jxejkq4iL6kzzBB/PZK5041o89MrdY2TGZuw/
   gDYZpQjzt0zLMNqVSiLNl0sQ2HuDbxMcdOuturMqzhEfuDZiUwuh9bjdj
   QSn0Be9HgXxwizBSxnYn8ZYIVSpwg/Yqc5BEfb+Klv78ObVEo2a/+BQqb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339870177"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="339870177"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1044816796"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="1044816796"
Received: from rmathew-mobl2.amr.corp.intel.com (HELO [10.212.134.235]) ([10.212.134.235])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:42:16 -0700
Message-ID: <680fadba-9104-3914-5175-e207fd3d9246@intel.com>
Date:   Wed, 21 Jun 2023 10:42:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
Content-Language: en-US
To:     Yair Podemsky <ypodemsk@redhat.com>, mtosatti@redhat.com,
        ppandit@redhat.com, david@redhat.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, frederic@kernel.org,
        will@kernel.org, peterz@infradead.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230620144618.125703-1-ypodemsk@redhat.com>
 <20230620144618.125703-3-ypodemsk@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230620144618.125703-3-ypodemsk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/20/23 07:46, Yair Podemsky wrote:
> -void tlb_remove_table_sync_one(void)
> +#ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
> +#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
> +#else
> +#define REMOVE_TABLE_IPI_MASK cpu_online_mask
> +#endif /* CONFIG_ARCH_HAS_CPUMASK_BITS */
> +
> +void tlb_remove_table_sync_one(struct mm_struct *mm)
>  {
>  	/*
>  	 * This isn't an RCU grace period and hence the page-tables cannot be
> @@ -200,7 +206,8 @@ void tlb_remove_table_sync_one(void)
>  	 * It is however sufficient for software page-table walkers that rely on
>  	 * IRQ disabling.
>  	 */
> -	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> +	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
> +			NULL, true);
>  }

That "REMOVE_TABLE_IPI_MASK" thing is pretty confusing.  It *looks* like
a constant.  It does *NOT* look at all like it consumes 'mm'.  Worst
case, just create a local variable:

	if (IS_ENABLED(CONFIG_ARCH_HAS_CPUMASK_BITS))
		ipi_mask = mm_cpumask(mm);
	else
		ipi_mask = cpu_online_mask;

	on_each_cpu_mask(ipi_mask, ...);

That's a billion times more clear and it'll compile down to the same thing.

I do think the CONFIG_ARCH_HAS_CPUMASK_BITS naming is also pretty
confusing, but I don't have any better suggestions.  Maybe something
with "MM_CPUMASK" in it?
