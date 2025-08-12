Return-Path: <linux-arch+bounces-13134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A1B22909
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF607A3338
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5F285047;
	Tue, 12 Aug 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N/xaT4Z+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD6283FD7
	for <linux-arch@vger.kernel.org>; Tue, 12 Aug 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006428; cv=none; b=PZ7NQXb2kL1qgKRfQJxomFNwwB0jxQ3PvQzN77dHaNcNZRE4rddWzF2qfc78xWvbzcamUFolTnpGYVzIm63AjuB5EiwxZZzmWTl5djCNEvBSvxlSTmQQYVbylspAOEK/Rcktq+af+5I98lmzKlcVY819xOuUxwbBVBQADO0XvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006428; c=relaxed/simple;
	bh=qNJQ858gOSPy6kQdYFjCHpvz41LSZgIxrbPFpqAX2+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVsmUM0EErN05si1E05hCRTdmF7+t5Reej3Wq+WtZ5mA2GIDlolvZ/4b5OCAgTbYDB7WwoZW35SLgqyt25wvILgA/SzIoGaA/oFGZ0EtkxibObl9TaXLeBNTL4G+LqeETcDJhC+SQyo07akOdSBRvqgNNNcsqGE0kFafQsRn4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N/xaT4Z+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fd3fe0d81so51874955ad.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Aug 2025 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755006426; x=1755611226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8WoxjvDBkfx4Zq67j4dS/oZqS1XLjrG4y/OFkK7qEk=;
        b=N/xaT4Z+YJbX1F5Qlk2hTKw2G1nBF7m9cps97WTm0LXSVH7I6xBQynVMZRiLxflYpK
         hVSlsvA69pyIRWUnUDcHCFtlTI2itKepVpFCSWJCkzJJ/YN56zMSWTxOe6WW3VJW6BWK
         9Tv4btG8+Q33Enzl0giTO0pNJohCJG2CPNyGo/rQrw8FbLaVLSTk5LFG3Xd1BZNrkIhj
         VNO74Q+ZFCXh0j6y0TQTGGtEkx4VLkRs19+ml4qVvOWRBEPODAx1lAWr8YwKptWABdy/
         /wNp0xKf0YNyxuWf58uPv2w3MKirYkiPcejDZSemywiQGPfrtHDp0AV8aIZA5diyRPdu
         3y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006426; x=1755611226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8WoxjvDBkfx4Zq67j4dS/oZqS1XLjrG4y/OFkK7qEk=;
        b=DdzkNOaLGNE24IS8tVTnt5SQruHuoSHI2nwiiWsiD+k5Nc2qmMqUZjRyEA4YWEXyCf
         XzIMR5xF3qIevtAvokcI2P/M0YVdLdgYnZAkVMMDjGTDOZEhV3wll4d3urtDBJq5ydzQ
         EMrNWxXHaVQVB5qr5dAaQJcw+0mFE2R4v0uNyz8e5vUkwdMY9fltgMhnfEewuWZY35rB
         ZTLYvvqj6qpZEfQv39eR2gHqVoO8wVqN5WU18RUhnEf30+Q4J/tqbT8Z8JKvCozdvfn/
         tEndKI5/ZdLQcpgEIanXrJfF4+CrNzn764r3U5yR/v+Dp7t10k3Ot/6KJ4v4NEPoO1sn
         k+og==
X-Forwarded-Encrypted: i=1; AJvYcCUN6zuj4497dmdvkpcC3+G04qLLVAsFxKrcjHag1rmh6Y9qmjPXVHTyDciLWhlCs0XNiBSK0wTDPj76@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKT/0d3ZB6ajVrFxEwpTDv8ZDHtJ/fpaYIrX03nFTX50qIhaE
	GUBClhJElD4ujia1KsbtqcWTfyqxkcZDc5J6CTwcUlR+SWwhUNl/ZFWck74VRfQEPzp7cCOS+nX
	RzD7qVqHoLIfM
X-Gm-Gg: ASbGncsgZMgekuN1J4eZLqiVr/ZGKq+6S/sh8TDQUV77MPruQCb1RV6HIfv0lD83P32
	9TaXD2mLZAPxt+6sTssWaOTnmoAhW2kTnvX/tsTSx5Mb4fJQeFTAnQ9HbIKqcayLgGKFXvk+vwj
	hHmyLQhfPyLNla4+wLBVtBzHgw4fQ28pqMbMJrgdxgoP3qVeEbunuHkN7cdcMDDXx9B0m8pAFt8
	4F914vWgtbkBbprFuoUzMOA+D+J8kxv4f9G97nbxfrCiIihIJs0IxtgKw8QXsmzB19HBjjcwapU
	fqs7pWaP2nfAshDCOaWjRpWdt1U9WkpgZgLil7LbheHEh5oDxD3CuzsbEWywZYjRwOz9XUmtkTY
	neXVU32V/BuKrRqgClaaw3X48IDoEyAcVeIq+xpta676ubj9hv0c=
X-Google-Smtp-Source: AGHT+IHA60tP4SeRa6XXCks2V9uQ+cQDXkYaDUBAx/8PtuesE53gCrJ6FR505cnAE/3WujtaqV6XRQ==
X-Received: by 2002:a17:902:ccc2:b0:240:99d8:84 with SMTP id d9443c01a7336-242fc38ac30mr53371355ad.52.1755006426232;
        Tue, 12 Aug 2025 06:47:06 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000:0:1:d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42890523basm12948595a12.45.2025.08.12.06.46.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 06:47:05 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com
Cc: akpm@linux-foundation.org,
	andreyknvl@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@intel.com,
	david@redhat.com,
	ebiederm@xmission.com,
	khalid@kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luto@kernel.org,
	markhemm@googlemail.com,
	maz@kernel.org,
	mhiramat@kernel.org,
	neilb@suse.de,
	pcc@google.com,
	rostedt@goodmis.org,
	vasily.averin@linux.dev,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	xhao@linux.alibaba.com
Subject: Re: [PATCH v2 13/20] x86/mm: enable page table sharing
Date: Tue, 12 Aug 2025 21:46:55 +0800
Message-Id: <20250812134655.68614-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250404021902.48863-14-anthony.yznaga@oracle.com>
References: <20250404021902.48863-14-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On 4/4/25 10:18 AM, Anthony Yznaga wrote:
> Enable x86 support for handling page faults in an mshare region by
> redirecting page faults to operate on the mshare mm_struct and vmas
> contained in it.
> Some permissions checks are done using vma flags in architecture-specfic
> fault handling code so the actual vma needed to complete the handling
> is acquired before calling handle_mm_fault(). Because of this an
> ARCH_SUPPORTS_MSHARE config option is added.
>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  arch/Kconfig        |  3 +++
>  arch/x86/Kconfig    |  1 +
>  arch/x86/mm/fault.c | 37 ++++++++++++++++++++++++++++++++++++-
>  mm/Kconfig          |  2 +-
>  4 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9f6eb09ef12d..2e000fefe9b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1652,6 +1652,9 @@ config HAVE_ARCH_PFN_VALID
>  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	bool
>  
> +config ARCH_SUPPORTS_MSHARE
> +	bool
> +
>  config ARCH_SUPPORTS_PAGE_TABLE_CHECK
>  	bool
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1502fd0c3c06..1f1779decb44 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -125,6 +125,7 @@ config X86
>  	select ARCH_SUPPORTS_ACPI
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> +	select ARCH_SUPPORTS_MSHARE		if X86_64
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 296d294142c8..49659d2f9316 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1216,6 +1216,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	struct mm_struct *mm;
>  	vm_fault_t fault;
>  	unsigned int flags = FAULT_FLAG_DEFAULT;
> +	bool is_shared_vma;
> +	unsigned long addr;
>  
>  	tsk = current;
>  	mm = tsk->mm;
> @@ -1329,6 +1331,12 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	/* mshare does not support per-VMA locks yet */
> +	if (vma_is_mshare(vma)) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +
>  	if (unlikely(access_error(error_code, vma))) {
>  		bad_area_access_error(regs, error_code, address, NULL, vma);
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> @@ -1357,17 +1365,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>  lock_mmap:
>  
>  retry:
> +	addr = address;
> +	is_shared_vma = false;
>  	vma = lock_mm_and_find_vma(mm, address, regs);
>  	if (unlikely(!vma)) {
>  		bad_area_nosemaphore(regs, error_code, address);
>  		return;
>  	}
>  
> +	if (unlikely(vma_is_mshare(vma))) {
> +		fault = find_shared_vma(&vma, &addr);
> +
> +		if (fault) {
> +			mmap_read_unlock(mm);
> +			goto done;
> +		}
> +
> +		if (!vma) {
> +			mmap_read_unlock(mm);
> +			bad_area_nosemaphore(regs, error_code, address);
> +			return;
> +		}
> +
> +		is_shared_vma = true;
> +	}
> +
>  	/*
>  	 * Ok, we have a good vm_area for this memory access, so
>  	 * we can handle it..
>  	 */
>  	if (unlikely(access_error(error_code, vma))) {
> +		if (unlikely(is_shared_vma))
> +			mmap_read_unlock(vma->vm_mm);
>  		bad_area_access_error(regs, error_code, address, mm, vma);
>  		return;
>  	}
> @@ -1385,7 +1414,11 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	 * userland). The return to userland is identified whenever
>  	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
>  	 */
> -	fault = handle_mm_fault(vma, address, flags, regs);
> +	fault = handle_mm_fault(vma, addr, flags, regs);
> +
> +	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
> +	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs)))
> +		mmap_read_unlock(mm);

I was backporting these patches of mshare to 5.15 kernel and trying to do some
basic tests. Then found a potential issue.

Reaching here means find_shared_vma function has been executed successfully 
and host_mm->mmap_lock has got locked.

When returned fault variable has VM_FAULT_COMPLETED or VM_FAULT_RETRY flags,
or fault_signal_pending(fault, regs) takes true, there is not chance to release
locks of both mm and host_mm(i.e. vma->vm_mm) in the following Snippet of Code.

As a result, needs to release vma->vm_mm.mmap_lock as well.

So it is supposed to be like below:

-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault(vma, addr, flags, regs);
+
+	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
+	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs))) {
+		mmap_read_unlock(vma->vm_mm);
+		mmap_read_unlock(mm);
+	}

>  
>  	if (fault_signal_pending(fault, regs)) {
>  		/*
> @@ -1413,6 +1446,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		goto retry;
>  	}
>  
> +	if (unlikely(is_shared_vma))
> +		mmap_read_unlock(vma->vm_mm);
>  	mmap_read_unlock(mm);
>  done:
>  	if (likely(!(fault & VM_FAULT_ERROR)))
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e6c90db83d01..8a5a159457f2 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1344,7 +1344,7 @@ config PT_RECLAIM
>  
>  config MSHARE
>  	bool "Mshare"
> -	depends on MMU
> +	depends on MMU && ARCH_SUPPORTS_MSHARE
>  	help
>  	  Enable msharefs: A ram-based filesystem that allows multiple
>  	  processes to share page table entries for shared pages. A file

Yongting Lin.

