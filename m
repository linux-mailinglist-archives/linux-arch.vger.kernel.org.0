Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4658D8F28
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbfJPLS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 07:18:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389063AbfJPLS4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 07:18:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005F828;
        Wed, 16 Oct 2019 04:18:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B2573F6C4;
        Wed, 16 Oct 2019 04:18:50 -0700 (PDT)
Date:   Wed, 16 Oct 2019 12:18:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, npiggin@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 7/8] locking/atomics, kcsan: Add KCSAN instrumentation
Message-ID: <20191016111847.GB44246@lakrids.cambridge.arm.com>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-8-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-8-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marco,

On Wed, Oct 16, 2019 at 10:39:58AM +0200, Marco Elver wrote:
> This adds KCSAN instrumentation to atomic-instrumented.h.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/asm-generic/atomic-instrumented.h | 192 +++++++++++++++++++++-
>  scripts/atomic/gen-atomic-instrumented.sh |   9 +-
>  2 files changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
> index e8730c6b9fe2..9e487febc610 100644
> --- a/include/asm-generic/atomic-instrumented.h
> +++ b/include/asm-generic/atomic-instrumented.h
> @@ -19,11 +19,13 @@
>  
>  #include <linux/build_bug.h>
>  #include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  
>  static inline int
>  atomic_read(const atomic_t *v)
>  {
>  	kasan_check_read(v, sizeof(*v));
> +	kcsan_check_atomic(v, sizeof(*v), false);

For legibility and consistency with kasan, it would be nicer to avoid
the bool argument here and have kcsan_check_atomic_{read,write}()
helpers...

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index e09812372b17..c0553743a6f4 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -12,15 +12,20 @@ gen_param_check()
>  	local type="${arg%%:*}"
>  	local name="$(gen_param_name "${arg}")"
>  	local rw="write"
> +	local is_write="true"
>  
>  	case "${type#c}" in
>  	i) return;;
>  	esac
>  
>  	# We don't write to constant parameters
> -	[ ${type#c} != ${type} ] && rw="read"
> +	if [ ${type#c} != ${type} ]; then
> +		rw="read"
> +		is_write="false"
> +	fi
>  
>  	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
> +	printf "\tkcsan_check_atomic(${name}, sizeof(*${name}), ${is_write});\n"

... which would also simplify this.

Though as below, we might want to wrap both in a helper local to
atomic-instrumented.h.

>  }
>  
>  #gen_param_check(arg...)
> @@ -108,6 +113,7 @@ cat <<EOF
>  ({									\\
>  	typeof(ptr) __ai_ptr = (ptr);					\\
>  	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
> +	kcsan_check_atomic(__ai_ptr, ${mult}sizeof(*__ai_ptr), true);	\\
>  	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
>  })
>  EOF
> @@ -148,6 +154,7 @@ cat << EOF
>  
>  #include <linux/build_bug.h>
>  #include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>

We could add the following to this preamble:

static inline void __atomic_check_read(const volatile void *v, size_t size)
{
	kasan_check_read(v, sizeof(*v));
	kcsan_check_atomic(v, sizeof(*v), false);
}

static inline void __atomic_check_write(const volatile void *v, size_t size)
{
	kasan_check_write(v, sizeof(*v));
	kcsan_check_atomic(v, sizeof(*v), true);
}

... and only have the one call in each atomic wrapper.

Otherwise, this looks good to me.

Thanks,
Mark.
