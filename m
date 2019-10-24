Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFCE325A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501919AbfJXM2Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 08:28:25 -0400
Received: from foss.arm.com ([217.140.110.172]:49806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJXM2Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 08:28:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E39F1B57;
        Thu, 24 Oct 2019 05:28:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58543F71A;
        Thu, 24 Oct 2019 05:28:04 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:02 +0100
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
Subject: Re: [PATCH v2 4/8] seqlock, kcsan: Add annotations for KCSAN
Message-ID: <20191024122801.GD4300@lakrids.cambridge.arm.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-5-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017141305.146193-5-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 04:13:01PM +0200, Marco Elver wrote:
> Since seqlocks in the Linux kernel do not require the use of marked
> atomic accesses in critical sections, we teach KCSAN to assume such
> accesses are atomic. KCSAN currently also pretends that writes to
> `sequence` are atomic, although currently plain writes are used (their
> corresponding reads are READ_ONCE).
> 
> Further, to avoid false positives in the absence of clear ending of a
> seqlock reader critical section (only when using the raw interface),
> KCSAN assumes a fixed number of accesses after start of a seqlock
> critical section are atomic.

Do we have many examples where there's not a clear end to a seqlock
sequence? Or are there just a handful?

If there aren't that many, I wonder if we can make it mandatory to have
an explicit end, or to add some helper for those patterns so that we can
reliably hook them.

Thanks,
Mark.

> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/seqlock.h | 44 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index bcf4cf26b8c8..1e425831a7ed 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -37,8 +37,24 @@
>  #include <linux/preempt.h>
>  #include <linux/lockdep.h>
>  #include <linux/compiler.h>
> +#include <linux/kcsan.h>
>  #include <asm/processor.h>
>  
> +/*
> + * The seqlock interface does not prescribe a precise sequence of read
> + * begin/retry/end. For readers, typically there is a call to
> + * read_seqcount_begin() and read_seqcount_retry(), however, there are more
> + * esoteric cases which do not follow this pattern.
> + *
> + * As a consequence, we take the following best-effort approach for *raw* usage
> + * of seqlocks under KCSAN: upon beginning a seq-reader critical section,
> + * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
> + * atomics; if there is a matching read_seqcount_retry() call, no following
> + * memory operations are considered atomic. Non-raw usage of seqlocks is not
> + * affected.
> + */
> +#define KCSAN_SEQLOCK_REGION_MAX 1000
> +
>  /*
>   * Version using sequence counter only.
>   * This can be used when code has its own mutex protecting the
> @@ -115,6 +131,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
>  		cpu_relax();
>  		goto repeat;
>  	}
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	return ret;
>  }
>  
> @@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
>  {
>  	unsigned ret = READ_ONCE(s->sequence);
>  	smp_rmb();
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	return ret;
>  }
>  
> @@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
>  {
>  	unsigned ret = READ_ONCE(s->sequence);
>  	smp_rmb();
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	return ret & ~1;
>  }
>  
> @@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
>   */
>  static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
>  {
> -	return unlikely(s->sequence != start);
> +	kcsan_atomic_next(0);
> +	return unlikely(READ_ONCE(s->sequence) != start);
>  }
>  
>  /**
> @@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
>  
>  static inline void raw_write_seqcount_begin(seqcount_t *s)
>  {
> +	kcsan_begin_atomic(true);
>  	s->sequence++;
>  	smp_wmb();
>  }
> @@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
>  {
>  	smp_wmb();
>  	s->sequence++;
> +	kcsan_end_atomic(true);
>  }
>  
>  /**
> @@ -262,18 +284,20 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
>   *
>   *      void write(void)
>   *      {
> - *              Y = true;
> + *              WRITE_ONCE(Y, true);
>   *
>   *              raw_write_seqcount_barrier(seq);
>   *
> - *              X = false;
> + *              WRITE_ONCE(X, false);
>   *      }
>   */
>  static inline void raw_write_seqcount_barrier(seqcount_t *s)
>  {
> +	kcsan_begin_atomic(true);
>  	s->sequence++;
>  	smp_wmb();
>  	s->sequence++;
> +	kcsan_end_atomic(true);
>  }
>  
>  static inline int raw_read_seqcount_latch(seqcount_t *s)
> @@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
>  static inline void write_seqcount_invalidate(seqcount_t *s)
>  {
>  	smp_wmb();
> +	kcsan_begin_atomic(true);
>  	s->sequence+=2;
> +	kcsan_end_atomic(true);
>  }
>  
>  typedef struct {
> @@ -430,11 +456,21 @@ typedef struct {
>   */
>  static inline unsigned read_seqbegin(const seqlock_t *sl)
>  {
> -	return read_seqcount_begin(&sl->seqcount);
> +	unsigned ret = read_seqcount_begin(&sl->seqcount);
> +
> +	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
> +	kcsan_begin_atomic(false);
> +	return ret;
>  }
>  
>  static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
>  {
> +	/*
> +	 * Assume not nested: read_seqretry may be called multiple times when
> +	 * completing read critical section.
> +	 */
> +	kcsan_end_atomic(false);
> +
>  	return read_seqcount_retry(&sl->seqcount, start);
>  }
>  
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
