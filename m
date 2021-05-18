Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD7387066
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 05:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhERD7G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 23:59:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36684 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbhERD7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 23:59:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1liqrO-001BZ4-7u; Mon, 17 May 2021 21:57:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1liqrN-00Dqoh-3t; Mon, 17 May 2021 21:57:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
References: <20210517203343.3941777-1-arnd@kernel.org>
        <20210517203343.3941777-2-arnd@kernel.org>
Date:   Mon, 17 May 2021 22:57:24 -0500
In-Reply-To: <20210517203343.3941777-2-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 17 May 2021 22:33:40 +0200")
Message-ID: <m1y2cc3d97.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1liqrN-00Dqoh-3t;;;mid=<m1y2cc3d97.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4F4J6T7VILKXf+JC2PApdv1NzJS5heMQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 580 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.21 (0.2%),
         extract_message_metadata: 14 (2.4%), get_uri_detail_list: 3.0 (0.5%),
        tests_pri_-1000: 12 (2.1%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 64 (11.1%), check_bayes:
        63 (10.8%), b_tokenize: 12 (2.1%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 35 (6.0%), b_finish: 0.77
        (0.1%), tests_pri_0: 463 (79.9%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The compat version of sys_kexec_load() uses compat_alloc_user_space to
> convert the user-provided arguments into the native format.
>
> Move the conversion into the regular implementation with
> an in_compat_syscall() check to simplify it and avoid the
> compat_alloc_user_space() call.
>
> compat_sys_kexec_load() now behaves the same as sys_kexec_load().

Is it possible to do this without in_compat_syscall(),
and casting pointers to a wrong type?

We open ourselves up to bugs whenever we lie to the type system.

Skimming through the code it looks like it should be possible
to not need the in_compat_syscall and the casts to the wrong
type by changing the order of the code a little bit.

Eric


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kexec.h |  2 -
>  kernel/kexec.c        | 95 +++++++++++++++++++------------------------
>  2 files changed, 42 insertions(+), 55 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..f61e310d7a85 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -88,14 +88,12 @@ struct kexec_segment {
>  	size_t memsz;
>  };
>  
> -#ifdef CONFIG_COMPAT
>  struct compat_kexec_segment {
>  	compat_uptr_t buf;
>  	compat_size_t bufsz;
>  	compat_ulong_t mem;	/* User space sees this as a (void *) ... */
>  	compat_size_t memsz;
>  };
> -#endif
>  
>  #ifdef CONFIG_KEXEC_FILE
>  struct purgatory_info {
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c82c6c06f051..6618b1d9f00b 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -19,21 +19,46 @@
>  
>  #include "kexec_internal.h"
>  
> +static int copy_user_compat_segment_list(struct kimage *image,
> +					 unsigned long nr_segments,
> +					 void __user *segments)
> +{
> +	struct compat_kexec_segment __user *cs = segments;
> +	struct compat_kexec_segment segment;
> +	int i;
> +
> +	for (i = 0; i < nr_segments; i++) {
> +		if (copy_from_user(&segment, &cs[i], sizeof(segment)))
> +			return -EFAULT;
> +
> +		image->segment[i] = (struct kexec_segment) {
> +			.buf   = compat_ptr(segment.buf),
> +			.bufsz = segment.bufsz,
> +			.mem   = segment.mem,
> +			.memsz = segment.memsz,
> +		};
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static int copy_user_segment_list(struct kimage *image,
>  				  unsigned long nr_segments,
>  				  struct kexec_segment __user *segments)
>  {
> -	int ret;
>  	size_t segment_bytes;
>  
>  	/* Read in the segments */
>  	image->nr_segments = nr_segments;
>  	segment_bytes = nr_segments * sizeof(*segments);
> -	ret = copy_from_user(image->segment, segments, segment_bytes);
> -	if (ret)
> -		ret = -EFAULT;
> +	if (in_compat_syscall())
> +		return copy_user_compat_segment_list(image, nr_segments, segments);
>  
> -	return ret;
> +	if (copy_from_user(image->segment, segments, segment_bytes))
> +		return -EFAULT;
> +
> +	return 0;
>  }
>  
>  static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> @@ -233,8 +258,9 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	return 0;
>  }
>  
> -SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> -		struct kexec_segment __user *, segments, unsigned long, flags)
> +static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
> +			     struct kexec_segment __user * segments,
> +			     unsigned long flags)
>  {
>  	int result;
>  
> @@ -265,57 +291,20 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	return result;
>  }
>  
> +SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> +		struct kexec_segment __user *, segments, unsigned long, flags)
> +{
> +	return kernel_kexec_load(entry, nr_segments, segments, flags);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>  		       compat_ulong_t, nr_segments,
>  		       struct compat_kexec_segment __user *, segments,
>  		       compat_ulong_t, flags)
>  {
> -	struct compat_kexec_segment in;
> -	struct kexec_segment out, __user *ksegments;
> -	unsigned long i, result;
> -
> -	result = kexec_load_check(nr_segments, flags);
> -	if (result)
> -		return result;
> -
> -	/* Don't allow clients that don't understand the native
> -	 * architecture to do anything.
> -	 */
> -	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
> -		return -EINVAL;
> -
> -	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
> -	for (i = 0; i < nr_segments; i++) {
> -		result = copy_from_user(&in, &segments[i], sizeof(in));
> -		if (result)
> -			return -EFAULT;
> -
> -		out.buf   = compat_ptr(in.buf);
> -		out.bufsz = in.bufsz;
> -		out.mem   = in.mem;
> -		out.memsz = in.memsz;
> -
> -		result = copy_to_user(&ksegments[i], &out, sizeof(out));
> -		if (result)
> -			return -EFAULT;
> -	}
> -
> -	/* Because we write directly to the reserved memory
> -	 * region when loading crash kernels we need a mutex here to
> -	 * prevent multiple crash  kernels from attempting to load
> -	 * simultaneously, and to prevent a crash kernel from loading
> -	 * over the top of a in use crash kernel.
> -	 *
> -	 * KISS: always take the mutex.
> -	 */
> -	if (!mutex_trylock(&kexec_mutex))
> -		return -EBUSY;
> -
> -	result = do_kexec_load(entry, nr_segments, ksegments, flags);
> -
> -	mutex_unlock(&kexec_mutex);
> -
> -	return result;
> +	return kernel_kexec_load(entry, nr_segments,
> +				 (struct kexec_segment __user *)segments,
> +				 flags);
>  }
>  #endif
