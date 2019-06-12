Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25642B77
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfFLP5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 11:57:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbfFLP5D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 11:57:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F334337;
        Wed, 12 Jun 2019 08:57:02 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B245D3F73C;
        Wed, 12 Jun 2019 08:56:58 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:56:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 2/2] arm64: Relax
 Documentation/arm64/tagged-pointers.txt
Message-ID: <20190612155651.GM28951@C02TF0J2HF1T.local>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612142111.28161-3-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A couple of minor nits below.

On Wed, Jun 12, 2019 at 03:21:11PM +0100, Vincenzo Frascino wrote:
> --- a/Documentation/arm64/tagged-pointers.txt
> +++ b/Documentation/arm64/tagged-pointers.txt
> @@ -18,7 +18,8 @@ Passing tagged addresses to the kernel
>  --------------------------------------
>  
>  All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +an address tag of 0x00, unless the userspace opts-in the ARM64 Tagged
> +Address ABI via the PR_SET_TAGGED_ADDR_CTRL prctl().
>  
>  This includes, but is not limited to, addresses found in:
>  
> @@ -31,18 +32,23 @@ This includes, but is not limited to, addresses found in:
>   - the frame pointer (x29) and frame records, e.g. when interpreting
>     them to generate a backtrace or call graph.
>  
> -Using non-zero address tags in any of these locations may result in an
> -error code being returned, a (fatal) signal being raised, or other modes
> -of failure.
> +Using non-zero address tags in any of these locations when the
> +userspace application did not opt-in to the ARM64 Tagged Address ABI,

Nitpick: drop the comma after "ABI," since a predicate follows.

> +may result in an error code being returned, a (fatal) signal being raised,
> +or other modes of failure.
>  
> -For these reasons, passing non-zero address tags to the kernel via
> -system calls is forbidden, and using a non-zero address tag for sp is
> -strongly discouraged.
> +For these reasons, when the userspace application did not opt-in, passing
> +non-zero address tags to the kernel via system calls is forbidden, and using
> +a non-zero address tag for sp is strongly discouraged.
>  
>  Programs maintaining a frame pointer and frame records that use non-zero
>  address tags may suffer impaired or inaccurate debug and profiling
>  visibility.
>  
> +A definition of the meaning of ARM64 Tagged Address ABI and of the
> +guarantees that the ABI provides when the userspace opts-in via prctl()
> +can be found in: Documentation/arm64/tagged-address-abi.txt.
> +
>  
>  Preserving tags
>  ---------------
> @@ -57,6 +63,9 @@ be preserved.
>  The architecture prevents the use of a tagged PC, so the upper byte will
>  be set to a sign-extension of bit 55 on exception return.
>  
> +This behaviours are preserved even when the the userspace opts-in the ARM64

"These" ... "opts in to"

> +Tagged Address ABI via the PR_SET_TAGGED_ADDR_CTRL prctl().
> +
>  
>  Other considerations
>  --------------------
> -- 
> 2.21.0

-- 
Catalin
