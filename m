Return-Path: <linux-arch+bounces-2667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411885EE51
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5EF282518
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F711CBC;
	Thu, 22 Feb 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G6aDil3i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636A11712
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563041; cv=none; b=P5/boND3kKik6EwGsgLAZRat1gqxiQKwXj6C71c7NCirzqXfsffH2dKprBpyp/s/BxDtmarBvPi4wmMd2on24MS2XF4pFkJhbHdbiJut3fFyp5caV6tMUzWYGtqrMrsRClx6r+hna+DdAFdmO/eFupaFFHETlAMauUFBWXCwhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563041; c=relaxed/simple;
	bh=5ne/cwIuCR8FyBAFcmxTad9FZ51QKgKQ/8n60a6xKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfjM8rXHw9OZDLfV2jLkgHjcCz6u5qA2tGVM587YINvknWbNY9ednIM0Ux/PfQEI8d4UYtj/uByqHkWHALuw55HBLej9iLXWnVigW0ODtM9nnqssmal2t40khvi0gIQOjvA9EluCJckC7XjjB+gYcZbdx+zUls7l6gIhrEUYWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G6aDil3i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso4117085b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708563035; x=1709167835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ne/cwIuCR8FyBAFcmxTad9FZ51QKgKQ/8n60a6xKD8=;
        b=G6aDil3iQzDQi4fBtdR3ChTgwGGcVcdnYJVctOH67n4nCkV9pXTHQk2enSZR1qkbKT
         EH35U0IAkb96ALzT1R5n4yYGAUXJdoeIA/jQfJ9ryXbsU6zbSA0ZF2QrBNaRP9Y/nr7n
         fiWUtZ9Ho9iqBBjiSVNz/M72t8QSOwiPs5uQz4hwPFbFcxFiPHPjY4ORcd0CN/+dVSPt
         AVh8/WsbP47YxNPpz06SA2OhOhPqQnARPlG3buF7rpXF/ep7G6WHjMDT3SCxaJHYhJ9v
         LKjnw9H02qLegeZ5Opv+ub3xUFGEcNI2TQgsUl5NBr1g2zg9Hq7FXnfS186MKv97mkgm
         jCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563035; x=1709167835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ne/cwIuCR8FyBAFcmxTad9FZ51QKgKQ/8n60a6xKD8=;
        b=F33csYgGfyvbFDIRqYAM5yijQH0g8H6fJRxYacVMq9GxqQ3CM78XEMnrTVAkNcasup
         sM6I0fUtqi0XYyEFXLTfVCywyqhg9t6tXKpiQ7uPoYpyvx1K7wILvpfX/w+HBMKqXFp8
         ygbz1riiu4RPfWet5h3HxOvr6YCpi0NSOsQl4C8TJ8ibRHUw9157udkZAC22IJkB1TPL
         TsXx7QpbvU4NQxRTU0mDfwy0dqLhmbKS8iIMqWDtn/qoUr55DX67aSqXO9vNq9se+rXR
         QaD796q1DGEpjlnIeaeFwVWm89aIke9uO17HGxQlxtg82K8d8s4Y8zR+WysMIIvZQAvy
         GdPA==
X-Forwarded-Encrypted: i=1; AJvYcCVYR2507L54IVNWBrIgrZffDh9mImJzvaVYtHmB/EnF8xEeXJo4mY8e2jNFpe8vPwNrJWLDdgbuHQ/SjQ6D5WomwgeAIwpucC+xfA==
X-Gm-Message-State: AOJu0YwJRemjavawBRgjmpee/v4sZOHXXsCLbj/lEVMotA4B5FUpk/Ha
	QF5EqRec4Pap1Ilr2XQ3lAa+9yz+RFGzEq3Cso8KDYqH7SbomAAPRkUHkfFfr9E=
X-Google-Smtp-Source: AGHT+IHGf00IBRZ94uXhy3F/2SqhItEAHmbVU+XM+K8PgG8OtyyJ9+JfcyGA+LZi58DTqhZ5nGjLug==
X-Received: by 2002:a05:6a00:ccb:b0:6e4:7b26:3f28 with SMTP id b11-20020a056a000ccb00b006e47b263f28mr7902748pfv.21.1708563035154;
        Wed, 21 Feb 2024 16:50:35 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a2-20020aa78642000000b006e34008d0c3sm8898152pfo.100.2024.02.21.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:50:34 -0800 (PST)
Date: Wed, 21 Feb 2024 16:50:30 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"alex@ghiti.fr" <alex@ghiti.fr>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	"atishp@atishpatra.org" <atishp@atishpatra.org>,
	"cleger@rivosinc.com" <cleger@rivosinc.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"gerg@kernel.org" <gerg@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>,
	"david@redhat.com" <david@redhat.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"panqinglin2020@iscas.ac.cn" <panqinglin2020@iscas.ac.cn>,
	"mchitale@ventanamicro.com" <mchitale@ventanamicro.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"revest@chromium.org" <revest@chromium.org>,
	"mason.huo@starfivetech.com" <mason.huo@starfivetech.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"baruch@tkos.co.il" <baruch@tkos.co.il>,
	"waylingii@gmail.com" <waylingii@gmail.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"ancientmodern4@gmail.com" <ancientmodern4@gmail.com>,
	"mathis.salmen@matsal.de" <mathis.salmen@matsal.de>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shr@devkernel.io" <shr@devkernel.io>,
	"andy.chiu@sifive.com" <andy.chiu@sifive.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.chen@sifive.com" <vincent.chen@sifive.com>,
	"greentime.hu@sifive.com" <greentime.hu@sifive.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"zhangqing@loongson.cn" <zhangqing@loongson.cn>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"Wang, Xiao W" <xiao.w.wang@intel.com>,
	"cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"ruscur@russell.cc" <ruscur@russell.cc>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
	"jszhang@kernel.org" <jszhang@kernel.org>,
	"jeeheng.sia@starfivetech.com" <jeeheng.sia@starfivetech.com>,
	"alx@kernel.org" <alx@kernel.org>,
	"guoren@kernel.org" <guoren@kernel.org>,
	"chenjiahao16@huawei.com" <chenjiahao16@huawei.com>,
	"omosnace@redhat.com" <omosnace@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"evan@rivosinc.com" <evan@rivosinc.com>,
	"bgray@linux.ibm.com" <bgray@linux.ibm.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <ZdaaVhM9Yb9Zuj3J@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
 <ba45e69f69851721419b84f1ff8b66a490f92c86.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ba45e69f69851721419b84f1ff8b66a490f92c86.camel@intel.com>

On Fri, Feb 09, 2024 at 08:44:53PM +0000, Edgecombe, Rick P wrote:
>On Wed, 2024-01-24 at 22:21 -0800, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> As discussed extensively in the changelog for the addition of this
>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>> existing mmap() and madvise() syscalls do not map entirely well onto
>> the
>> security requirements for guarded control stacks since they lead to
>> windows where memory is allocated but not yet protected or stacks
>> which
>> are not properly and safely initialised. Instead a new syscall
>> map_shadow_stack() has been defined which allocates and initialises a
>> shadow stack page.
>>
>> This patch implements this syscall for riscv. riscv doesn't require
>> token
>> to be setup by kernel because user mode can do that by itself.
>> However to
>> provide compatiblity and portability with other architectues, user
>> mode can
>> specify token set flag.
>
>A lot of this code look very familiar. We'll have to think about at
>what point we could pull some of it into the code kernel.
>
>I think if we had an arch write_user_shstk(), most of the code could be
>shared here.

Yes it is. I'll think a little bit more on this on next set of patchsets
when I send.

