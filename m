Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5551DE5C
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiEFRf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444142AbiEFRf2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 13:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C650449;
        Fri,  6 May 2022 10:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F02FFB8381C;
        Fri,  6 May 2022 17:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3C9C385AC;
        Fri,  6 May 2022 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651858302;
        bh=XM4Gk5T8GH7GMEQf6U7SdCZ/bJ3i7FcXCA8a6u/+Phw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuEgS8uT/cx0rVZpl3sJSdC+aa46jfK7MQTmuUq1/7k/Q1utE92cfKe2AwGDY4Szm
         zqucEQ9F4R+MHnozBuS4/elW/i5mKokD5lKRwYCRpx+Pa6HXThFwzqoWdApxm1HsX9
         ODHxvi5F7XaFwBO5T64FGZTtnOWHhNGzQ/wbffhcqHRORum3xp1cvXJqRUyGQXm81F
         rXChqOeKXsj0KYO38Bi7qpGWDKvTg5nSi19tvRpYc2rYYqR7ROT3ZwxU3IPtFK8EbC
         k1Nex2dBChoxmrlm4S/SIaSepRjZqL/Yv4T1Fc/0CroYXjyRrbedY4OFjB8sCb0g45
         brfTNsHvA284A==
Date:   Fri, 6 May 2022 10:31:40 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, maz@kernel.org,
        tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Message-ID: <20220506173140.gkuhf3kzxq7mxfi2@treble>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
 <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
 <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
 <20220505092448.GE2501@worktop.programming.kicks-ass.net>
 <YnOtbYOIT5OP7F0g@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnOtbYOIT5OP7F0g@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 05, 2022 at 11:56:45AM +0100, Mark Rutland wrote:
> The objects under arch/arm64/kernel/{vdso,vdso32}/ are all userspace objects,
> and from userspace's PoV the existing secrtions within those objects are
> correct, so I don't think those should change.
> 
> How does x86 deal with its vdso objects?

On x86, we just use OBJECT_FILES_NON_STANDARD (like the up-thread patch)
to tell objtool to ignore all the vdso objects.

That should be fine for vdso, since it doesn't actually end up as text
in vmlinux.

-- 
Josh
