Return-Path: <linux-arch+bounces-13961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDABC6C31
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 00:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3CA407673
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871A2C11DB;
	Wed,  8 Oct 2025 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WC5dSuY9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07102BFC60;
	Wed,  8 Oct 2025 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961498; cv=none; b=LR/NsMDyMkOB77eP1eeQvpKYRz3OPjqweo+fhNw/eBDJfYOeRVoVLykPKilgDBRCZ2Yu+qlqtpe3qkGCWtWKrGc1Luyraiw5oBqyufSQLnB1uX3YLNfwGdYOuePKSzKQFj1RvtBZlH/Ta0bZPKhxWc++QMNNkjHvnO6I/q5CiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961498; c=relaxed/simple;
	bh=jTKYLaLRtyigCnNTJTWGsvVpJnOlKn1CfHqjgkO2gK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPl7t8kfUeSEHADeEkg7YkWJylssYOEN9dazM09hWd3tWdJZ8WY/Wna/j4nb+169Mm6sjwpdViF56jMZfkGNV1KnLiLG0ohzgP15ANQISACTtUR1rEJ6kJNMknfzF0I8hi912JFQ4xk/W0RYseMe6Dxod8bT6Dzac9Vgd3V2YXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WC5dSuY9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87FBB2038B7F;
	Wed,  8 Oct 2025 15:11:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87FBB2038B7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759961495;
	bh=8yv/8GfirvSjXwI2/6nuSNN5vInQoAjX4iRrfll9r0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WC5dSuY9PG1dAIRi8RKudAGKUfffoDylwTyDS4RBrN4kRpOAoN9so8xGz3nyimYuj
	 YAPx1vAfBXjhlGQLRe9Kmo7OZqJOh3kB/n3D7Ty/32ggs8B3aPWJqHs7nYmI/tll83
	 6iLKDgX1pgvtkdW/NKpVjkqZ6bZUXYj1wGPtWIrM=
Message-ID: <f1cd86d1-3a59-4bfa-ae97-3ab092a1f3d3@linux.microsoft.com>
Date: Wed, 8 Oct 2025 15:11:35 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 kys@microsoft.com, mikelley@microsoft.com, mingo@redhat.com,
 tglx@linutronix.de, Tianyu.Lan@microsoft.com, wei.liu@kernel.org,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
 <aOWouGarxf0FB7ZR@archie.me>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aOWouGarxf0FB7ZR@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/2025 4:56 PM, Bagas Sanjaya wrote:
> On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
>>
>>
>> On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
>>> On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
>>>> +The data is transferred directly between the VM and a vPCI device (a.k.a.
>>>> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VTL2
>>>> +and that supports encrypted memory. In such a case, neither the host partition
>>>
>>> Nit: You can also write the cross-reference simply as vpci.rst.
>>>
>>
>> Thanks for helping out! I could not find that way of cross-referencing
>> in the Sphinx documentation though:
>> https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-referencing-documents
> 
> That's kernel-specific extension (see Documentation/doc-guide/sphinx.rst).
> 

Thanks, got it! So far, in my experience, that doesn't work for PDFs.

>>
>> I tried it out anyway. The suggestion worked out only for the HTML
>> documentation, and would not work for the PDF one. Options attempted:
>>
>> 1. vpci
>> 2. vpci.rst
>> 3. Documentation/virt/hyperv/vpci
>> 4. Documentation/virt/hyperv/vpci.rst
>>
>> and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
>> generated a hyperlink in HTML.
> 
> That's it.
> 
> Thanks.
> 

I found in the document you referred to ("1.3.4 Cross-referencing") that

"Cross-referencing from one documentation page to another can be done
simply by writing the path to the document file, no special syntax
required."

 From the document, that relies on some additional processing within the
kernel tree (above you mentioned that, too), and that doesn't seem to
work for PDFs. I'll stick to the :doc: syntax then used in the patch.
I'll investigate separately why the additional processing that allows to
simplify syntax works for HTMLs only.

Appreciate your help very much!

-- 
Thank you,
Roman


