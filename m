Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47F11092EE
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKYRiC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 12:38:02 -0500
Received: from foss.arm.com ([217.140.110.172]:53306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYRiB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Nov 2019 12:38:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E134731B;
        Mon, 25 Nov 2019 09:38:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75FDE3F68E;
        Mon, 25 Nov 2019 09:37:59 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:37:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] asm-generic/atomic: Prefer __always_inline for
 wrappers
Message-ID: <20191125173756.GF32635@lakrids.cambridge.arm.com>
References: <20191122154221.247680-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122154221.247680-1-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 22, 2019 at 04:42:20PM +0100, Marco Elver wrote:
> Prefer __always_inline for atomic wrappers. When building for size
> (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> inline even relatively small static inline functions that are assumed to
> be inlinable such as atomic ops. This can cause problems, for example in
> UACCESS regions.

From looking at the link below, the problem is tat objtool isn't happy
about non-whiteliested calls within UACCESS regions.

Is that a problem here? are the kasan/kcsan calls whitelisted?

> By using __always_inline, we let the real implementation and not the
> wrapper determine the final inlining preference.

That sounds reasonable to me, assuming that doesn't end up significantly
bloating the kernel text. What impact does this have on code size?

> This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> in the KCSAN runtime:
> http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/asm-generic/atomic-instrumented.h | 334 +++++++++++-----------
>  include/asm-generic/atomic-long.h         | 330 ++++++++++-----------
>  scripts/atomic/gen-atomic-instrumented.sh |   6 +-
>  scripts/atomic/gen-atomic-long.sh         |   2 +-
>  4 files changed, 336 insertions(+), 336 deletions(-)

Do we need to do similar for gen-atomic-fallback.sh and the fallbacks
defined in scripts/atomic/fallbacks/ ?

[...]

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 8b8b2a6f8d68..68532d4f36ca 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -84,7 +84,7 @@ gen_proto_order_variant()
>  	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
>  
>  cat <<EOF
> -static inline ${ret}
> +static __always_inline ${ret}

We should add an include of <linux/compiler.h> to the preamble if we're
explicitly using __always_inline.

> diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
> index c240a7231b2e..4036d2dd22e9 100755
> --- a/scripts/atomic/gen-atomic-long.sh
> +++ b/scripts/atomic/gen-atomic-long.sh
> @@ -46,7 +46,7 @@ gen_proto_order_variant()
>  	local retstmt="$(gen_ret_stmt "${meta}")"
>  
>  cat <<EOF
> -static inline ${ret}
> +static __always_inline ${ret}

Likewise here

Thanks,
Mark.
