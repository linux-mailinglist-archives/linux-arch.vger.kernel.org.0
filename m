Return-Path: <linux-arch+bounces-11566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D04A9B5D4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30FF4A7D3D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EA28F510;
	Thu, 24 Apr 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HBBpqt9K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4C28C5B9
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517404; cv=none; b=imM6M3YbkoahhYlH+fLHTKAotBRuGdO2x/rinKhzni+tpyamWkHYexpioGY1v9WQVLf679VakBLUCkg4C6PxBTO4DHnyTqZGsLjYh9MsuVs2KovRtbpyfwWl34h0RrG0S8vDqOA9vJJ+MYeMlVHt1USPLSfz/eUCzjtl/LyY7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517404; c=relaxed/simple;
	bh=H+WVN8dXMu4VVGlDt8K/6nV5Fu+NlPxMpEedLUpBf70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPSvPscUcet7QdK9VYef3idWjL7Y1IGUdeBi6pQPfKs1Pr4ZjwFnTAe2px+p1XcTU6VTRygaAcD0e0TvsRbnxwznEbsgy3smD6FXqchzUCNTrCm0jreOgwOglFhGpgMuaRL9i8cMaA61jNajikdC+WR88D/GESPsUgPNNw1L3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HBBpqt9K; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b34a71a1so1566284b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745517398; x=1746122198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOLy/80XFfLxXJDNfbBZwCZ4HqYR8Mbf5OU8mj5q3uc=;
        b=HBBpqt9KIGTf8v2jOqTTdlAfcz9kwaqf7mHomP6hOLCcRR+I0n097mmb1YKNakIQuq
         oOcwwBNZ0MTG28FUnEgX0VCbDAGGKbyyES4CDzuRecLikf8Jyr+4puwFYpaBt3iLSMjt
         n05XoaDgzqjvldrrcuKVPTYsnoIGaGyXh+Gx6A4j5E3FABylK4dv8PwhtNWpIaTeyz3k
         Wz8iat9Z8M4S1wFKPNnXW9gTYnCcev5DNO7f4lOFR7gBR++EoS76otidVRlqUIPBYmd+
         +C8q8MPSYL9xDEbraGgXX8v7w1y7RiGq6uWO7P1dDBYbWGGZJgOBcs0xWwQ7AAuJZ3gI
         zjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745517398; x=1746122198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOLy/80XFfLxXJDNfbBZwCZ4HqYR8Mbf5OU8mj5q3uc=;
        b=EEj7B5k27C+HTjldMqPhUCnrQhbBEDvS4f11wy4ADdT+rhEXXURqVzNCQey/5Bwrxx
         mP8LWdo2w2YXTbcBp1pVG2VtIY6QnLuamTZdr8Q0g7WvErlHecVHyLNkcUegP/CgN2Ca
         qFNDSii36lwCR8VHt27xG9C9xCUraCT1kDTFcntoNSKa1qlhVOK9EtvQrbr5iU3XhXMa
         Rev5dqnl+DYtGgxqKkuYTXZnJe8qMVFLpwPRw9pWgQjIeRcvn2GW8M3yACYfHzum4jka
         TFnCAWJq7yGO4mDZEsezarg+9IadS4klgq8jlqk1fUiEbbLa7bZbW4SY23UR+Cj3yh1P
         ftkw==
X-Forwarded-Encrypted: i=1; AJvYcCW+GP0bRiBDkHQ2Apmf+gq7LW8xmH2Z8czKeM/GiQz1LF1gaHPsOqtcXlYiGTigrHePzyXwA+R/HNfs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DSowBz1NLdKnJcs6e+p0eBE4ov7m+eeWiIbJZYbxJJIBfOJ8
	k650skH6RE2Y8/u9N+DFTuLcU/AOZfwZ1nN8DtBxCvjChF4u2GkCgZRrJH2av7U=
X-Gm-Gg: ASbGnctYYrLl3jYpy2FRXuMZL+B7E7KAVVu2i61N8H74cAONY8DGs6x1/yMrHmjBqts
	Drgn/hqV8nRWJ8M/Rt48zpyEXsIfoxiaj6tJ1S6Q0+CfCAy9F2NBm1JjGzXUgZmi+qqwTwgbfJC
	k+7AJrBkEV3Z7qRs98Gclh25kxefrm5LOwPOk8U/UqD6FGGKCpv8iZNJHsUkvsR34IFJtabtEQh
	1xS8ncZMNs2pSlGhd5SJ/Ov9oxr+qgxihoYKz37Pl1AEJ4Oqp48IeuYGkWcrtw45P7FNi41dN9z
	rMq0epQxWd4V8eNuXIO5wyAqIPBQ5AqxauT9Y6PeqveVa5QoLY0=
X-Google-Smtp-Source: AGHT+IEvwKAWcL1BB3CDYo6zsE5OWQQndt5nVMjDwtZXDpnZ2rdOW1imvzSm4O5fk1CTzTK9UpqvkQ==
X-Received: by 2002:a05:6a00:1744:b0:735:d89c:4b8e with SMTP id d2e1a72fcca58-73e32fbafeemr709517b3a.5.1745517398496;
        Thu, 24 Apr 2025 10:56:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9940esm1697082b3a.129.2025.04.24.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:56:38 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:56:34 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, broonie@kernel.org, rick.p.edgecombe@intel.com,
	Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aAp7Un415hNqtshd@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
 <aAl_HRk49lnseiio@debug.ba.rivosinc.com>
 <D9EUJBQ5OHN0.2KUJHGXK262TR@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9EUJBQ5OHN0.2KUJHGXK262TR@ventanamicro.com>

On Thu, Apr 24, 2025 at 01:52:43PM +0200, Radim Krčmář wrote:
>2025-04-23T17:00:29-07:00, Deepak Gupta <debug@rivosinc.com>:
>> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Krčmář wrote:
>>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>>> @@ -62,6 +62,9 @@ struct thread_info {
>>>>  	long			user_sp;	/* User stack pointer */
>>>>  	int			cpu;
>>>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +	struct cfi_status	user_cfi_state;
>>>> +#endif
>>>
>>>I don't think it makes sense to put all the data in thread_info.
>>>kernel_ssp and user_ssp is more than enough and the rest can comfortably
>>>live elsewhere in task_struct.
>>>
>>>thread_info is supposed to be as small as possible -- just spanning
>>>multiple cache-lines could be noticeable.
>>
>> I can change it to only include only `user_ssp`, base and size.
>
>No need for base and size either -- we don't touch that in the common
>exception code.

got it.

>
>> But before we go there, see below:
>>
>> $ pahole -C thread_info kbuild/vmlinux
>> struct thread_info {
>>          long unsigned int          flags;                /*     0     8 */
>>          int                        preempt_count;        /*     8     4 */
>>
>>          /* XXX 4 bytes hole, try to pack */
>>
>>          long int                   kernel_sp;            /*    16     8 */
>>          long int                   user_sp;              /*    24     8 */
>>          int                        cpu;                  /*    32     4 */
>>
>>          /* XXX 4 bytes hole, try to pack */
>>
>>          long unsigned int          syscall_work;         /*    40     8 */
>>          struct cfi_status          user_cfi_state;       /*    48    32 */
>>          /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>>          long unsigned int          a0;                   /*    80     8 */
>>          long unsigned int          a1;                   /*    88     8 */
>>          long unsigned int          a2;                   /*    96     8 */
>>
>>          /* size: 104, cachelines: 2, members: 10 */
>>          /* sum members: 96, holes: 2, sum holes: 8 */
>>          /* last cacheline: 40 bytes */
>> };
>>
>> If we were to remove entire `cfi_status`, it would still be 72 bytes (88 bytes
>> if shadow call stack were enabled) and already spans across two cachelines.
>
>It has only 64 bytes of data without shadow call stack, but it wasted 8
>bytes on the holes.
>a2 is somewhat an outlier that is not used most exception paths and
>excluding it makes everything fit nicely even now.

But we can't exclude shadow call stack. It'll lead to increased size if that
config is selected. A solution has to work for all the cases and not half
hearted effort.

>
>> if shadow call stack were enabled) and already spans across two cachelines. I
>> did see the comment above that it should fit inside a cacheline. Although I
>> assumed its stale comment given that it already spans across cacheline and I
>> didn't see any special mention in commit messages of changes which grew this
>> structure above one cacheline. So I assumed this was a stale comment.
>>
>> On the other hand, whenever enable/lock bits are checked, there is a high
>> likelyhood that user_ssp and other fields are going to be accessed and
>> thus it actually might be helpful to have it all in one cacheline during
>> runtime.
>
>Yes, although accessing enable/lock bits will be relatively rare.
>It seems better to have the overhead during thread setup, rather than on
>every trap.
>
>> So I am not sure if its helpful sticking to the comment which already is stale.
>
>We could fix the holes and also use sp instead of a0 in the
>new_vmalloc_check, so everything would fit better.
>
>We are really close to fitting into a single cache-line, so I'd prefer
>if shadow stack only filled thread_info with data that is used very
>often in the exception handling code.

I don't get what's the big deal if it results in two cachelines. We can
(re)organize data structure in a way the most frequently accessed members are
together in a single cacheline. We just need to find those members.

In the hot path of exception handling, I see accesses to pt_regs on stack as
well. These are definitley different cacheline than thread_info.

I understand the argument of one member field crossing into two cachelines can
have undesired perf effects. I do not understand reasoning that thread_info
exactly has to fit inside one cacheline.

If this was always supposed to fit in a single cacheline, clearly this
invariant isn't/wasn't maintained as changes trickled in. I would like to see
what maintainers have to say or someone who did data analysis on this.


>
>I think we could do without user_sp in thread_info as well, so there are
>other packing options.

Sure, probably somewhere in task_struct. But fact of the matter is that it has
to be saved/restore during exception entry/exit. But then load/store to
task_struct is essentially a different cachline. Not sure what we will achieve
here?

>
>Btw. could ssp be added to pt_regs?

I had that earlier. It breaks user abi. And it was a no go.

>
>Thanks.

