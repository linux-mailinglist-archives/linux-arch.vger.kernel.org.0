Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8E39EBA3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 03:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFHBuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 21:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHBuJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 21:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8208860FE4;
        Tue,  8 Jun 2021 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623116886;
        bh=Q+5SvaOmqmPqR5Wg8GMpvtupvlOuAHY76M4MzKRjOlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=woVcnjT2gvMlMWupzbm2RW1aHD1OpFrxMPpGTUAlHEqwXyI+cqSEqpahSce9sUa23
         PX7XyEWUPXze2G2Xc83G0Hs999jBFcv3Pkf8Fj6xeYUV1QWlNdJO3BDpVcAT4dcFoC
         SQ8y+ueymlzsAPBdddPwS27YmwAOpFQ5DXJ/VzSQ=
Date:   Mon, 7 Jun 2021 18:48:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/4] lazy tlb: introduce lazy mm refcount helper
 functions
Message-Id: <20210607184805.eddf8eb26b80e8af85d5777e@linux-foundation.org>
In-Reply-To: <1623116020.vyls9ehp49.astroid@bobo.none>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-2-npiggin@gmail.com>
        <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
        <1623116020.vyls9ehp49.astroid@bobo.none>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 08 Jun 2021 11:39:56 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> > Looks like a functional change.  What's happening here?
> 
> That's kthread_use_mm being clever about the lazy tlb mm. If it happened 
> that the kthread had inherited a the lazy tlb mm that happens to be the 
> one we want to use here, then we already have a refcount to it via the 
> lazy tlb ref.
> 
> So then it doesn't have to touch the refcount, but rather just converts
> it from the lazy tlb ref to the returned reference. If the lazy tlb mm
> doesn't get a reference, we can't do that.

Please cover this in the changelog and perhaps a code comment.
