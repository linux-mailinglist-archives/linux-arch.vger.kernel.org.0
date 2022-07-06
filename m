Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C1568E5D
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGFPxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiGFPxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 11:53:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B418398;
        Wed,  6 Jul 2022 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657122732; x=1688658732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y3/9f4gAnKgtfKYM4zXe/3Q35Ma8+prwhvKdkpVJo64=;
  b=UZqyyVFPijSkyZ6NJTB462HO9aUTSezlH62xGgsodKHzQjbZu2a0rn36
   ojFbUfqzs0M22mBV7oJSP/gTVUSoOt1A20XDyPG5cZIr6cY9pSqmM19Ym
   qwewCiMLgwjqNeg0zKTJF2EvLhFzdjjLCK4DkUOmfNlj1Bnv18Ki4G+UJ
   9ua4W6bwYkbzjUFRnxKccF2GvZ5eD2dmNEnxd+ivb7tLxwKRPPsR0gcmx
   WemhQwtSBEkw9PzwbTyYUkRrSnSLuq10iS0fDsoshT8LCDTDkQTGJl1xA
   +79EMxdedsvb1fJLZwY62SM2NsNZOF76hMAQ2ijzm7kEMZI3ANwNWvJvZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347770035"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="347770035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 08:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="620370161"
Received: from tjsteven-mobl3.amr.corp.intel.com (HELO [10.255.228.25]) ([10.255.228.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 08:50:12 -0700
Message-ID: <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
Date:   Wed, 6 Jul 2022 08:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, kernel@xen0n.name,
        tsbogend@alpha.franken.de, dave.hansen@linux.intel.com,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arnd@arndb.de, guoren@kernel.org,
        monstr@monstr.eu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/6/22 01:59, Baolin Wang wrote:
> Now we will miss to account the PUD level pagetable and kernel PTE level
> pagetable, as well as missing to set the PG_table flags for these pagetable
> pages, which will get an inaccurate pagetable accounting, and miss
> PageTable() validation in some cases. So this patch set introduces new
> helpers to help to account PUD and kernel PTE pagetable pages.

Could you explain the motivation for this series a bit more?  Is there a
real-world problem that this fixes?
