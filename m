Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE24D268B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 05:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiCIBic (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 20:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiCIBiZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 20:38:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE5BF953;
        Tue,  8 Mar 2022 17:37:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCvvM5DSQz4xdl;
        Wed,  9 Mar 2022 12:37:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646789841;
        bh=p1p4VSMUJYVQ87kKlKJCoseMUR6jFyJEysr+m3gIwi0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kg4LLqW19iBCuq6n4YWNFuQaigJTPm2LPygRh+xs6IVrctsXaXt3ILv9VhGErZIg6
         De9njLj/wF5dAdJJLt5SxO61eaCgUqPMe1isTs6EegH4AnCAlKz4BRMBcBMYg+fF/o
         L1VMXucsVKKJhzcj0i7Mi/DrmHB78UZ9JVE+OGdyuInE474Tu3KF5VA3O8PaX7Hqq8
         EmehPbpWFGyHpvLOOoRZhgQmFdZPeiCEk4eqcTMrx7/Tj/FNsQEICY4kKzlXp/H91c
         yU/06lKGdyFkDF9YlPTi3xCkMehPi73O1kmPCk1nG8uGpdhh1XnCRgrOxpbFcJvNhC
         bej463KEgL1IQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
In-Reply-To: <164674125384.3322453.12551849351633372798.b4-ty@ellerman.id.au>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <164674125384.3322453.12551849351633372798.b4-ty@ellerman.id.au>
Date:   Wed, 09 Mar 2022 12:37:14 +1100
Message-ID: <87r17bnbxx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 15 Feb 2022 13:40:55 +0100, Christophe Leroy wrote:
>> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
>> on those three architectures because LKDTM messes up function
>> descriptors with functions.
>> 
>> This series does some cleanup in the three architectures and
>> refactors function descriptors so that it can then easily use it
>> in a generic way in LKDTM.
>> 
>> [...]
>
> Applied to powerpc/next.

I also have it in an rc2-based topic branch if there are any merge
conflicts that people want to resolve, I don't see any in linux-next at
the moment though.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/func-desc-lkdtm

cheers
