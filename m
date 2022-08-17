Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6953A596AAE
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiHQHyi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 03:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHQHyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 03:54:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB076FA13;
        Wed, 17 Aug 2022 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YZL2udXtnu7kSf5BoGRC8CmiIz9CMCVJ89aCm+TG/5Y=; b=L3LmfID7hue/edze1z7PIN388E
        E7FKX7AcKxTUNphdOSos96NgmPrzoTocC9DSen7qeNo1CJZTfCj36gttmcbnUovkcju9Ld1zJf2ZD
        cVSaJJ1/64ko20P7ujwBYOCblqjQVvVMNTREmZJwJKR+bRpJBn4AL4YUnOdDodVL4V3EIU1jy1tnA
        jRE6w+Vd23i3b7l+epsFD/PAXC57YdS6JcBLc3rZkjgzy35RYGlWl6zXhHxOr4JoIPYnhjbdltWsp
        TG2diUWec2TK111lBwGZrwiDmh08U7R/G9VQyKbrj6gKfeMFdL9fTAneh5oORPrjJgTJ7z5UXCTFE
        j3R5H5YA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oODs9-003Cne-Al; Wed, 17 Aug 2022 07:53:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CCD298007A; Wed, 17 Aug 2022 09:53:52 +0200 (CEST)
Date:   Wed, 17 Aug 2022 09:53:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
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
Message-ID: <YvyekFhBWQ6qlAP6@worktop.programming.kicks-ass.net>
References: <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld>
 <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
 <62fbcae511ec1_dfbc129453@dwillia2-xfh.jf.intel.com.notmuch>
 <20220816165301.4m4w6zsse62z4hxz@offworld>
 <CAA9_cmfBubQe6EGk5+wjotvofZavfjFud-JMPW13Au0gpAcWog@mail.gmail.com>
 <20220816175259.o5h5wv23rs2bvcu6@offworld>
 <62fbe6d7b75ae_f2f5129482@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fbe6d7b75ae_f2f5129482@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 16, 2022 at 11:49:59AM -0700, Dan Williams wrote:

> What would have helped is if the secure-erase and unlock definition in
> the specification mandated that the device emit cache invalidations for
> everything it has mapped when it is erased. However, that has some
> holes, and it also makes me think there is a gap in the current region
> provisioning code. If I have device-A mapped at physical-address-X and then
> tear that down and instantiate device-B at that same physical address
> there needs to be CPU cache invalidation between those 2 events.

Can we pretty please get those holes fixed ASAP such that future
generations can avoid the WBINVD nonsense?
