Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD633FB8F
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 23:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQW7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 18:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQW6o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Mar 2021 18:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE4D64D9F;
        Wed, 17 Mar 2021 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616021924;
        bh=mPPiBe/bfcCRC6s/WTecgYs69LyDrOV06BZGWgBGh88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQSoeij97X1M0/w9/5ziAaBjrHs7Y+lZ8IrLV+fkfU6KJaRXfc1FGuav4T0Y3J1fQ
         yLo8aYxQ1lsBrOcKJ1OBBCFyCYguMi3sy4Ipqa3HZMDImJS81fMq7cps2fgDiug5GZ
         zPzfIg6paHc2D+BMdx135Babgj1f/oULiTX9Y6VA=
Date:   Wed, 17 Mar 2021 15:58:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v13 00/14] huge vmalloc mappings
Message-Id: <20210317155843.c15e71f966f1e4da508dea04@linux-foundation.org>
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 17 Mar 2021 16:23:48 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> 
> *** BLURB HERE ***
> 

That's really not what it means ;)

Could we please get a nice description for the [0/n]?  What's it all
about, what's the benefit, what are potential downsides.

And performance testing results!  Because if it ain't faster, there's
no point in merging it?
