Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F79815C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfHURfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfHURfH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 13:35:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809FC22D6D;
        Wed, 21 Aug 2019 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566408906;
        bh=oft2b/XAnOccaMbScogNYg5GBmBHqqVhsI2dgxn3frk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDrCB6hTk4MgsFW5L7cH0WWv1uq0GK+uo0eFZhYt9jal412Ps88auo95YKLoSijfw
         HgXtwtGGfReUWAThdTALJejBZ+lacbpBcnlBxqFlBEMEGabf9izZNNuhKMhIsGOvzd
         P1qQJpo7fn1vTibgT7BoACw5MlbTwJ5/UqLgXc4M=
Date:   Wed, 21 Aug 2019 18:35:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 2/3] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190821173501.brvyn5mm5oh6m2s7@willie-the-truck>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-3-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821164730.47450-3-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 05:47:29PM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> (EL0) to perform memory accesses through 64-bit pointers with a non-zero
> top byte. Introduce the document describing the relaxation of the
> syscall ABI that allows userspace to pass certain tagged pointers to
> kernel syscalls.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/arm64/tagged-address-abi.rst | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/arm64/tagged-address-abi.rst

Thanks, I'll pick this on up.

Will
