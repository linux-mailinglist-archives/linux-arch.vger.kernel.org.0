Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E813606439
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTPWU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJTPWK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 11:22:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0F537D3;
        Thu, 20 Oct 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666279329; x=1697815329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Aczg4Jc/OHYoyF/FrcuRG5QzhTL5LWV6IYaxF3YgRoE=;
  b=R7R530j0oSaubckB4nFTfgD1fvMX40pEPVuzSrlXU9SRq//Ie7DaSh+P
   GcSa27wyYQhWSNnJT03MJGdakEdjc1VtZfvFeDvL4JcMMJL70XM2ce4S4
   V1l6CzDG3nQLYIBgyzCD9cZqdBdxOI9/fZh9B9whp3a+QKEMOflfL5SuZ
   Ku5iPm8tbtBT1Dyg6IhLdNN8L2YFhQrsXoVT3C7DAfOt+/Ddz5YNQl7w8
   w3AP4s0hb+SbYzwEDIyRuqy+QbH2jqd0XYRHCVg3zV45VFFVOII37mAjE
   p7i3URCAZgmgTceSc0qbHx8itbc97XevVWUxeTj8PfYSvP+MsxmRcQbMH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="307840395"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="307840395"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:22:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="698724218"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="698724218"
Received: from amancuso-mobl.amr.corp.intel.com (HELO [10.209.121.211]) ([10.209.121.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:22:07 -0700
Message-ID: <edb1c35e-03d5-5a5a-5157-103a9d9bc3ae@intel.com>
Date:   Thu, 20 Oct 2022 08:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V12 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
References: <20221020072317.492906-1-chenhuacai@loongson.cn>
 <20221020072317.492906-4-chenhuacai@loongson.cn>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221020072317.492906-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/20/22 00:23, Huacai Chen wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
> share its implementation.
> 
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/arm64/mm/mmu.c      | 55 +++++++-----------------
>  arch/loongarch/mm/init.c | 59 +++++++-------------------
>  arch/x86/mm/init_64.c    | 92 ++++++++++++++--------------------------
>  include/linux/mm.h       |  6 +++
>  mm/sparse-vmemmap.c      | 63 +++++++++++++++++++++++++++
>  5 files changed, 132 insertions(+), 143 deletions(-)

Thanks for doing this.  It's always nice to see the per-arch duplication
get collapsed!

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
