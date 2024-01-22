Return-Path: <linux-arch+bounces-1423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA403836E49
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7531C27D28
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36B4D59A;
	Mon, 22 Jan 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE5JOk3Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDB3EA8B;
	Mon, 22 Jan 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943752; cv=none; b=WREn1H3no/y4RrVjjJdHPsQ4mo5PsfeRhJbVlU86+uLPBD+ypWXemH6rNLdsr1SIDEWH79VJTwdR5Wm2wckxz7V66cdrE1JZfhbyaA7pkhe6rnNrvfhEhSkl/oTVUBmVuXoxFWvj6tC0D2G5hfTCCyFz7HMbRdSpjMLKM3oLi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943752; c=relaxed/simple;
	bh=/5lMkv6sITbYfQIZovWSUEAR+CxLVZmytxQvnKPdvU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GppQ5bNusivNo6BcPJhAbGePVcqHkvZIF6jJGZ8rBLB5xswhQQNB6Nu2HLK9W9W2P01eMZuvwOmgRHTStfNcxhsdycxfYryJjSG7MyVAv33ZIBnN+SBfwQgDvADiMDHSF08cfxZlfrvSQfefOUbTF4xhgJHP4jPeXa+tlgwLUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE5JOk3Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d720c7fc04so16196095ad.2;
        Mon, 22 Jan 2024 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705943750; x=1706548550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7wauAHZjPbJhqs+zpIZbtti9g0b0LXU1JBTcWTNXgSc=;
        b=SE5JOk3QrMCLBMjcl49axGL8AhkMxSbU9IKP3L4GDvOaUMCNnTDOPxjoUU24jqUqFi
         2mtt7iVL2RApnlWhM7C/+UklI4nW28zUhvAFjhMonYRJO0IHQMXm+/FoHpK60WozsRSk
         AQPA6pf1Rmq5YK/Tg51JZeCQ18fDIC3KARASGRYPBxzt5pn/9WWMXUR0B6RM1NXdpNJi
         tj5WWXAo5jQTVVN/Ba6MJ3aKH7LM1M7v/jq0ZoNLO932Pd5NcTpbAQRiaaUQhsOjKz+V
         Qd3p9UE8wCHrGRTd5ubMxB8tNrSQ2i9Brxp3AXtu0UzwChqRbYQynPwmmWUJM9dmKva7
         PuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943750; x=1706548550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wauAHZjPbJhqs+zpIZbtti9g0b0LXU1JBTcWTNXgSc=;
        b=GjFT/C013uAVD3fHEsjgYT9i9aFBd9Ou/MqJoUDwCDxp1dxPCd5boa6pBHU+3FVkE8
         Fbh99OF8V6GkCx8bCqwteh8S09YkDBc6MLYUHWhXcEZhyfrhOGkqDSmFxdQx5EGdIdPJ
         HfZivkho9ZHI7Kw8vtA9qn3WSKAQ83d3/3S5Lo3uYzy2Jc7Nrh7a5ptO/thILr1H4u6s
         652WBehcczAGexk3hkJGc3WAoh9j6o3YlvXS0K2Tuuk6IaFM7pO1e2tQSeWAokuBO6qo
         iem7qBN7rMvAELpCciS1TDMwbeDvi2Lqo4wqaD5vwan+CyuFJlsjAyXlQvwWehZpr5uI
         t5mQ==
X-Gm-Message-State: AOJu0Yx9AMBZOL16/czCDO4ZtSmfaJPlNWlQk6OGnOppc5Ha+CEBSvTq
	ZcF3Co/Px+2C9HVW7udwgt2Wu5etO0G5rCJmT21B+bvH8yG9mGoy
X-Google-Smtp-Source: AGHT+IGb9qZ9ThUvwf2SP/ET+iq/Tlz8BjhmlsDoV9xbRbTAfLK/KjrzuGGHfxZkf26S+frZL2w+OA==
X-Received: by 2002:a17:903:2441:b0:1d7:3ffc:c2bc with SMTP id l1-20020a170903244100b001d73ffcc2bcmr1661498pls.13.1705943749857;
        Mon, 22 Jan 2024 09:15:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001d403f114d2sm7486862plk.303.2024.01.22.09.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:15:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1dd253a5-9fe9-4d0a-b0cd-3775f089ca0c@roeck-us.net>
Date: Mon, 22 Jan 2024 09:15:46 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Xiao Wang
 <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>,
 Guo Ren <guoren@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
 <20240108-optimize_checksum-v15-5-1c50de5f2167@rivosinc.com>
 <2c8e98b6-336e-4bc7-81ba-5a4d35ac868a@roeck-us.net>
 <6b0dc20f392c488a9080651a2a2cd4bd@AcuMS.aculab.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6b0dc20f392c488a9080651a2a2cd4bd@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 08:52, David Laight wrote:
> From: Guenter Roeck
>> Sent: 22 January 2024 16:40
>>
>> Hi,
>>
>> On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
>>> Supplement existing checksum tests with tests for csum_ipv6_magic and
>>> ip_fast_csum.
>>>
>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>> ---
>>
>> With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad hiccup.
>>
>> [    1.839556] Unhandled exception: IPSR = 00000006 LR = fffffff1
>> [    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc1 #1
>> [    1.839948] Hardware name: Generic DT based system
>> [    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
>> [    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
>> [    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
>> [    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
>> [    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
>> [    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
>> [    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
>> [    1.840942] xPSR: 0100020b
>>
>> This translates to:
>>
>> PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
>> LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60
>> ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)
>>
>> Obviously I can not say if this is a problem with qemu or a problem with
>> the Linux kernel. Given that, and the presumably low interest in
>> running mps2-an385 with Linux, I'll simply disable that test. Just take
>> it as a heads up that there _may_ be a problem with this on arm
>> nommu systems.
> 
> Can you drop in a disassembly of __csum_ipv6_magic ?
> Actually I think it is:

It is, as per the PC pointer above. I don't know anything about arm assembler,
much less about its behavior with THUMB code.

> ENTRY(__csum_ipv6_magic)
> 		str	lr, [sp, #-4]!
> 		adds	ip, r2, r3
> 		ldmia	r1, {r1 - r3, lr}
> 
> So the fault is (probably) a misaligned ldmia ?
> Are they ever supported?
> 

Good question. My primary guess is that this never worked. As I said,
this was just intended to be informational, (probably) no reason to bother.

Of course one might ask if it makes sense to even keep the arm nommu code
in the kernel, but that is of course a different question. I do wonder though
if anyone but me is running it.

Thanks,
Guenter

> 	David
> 
> 		adcs	ip, ip, r1
> 		adcs	ip, ip, r2
> 		adcs	ip, ip, r3
> 		adcs	ip, ip, lr
> 		ldmia	r0, {r0 - r3}
> 		adcs	r0, ip, r0
> 		adcs	r0, r0, r1
> 		adcs	r0, r0, r2
> 		ldr	r2, [sp, #4]
> 		adcs	r0, r0, r3
> 		adcs	r0, r0, r2
> 		adcs	r0, r0, #0
> 		ldmfd	sp!, {pc}
> ENDPROC(__csum_ipv6_magic)
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


