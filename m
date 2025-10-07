Return-Path: <linux-arch+bounces-13945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3EBC2A86
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B619A1F54
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCD2222B6;
	Tue,  7 Oct 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XjbWIs7y"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298551D90AD;
	Tue,  7 Oct 2025 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869488; cv=none; b=SHRYh3Hmsug4jBNkTL/Mz41ubwJHE0TZ45AZb5ZFiFA4j2MNVicxvC+j2rk9S3zpRKwmIt9uOThqqFdWlAtqFldzZKoB3eDYfxOpM9VYPA36oaCIkdWdw4wAEYpCtGWre4JMiAKNsa/1TPETcRwYwwThsf+LVFCzyfMkUOwV0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869488; c=relaxed/simple;
	bh=4cYMjdMGETzW2Kdd5CvNRjREqsKnjK0Px2bK6XAAJAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgraX+wwdM01fpGV95B89eSr5ji/U1juvdRsTAxO4butePWs5S2rjW13IeVD4PivXP/RjXkYSNO9s6f6d4ZX+jg0YdVFcdWv9PawZruDiW6dQIo95dck4NKolHsq/EUJTVkdZXHoXIXtGDalB4B7MznjxeNc56j9mjeb2v9T4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XjbWIs7y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FC8C2038B49;
	Tue,  7 Oct 2025 13:38:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FC8C2038B49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759869483;
	bh=eBHded0+/fHmMsw247Acr2N9kOnPFP0ghuWlMwLlh9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XjbWIs7yqUEUuk89rwVEKYjtz9w0OI1x9QOtMrCeGlfGKr59FGiRhYLgmjCxx/jJs
	 i4X2hq7kfA5zIB7zlDvJSQ8lJ936wNhLNdg8UZa52fJI3DBEfRK8bdY/CxIBK2LT/b
	 LFXyr2rJEXq2Y/UeKkg+ldfcNLDKCTKYH4eRyBEE=
Message-ID: <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
Date: Tue, 7 Oct 2025 13:38:02 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aOR5juzHnsK2E40z@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
>> +The data is transferred directly between the VM and a vPCI device (a.k.a.
>> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VTL2
>> +and that supports encrypted memory. In such a case, neither the host partition
> 
> Nit: You can also write the cross-reference simply as vpci.rst.
> 

Thanks for helping out! I could not find that way of cross-referencing
in the Sphinx documentation though:
https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-referencing-documents

I tried it out anyway. The suggestion worked out only for the HTML
documentation, and would not work for the PDF one. Options attempted:

1. vpci
2. vpci.rst
3. Documentation/virt/hyperv/vpci
4. Documentation/virt/hyperv/vpci.rst

and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
generated a hyperlink in HTML.

The

| :doc:`vpci`

directive I've used produces a hyperlink both for HTML & PDF and is
mentioned in the Sphinx documentation linked above.

Please let me know if I misunderstood your suggestion and/or tested
it in a wrong way. So far, it appears that it works only for HTML.

> Thanks.
> 

-- 
Thank you,
Roman


