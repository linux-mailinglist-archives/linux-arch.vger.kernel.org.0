Return-Path: <linux-arch+bounces-4516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A188CE16E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849CF1F220EF
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2C6EB4C;
	Fri, 24 May 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="y2ijOrSi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2618E1E
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534995; cv=none; b=Hq0UZnMG0uht7HSiHIU+cgjOyOqN2ev8g7toRK2KvmYYanYPmLHxnBMZgqoPIHip+IBRD6F8DVhQx5VnN7GCeLVRaICNpRp5B2yV4fkOyhTsAaqzvjOfNmIOL8F/uDFEoFHKhDfZKZSsi5xLFAV6QvfgBYlT0qRpd15Pknj70gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534995; c=relaxed/simple;
	bh=L5dtxTCrzKCyV3a12hQ+4vBbPtIXGLsw+Pi3J3zri8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkcEoX2VcrnTTDseEELjJ2gzPeL8xDd2lYiOOwuMLsiaj881xvX02G2mCGe3NbpZ0gIcUKhrFlmXKjdSiL+lAMGPt2qjqmyzfB9QV5A/glMy/0nj/oalXiQmCHZkDJG6+rvuV02A8hWDYe7uhQdRHve3Gh6PB7HkR78sVeFr/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=y2ijOrSi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-68195b58daeso469220a12.2
        for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716534992; x=1717139792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5b7QgiVlAzfw1l+FA1jhqowDIFfn6XCF4+Yt8iGQO0=;
        b=y2ijOrSiwn8kujMA0869ALapDPpI42dWw9fvOBWqX8Y8XIpcqYXkUkkubl7IuDmmgr
         UXgs/FYwWQ6cMuIo093RxaHWEmjtTlpcPKupttpXoO4fgnH95uo/yaxP5aiTe2K0XTK6
         OB8Hf49CztFRHosI56opMlAGwTeRKeLa7jDUtXNV3n1p1lK8CwTzFsc2CcTBhW2OQl9c
         y5qGjjAYEsJqZqRGr4HQu2IUQ11hKqzITyzCBxl3gLhHVB9p4BNs9O6j/HB/qLxm07aS
         +zTKlMC5xlJAWs8LHA+/ivB1Cb7gpZt6kBbkLyaNpACXt8lTMYOy0j5JSg5MfxhV1IOJ
         uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716534992; x=1717139792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5b7QgiVlAzfw1l+FA1jhqowDIFfn6XCF4+Yt8iGQO0=;
        b=K9Ut0O3hNlivIORqiCgBRmhuM2nhU38pZRYQvYgmiAqRGAH/dsYCyCRCvPfvU6Txvz
         ox5XbiOgS2NTYhTYhyifrNWJ6epEA/yH7dVLDY6AF+WByRhw+HiHpgoaazvEqpPzpWlu
         KwnE/GPcKqbaluF6i0NbNY+xZdlFREuW6XzvZO0dFIIFMdfZ+q/mOeNAEkLQZBcanEH7
         g4pr44Y+CsWjyOfM3B99o8GpL7OIM/1R0j5L7w7SK8MRp5afjXNdFqtAML1MmIvxcz3Q
         xly2nUqcrUK5Jq9W/envIoaOmDSVI4PFiz6/nP8bp5OjObYLyNnyy3+TkWC2Dkom84B/
         RVGg==
X-Forwarded-Encrypted: i=1; AJvYcCU1DeWn0X3F4uqirsKN7LihZt0wjmPX4SQH1p+gpbJIqB2+R5xdwj27+y8aYz21Q8XWJ9f9tV6M2Smd9o3CJXSkLggGjcJRYpP1Rg==
X-Gm-Message-State: AOJu0YwoIpInMiO09IAHbXPNxOu+3/tVXLDc8zGgYSKUquxhj5R0P5Qm
	gCHHj8quJLW612l/qMfI19Oq17wZlpAwiqeMsq2prkYSU5HlxNXROJgbViGpJdA=
X-Google-Smtp-Source: AGHT+IEDTqTA76mWXJ68mdGF74fNSFi0v4c+GSsV/TK7Kq0h+0BnWlexLZoWy2cb8clnmvmHxGdpVw==
X-Received: by 2002:a17:90a:ec12:b0:2bf:5992:31ae with SMTP id 98e67ed59e1d1-2bf5ee1cb71mr1385379a91.20.1716534992281;
        Fri, 24 May 2024 00:16:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f9b28dcsm742083a91.52.2024.05.24.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:16:31 -0700 (PDT)
Date: Fri, 24 May 2024 00:16:27 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com, broonie@kernel.org,
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, atishp@atishpatra.org, bjorn@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
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
Subject: Re: [PATCH v3 13/29] riscv mmu: write protect and shadow stack
Message-ID: <ZlA+yxsiHtyUJ/5/@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-14-debug@rivosinc.com>
 <276fa17b-cd62-433d-b0ec-fa98c65a46ca@ghiti.fr>
 <ZkJOs6ENmDHFsq/U@debug.ba.rivosinc.com>
 <CAHVXubhS3CJ87DxC+9+8z6CiWDV1bQ8nK+iOZUDvMiT7vszFLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubhS3CJ87DxC+9+8z6CiWDV1bQ8nK+iOZUDvMiT7vszFLA@mail.gmail.com>

On Thu, May 23, 2024 at 04:59:30PM +0200, Alexandre Ghiti wrote:
>Hi Deepak,
>
>On Mon, May 13, 2024 at 7:32 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Sun, May 12, 2024 at 06:31:24PM +0200, Alexandre Ghiti wrote:
>> >On 04/04/2024 01:35, Deepak Gupta wrote:
>> >>`fork` implements copy on write (COW) by making pages readonly in child
>> >>and parent both.
>> >>
>> >>ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
>> >>Assumption is that page is readable and on fault copy on write happens.
>> >>
>> >>To implement COW on such pages,
>> >
>> >
>> >I guess you mean "shadow stack pages" here.
>>
>> Yes I meant shadow stack pages. Will fix the message.
>>
>> >
>> >
>> >>  clearing up W bit makes them XWR = 000.
>> >>This will result in wrong PTE setting which says no perms but V=1 and PFN
>> >>field pointing to final page. Instead desired behavior is to turn it into
>> >>a readable page, take an access (load/store) fault on sspush/sspop
>> >>(shadow stack) and then perform COW on such pages.
>> >>This way regular reads
>> >>would still be allowed and not lead to COW maintaining current behavior
>> >>of COW on non-shadow stack but writeable memory.
>> >>
>> >>On the other hand it doesn't interfere with existing COW for read-write
>> >>memory. Assumption is always that _PAGE_READ must have been set and thus
>> >>setting _PAGE_READ is harmless.
>> >>
>> >>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >>---
>> >>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>> >>  1 file changed, 10 insertions(+), 2 deletions(-)
>> >>
>> >>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> >>index 9b837239d3e8..7a1c2a98d272 100644
>> >>--- a/arch/riscv/include/asm/pgtable.h
>> >>+++ b/arch/riscv/include/asm/pgtable.h
>> >>@@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
>> >>  static inline pte_t pte_wrprotect(pte_t pte)
>> >>  {
>> >>-     return __pte(pte_val(pte) & ~(_PAGE_WRITE));
>> >>+     return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
>> >>  }
>> >>  /* static inline pte_t pte_mkread(pte_t pte) */
>> >>@@ -581,7 +581,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>> >>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>> >>                                    unsigned long address, pte_t *ptep)
>> >>  {
>> >>-     atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
>> >>+     volatile pte_t read_pte = *ptep;
>
>Sorry I missed this ^. You need to use ptep_get() to get the value of
>a pte. 

Noted. will fix it.

>And why do you need the volatile here?

I don't remember the reason. It's probably not needed here.
But I am sure I was debugging something and trying everything.
And this probably slipped sanitization before sending patches.

Will fix it.
>
>> >>+     /*
>> >>+      * ptep_set_wrprotect can be called for shadow stack ranges too.
>> >>+      * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
>> >>+      * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
>> >>+      * but we dont want this wrong configuration to be set in page tables.
>> >>+      */
>> >>+     atomic_long_set((atomic_long_t *)ptep,
>> >>+                     ((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
>> >>  }
>> >>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>> >
>> >
>> >Doesn't making the shadow stack page readable allow "normal" loads to
>> >access the page? If it does, isn't that an issue (security-wise)?
>>
>> When shadow stack permissions are there (i.e. R=0, W=1, X=0), then also shadow stack is
>> readable through "normal" loads. So nothing changes when it converts into a readonly page
>> from page permissions perspective.
>>
>> Security-wise it's not a concern because from threat modeling perspective, if attacker had
>> read-write primitives (via some bug in program) available to read and write address space
>> of process/task; then they would have availiblity of return addresses on normal stack. It's
>> the write primitive that is concerning and to be protected against. And that's why shadow stack
>> is not writeable using "normal" stores.
>>
>> >
>
>Thanks for the explanation!
>
>With the use of ptep_get(), you can add:
>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>Thanks,
>
>Alex

