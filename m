Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29973A1F5
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFVNh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFVNh4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 09:37:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11421996;
        Thu, 22 Jun 2023 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687441075; x=1718977075;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=88JqeT9MZdKfshSYWUg9b2Zs8SDEVOQUaP4tUg0s77U=;
  b=QcydbnxOAYGsU7s6CiSg/Q9FtoSSnuqDhKkZVw73ADnb/iA1nOXCd+XP
   X7ORav5LwnS8OtBOU6/ENCsw+2dbX+jjccMUX/cEcNDV54RHStnh3glVg
   QCpxt5CeqtwOuc09r4Si1Rjnn5UUNz0YSM+h2QxFuiE4UGelpiRbSeKyb
   9GH8s/VCGTgPFrjJd3p1N5mtKlEha3fjNyC758mXOWsfer1HdyQMR0cua
   2Z6KwqtCOwl72EfGulDrRel59pnHtxByRa9Hrddu0lmhoxA94LKxJZkD6
   06G1p+aP0TGwLUPvcuHC5jkdUVdPjfO4ShE0RSUXy1CDWPyzWzQ5m3W3q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357982784"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="357982784"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1045176209"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="1045176209"
Received: from pajgaonk-mobl1.amr.corp.intel.com (HELO [10.212.235.136]) ([10.212.235.136])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:37:51 -0700
Message-ID: <d0ef9148-3c95-87bb-26f9-ea0920a4faa4@intel.com>
Date:   Thu, 22 Jun 2023 06:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
Content-Language: en-US
To:     ypodemsk@redhat.com, mtosatti@redhat.com, ppandit@redhat.com,
        david@redhat.com, linux@armlinux.org.uk, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
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
 <680fadba-9104-3914-5175-e207fd3d9246@intel.com>
 <79f29f99fa07c46dbaee7b802cdd7b477b2d8dd1.camel@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <79f29f99fa07c46dbaee7b802cdd7b477b2d8dd1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/22/23 06:14, ypodemsk@redhat.com wrote:
> I will send a new version with the local variable as you suggested
> soon.
> As for the config name, what about CONFIG_ARCH_HAS_MM_CPUMASK?

The confusing part about that name is that mm_cpumask() and
mm->cpu_bitmap[] are defined unconditionally.  So, they're *around*
unconditionally but just aren't updated.

BTW, it would also be nice to have _some_ kind of data behind this patch.

Fewer IPIs are better I guess, but it would still be nice if you could say:

	Before this patch, /proc/interrupts showed 123 IPIs/hour for an
	isolated CPU.  After the approach here, it was 0.

... or something.
