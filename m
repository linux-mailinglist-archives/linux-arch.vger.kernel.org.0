Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0F59575C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiHPKA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiHPKAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 06:00:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C574C45053;
        Tue, 16 Aug 2022 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rFcsh5EaXMjyQvBz6Px9JuV8hMB5E551U26Ntc3NwIA=; b=GJchraaCp4Klmfi3ZVHxYa9oRu
        b4agUH2uWZUTGNSV7SBi9fApi/iBoiVncfCPPHT8N/smFMxxCHdxc2qJL0NAbVmP78DMRliIAybve
        8oFbik7+x32aIcWla7kp5/4bFOB86cScaS8UEumAsr9W+yElrNSfNFCf5pwnIHawItattmLVPtF9Q
        nfyPrB4EWP+fCEnqnTrsY0Kxaw8X+ypYlJQyIHjy3clqn11hb/eScLGNIiJg3D3XNKZAnZcpbMVi5
        Sl+UKBGD4B3ss+b8KxyJ1OrSsUMsYYCNDfajqcuNNHcv/f0zui+onWZGz0gCItg5Kw8bJdifIBHG8
        +E+BKhcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNsRn-002ufq-7J; Tue, 16 Aug 2022 09:01:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E714980083; Tue, 16 Aug 2022 11:01:14 +0200 (CEST)
Date:   Tue, 16 Aug 2022 11:01:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815160706.tqd42dv24tgb7x7y@offworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 15, 2022 at 09:07:06AM -0700, Davidlohr Bueso wrote:
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index b192d917a6d0..ce2ec9556093 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -10,4 +10,7 @@
> 
>  void clflush_cache_range(void *addr, unsigned int size);
> 
> +#define flush_all_caches() \
> +	do { wbinvd_on_all_cpus(); } while(0)
> +

This is horrific... we've done our utmost best to remove all WBINVD
usage and here you're adding it back in the most horrible form possible
?!?

Please don't do this, do *NOT* use WBINVD.
