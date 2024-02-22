Return-Path: <linux-arch+bounces-2666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275C85EE42
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032D22824FA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA010A19;
	Thu, 22 Feb 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pRb17MbG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C820101F1
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562838; cv=none; b=jIqzfSjS/Qpt8fghJclfl9bOK+X2/vJfcd3GKCfGxwVnu37hnZswgbDIghNPZCiVCdb/FXUKIJkpthIJM3LtYvd+Qhzpc5+Xccze3keQLZnVisCdW2mJYVbT6uG4ZlYZgujKetGb2XDZXHxdx3cb0F1cdGTiukfA+1doH7rWNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562838; c=relaxed/simple;
	bh=TPRDg52o/XUAEJGbQcaz27E13NquY89Tp4mylzmLm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJHKNRWpjoUb2I/HgZzI14Pv9XlZWK6nnpiRTUHw6m7HYNoY5Ao6ONGYMXPUnZwYKGJd7x9e/a30SYTd/bCPMAtFphbocMWylAkaK5TIdFj99Tl1uvFiJlsA3XC677kmHquSKeVinf4jebLAS02u9oY/6cR4hkLcHID3gXJ/G4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pRb17MbG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c031c24fbeso857432b6e.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 16:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708562836; x=1709167636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxnB8hIBaJHKU9GMJod5TzavYw729HDn9dbYWz/K8DM=;
        b=pRb17MbGCSgF084iq8gn+zcwxWgWZ7DZdI4X3SQ4AQePL32QfkTF3m/ziJYnQP1k1S
         2pMHI23BvPUIhmY0m6OkAntfXbw3EfAeUoV7KRsemjn3mXuov2AUF18H4uEs8A/atUSu
         cWNiwZoec7ZLBovAlsoMNZBRLGZZrrA0gd5CCE2WCT59gHi+190Gw527w92Mg07nGNQz
         b+aRR9ZXjcf75FYFJ8QUOhfvW/kN4lsfidpabsdKasHSFv7cW6SLjzDKcs8rJjgMEzdC
         Mzb/E9HeHazoNloEL8LElBrxh1NYpZ/mG7h3Jr74W4qoEcZCXa1P0por5A6xtMniQdWf
         2xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562836; x=1709167636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxnB8hIBaJHKU9GMJod5TzavYw729HDn9dbYWz/K8DM=;
        b=jVzmZ9Tbw3rfudwc4RTbIms1W6KVpi9TAK8w41j0hW0TKNvNKzgkfvfVzhOw4+cAuM
         fpf+wXr0bwlVlGcQcKIq8b5C+G414FECRPC4XsLsaB72zUJ6hA7RODdPOBZqxqcgd32m
         t0ilJDxhBCVRzET544fNZi4iRPe6FExnsfe7LJxMAVH5l3uafVNLe5wZUy9IbP3dG1OI
         ySHzZg7kzLM3A7TvUH70eXLKBdXOzLffLr7LxaaQECmm6SUr37ihe60cKkGFZQPqGaWs
         9mITKxTCGrk/BydJ8hd9jV0PpgNnxjN+X10uB5CEUJdqjPsQsMsYNScKxTxFwM430puF
         P9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM2G9dPyvshubPipjjsjhye0uyNoE+0crQ4VYa815fZaB8rkxFsiRO3fSS14npCeIlFuv9mjz7HeEQIEVIb68L9a12E2s0RavC/Q==
X-Gm-Message-State: AOJu0YzBf+uXPCtNDZqY8KHvrCEpvtUkcMfi2S1wh9JPP79oifLlhVZC
	MHCOI7t+xHx8aZE5kz3HgtBX/gS6o6PO/NslI1hMOTIdOQHnFI+2E5zS3btqgT4=
X-Google-Smtp-Source: AGHT+IFSLTMc3hCuIYilhHI07UG+3jHSb+dOia9uI0EVHy8hIHGEMNdRSjhvd4xYo+3moab7FJoglQ==
X-Received: by 2002:a05:6808:170f:b0:3c1:5440:d2c5 with SMTP id bc15-20020a056808170f00b003c15440d2c5mr11757138oib.38.1708562836074;
        Wed, 21 Feb 2024 16:47:16 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a000b0a00b006dddf2ed8f0sm9533333pfu.154.2024.02.21.16.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:47:15 -0800 (PST)
Date: Wed, 21 Feb 2024 16:47:11 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <ZdaZj0pqaVJiNOUg@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
 <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 04:01:28PM +0000, Mark Brown wrote:
>On Wed, Jan 24, 2024 at 10:21:40PM -0800, debug@rivosinc.com wrote:
>
>> As discussed extensively in the changelog for the addition of this
>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>> existing mmap() and madvise() syscalls do not map entirely well onto the
>> security requirements for guarded control stacks since they lead to
>> windows where memory is allocated but not yet protected or stacks which
>> are not properly and safely initialised. Instead a new syscall
>> map_shadow_stack() has been defined which allocates and initialises a
>> shadow stack page.
>
>While I agree that this is very well written you probably want to update
>the references to guarded control stacks to whatever the RISC-V term is :P

Noted. I'll do that in next patchset.

>
>> --- a/include/uapi/asm-generic/mman.h
>> +++ b/include/uapi/asm-generic/mman.h
>> @@ -19,4 +19,5 @@
>>  #define MCL_FUTURE	2		/* lock all future mappings */
>>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>>
>> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
>>  #endif /* __ASM_GENERIC_MMAN_H */
>
>For arm64 I also added a SHADOW_STACK_SET_MARKER for adding a top of
>stack marker, did you have any thoughts on that for RISC-V?  I think x86
>were considering adding it too, it'd be good if we could get things
>consistent.

Please correct me on this. A token at the top which can't be consumed to restore
but *just* purely as marker, right?
It's a good design basic with not a lot of cost.

I think risc-v should be able to converge on that.



