Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6233D26D5F1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIQILQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 04:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIQILO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Sep 2020 04:11:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99BF2075B;
        Thu, 17 Sep 2020 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600330273;
        bh=eg3lR9x3657HMHEjPx3Tzvtby/XM1NAWCcAT0pbyLKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qikKcdH3N7nwiA2vnr+2K4DaIFMOUqsim4FVj4Z1SxmQwrkyc8ytc38XpJ263zgCj
         p0V+lKjtSQR4x+2b9tfZu7J+zygvZOCvJ0FPKyWO/M4dqKFDvnXlepL7++Y7/H7b7O
         BVYm0xstCL1UNpWUUJbK7RMkmVxqgtrY30VDd+Tc=
Date:   Thu, 17 Sep 2020 09:11:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200917081107.GA29031@willie-the-truck>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904103029.32083-30-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> a mechanism to detect the sources of memory related errors which
> may be vulnerable to exploitation, including bounds violations,
> use-after-free, use-after-return, use-out-of-scope and use before
> initialization errors.
> 
> Add Memory Tagging Extension documentation for the arm64 linux
> kernel support.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

I'm taking this to mean that Szabolcs is happy with the proposed ABI --
please shout if that's not the case!

Wasn't there a man page kicking around too? Would be good to see that
go upstream (to the manpages project, of course).

Will
