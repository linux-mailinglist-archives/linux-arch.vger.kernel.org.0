Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71369CB82
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjBTM6E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 07:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjBTM6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 07:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BC10246
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676897833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zemW7aNWRwAi+p4sGKW/xJ1ltsTq0KCUp+kk3nYuOkc=;
        b=Puxir4dBZKjxYkcx7X3GpmNRNSZC1fjAAOA1z6kQJ49vDmuWhnTOdeYnWTJ6fcN0XEza+O
        XcKt4eor0j7di0NsBuUfddp4w1Dcq75JeX0FRG1vqg7tcd1YRVsuuj75d2takqAqvg35M+
        Fwi0e3EexaHf1SVPxskaLyJgY++VRYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-h-XzdMj9P7al_l_5X7_LXg-1; Mon, 20 Feb 2023 07:57:12 -0500
X-MC-Unique: h-XzdMj9P7al_l_5X7_LXg-1
Received: by mail-wm1-f70.google.com with SMTP id k26-20020a05600c0b5a00b003dfe4bae099so560705wmr.0
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zemW7aNWRwAi+p4sGKW/xJ1ltsTq0KCUp+kk3nYuOkc=;
        b=GaMPXFqlmFXjNZzGG72AryQLtajqPQe6ChCJHU+BsFLdPylwwYYHCiSVBTwTqFr/Xv
         kSrmqJaO0/9khjYCdA0UrZZYGfJZni5MdQIV+M2+UYPtFUwyDMeLBeyBVpZQEGSijYKa
         z9s+DPncolm66w29Fb88mPE417HusbXoC7ate8X0OCsesSiPlhJkwJfGlS87Lkuycwu2
         7/OgWw3IKgYJOgqNgs/zXKKGiNk4LMCLZq4l8P4A3NfgYfVE5zzrmdYryKCMR+YFESU+
         wXyZaFGl3gjBwpioe218uW/Hi0kOsoJoToExPD2DKNIiQVbztXbo7/yJEf/4SP27kcDs
         1P5g==
X-Gm-Message-State: AO0yUKUhHEdZgVICwuFZ4/FRCZ72OnIeCYlWjJXf/rzr82e/rQOuTYqK
        ocybQvaX0YI6UyqkkB+lrJK6FmLyyZPkRpxkHNMLG1QMXnKxNcjBH+2qSLn8TEIzuiLKujF4Pll
        sx8loH3QoEVlYoAOqQYsgvA==
X-Received: by 2002:a5d:6544:0:b0:2c5:953c:696f with SMTP id z4-20020a5d6544000000b002c5953c696fmr172010wrv.30.1676897830802;
        Mon, 20 Feb 2023 04:57:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+/84V+aDeHrLh5AwgyrTahMkPSaK64yS70UPPno5zO+r6bOD3NKj93IjGMJQae+rzSOfSbzA==
X-Received: by 2002:a5d:6544:0:b0:2c5:953c:696f with SMTP id z4-20020a5d6544000000b002c5953c696fmr171966wrv.30.1676897830380;
        Mon, 20 Feb 2023 04:57:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b002c54241b4fesm5961541wrn.80.2023.02.20.04.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 04:57:09 -0800 (PST)
Message-ID: <458b3d39-ddce-c0f2-fe80-4e0cc5b101bd@redhat.com>
Date:   Mon, 20 Feb 2023 13:57:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 19/41] x86/mm: Check shadow stack page fault errors
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-20-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-20-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The CPU performs "shadow stack accesses" when it expects to encounter
> shadow stack mappings. These accesses can be implicit (via CALL/RET
> instructions) or explicit (instructions like WRSS).
> 
> Shadow stack accesses to shadow-stack mappings can result in faults in
> normal, valid operation just like regular accesses to regular mappings.
> Shadow stacks need some of the same features like delayed allocation, swap
> and copy-on-write. The kernel needs to use faults to implement those
> features.
> 
> The architecture has concepts of both shadow stack reads and shadow stack
> writes. Any shadow stack access to non-shadow stack memory will generate
> a fault with the shadow stack error code bit set.
> 
> This means that, unlike normal write protection, the fault handler needs
> to create a type of memory that can be written to (with instructions that
> generate shadow stack writes), even to fulfill a read access. So in the
> case of COW memory, the COW needs to take place even with a shadow stack
> read. Otherwise the page will be left (shadow stack) writable in
> userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
> for shadow stack accesses, even if the access was a shadow stack read.
> 
> For the purpose of making this clearer, consider the following example.
> If a process has a shadow stack, and forks, the shadow stack PTEs will
> become read-only due to COW. If the CPU in one process performs a shadow
> stack read access to the shadow stack, for example executing a RET and
> causing the CPU to read the shadow stack copy of the return address, then
> in order for the fault to be resolved the PTE will need to be set with
> shadow stack permissions. But then the memory would be changeable from
> userspace (from CALL, RET, WRSS, etc). So this scenario needs to trigger
> COW, otherwise the shared page would be changeable from both processes.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping. Also, generate the errors for invalid shadow stack accesses.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v6:
>   - Update comment due to rename of Cow bit to SavedDirty
> 
> v5:
>   - Add description of COW example (Boris)
>   - Replace "permissioned" (Boris)
>   - Remove capitalization of shadow stack (Boris)
> 
> v4:
>   - Further improve comment talking about FAULT_FLAG_WRITE (Peterz)
> 
> v3:
>   - Improve comment talking about using FAULT_FLAG_WRITE (Peterz)
> ---
>   arch/x86/include/asm/trap_pf.h |  2 ++
>   arch/x86/mm/fault.c            | 38 ++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
> index 10b1de500ab1..afa524325e55 100644
> --- a/arch/x86/include/asm/trap_pf.h
> +++ b/arch/x86/include/asm/trap_pf.h
> @@ -11,6 +11,7 @@
>    *   bit 3 ==				1: use of reserved bit detected
>    *   bit 4 ==				1: fault was an instruction fetch
>    *   bit 5 ==				1: protection keys block access
> + *   bit 6 ==				1: shadow stack access fault
>    *   bit 15 ==				1: SGX MMU page-fault
>    */
>   enum x86_pf_error_code {
> @@ -20,6 +21,7 @@ enum x86_pf_error_code {
>   	X86_PF_RSVD	=		1 << 3,
>   	X86_PF_INSTR	=		1 << 4,
>   	X86_PF_PK	=		1 << 5,
> +	X86_PF_SHSTK	=		1 << 6,
>   	X86_PF_SGX	=		1 << 15,
>   };
>   
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 7b0d4ab894c8..42885d8e2036 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1138,8 +1138,22 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>   				       (error_code & X86_PF_INSTR), foreign))
>   		return 1;
>   
> +	/*
> +	 * Shadow stack accesses (PF_SHSTK=1) are only permitted to
> +	 * shadow stack VMAs. All other accesses result in an error.
> +	 */
> +	if (error_code & X86_PF_SHSTK) {
> +		if (unlikely(!(vma->vm_flags & VM_SHADOW_STACK)))
> +			return 1;
> +		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> +			return 1;
> +		return 0;
> +	}
> +
>   	if (error_code & X86_PF_WRITE) {
>   		/* write, present and write, not present: */
> +		if (unlikely(vma->vm_flags & VM_SHADOW_STACK))
> +			return 1;
>   		if (unlikely(!(vma->vm_flags & VM_WRITE)))
>   			return 1;
>   		return 0;
> @@ -1331,6 +1345,30 @@ void do_user_addr_fault(struct pt_regs *regs,
>   
>   	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>   
> +	/*
> +	 * When a page becomes COW it changes from a shadow stack permission
> +	 * page (Write=0,Dirty=1) to (Write=0,Dirty=0,SavedDirty=1), which is simply
> +	 * read-only to the CPU. When shadow stack is enabled, a RET would
> +	 * normally pop the shadow stack by reading it with a "shadow stack
> +	 * read" access. However, in the COW case the shadow stack memory does
> +	 * not have shadow stack permissions, it is read-only. So it will
> +	 * generate a fault.
> +	 *
> +	 * For conventionally writable pages, a read can be serviced with a
> +	 * read only PTE, and COW would not have to happen. But for shadow
> +	 * stack, there isn't the concept of read-only shadow stack memory.
> +	 * If it is shadow stack permission, it can be modified via CALL and
> +	 * RET instructions. So COW needs to happen before any memory can be
> +	 * mapped with shadow stack permissions.
> +	 *
> +	 * Shadow stack accesses (read or write) need to be serviced with
> +	 * shadow stack permission memory, so in the case of a shadow stack
> +	 * read access, treat it as a WRITE fault so both COW will happen and
> +	 * the write fault path will tickle maybe_mkwrite() and map the memory
> +	 * shadow stack.
> +	 */

Again, I suggest dropping all details about COW from this comment and 
from the patch description. It's just one such case that can happen.


-- 
Thanks,

David / dhildenb

