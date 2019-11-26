Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF21F109DF5
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 13:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfKZM3Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 07:29:25 -0500
Received: from foss.arm.com ([217.140.110.172]:33822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfKZM3Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Nov 2019 07:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511831FB;
        Tue, 26 Nov 2019 04:29:24 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5563F52E;
        Tue, 26 Nov 2019 04:29:22 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:29:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] asm-generic/atomic: Use __always_inline for pure
 wrappers
Message-ID: <20191126122917.GA37833@lakrids.cambridge.arm.com>
References: <20191126114121.85552-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126114121.85552-1-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 26, 2019 at 12:41:19PM +0100, Marco Elver wrote:
> Prefer __always_inline for atomic wrappers. When building for size
> (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> inline even relatively small static inline functions that are assumed to
> be inlinable such as atomic ops. This can cause problems, for example in
> UACCESS regions.
> 
> By using __always_inline, we let the real implementation and not the
> wrapper determine the final inlining preference.
> 
> For x86 tinyconfig we observe:
> - vmlinux baseline: 1316204
> - vmlinux with patch: 1315988 (-216 bytes)
> 
> This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> in the KCSAN runtime:
> http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Add missing '#include <linux/compiler.h>'
> * Add size diff to commit message.
> 
> v1: http://lkml.kernel.org/r/20191122154221.247680-1-elver@google.com
> ---
>  include/asm-generic/atomic-instrumented.h | 335 +++++++++++-----------
>  include/asm-generic/atomic-long.h         | 331 ++++++++++-----------
>  scripts/atomic/gen-atomic-instrumented.sh |   7 +-
>  scripts/atomic/gen-atomic-long.sh         |   3 +-
>  4 files changed, 340 insertions(+), 336 deletions(-)

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 8b8b2a6f8d68..86d27252b988 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -84,7 +84,7 @@ gen_proto_order_variant()
>  	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
>  
>  cat <<EOF
> -static inline ${ret}
> +static __always_inline ${ret}
>  ${atomicname}(${params})
>  {
>  ${checks}
> @@ -146,17 +146,18 @@ cat << EOF
>  #ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
>  #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
>  
> +#include <linux/compiler.h>
>  #include <linux/build_bug.h>

Sorry for the (super) trivial nit, but could you please re-order these
two alphabetically, i.e.

#include <linux/build_bug.h>
#include <linux/compiler.h>

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

[...]

> @@ -64,6 +64,7 @@ cat << EOF
>  #ifndef _ASM_GENERIC_ATOMIC_LONG_H
>  #define _ASM_GENERIC_ATOMIC_LONG_H
>  
> +#include <linux/compiler.h>
>  #include <asm/types.h>

Unlike the above, this doesn't need to be re-ordered; for whatever
reason, linux/* includes typically come before asm/* includes.

Thanks,
Mark.
