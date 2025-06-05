Return-Path: <linux-arch+bounces-12246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A2ACF1F7
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4FA189DE2E
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BC18C031;
	Thu,  5 Jun 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBSUi9TZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3427149E17;
	Thu,  5 Jun 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133631; cv=none; b=mmvoYhfAYc6ynfmQaMgmEXemXgjXDx1AkR0u3VSu09cacH6rfNBk/IbHVK/9eat546WMMtGCURcK5SzuWXinPkbU8puFjEUOR2Nq+dWQDG828lorlqIRVXk23/XZJ02lzS81cwjT5JzLIqaVC+WMP6O1kZCl3xQ/ZRKqp8eRHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133631; c=relaxed/simple;
	bh=OqihrxSS4GkRLJ/+zmwRzLqFFD7y9+7mna+63hB3CtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV1odIEVwo/Ai8ey00Xg1jLn6xV4BGSe0CGY/GgykUFr4+g2YIoKOEITlAYDjPZosynWUNmepSmu3h3oDE3VnlanslZqCKu2V9PUr6DPjnSKi3HW7NF+oEOWA6qxpWwDE9jMASiZCNJdbA5G6D3Qn7ZxbviP3N3L5n1vOtiuOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBSUi9TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBCC4CEE7;
	Thu,  5 Jun 2025 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749133629;
	bh=OqihrxSS4GkRLJ/+zmwRzLqFFD7y9+7mna+63hB3CtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NBSUi9TZN2up+vkvBNbcTWzcHjsUiDsqAPf2AouOJIZP+TIWpHsGVpWs+Ux+7sM8T
	 vyp4wfOBr9jMRoh8Oh78l/+o+1DqDPhRHaEMUblKdlmX/bZL5nB2BapOJcfdCvOVXR
	 PhZCzYOcx4OsEEFlH7SYYq1quLd+wBosFyyjMfjc03x75eLUr61TIX65cn6MDa/uGU
	 bc/z1heVwFAz9LM2UcIZatvxZZkcsgcqUee8eb5twVhBWJDwlaItoVkkkyOSKjNnYT
	 Y4H5mJFdPaEK482do+KagBqulvRUPKAVy8++hYtTlBWczHvBrIiydDvkIjjbPGLTAZ
	 rhU7a2aoHtkww==
Message-ID: <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org>
Date: Thu, 5 Jun 2025 16:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
 <20250127160709.80604-7-ubizjak@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250127160709.80604-7-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 01. 25, 17:05, Uros Bizjak wrote:
> This patch declares percpu variables in __seg_gs/__seg_fs named AS
> and keeps them named AS qualified until they are dereferenced with
> percpu accessor. This approach enables various compiler check
> for cross-namespace variable assignments.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Nadav Amit <nadav.amit@gmail.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>   arch/x86/include/asm/percpu.h | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 27f668660abe..474d648bca9a 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -95,9 +95,18 @@
>   
>   #endif /* CONFIG_SMP */
>   
> -#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> -#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> -#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
> +# define __my_cpu_type(var)	typeof(var)
> +# define __my_cpu_ptr(ptr)	(ptr)
> +# define __my_cpu_var(var)	(var)
> +
> +# define __percpu_qual		__percpu_seg_override
> +#else
> +# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> +# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> +# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> +#endif
> +

Another issue with this is this causes all modules in 6.15 are 2-4 times 
(compressed size) bigger:
$ ll /usr/lib/modules/*-[0-9]-default/kernel/drivers/atm/atmtcp.ko.zst
 > -rw-r--r--. 1 root root 10325 May 13 11:49 
/usr/lib/modules/6.14.6-2-default/kernel/drivers/atm/atmtcp.ko.zst
 > -rw-r--r--. 1 root root 39677 Jun  2 09:13 
/usr/lib/modules/6.15.0-1-default/kernel/drivers/atm/atmtcp.ko.zst

It's due to larger .BTF section:
.BTF              PROGBITS         0000000000000000  [-00003080-]
[-       00000000000011a8-]  {+00003100+}
{+       0000000000012cf8+}  0000000000000000           0     0     1

There are a lot of new BTF types defined in each module like:
+attribute_group STRUCT
+backing_dev_info STRUCT
+bdi_writeback STRUCT
+bin_attribute STRUCT
+bio_end_io_t TYPEDEF
+bio_list STRUCT
+bio_set STRUCT
+bio STRUCT
+bio_vec STRUCT

Reverting this gives me back to normal sizes.

Any ideas?

FTR downstream report:
https://bugzilla.suse.com/show_bug.cgi?id=1244135

thanks,
-- 
js
suse labs


