Return-Path: <linux-arch+bounces-7296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB27978886
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CFCB248C4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176912C530;
	Fri, 13 Sep 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4Jt31Cd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C1459E4
	for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254616; cv=none; b=ZZXI6ueimZ+U5PGAwLjrq0fMnMImP2aFZIhls/YqUYRrpXemgHmq+SbxQGaZ0+HQoIxi9Cwz5WqgKMm0K3oIfCCizR4ueaQdHXwQc7wlmkX8Dhen8MPaartVbFpszcgDGkOkrTpJhnoQ2GvpRvmDI8SrQjL9NwQOEBUcnqFWNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254616; c=relaxed/simple;
	bh=VCyxAOb358DQX0k5EUUYXJ03GN/6cyA8WwZwwvkZ4Gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C/SFN4QmL1ki9W+wj6mNPcyUhZNpwpuSqgmfuVlm5PncUQUYEoRycuGA7Ev5Z2fM8zqxgkc1vA3HkCkEKMh4A6M5zA5AGTxe8Q0fVl58bQDJyK580OBdjWVa4txeV+VMYrnqQ1eTJ0KOydasUpxf9NhacYDdWP29ab1V93OPZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4Jt31Cd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd849a6077so2193399a12.0
        for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726254614; x=1726859414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/PZCN7uc3ggROC6ytkOyGfCP32yMnxJ330RaYLSQz4=;
        b=u4Jt31CdeQvM0UFzDkAXLJsXmA1D/aYY5hmXFpri4d0PgVLUrElI6JZ1Gwxe/FVH9I
         6KG5CCJBayULcGfLGqtkVEjDHAF5lz0qS09mwdvnEzrvLVvDFyljQZP91Bbyo5AloDY7
         QXt6sZilSyCwlKakY5tAdGSJcURiG/UD86s+qCx+6lSZEhrKVWhBXOMTg6A/8JmoT43x
         h4MqF3hmgFem5Pzaw/zEy6Xtof7jjUREcFJ9wVCw1eQsI0R5j7MkZJUMdWHTNWp5hXeY
         ztTz9Ki7cyz5hJYVPaxfsXsD8DVE9QhNTkj+yxequI4bm6DPKO08dSIqjnul7nyt9ke4
         Cg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254614; x=1726859414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/PZCN7uc3ggROC6ytkOyGfCP32yMnxJ330RaYLSQz4=;
        b=nsoTnfdz00EvjQqiVn6JTCjc+nzcL8Ye2dKjcQB2B+Q8CTu3C/+WY/TSuBZmCDc0ne
         fhDGB6rsfdCjDaKODhuT6hdhCg+m1z7rJr6Vd0PowdQzovUGOFp4P7qUN/RxApb/03VX
         gJVdEMS3yKMVd6L9Bn6PyBuoseTmhQf/thdMwvwlIou6RYTKq0YfPiK2whFDnf2e8CFU
         2evtL/DSTKUb4IQeIffMdvtphRZkdi7avAWEzsG2/30IkgzVw5+wZNUC8QKQLciRkL1R
         8Q9KDQ7tmvVSJV9Gv4hOzcz5QEqtYjaXFGNj+2olbH0JqSx0pPRRlD150CGMYP8P+u3s
         qTCg==
X-Forwarded-Encrypted: i=1; AJvYcCW8iCHJ7SjGoirqbG7GyGW1XDJJjbJic8vDx5XefbomWYjtCkUy3qsT+BoX1rgPgiOSGBTdK8zFdcB3@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnN82mSlYzVRHKvI8esZczeGWhDUXrwnj/wyibaTaV4DHeNGV
	GMq7lOFh0s2Lzsm/fJFREUHZ98+KkWNQwA2xbcu89woId7e/CWur9wftjbvOtRA7zo95cD91sZk
	A5A==
X-Google-Smtp-Source: AGHT+IFwbi6CjhGrfff5iqz7S20uwCX00VZkU3GsK5N6YCDvxwkQJ/4maqNVoiyI0T9MiWjqzz7IZ8Usvns=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d489:b0:2d8:e4f9:259e with SMTP id
 98e67ed59e1d1-2dba003b5b0mr39455a91.3.1726254614188; Fri, 13 Sep 2024
 12:10:14 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:10:12 -0700
In-Reply-To: <20240609154945.55332-11-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com> <20240609154945.55332-11-nsaenz@amazon.com>
Message-ID: <ZuSOFJJbkp1cNdsJ@google.com>
Subject: Re: [PATCH 10/18] KVM: x86: Keep track of instruction length during faults
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	graf@amazon.de, dwmw2@infradead.org, paul@amazon.com, mlevitsk@redhat.com, 
	jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	amoorthy@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> Both VMX and SVM provide the length of the instruction
> being run at the time of the page fault. Save it within 'struct
> kvm_page_fault', as it'll become useful in the future.

Nit, please wrap closer to 75 characters.

> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 11 ++++++++---
>  arch/x86/kvm/mmu/mmu_internal.h |  5 ++++-
>  arch/x86/kvm/vmx/vmx.c          | 16 ++++++++++++++--
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8d74bdef68c1d..39b113afefdfc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4271,7 +4271,8 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
>  	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
>  		return;
>  
> -	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code, true, NULL);
> +	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
> +			      true, NULL, 0);

Hrm, I just proposed adding another (out) parameter to kvm_mmu_do_page_fault()
in the TDX series[*], I wonder if we're reaching the point where it makes sense
to have kvm_mmu_do_page_fault() take a struct too.

[*] https://lore.kernel.org/all/ZuR09EqzU1WbQYGd@google.com

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ac0682fece604..9ba38e0b0c7a8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5807,11 +5807,13 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
>  		return kvm_emulate_instruction(vcpu, 0);
>  
> -	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> +	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL,
> +				  vmcs_read32(VM_EXIT_INSTRUCTION_LEN));

It might be worth adding a cached EXREG for instruction length, e.g.
VCPU_EXREG_EXIT_INFO_3 + vmx_get_insn_len(), similar to how for vmx_get_exit_qual()
and vmx_get_intr_info() pair up with VCPU_EXREG_EXIT_INFO_{1,2}.

