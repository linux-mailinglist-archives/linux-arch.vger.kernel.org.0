Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3E651A6D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLTFwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiLTFwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:52:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D5140FD;
        Mon, 19 Dec 2022 21:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A8FB80B4A;
        Tue, 20 Dec 2022 05:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98797C433D2;
        Tue, 20 Dec 2022 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671515523;
        bh=k6yHixLVE3U9pNLPDWoHZ8KCCDWLbUAFeGls6uMNDVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4qNxFEfAoICReXUu76kgpqClyhio4C1oWONukCsmPCtnJMTXqLKY/m0Zs8UuFTZM
         g5pDbnx7DvNBykzHCq4TlDro7TQyNy/534mmFbSOTdvL5jKkLzTnUTjBSJNabIwgiJ
         exdOfYcQMkl9Y+BJ0s6BqbBOupPanLr5iAAi4rQcTU9beGwI7FspZO42Jj/YleWHxQ
         lHx6k8EG785snbOE8YixAvsAeO3IOEGbbEHiouhdS5KAa9YYOuVFPAaBGcVx/Mr+ux
         qnboVZ01KM2R7CpAc6cboF8ArJaT18WLDGgLa66+eDIzC8ifHTQpDxOMBXFAmlYv00
         qpNuFncUWMCBQ==
Date:   Mon, 19 Dec 2022 21:52:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 03/12] cyrpto/b128ops: Remove struct u128
Message-ID: <Y6FNgNQ8/I9uqYwc@sol.localdomain>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.022180444@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.022180444@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:28PM +0100, Peter Zijlstra wrote:
> cyrpto/b128ops: Remove struct u128

cyrpto => crypto

> Per git-grep u128_xor() and its related struct u128 are unused except
> to implement {be,le}128_xor(). Remove them to free up the namespace.

There's still a reference to u128 in drivers/crypto/vmx/ghash.c.  But, it's only
dereferenced by assembly code, so it should keep working even if u128 gets
redefined to a native int.  I don't speak PowerPC, so I'm not sure what the
"correct" type is there.

- Eric
