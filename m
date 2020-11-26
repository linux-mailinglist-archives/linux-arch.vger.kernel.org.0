Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9B2C542A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbgKZMoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbgKZMoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8E0C0613D4;
        Thu, 26 Nov 2020 04:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2QxB9Tko6VxzQK7rF+Tls2ukwTI0b9ebxuRE3vlWOE=; b=gogxr3C6MfjHWJz/elZYnCYrgU
        seXxxFEQz3HV3q/C8U+iZUzPSdWt4ez5w8uGrwFwtqbKwWujFxjiUFve7iQadsSPUaEoKqzJXg1lH
        V9tXW2JSTkrNd8b1T//zdSuPd4EmMJYbFJHGeCxeo6BsJh9gVA7QRzi3+eYf48FRh6r1THx5M4oF0
        Oun1x5Z7MIA0oOX1Zbkj6bI4QXW2fQOOiimMwOFw3LSohE5YdOKWA/LW3vaJrq6fGCfkWKt1v8b83
        /YPBZTxuhh6rNrdLdw/s3O/9gbrvcfU8HwZtqUV/FR2AKyaFzQpObvGRvO3AMboxo+cIdno4h05lJ
        AG1abE2A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGcn-0002W5-Bq; Thu, 26 Nov 2020 12:43:49 +0000
Date:   Thu, 26 Nov 2020 12:43:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 2/6] mm: Introduce pXX_leaf_size()
Message-ID: <20201126124349.GQ4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.102580109@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126121121.102580109@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 01:01:16PM +0100, Peter Zijlstra wrote:
> A number of architectures have non-pagetable aligned huge/large pages.
> For such architectures a leaf can actually be part of a larger entry.
> 
> Provide generic helpers to determine the size of a page-table leaf.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
