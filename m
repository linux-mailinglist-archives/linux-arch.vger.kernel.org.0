Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A12150CC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGFBP3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jul 2020 21:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGFBP2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 21:15:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB9C061794;
        Sun,  5 Jul 2020 18:15:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so16268769pfi.13;
        Sun, 05 Jul 2020 18:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=kKz4Uc8g6oN59bjHPGbiXHOBXR+HQpK1+CYrAwQF6u8=;
        b=GIS2xLAWfhMaHveWqzZJDX6s+nlPSKSGES/PgtapW79bxCXnHLgwpi3IRej0D/5vea
         vcMjrsmYG2ido/dabasTOULFOK/llqAitqk9qCPIkktoAEosRf+H5oTnlVJ2HNT/zXm5
         zKILOGDgvrzAgw6KZvRC8+Qb1o0kLcUyL03Sgw5A3ko7mKZvOe5Q9p6ZFKOUndmSvEV1
         6SJzXM0CmToBu7vnOj+tYiSX8dy2bQPwil8jyvU5gUV3kR0ou38nGG7XOv8L92UibqIX
         QnDf03bF08Z2Hr0Zm1gKNGxQba7TKOYg2dRNLE8fsqm8V2+TpuHWKULuDXFvtToLtQ55
         Xi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=kKz4Uc8g6oN59bjHPGbiXHOBXR+HQpK1+CYrAwQF6u8=;
        b=tovt66Hnr+NbAtKGgog/oXiMUY8HSJ7FmOUfGrz6qHOP7BnoBlW59j2ePlBl6vDZr/
         vhKBi8aQsk3fG9MtuSdteXDjzh1JjZO+MP7rSTSLOWgMyqoY2l/3Lry4AjOr9yWFIFov
         PUuCAL7g8oGbGeKPFzjUg7r1RP0LYiMAEIy3HeKHUHOoha0UFAofjxxbJMfr6X86oHGy
         OOhrxNWfRiSWMGQRiTYVWqERqzLvCTgGqGrzUoficOczrteSxBkRwf3CUy50IMmKtOFz
         8rNkdcU/GZgcHwBBJzVaB7tW7RP9hGuhcuW5wYkL+Xu5Vh0j2T37LyvRdIEzJK6PTU7C
         e8OA==
X-Gm-Message-State: AOAM5307PXEGNBqrllBQLoTntS5HeEfQ+ZVQcsIbgfvJvXiX4pUUKGWG
        ZM7PeOvszUKqgVXBQ/O+oeQ=
X-Google-Smtp-Source: ABdhPJx0bijqELQmwViOLeclUZEr6ZTl8k5qss/sx+9ojiJYxl/I3BLU3z+/ZuiTlj/nDQzOs87zvw==
X-Received: by 2002:a62:ae0d:: with SMTP id q13mr34199195pff.89.1593998128402;
        Sun, 05 Jul 2020 18:15:28 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id e12sm17074775pfd.69.2020.07.05.18.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 18:15:27 -0700 (PDT)
Date:   Mon, 06 Jul 2020 11:15:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/5] powerpc/mm: Remove custom stack expansion
 checking
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     hughd@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
        <20200703141327.1732550-4-mpe@ellerman.id.au>
        <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
In-Reply-To: <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1593997323.8pwn48yz8u.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of July 6, 2020 3:49 am:
>=20
>=20
> Le 03/07/2020 =C3=A0 16:13, Michael Ellerman a =C3=A9crit=C2=A0:
>> We have powerpc specific logic in our page fault handling to decide if
>> an access to an unmapped address below the stack pointer should expand
>> the stack VMA.
>>=20
>> The logic aims to prevent userspace from doing bad accesses below the
>> stack pointer. However as long as the stack is < 1MB in size, we allow
>> all accesses without further checks. Adding some debug I see that I
>> can do a full kernel build and LTP run, and not a single process has
>> used more than 1MB of stack. So for the majority of processes the
>> logic never even fires.
>>=20
>> We also recently found a nasty bug in this code which could cause
>> userspace programs to be killed during signal delivery. It went
>> unnoticed presumably because most processes use < 1MB of stack.
>>=20
>> The generic mm code has also grown support for stack guard pages since
>> this code was originally written, so the most heinous case of the
>> stack expanding into other mappings is now handled for us.
>>=20
>> Finally although some other arches have special logic in this path,
>> from what I can tell none of x86, arm64, arm and s390 impose any extra
>> checks other than those in expand_stack().
>>=20
>> So drop our complicated logic and like other architectures just let
>> the stack expand as long as its within the rlimit.
>=20
> I agree that's probably not worth a so complicated logic that is nowhere=20
> documented.

Agreed.

>> @@ -569,30 +488,15 @@ static int __do_page_fault(struct pt_regs *regs, u=
nsigned long address,
>>   	vma =3D find_vma(mm, address);
>>   	if (unlikely(!vma))
>>   		return bad_area(regs, address);
>> -	if (likely(vma->vm_start <=3D address))
>> -		goto good_area;
>> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>> -		return bad_area(regs, address);
>>  =20
>> -	/* The stack is being expanded, check if it's valid */
>> -	if (unlikely(bad_stack_expansion(regs, address, vma, flags,
>> -					 &must_retry))) {
>> -		if (!must_retry)
>> +	if (unlikely(vma->vm_start > address)) {
>> +		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>=20
> We are already in an unlikely() branch, I don't think it is worth having=20
> a second level of unlikely(), better let gcc decide what's most efficient=
.

I'm not sure being nested matters. It does in terms of how the code is=20
generated and how much it might acutally matter, but if we say we=20
optimise the expand stack case rather than the segfault case, then=20
unlikely is fine here. I find it can be a readability aid as well.

Thanks,
Nick
