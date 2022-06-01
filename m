Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8E53AA6B
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiFAPs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355820AbiFAPsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 11:48:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ACBA5A90;
        Wed,  1 Jun 2022 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VXYr3ATzNWQCnRCt+pdqql8XBT4Y9x24RSawilp3c7g=; b=PCBwW45dCyoYbCgGK8uDmSQpHv
        r68xn3QcmUPMkNrYThktGCr9gEjwQlaFp+7FQraLZGPD710WJCe0SwYTApjklaOP5CJMVxdpFP8hc
        vtKwBXCwCrXyFGU6u4s6YZB/VZyHVwDOAKMji435HNR4o3OtnfFbJOmz54HZymfO+Y71OHMD0rMTB
        FLUoqwmygi+1xQhfjBB1wuxwjfdYeu3ahhGFnhpMkSoMMgAeKNums3DHq6bFOfDmqxdBS0gRP2rzm
        GnqQvzxcDGskSYgXjeLAfwT5zSkzgOuOEE8yTZw6IOSrs9I/5yMmGctDOIctZdk029uwxEF3Qpk6V
        O+O1pJTA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQZh-003p4F-So; Wed, 01 Jun 2022 15:47:59 +0000
Message-ID: <ddf17a99-5c68-4be9-d073-124538b9d51e@infradead.org>
Date:   Wed, 1 Jun 2022 08:47:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V12 07/24] LoongArch: Add build infrastructure
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-8-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220601100005.2989022-8-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi--

On 6/1/22 02:59, Huacai Chen wrote:
> +config 32BIT
> +	bool
> +
> +config 64BIT
> +	def_bool y
> +

I don't see a way to set (enable) 32BIT.
Please explain how to do that.

thanks.
-- 
~Randy
