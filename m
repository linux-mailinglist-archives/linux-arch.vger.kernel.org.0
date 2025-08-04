Return-Path: <linux-arch+bounces-13032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58818B1A134
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3F17F4B7
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132B25A2CC;
	Mon,  4 Aug 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFg0Oh2Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9225A2C9
	for <linux-arch@vger.kernel.org>; Mon,  4 Aug 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309903; cv=none; b=ICj81QMXRYnPgX1sbCB/m7TtzVN4rnMr6z/ztiTbBnXt55GzEx961yR+9vkvlcXPgSh7NRH5f5xYT9zjgxcyYJceEHbcYlQiS7lj2LUqqq2/BtI9dUTCDoFzK1pS+5Ywz/kBPfHO5yg57qcMrlFygV6Nq8hMG2JTVNS/7WLORjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309903; c=relaxed/simple;
	bh=tev8ZZD2uIs9rabhdyEBYn7rJGYpPc57fVH69YPMGv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyW956z4Ot8NkSGaNRYyhS8ZTMr2N8on3OqWxvcQIu1UXLNZjJnoFcRxWW/hG7l1DFqv2JucX61zcA8QXDZ8A8R+akLXFeK45xMeE1squJlRZSXuoG+t1WloIedT0NZkTt5l6csMa5kAN7ZgQxfSH+OIq+3KyEBcEBadKj9JQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFg0Oh2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754309901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aP1j/ubQX+lP/A8PXryWthbp18R/7thL54KlRxdc41c=;
	b=CFg0Oh2YUEyNM24/deSss07Em3DSa834zSvwg9xV7vTiNwwXa6++PdUZy6fbgIZwGMCi7i
	u6eiHHV2p14okwi4DGSIsCd+K821PZV5foJmM1kfOm2AyLdfcaUwT+jP0kPhcUlrQMqSS6
	9u7N8g5lHB3GJ5gOkhY3BYE1uFVIsIU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-B2y0LafeM8WVmvmK04nv9w-1; Mon, 04 Aug 2025 08:18:20 -0400
X-MC-Unique: B2y0LafeM8WVmvmK04nv9w-1
X-Mimecast-MFC-AGG-ID: B2y0LafeM8WVmvmK04nv9w_1754309899
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so1812165f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 04 Aug 2025 05:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754309899; x=1754914699;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aP1j/ubQX+lP/A8PXryWthbp18R/7thL54KlRxdc41c=;
        b=aVePDLMlm6+AxinwH1X7ZWKQJvbS+bQzeNwpU1M82AsIAto8IV1RHGhHyQM9pDV+Ul
         3un9gb5aFSbrOhQfuuzIdoC74m2Y/PaM+nBh51v7LHJeCZZ6+qWjnKAkErQdKm1rhbUo
         wGX9X+QCWKIZh3WN7H7AedChV8RKmsA409DqT2qrT39pOla+amsMXOvKThnKr9Z1F7oY
         FAmA/4U7JMZjqixQ4xo2h2u3QWy9E5M6Wuio3n4PR4I5yxMviqjinjSSToGUbXONCFLD
         WjfP0rGp/1MYeGCW6K9oau1qMDSx2VzLUCw0iAakr0ckfp3hFz89gGW4YscIu4/SybXL
         cNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXix9PWPvEkNMBsEvh+X+TUjUFM64payfgVRTvecSnLvZ44oZNAm+q3YWQ5xjmyufHinlXYZFUglxXr@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDGqWRHhnpNS2fTWDTtJAqduG1Tj4785yRdEAEH/VDxydExMp
	Ds/7V1YZL9QId76wZ6/CqCQIctuBC3FgFqtKq8EFtl2h0GRD/iQopBoHCIxsvMbY/8GNQHKjknx
	LAebBib3g9M6Ag7UbVOtvAgKCh2B4CAlkFGN6h8tPNQOowSqciC7epOTFPIm9hyA=
X-Gm-Gg: ASbGncvWgNB6XTo2LoAiLHaWE5vzv/ILtvFzc3UwO1KWh0x10NrtDZacneTgUNaK3YH
	XFg6MKF0LDXC04XSoEybSkVSbLf59uuaeNXa5B3t/nSvKRxPqKjoIH+MdBAhCG5frlxdHXn8gKz
	fbAXZxNuC0b3x0OKWJskeE4l56hEHf1i0N11l2iFiyWxnRHiTqp9xjeBLmZzzGEafz900E1gEFo
	e/ELtmZQTY+nQN6LuV1RWHNIgL5AfoTz4chhXApREK9Z4q4CRksFRmmVRjs186oUJm5OdUmTtPw
	SE9vqua8cKAd3gaKn/UupvalvcLMyCNRfL3Mibu2DbKHbRwg85fZMDEcHS1Zbx4kiv9jtY/11Hy
	eszHYgIpFB4tsWPZtlgdLeDQAKt3T+dxVbjR0X9SU+5BoY9GYX0uLx9n6Db/D/OvoFLc=
X-Received: by 2002:a05:600c:1c16:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-459d9a2eccfmr32262155e9.5.1754309898622;
        Mon, 04 Aug 2025 05:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+2bCGV2C6/ebzafcm9l4NbmkmomX5W4derdkR7sRtPpZ9SM3xwRcTp42bRjUUnf42oqlN8w==
X-Received: by 2002:a05:600c:1c16:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-459d9a2eccfmr32261825e9.5.1754309898198;
        Mon, 04 Aug 2025 05:18:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc2647f6sm15009255e9.2.2025.08.04.05.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:18:17 -0700 (PDT)
Message-ID: <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
Date: Mon, 4 Aug 2025 14:18:16 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 13:06, Eugen Hristev wrote:
> 
> 
> On 8/4/25 13:54, Michal Hocko wrote:
>> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>>> On 30.07.25 15:57, Eugen Hristev wrote:
>> [...]
>>>> Yes, registering after is also an option. Initially this is how I
>>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>>> here:
>>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>>> Do you think we can continue that discussion , or maybe start it here ?
>>>
>>> Yeah, I don't like that, but I can see how we ended up here.
>>>
>>> I also don't quite like the idea that we must encode here what to include in
>>> a dump and what not ...
>>>
>>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>>> where we e.g., have
>>>
>>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>>
>>> Could we similar have some place where we construct what to dump similarly,
>>> just not using the current values, but the memory ranges?
>>
>> All those symbols are part of kallsyms, right? Can we just use kallsyms
>> infrastructure and a list of symbols to get what we need from there?
>>
>> In other words the list of symbols to be completely external to the code
>> that is defining them?
> 
> Some static symbols are indeed part of kallsyms. But some symbols are
> not exported, for example patch 20/29, where printk related symbols are
> not to be exported. Another example is with static variables, like in
> patch 17/29 , not exported as symbols, but required for the dump.
> Dynamic memory regions are not have to also be considered, have a look
> for example at patch 23/29 , where dynamically allocated memory needs to
> be registered.
> 
> Do you think that I should move all kallsyms related symbols annotation
> into a separate place and keep it for the static/dynamic regions in place ?

If you want to use a symbol from kmemdump, then make that symbol 
available to kmemdump.

IOW, if we were to rip out kmemdump tomorrow, we wouldn't have to touch 
any non-kmemdump-specific files.

-- 
Cheers,

David / dhildenb


