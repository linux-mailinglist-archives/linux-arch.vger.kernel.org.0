Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CF58F3C5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiHJVXJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVXI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 17:23:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4410541;
        Wed, 10 Aug 2022 14:23:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E6ECB821994;
        Wed, 10 Aug 2022 21:13:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a301.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2C5F882170E;
        Wed, 10 Aug 2022 21:13:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660166022; a=rsa-sha256;
        cv=none;
        b=ps73b2SUxkvE1hdSj4jgMlJcR6SOyPrGBgxwGYcbKdP7LaqkCbUynH8M5JyWbE7VF+Ug84
        sRgS6I3C6BGgvDJrqT7MrafW8CRyzthHOYX9kNQ1EzKibJBRAzGUB7aBtWIlB1ZqCLhysg
        VNvpowvPjBiVJ/gAP8YJrMeNb2V+cVSIaVc2V0AfxHf0ym//CN6ztEk9N/EcDFJX7Abpvm
        zGlHcoAJYffzoKV2B49J5NTVw/N5ZvOQf2+q0fhkpQt1FjBuFNsFqZ9NWlfY/6ISx8h0k6
        pKr52BGJ6ZuKPk6k8AhZFetFe/lEVe8SMq0hmas4e1hMtKX53+nzpO1jqpgIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660166022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=e1bm2IP5sdf1tCIrl5T23ze6bEl+DGHSYHzaFyz8rEo=;
        b=il63h9oEHLKGUonm/gU+L9d1TP2Xo8GmUd8Ux84Gm6zQnlA3g6z3SJxlqlvWPvg5gakYie
        luynkKhxs9A5UP9nuyMvUjmOCVgIbJcNqzlUe81NsfiedCkoABgeL8LDt+/yfyNSWICl6u
        YPqDlaE1PzhH5mdMz6x1rPrh9Q/PLdsagJmZqL6IcKnMjnbFyppgV/G3dtRNeVgeLGU6ln
        4WSrH/95XGxGT7bsaDn5wWTww4kR/QVexHYZ/ymnBbYro6z6ct1JoX5ZK0ribLkwOgSOPo
        cudqVuW1DipXwyBAvVu0yXGhj1S1qj88z6cB0V5GEJ3o9AEYk27ceF5GS1OOZQ==
ARC-Authentication-Results: i=1;
        rspamd-7586b5656-kskzc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Stop: 7177ff9d6dc4c047_1660166022722_2415375917
X-MC-Loop-Signature: 1660166022722:1709658693
X-MC-Ingress-Time: 1660166022722
Received: from pdx1-sub0-mail-a301.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.58 (trex/6.7.1);
        Wed, 10 Aug 2022 21:13:42 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a301.dreamhost.com (Postfix) with ESMTPSA id 4M32jc5wMYz64;
        Wed, 10 Aug 2022 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660166021;
        bh=e1bm2IP5sdf1tCIrl5T23ze6bEl+DGHSYHzaFyz8rEo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=A5K6iDwodcK6bM0P/mUDtKfab9ELJl8ZVSQTJL+iIC3xLsFelM8BWgnN5h+6H1Y4a
         t7g9m/gyPNKmQSVCK4T4z9ZRGHmLBZ2zgtqAnf10PSx5zn+RtjFd+pvg531NntEw4c
         ETUuYhZq9hTgXm38+M7sYoxCzrN+VlabHw5CcH4SRpmdrDPlwAXqBuhPG37F2huBuw
         2jh/gLiHpi4TKlVwXa3PcDLKUDTini8LpGCAcaBlgQ7sfm8nz7Hc34W84oHbhQbAFi
         ZIEWWdIqgSM66YTAmxOJ453R/roNMnPbN91X1teB4Embw7HtRH/Y4EPn5hW02jJOzx
         lPwEyZ7kmMleQ==
Date:   Wed, 10 Aug 2022 14:13:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 10/15] x86: add an arch helper function to invalidate
 all cache for nvdimm
Message-ID: <20220810211337.ha27cl24splm4wjh@offworld>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 10 Aug 2022, Dan Williams wrote:

>I expect the interface would not be in the "flush_cache_" namespace
>since those functions are explicitly for virtually tagged caches that
>need maintenance on TLB operations that change the VA to PA association.
>In this case the cache needs maintenance because the data at the PA
>changes. That also means that putting it in the "nvdimm_" namespace is
>also wrong because there are provisions in the CXL spec where volatile
>memory ranges can also change contents at a given PA, for example caches
>might need to be invalidated if software resets the device, but not the
>platform.
>
>Something like:
>
>    region_cache_flush(resource_size_t base, resource_size_t n, bool nowait)
>
>...where internally that function can decide if it can rely on an
>instruction like wbinvd, use set / way based flushing (if set / way
>maintenance can be made to work which sounds like no for arm64), or map
>into VA space and loop. If it needs to fall back to that VA-based loop
>it might be the case that the caller would want to just fail the
>security op rather than suffer the loop latency.

Yep, I was actually prototyping something similar, but want to still
reuse cacheflush.h machinery and just introduce cache_flush_region()
or whatever name, which returns any error. So all the logic would
just be per-arch, where x86 will do the wbinv and return 0, and arm64
can just do -EINVAL until VA-based is no longer the only way.

Thanks,
Davidlohr
