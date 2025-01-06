Return-Path: <linux-arch+bounces-9610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52578A026C0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D895F188594B
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4D1DE3C8;
	Mon,  6 Jan 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NuN2UeE1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA11DE3B1
	for <linux-arch@vger.kernel.org>; Mon,  6 Jan 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170672; cv=none; b=j9WhneObGB86rHDk8fs9wz3AFVK5C7YevUH93KteXv32TzAcDJ99TyF+Ta+ejvOe53VkcyPjYoJr6HfQ5eXfbmFepw8+C0XdyOdIcVX+0p4/uAjb0Wo65HJG6ECmxoD9PWnWcZy1x/mWd6fxqe7YRWI0nCz0A0en+LilAhh7ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170672; c=relaxed/simple;
	bh=LrtzBOpc20LA4eXs+7jXvZs6h3AKiR2Si9ZU3N7n2dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSDY0Np/sWZ0zYCIwpU/SeVEqeJiFmrnXeVfNeKzSGBTiye5EWgRYUYEvFpZkM2EGT64GVQ1/V1g7VHvFRYZBlVNG47LLaI1wGnpavffyMZyNM1AIQx5FyPQiKICg9I+VuEh3K7hRiMSWlDtIqfbykvyC8js74DlpiS6wYeW5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NuN2UeE1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so23102785ad.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Jan 2025 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736170670; x=1736775470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45XLTheYrSs123jVGiTYWA09gh8PmFWTSz2LniJsnL8=;
        b=NuN2UeE1GdCda6qrwFsmhiL7uWpUjeNKWHV3aAfKBp8gSVqZZ5qyv+AVLM00GgPdK9
         34ZNTRef6uiMLHGdMy6X3j+8PPHLGyCij8sVkhOVqz1kdh6sju+ib3+UTUp2e1WUATZ/
         LPTcHdj/VdjBjm8Uq6LfMc/qkEEZe9NkloicHQagMxRkH1zm8Gjrzvcz2ouCQMQqcZlK
         NsVYHQkQ/pOjvND16yXWpzsfuJbRraihd1O+SvlBKuUkjnP5NfzTtCpBMbwHjFv1omZ2
         4HxJxAZRyeqClmBYfFHu+xRpc5hTaKkBPcD5nP3/A4CnBkXmLZP29mkiy/4GqvEve0gJ
         gxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170670; x=1736775470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45XLTheYrSs123jVGiTYWA09gh8PmFWTSz2LniJsnL8=;
        b=ZoVi8GFaCDAq83Kr8axKjcOhibqm7ZyVamzLZ0j3e60MJco5UMHzWFnyW3+EH6EQTB
         BMBAvuLFOeGTaOvBBVrJ/r3/TG2whZaPYjnKRszo4L5OEARAdMNuqBykzBWl/IkKMtly
         ESTg0HZyP5efGULz1UgELA9hm3nuR61LTJNZhszF8HQjp0UFfBWvb4+h488UCizUplHc
         j/xCk3QoUyar+W9WALfsmYjUH8ZyoL7hIBwLZrept9LCJEmKXQXAhnR42uekUgBx0HIk
         NeO/odbblGXSPKmaZoQWe7rTP5B2C5K2BHwAlYE5mHaYb15xBBW6LHYjpb/hrKw0M/AE
         MUmg==
X-Forwarded-Encrypted: i=1; AJvYcCUIAYHN+8pntmkJuco9IlPwodASkqe8pfTSVLreQsnMu4TCFw47sCYetUokQxklnObgyfSK5pkHyp9/@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2e+xEyE92ZLwB1RutwQ1dakvNnCFjVHXI4/BekkSzKWS1nQl
	4Yf0jjm2+sdoQux2ijAe9SVwiYbf9ZGvI6lHMWiWKfwRm/KbXP9BoWjmfv6uUWk=
X-Gm-Gg: ASbGncsntg2yEdHvK0tuxjneaoP/CQFY1x4vZYkJlwqy3/wmAlNHo7o0mPk3Xr0uOgy
	Ax2gbdS8HvqnKblqmbNpG8izZw6fYgzV8ufFkeQXl9LTHRNod+sMHaSGcLn43uGvNajWv9/qSmW
	zOfsF3FHwBG651VGE7FM+TKHsrJQMN7CiQP0cPeSBKvquOa2eF/2FAVvOhbD61zw2t0mkDAyn7I
	9hYorZ0Lv1PMTNajOFHmeY4FIEpYRQFQs93Gxgx8OGkdmiJUA4K4lJblz6weH3eMytpT3ml12gn
	pT7mOhNZHIFrex1iuaTRLtfgqJ4j/toIW2e3g20EOxWUC8rtYS91
X-Google-Smtp-Source: AGHT+IFnWXSZW4FIIFkfBRxwzvmAw3s/HsdTqMia2pBdvLu70V6jfgNFfu5B3ABCLJ+ulhyhNt7Jxw==
X-Received: by 2002:a17:902:c406:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-219e6ebb716mr865705425ad.26.1736170668665;
        Mon, 06 Jan 2025 05:37:48 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f51a0sm290583325ad.187.2025.01.06.05.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:37:48 -0800 (PST)
Message-ID: <760c9610-a11b-4bc2-852e-340adb27f666@bytedance.com>
Date: Mon, 6 Jan 2025 21:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D
 level page table
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxVkg3i7zXI92e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <a3a2bd64-9952-4c66-8626-f2436ce07d1d@bytedance.com>
 <Z3vb+0MktvDNysQD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vb+0MktvDNysQD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 21:34, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 07:05:16PM +0800, Qi Zheng wrote:
>>> I understand that you want to sort p.._free_tlb() routines, but please
>>
>> Yes, I thought it was a minor change, so I just did it.
>>
>>> do not move the code around or make a separate follow-up patch.
>>
>> Well, if you have a strong opinion about this, I can send an updated
>> patch.
> 
> If you ever send v5, then please update this patch.

OK, will do.

> 
>> Thanks!
> 
> Thank you!

