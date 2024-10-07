Return-Path: <linux-arch+bounces-7790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE9993B35
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 01:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B103F1F23E05
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE4192B8E;
	Mon,  7 Oct 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ktby9xLk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63B17279E
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343815; cv=none; b=dn89+sJl6HlJoUFjFB8/aIrH6WHVANFKssW9pOEklBhNDppAbo3bRokhK4UDmf84YHcVLgfXOah9lmnpGCMPyqMaZgHsEBSyjAQqAr3rwqxNkBxpSGaOjW5zoNSPbCC5r1StFzIdBc6swQqeyDlDRTFvsasSbqYCfeOz4Q0bh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343815; c=relaxed/simple;
	bh=S1F++puxXk1Ulj8gHCvxmOOAcPGjm+vi9Ym0UiVV8hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozvza2XS71opsD/TFZUnPaz/8fsNmWHdlB3FyeieKeP6qUIBiUvGBYOd4tvpa1ZMjhUa7tqA6V/rTUYERa5Zl5OKHxAiQvERQ5qbPyzr+TJ83/4UNwsknR69Ze5/6EcoAQCTfm+j/iXqmmnXgaxPTHdxOBjPhyUUjYgd8U59IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ktby9xLk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e02249621so1118022b3a.1
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728343812; x=1728948612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e7/GR1vy5g6MzSW/6AGsBA6lPgGhyPg9oR0WwZB3CYI=;
        b=ktby9xLkZAr2/l0cdYu5vXBZSpJTc8C1WJY4c0br7+rLMbpYJICVnk5B8OlUVXfThH
         WiW2iiUvC5W0J2qdKb/9cuSXSuQF4i51HcPsmcDJpiaBmm6YjTRrH2tBqMMlaV++p3fG
         u0E26Y23eCqRzhG6wbKWlJJIvsfnQ98Jy1HKkmUM2sv1Zg6jL/s+woWdKI+17vZr+XXC
         OYorqtcblNuNivuqozuxo2THjZyAK2r1TCSwDiOf1tz9n3Dkfeon1W/kvpl+j6kegFsF
         w5Ea1KLLz5H33G8KmASrKvkCvKstLrFWKDHQ5r8yEUOyR15C3KJlRe5TCnXqknDhd2oO
         /60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728343812; x=1728948612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7/GR1vy5g6MzSW/6AGsBA6lPgGhyPg9oR0WwZB3CYI=;
        b=g9Vi7x41QRzctjHarBzhWtg4iRrTlKCbFSe6DuBgEqdetqP0UBJwrdXB0FWDV0wCh4
         ZPvO/y58XmC1PG5++K3M90zu0PZdPO+8SjtuCz305STp1ueMnGJcG0dLOtZ3SdNwfzAH
         4vZHzPzIYmoLDsaLz2TYBQX+Vpaa1G+PpPE9CTIVmRTgkLVfd/r24JJEY1ZnEBJHmlQ5
         Fr1RZz06w1OEfWuvAI3peG3g6kfZ+RPQe5luUi6OQnCk2gl1L3V2ZItci0/j5e/Zfjse
         ZtQXUPD0jbtWc1Gutp0lnpNjThIZFufcR0s/p6MpSnjvjkTeHeniYo6FIqFXulDRJhpK
         xTcw==
X-Forwarded-Encrypted: i=1; AJvYcCX8gkRV/BsWdfam32jGlsFo/vQ0fKSaNY7Y+zxyywevP5TzitrGaR2MISDoO1QTr6X9BWfF+SWDxGw0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjZkeDK8CBPzh22JXNH+KudBJy2jAR8a5Z5fhA8SEzgS2C3nA
	/LHfesOLi74b8Ve77z8nfP3zC6c8cZyJuTUBL9zAlpdEvWzlLOu7m49nb7Wp7hI=
X-Google-Smtp-Source: AGHT+IGbBDU9FuYkbc/ROL+eEuwX1ANHvoegHjKgVYPBMiJcEOGbwaOtHTQqomqAdeFDnRJFbE5XwQ==
X-Received: by 2002:a05:6a00:8a03:b0:71d:ee1b:c854 with SMTP id d2e1a72fcca58-71dee1bcacamr11916142b3a.9.1728343812103;
        Mon, 07 Oct 2024 16:30:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbba1csm4970382b3a.33.2024.10.07.16.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:30:11 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:30:08 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
Message-ID: <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>

On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
>On Wed, Oct 2, 2024 at 12:20 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Userspace specifies CLONE_VM to share address space and spawn new thread.
>> `clone` allow userspace to specify a new stack for new thread. However
>> there is no way to specify new shadow stack base address without changing
>> API. This patch allocates a new shadow stack whenever CLONE_VM is given.
>>
>> In case of CLONE_VFORK, parent is suspended until child finishes and thus
>> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
>> because entire address space is copied from parent to child.
>>
>> `clone3` is extensible and can provide mechanisms using which shadow stack
>> as an input parameter can be provided. This is not settled yet and being
>> extensively discussed on mailing list. Once that's settled, this commit
>> will adapt to that.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/usercfi.h |  25 ++++++++

... snipped...

>> +
>> +/*
>> + * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
>> + * cases where CLONE_VM is specified and thus a different stack is specified by user. We
>> + * thus need a separate shadow stack too. How does separate shadow stack is specified by
>> + * user is still being debated. Once that's settled, remove this part of the comment.
>> + * This function simply returns 0 if shadow stack are not supported or if separate shadow
>> + * stack allocation is not needed (like in case of !CLONE_VM)
>> + */
>> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>> +                                          const struct kernel_clone_args *args)
>> +{
>> +       unsigned long addr, size;
>> +
>> +       /* If shadow stack is not supported, return 0 */
>> +       if (!cpu_supports_shadow_stack())
>> +               return 0;
>> +
>> +       /*
>> +        * If shadow stack is not enabled on the new thread, skip any
>> +        * switch to a new shadow stack.
>> +        */
>> +       if (is_shstk_enabled(tsk))
>
>Hi Deepak,
>Should it be '!' is_shstk_enabled(tsk)?

Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFORK, it was returning
0 anyways. And in the case of CLONE_VM (used by pthread), it was not doing the right thing.
Most of the testing has been with busybox build (independent binaries0 driven via buildroot
setup. Wondering why it wasn't caught.

Anyways, will fix it. Thanks for catching it.

>
>> +               return 0;
>> +
>> +       /*

