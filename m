Return-Path: <linux-arch+bounces-7298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11969788AB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 21:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840032854ED
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC914A4E1;
	Fri, 13 Sep 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVZLeFva"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AC1487DD
	for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254799; cv=none; b=IqlhCEhFhxb3UvlInnwNrO1+8x90YIMHNMWu7509vv4vYIDsBSr3Rg/b4u+3lX2CBCVhN6NU5rqUVt2IJrn7Nm5RQLPCwvMtRSNU9EksiWFkXajU+8AjqBcGuGmz+bXoSNieFe5KXcvcdAO9+3uBsV3oVb2Ty+eNU51mc5WFe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254799; c=relaxed/simple;
	bh=IsfTERefoLI8uj0HMVKFZe9Wcvo97d6+PwD/aMKAFoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTDu8M3v5tXxd265JyGIVLvoOuE6M1Z/iKRsOsedONBGD3umMHhEFeUKL7mmxzc1yUnkawhdLLsspTd0t4BuNe51QTb1BILjYJTH2qvCyXLXmc8jVIQM6Qj5wHBK1rKDc4bx/fG0ym2px8LaMZxbQ5HsNXimbfWyELZdPrZOQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVZLeFva; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5fccc3548so37402547b3.1
        for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726254796; x=1726859596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBbJrnW2Tttv+PkO4muirmSoBYIYxfrhHvQ5HrkpYw=;
        b=wVZLeFvaU2fawCrni21fvSCVIJ4nTHbfE+eDRYUNfLfJdL89+HQ0rDs55qAl0ZO9a5
         oIeEQX300Zdb/YGjaITeXX8cU608BntfHEY2n7p1vY2poGraIzNROLS3wgeu6nAAhb3Q
         Pw5PVKyjTm5DZvps0KbUBLXYO1Bg0bdVAvAK7LfNEKYCxnmStoX0YNq5oMgUauZJnPpp
         La2XEnuowKHdRyStGQ10L1+Uo8+y6CYeaa0WvmNbXDhNpUB5aHNsK8bONrx1BIpl4bXC
         tAbaRCKai1yE5nnL+F3mGjmsdI0gI0Ups1Z0MSFsNtL56e2A9CcswPrHPdU0YaVdxJ3c
         rrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254796; x=1726859596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBbJrnW2Tttv+PkO4muirmSoBYIYxfrhHvQ5HrkpYw=;
        b=PZR/RRsVVUVf1HHCrjmQeJ+x/fKPD5Ckkv/Fc5SxZQdR/LwLdIjvilu3s9SXMzDGDT
         RJGz2feSmORIgk9ZC0XackXHL7JKJhjnhRpUJ161o25vgQdL7iP/QkvuKmqgRToLt3yl
         07Y0CWVQKPa+40+Nau1m1jgpehzz02u6pdMY9Q5LQxX44/FlyqcSlqQjXHrU1H2EUgXS
         XsTuLvtQ8RhJ2no+Qs1dYcPeB3Jf0a98oZJly01FAua4VrKnogzgJ9PPTjsA8S+/ayQP
         Jf23nwGLA/sJbUdOrunsOyp9MBdXgr/45ApuVHfUaJq6H0eEbK2dyzOP38WqWgQeZ2sw
         +vXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpvT099EvlDOoirGqIxCm0UNT2MTyui6BFx0pU3mXkSNbAn3/fv9yAGlbY7w8kr/oe7KhG1Vgb5v8R@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVfb1p06TPCFuZMLUKW9+fauwa4nYzTR6+KMnM1zyhkeaC6Xg
	SoQaFoIFD8UjNQePrvxkESafJDv309g6r4z5IOYSGDMeS0KaELK1L87t2SoOjl7Vc5YQI4X2agB
	Saw==
X-Google-Smtp-Source: AGHT+IGTejNuqL6glXrCADl/dX/2uGL712VdJXtzFkez+CePyZui9Ys40KT42WYKzoIlXbFDZPgY//LOm1Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:20a0:b0:6db:7f4d:f79f with SMTP id
 00721157ae682-6db951c4d86mr2488857b3.0.1726254796248; Fri, 13 Sep 2024
 12:13:16 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:13:14 -0700
In-Reply-To: <20240609154945.55332-14-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com> <20240609154945.55332-14-nsaenz@amazon.com>
Message-ID: <ZuSOyipSCOi_gDyM@google.com>
Subject: Re: [PATCH 13/18] KVM: x86/mmu: Avoid warning when installing
 non-private memory attributes
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
> In preparation to introducing RWX memory attributes, make sure
> user-space is attempting to install a memory attribute with
> KVM_MEMORY_ATTRIBUTE_PRIVATE before throwing a warning on systems with
> no private memory support.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 8 ++++++--
>  virt/kvm/kvm_main.c    | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b0c210b96419f..d56c04fbdc66b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7359,6 +7359,9 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>  					struct kvm_gfn_range *range)
>  {
> +	unsigned long attrs = range->arg.attributes;
> +	bool priv_attr = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;

It's probably worth making this check generic straightaway, e.g. build and then
check the set of allowed attributes, similar to how check_memory_region_flags()
builds and checks the set of allowed flags.

