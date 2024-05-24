Return-Path: <linux-arch+bounces-4537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C38CEA2E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41291B20BFA
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFE40849;
	Fri, 24 May 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cvl34NI5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD02381C6
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577889; cv=none; b=WQaulmS5z/kLK1yfEn3uV5M5BcWeZzK0y+IaJ8ChRTo/GqzYaXIRhyQlEiWAXVbZJHX9aewrtnIVsRbJng5/ZbwuybgkGEFfwMDDKPrzGyaAmdi3bS9FWmH2RtkHICg/L/3ng2w6nh0e06MKwZSRUATjEPFqWfiESh5TcsRNVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577889; c=relaxed/simple;
	bh=ekJ4PIWteF0STOLt8GEwvTZKcTBrMpP/XnMQSDaKdFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RobTeaD4TqQmKYuA18Gfokg+2RjxGkqJ7U6dTWVWkqlLZTYwPhpIrskW5kLYdYJfh4vhR2otyvONzz8jd9bClnnJiHb0OuC29P8dIPgwdoDTdrdh5p3kOec7jpwbneHL/G9mJvhPYAgq4f6Cqy4f+Ux7Evr8IHdc358qj0062BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cvl34NI5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so4150504b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716577887; x=1717182687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NHWDoWZZfWuUu/P0x+kbvgCTb8gOtuuYHKkIDhOcYik=;
        b=cvl34NI5VpJxkDOSy7KYVz/xK3ENQGCrkfRLgQ4/IO8GkFp1fUFXllN1DETVJl1aoB
         F71hMlbxt64dut/e7wQyxc02fWBbI/wEMjW4bYitcIs2XIkLlxrsCHLBcPEmRhN9GtPQ
         doeACI5uJUIXrVR4AMrrNkpz0KFyV4iTui3z/il+6kBHJ0vjW9XlRrScJDr/hzIi+GqF
         14rgtxrXUN1124OkrFiRuHysCB9XYa82gBmQjA2Wg3GbHhww85RBvGZC2EkywHNdQvGc
         LiphDU8ybvD0bpkJs504lph7tZuiXrGzmVYxfcixqboZVnVfSeoreuGgMT2+I4lnXgWB
         GXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716577887; x=1717182687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHWDoWZZfWuUu/P0x+kbvgCTb8gOtuuYHKkIDhOcYik=;
        b=NwO9fWwwNeExvcsp1JrcozZTYJwmEEP7EAhyABgyiKmeevlwHIOsmsmKztnxs8TLQD
         hgGoEn0nRMqaXenKrciZvwZV/2424MKDGQsZAt1ANCgT5NOJ4BNClpVdxiUad44swUGs
         +8/sMzuSbcOeDxHAmh7WYdNs2xYviI6rC2HSm1sWRBGG3s1Y427DRIdc1ZYozLdcoV2P
         orhRLYQXa3gMVu9P6gm9Z+Mk/JH8cKj0WvbpXEmWjVSko4V9cDI9UpX2CzTRDgFurH4g
         NiZpg7aAxi19d9qaSkv94OSAJiP2FlBcri3QziHlmEmfoW+JP9ZM8QJmP0aBN4PYbw+o
         JX6w==
X-Forwarded-Encrypted: i=1; AJvYcCXLAHK3yxrawz2vjIk6EOpPSkrm/BFgpZczWbCZGI0z3n2iz0pXQ7LnPUxXF7mHz+aV5jVen8TYRW4krix8nmMkCWtsPt/Hf1GE8A==
X-Gm-Message-State: AOJu0Yxkk0UW4EHNvoJgbJ6bg/raG3FJpYkFInEC+29+UvQM3w9Ec10D
	D5o0YXdpozG4M9dhZxWM2oeyyj/6IORQ2E5OyX7P+MAJfGRRf60UCeVFLWkHwwY=
X-Google-Smtp-Source: AGHT+IEwWQZpFilaYbUUGlopJo1f2TdPyB2rRnSl7U/MDmzei8hNgpy175SX2dTVTzyB8unJyM8ICQ==
X-Received: by 2002:a05:6a20:12ca:b0:1af:93b0:f007 with SMTP id adf61e73a8af0-1b212cc4fd5mr4361727637.1.1716577887327;
        Fri, 24 May 2024 12:11:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe5961sm1424089b3a.164.2024.05.24.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:11:26 -0700 (PDT)
Date: Fri, 24 May 2024 12:11:22 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, jerry.shih@sifive.com,
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, charlie@rivosinc.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 22/29] riscv sigcontext: adding cfi state field in
 sigcontext
Message-ID: <ZlDmWoo6EVZ1MKbN@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-23-debug@rivosinc.com>
 <CABgGipW4ZTFLh1dkiRuWD0WP4RRkfhyFCc+RsUjCD2EkA5GhSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgGipW4ZTFLh1dkiRuWD0WP4RRkfhyFCc+RsUjCD2EkA5GhSQ@mail.gmail.com>

On Fri, May 24, 2024 at 05:46:16PM +0800, Andy Chiu wrote:
>Hi Deepak,
>
>On Thu, Apr 4, 2024 at 7:42 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Shadow stack needs to be saved and restored on signal delivery and signal
>> return.
>>
>> sigcontext embedded in ucontext is extendible. Adding cfi state in there
>> which can be used to save cfi state before signal delivery and restore
>> cfi state on sigreturn
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/uapi/asm/sigcontext.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
>> index cd4f175dc837..5ccdd94a0855 100644
>> --- a/arch/riscv/include/uapi/asm/sigcontext.h
>> +++ b/arch/riscv/include/uapi/asm/sigcontext.h
>> @@ -21,6 +21,10 @@ struct __sc_riscv_v_state {
>>         struct __riscv_v_ext_state v_state;
>>  } __attribute__((aligned(16)));
>>
>> +struct __sc_riscv_cfi_state {
>> +       unsigned long ss_ptr;   /* shadow stack pointer */
>> +       unsigned long rsvd;             /* keeping another word reserved in case we need it */
>> +};
>>  /*
>>   * Signal context structure
>>   *
>> @@ -29,6 +33,7 @@ struct __sc_riscv_v_state {
>>   */
>>  struct sigcontext {
>>         struct user_regs_struct sc_regs;
>> +       struct __sc_riscv_cfi_state sc_cfi_state;
>
>I am concerned about this change as this could potentially break uabi.
>Let's say there is a pre-CFI program running on this kernel. It
>receives a signal so the kernel lays out the sig-stack as presented in
>this structure. If the program accesses sc_fpregs, it would now get
>sc_cfi_state. As the offset has changed, and the pre-CFI program has
>not been re-compiled.

Yeah this is a problem if program was built with older kernel/old toolchain
(or cfi unaware toolchain). Thanks.

>
>>         union {
>>                 union __riscv_fp_state sc_fpregs;
>>                 struct __riscv_extra_ext_header sc_extdesc;
>> --
>> 2.43.2
>>
>
>There may be two ways to deal with this. One is to use a different
>signal ABI for CFI-enabled programs. This may complicate the user
>space because new programs will have to determine whether it should
>use the CFI-ABI at run time. Another way is to follow what Vector does
>for signal stack. It adds a way to introduce new extensions on signal
>stack without impacting ABI.
>
>Please let me know if I misunderstand anything, thanks.

I think following how vector does would be cleaner.
Let me munch on this a little bit.

>
>Cheers,
>Andy

