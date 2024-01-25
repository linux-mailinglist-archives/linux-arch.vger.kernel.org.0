Return-Path: <linux-arch+bounces-1656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A681383C991
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355711F296AB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4BD131758;
	Thu, 25 Jan 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W5o3TfmG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B513F00D
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202429; cv=none; b=MHxwGKarpq1LNwkBhhwTGspXjw8UdkHUh5OcaEUYfxTeinfmSo5IxqMWiUzt9mySZEnRlpQ6o4vih8Hj7dP0KjnlpOine10cdg4flEHD4bjO1iKPMUKqDLGqtczD1np39LAgAq/7X0OFwdTTUj0n9a26qAmwndxuA0mugLjE0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202429; c=relaxed/simple;
	bh=D67xfWj49rEWhxKLXVTx8zZvTyjJJP7GfOM5AXkQED8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz0cu3caaBNEnoBW1kN0CIVkqUt0CeVOUsbuus+luXcJzT/yicMr68GBmtZhqL50cCSzMFE4k4Ijh/laoHO62e7d1WbhYHf0SgAI+HKM7wfFuXjdOk50qif4btwx9V8+0HYqqPPZOFv0MbInluJP87T339wIYsL8XN46b18Ez7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W5o3TfmG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so1704972b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706202427; x=1706807227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Y205/Bj9/UaPGsjWa2kZTirfJ1VaurSr0W2Uv0l3s=;
        b=W5o3TfmG1qYIQsYSVDvRFTtYt/tcqX4EtviBfEh4+vk8nv4TA3jgBqwyUCRH8hc6Ey
         K7m6hdSNilDw+iVPVHFW50Jt5Hic4nxmABkZJX1h9hhknC07AgbQl3dM2Pkvkx5854UE
         LLxtoyeq2nVcG25Di3wRg3+AcibCUtxCg9+I50tdgZLKpNn47dCdOTZZlRTx2YalPWnb
         tY2llH67aDUY3PjHZtwagEOJMdfja36GeILOw97OuyaMvg5+u7zFk8wZwS//dRisk0rm
         rmPTLmWZ9d8Jzmx50fTs7ImswwosfMKW+2s2hEkykxm4MhH26vQnUQ9lXltkp3rlc7n+
         keZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202427; x=1706807227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Y205/Bj9/UaPGsjWa2kZTirfJ1VaurSr0W2Uv0l3s=;
        b=c57kTtcthzMaCWyvm7aX43GdraByAewtuL+T7NxWuzow7Ent1N++Qis23nBQZxTpee
         VCl7SZv+Pcjl6RCoUkTgP1u+DDRALBzjZXdLHNk9Y52aGudNiLIHVbeeQ/2YNpTF8hN9
         7EmrTEuZj1dyNgY60LJQC6/ggXQTPlg06MscOVUKeRYnP/ueV7X4fTHsNxYCsAsc2u9F
         QwhQXYHgb3pa8civvMp/iK9RVBzd6Sd+6DR5iMwXt5vS8QxtgRrixl35pGto9PIQ6iCV
         d1xcAsOwwkRtsN/o4QVfiKgG+mPmPKxbNKz879uGmdIzA4URaU91lumPlxmQvQf+TKlI
         +gzw==
X-Gm-Message-State: AOJu0Ywl+Z1YUYWYFdCKRWT2diiRPMY7k0u3ybDYsKYOCO0a1Z9G4/1X
	j2IoLa/15MI1RY16XUlr3MxKQYKc1Cb4Z3X4byoyQm3DqA64U6KZZUcRbpmOPbc=
X-Google-Smtp-Source: AGHT+IHYeX7pTsc6T2+Oj8CHwr5rzy78ADNZC7lkEDYMAD93a3MlR2jkEuTYyjSwB5kHgHqSGlWjog==
X-Received: by 2002:a05:6a00:2b56:b0:6dd:8a23:b2c7 with SMTP id du22-20020a056a002b5600b006dd8a23b2c7mr21796pfb.5.1706202427107;
        Thu, 25 Jan 2024 09:07:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id lc9-20020a056a004f4900b006db105027basm16031068pfb.50.2024.01.25.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:07:06 -0800 (PST)
Date: Thu, 25 Jan 2024 09:07:02 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: David Hildenbrand <david@redhat.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
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
	shikemeng@huaweicloud.com, charlie@rivosinc.com,
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
Subject: Re: [RFC PATCH v1 09/28] mm: abstract shadow stack vma behind
 `arch_is_shadow_stack`
Message-ID: <ZbKVNm5ubV8yQtSE@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-10-debug@rivosinc.com>
 <2f34f6aa-99fa-4545-b706-a1d50864f9e9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2f34f6aa-99fa-4545-b706-a1d50864f9e9@redhat.com>

On Thu, Jan 25, 2024 at 09:18:07AM +0100, David Hildenbrand wrote:
>On 25.01.24 07:21, debug@rivosinc.com wrote:
>>From: Deepak Gupta <debug@rivosinc.com>
>>
>>x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
>>stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
>>need a way to encode shadow stack on 32bit and 64bit both and they may
>>encode this information differently in VMAs.
>>
>>This patch changes checks of VM_SHADOW_STACK flag in generic code to call
>>to a function `arch_is_shadow_stack` which will return true if arch
>>supports shadow stack and vma is shadow stack else stub returns false.
>>
>>There was a suggestion to name it as `vma_is_shadow_stack`. I preferred to
>>keep `arch` prefix in there because it's each arch specific.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  include/linux/mm.h | 18 +++++++++++++++++-
>>  mm/gup.c           |  5 +++--
>>  mm/internal.h      |  2 +-
>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>
>>diff --git a/include/linux/mm.h b/include/linux/mm.h
>>index dfe0e8118669..15c70fc677a3 100644
>>--- a/include/linux/mm.h
>>+++ b/include/linux/mm.h
>>@@ -352,6 +352,10 @@ extern unsigned int kobjsize(const void *objp);
>>   * for more details on the guard size.
>>   */
>>  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
>>+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
>>+{
>>+	return (vm_flags & VM_SHADOW_STACK);
>>+}
>>  #endif
>>  #ifdef CONFIG_RISCV_USER_CFI
>>@@ -362,10 +366,22 @@ extern unsigned int kobjsize(const void *objp);
>>   * with VM_SHARED.
>>   */
>>  #define VM_SHADOW_STACK	VM_WRITE
>>+
>>+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
>>+{
>>+	return ((vm_flags & (VM_WRITE | VM_READ | VM_EXEC)) == VM_WRITE);
>>+}
>>+
>
>Please no such hacks just to work around the 32bit vmflags limitation.

As I said in another response. Noted.
And if there're no takers for 32bit on riscv (which highly likely is the case)
This will go away in next version of patchsets.

>
>-- 
>Cheers,
>
>David / dhildenb
>

