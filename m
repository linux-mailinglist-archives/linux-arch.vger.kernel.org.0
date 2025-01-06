Return-Path: <linux-arch+bounces-9612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22528A0285F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B4F1659DC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90D1DD87C;
	Mon,  6 Jan 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AOENsm2R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6021DE8BD
	for <linux-arch@vger.kernel.org>; Mon,  6 Jan 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174678; cv=none; b=VpcpTwMCL9Odv3MFL8HsZmqH6VOrmCv1EE0VpUCy2JtPnybDMLLFCDmxqdgTkRmDbBnKWvh0MEklU1IV8A7MnSRaOPv0Wvo0juzzyaSklk2TA7JLPa2Yb6I9XAaXeFw21FL7exLiWIIuWOn0ycjMHcYvYvVOZrNwSPiLW7rcd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174678; c=relaxed/simple;
	bh=FT+GsbrHFNytgmVw9pS4MWUyG9GELMc2aWIALV4R5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPrJBrkWUxU2logb4rZ2Itm5u2sWr9/x6wCJxquGFxqOgAEHRxA2ghmw0lmfw5nYTsKlQ/ZHYtzVMN4Cyu8pXBuhLUWeccRSr8wkiigctJ+EEtSWb2sEgFIa1jgedc1SZqaI1X4d3oOZy6N7qN+f9MIi75+w58WMJqAavSL9G34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AOENsm2R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216634dd574so137625715ad.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Jan 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736174674; x=1736779474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=AOENsm2RWVESkj+tEE8NednRuNGe+HrlfMpqdMmB96TFPb1M05S6p2+RrKZ6kOJ2r6
         2m1ghhviUlJEv7uX2tL/vtDm1POjsFwB5CCUwKifHrGiN6wAdyKGQ9X2oL3piluKNYb0
         I3X+PpobzTtVz7/hTPrBW0pImZItQ99bJssa2FVL4Lrrjx7q1lNsJd7rELXfXFDMcswv
         aXqs85gh+NKJfwv3V9Dy+ZrYnXCasR3YIZbwRcM0jNsQdZ/dg9IB1W+XfduD1DKb5HNn
         zxq03RDCixKBfv9y4elRxUNAap32HNjC1W6uJzlwSMZFFa8MSUhCPMDJQ1aCRNa6iLgr
         188g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174674; x=1736779474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=B13MuUucFVG2Gw+SarlliqkrvJAThBzQ68DRHg1bPpoDHt5NoVsXRD/4My6PQ4KETR
         iw/4qkCt5dZG3cNhavv+SIhCF46SC1O73nx+bdvNaV1QDFbXycuZaLx/PSEjo8CJSSKO
         2akT7ld07eRcBPUTwEt/bP6jvq2bhsgQowTsEUJSdhSeNt0erdqgSuu0ARlPO6+n3GOa
         COkkSb3KKkUnIG1OJCkDsHJqz1ki9SRYivNJ0XUoe0IraQt5h6WKiZTjHtzhG5ZVY588
         dgDHk/n0IHKTku1Xmfve03DlJ8J3FFy3oRCkYjfqha0H/uw1fmnAuoZDhzfm+P3IVXud
         YJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJRKjIdIsDeim0PybpYApZ3ZI9/6GoxqUNaSxVyTeUUivQw6gUVVQgOACBMmSRZlKSO0H9YreAGSGz@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaa2OQPC9rtL2s8kNlBQp5HNWQgex8D01UCCvsiHQXcjdk4cT
	jQ6V6OL2nesA9IRoRCoyop96Nb2uyyWnwmqXObtGNbZnRm77PRvKeNmKXktdz8U=
X-Gm-Gg: ASbGncspySXaOkWYBmceleO1Wh1x6wjCHL7YUEN6tQ3BKdDC+U4xRf3nJ23iIEqMnyP
	YDd/63XAOkE3ciLxUscHcLUBVkxLYZLnx5xrV4vQCuBEOOaqrqlkmAXBHwUNXvORzeR8EzO3/uw
	1+BWLHZhgBnyOdUclv4b7/l7X+alLwfDtLSJtnvaAk14MT/dJu0D0Zsd6e6EU4wg4Qc4BskDUsQ
	TwX/KQiNLg6ZdxPiNGGka3o3td1331TUZYTr7RnZnX+U3uDaxrL8aTFaPGUoA+Wf7fi3y6iWG1x
	pDSooFr8ql4Y4GT90uyUAc3IE21x0BZ5J3ycVrZAZrv7eUMQOxyj
X-Google-Smtp-Source: AGHT+IHfRKlSBRBXUw7mHIW0SQFNESOEWbBrtQcBXd7/ffhetsdlBCZHRjeTrMJdIBfoDiMG7l+wRg==
X-Received: by 2002:a05:6a00:ac3:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-72abddcadd6mr82367083b3a.13.1736174674262;
        Mon, 06 Jan 2025 06:44:34 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815804sm31532588b3a.32.2025.01.06.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:44:33 -0800 (PST)
Message-ID: <dbcbf4c3-f86a-4414-be52-8ac02dae5b6b@bytedance.com>
Date: Mon, 6 Jan 2025 22:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
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
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
 <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 22:35, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 09:34:55PM +0800, Qi Zheng wrote:
>> OK, will change the subject and description to:
>>
>> s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()
>>
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to pagetable_dtor_free().
>>
>> But pagetable_dtor_free() is newly introduced in this patch, should it
>> be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
>> strange. :(
> 
> s390: pgtable: consolidate PxD and PTE TLB free paths
> 
> Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
> freed - same as it is done for PTE tables. That allows consolidating
> TLB free paths for all table types.
> 
> Makes sense?

Ah, make sense. Many thanks to you!

Will do it in v5.

> 
>> Thanks!
> 
> Thank you!

