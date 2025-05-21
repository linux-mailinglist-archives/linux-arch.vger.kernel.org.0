Return-Path: <linux-arch+bounces-12066-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B9ABFCFD
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3093BD4B2
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3517A2EF;
	Wed, 21 May 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3cygqJW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7428F511;
	Wed, 21 May 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853109; cv=none; b=AC49gZD6Ac3gHFq7VVQ8Qt8BR7d6UDoNreKfQdqOShFB4FJEG8U+cZqO/rovNVSOkMdzpGw32+PHJKWdBOuSctABLCcgndUvSYQmt4pyZpD/f8y830k2XGOpgari1ovNKKmhwbsGSIP7FdSskaZJcoh+08BJzv8oZJCuGiUQrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853109; c=relaxed/simple;
	bh=jBLoeuewKrege5Wtka5Hd1ay2J4eD2x0XIFMdXt+N5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aab6VE8iwIVC43P359e2hNJKbb9IJCM6sAS4dIjC3Fe3qRCpAX6WjDbZkHXPXCa9UVyA+JIplgeGF/Co58B9B2Xn060RP3N1Ni4d6LB6+WT3haaiSOgFKy7q+x5ZGGXcpezCniMEHldWiMN06H4WfqRF/KHxINtpmTLgg27kY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3cygqJW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad53a96baf9so845240866b.3;
        Wed, 21 May 2025 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747853104; x=1748457904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2lUyA33NhEkDq8F9MLJ5zGOQr8lFEQZWi132GjmsnQ=;
        b=W3cygqJWKiNvxsMAc0co8foe4GMH5lI/Xh5LetWjd7GBWME5UPj41B4ccHLSzcnqHh
         e1Qvm6quYkxsSaFMwvANIHXIhB+7Kw8BZq50yjMQij12zMz7vTdfR+WEHWQYUSb3e7Yh
         xJ24lRy4FBECqrPJfRmiPrixMNARI7Dldua+/Zyt5yuHjcbm3GID9xOOw9CwCWOkiShe
         IZfNVjbIeGM02fZJpQo719A0i1A82VD0oDpr2QXFelZmBn8rbvb2a4kTOsffCKU55VK2
         +FBqzHna/MsevUFhl4Db8ym0JlcB9ZlcoH/ywZy2Jx5FvB/5cLwwX8nQ5YMvt6o0fDIh
         Mtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853104; x=1748457904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2lUyA33NhEkDq8F9MLJ5zGOQr8lFEQZWi132GjmsnQ=;
        b=fDvUH8RdHJw5p+Op1FgwWqdeN0cs+pCNVJnLh1GVDv/Xr5SXPCq5e5BT69NqpkUbNS
         gQfW9kDOG4TYZAzrAoGrBxOZQGkrbVMhDTnQAo7qXQfPSdvwgxpctS2XF2E2i1lQ2tLV
         n2Zr3Tk7fq0jWlW7rZCRF7wG9gB6gjvu4nHsxKBW4NLWunRuiXIbWN1w/RiS9vsyk5JT
         RBMwVzF8c05D+VISL7c+rjN7wOxdGWbieoWdtjPVPs3WZbmmzlB2ZZCfTMAfB/8q44Bq
         Omm5NRqbS5fXIDIPibzbrXy3pI0reGxcVGqIezioQDyxzx1WkXnMWaStxdWV1W0x+O38
         DwAg==
X-Forwarded-Encrypted: i=1; AJvYcCUcJDChbhxedtbFA6tahphpCEnjfKcPzeUlNCjlBupvB1LbyVgdzIP7kZVNYTCUu1pyeSBPiNOnGCzGtqmt@vger.kernel.org, AJvYcCXTAvJJVplj4MGhOH4CrJ4IFFd5szwvm7FR2qCMY5pE697wdroue/SsnPf004FMXqNz4H/J/m5rFmEm@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb2XOyKFnWlyunodaSAmeJES7M7B7qoDVXXv2ZJV0+ZsXohFx
	eRW2+hq3s9w2d0E6Gs+GzGrePWjSNrOM0cHN1lW5sVMDxoB5gK1Y2KOm
X-Gm-Gg: ASbGnctLdyLSX5PUOGMJ+9iV2nY02u/A4bRS0GTjHtscZO96+GINKqYYYAoNMBIqJpi
	dU0O+KVyHLDvh1vw7pzvEfuO8kRrcyoOeDr4+6iiG9Msv4Yfkf8YKHEyKksvhFOAgSZqYyEn0/f
	NC6pZ4trvZ5hqqLGn+djxsw0y+21BlB6NuugKqTmyjs1IX7LeD/jkJ9s+swlHsAUORnRrBRr5KM
	NUKNAaj5DWrcLoi8LjDrnZ+4g6uLSZAt4qoVsho3n/MXr8PkW0FZlf2NNqY328LGOxqvMs9KPAM
	iB5CkGqViyg4VcnxpFrsQY3lI/IL4dg/ciN2aBTPa5/MfjfJhra+xYuvzyZzaEa91ncnf5cWbCr
	ZDyXwAAPB4nDlwT4C/9ODU9bhISQ=
X-Google-Smtp-Source: AGHT+IFh/3BL64icpWdGBo9UdEEehAhQzADDMRBLK+4dhIoXxMOv/ZTRgq/fhO+UtaOMiprk3tI39w==
X-Received: by 2002:a17:907:788:b0:acb:5583:6fe4 with SMTP id a640c23a62f3a-ad52d42c0e1mr1750819566b.6.1747853103323;
        Wed, 21 May 2025 11:45:03 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:8d0:f08c:4e6a:b32f? ([2620:10d:c092:600::8a7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04e665sm935977566b.5.2025.05.21.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 11:45:02 -0700 (PDT)
Message-ID: <a1b24903-fad0-4337-875b-72f97908908a@gmail.com>
Date: Wed, 21 May 2025 19:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 SeongJae Park <sj@kernel.org>
References: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
 <1a7be28f-c805-4092-a7dc-d71759920714@lucifer.local>
 <9ca3f5eb-e76f-4135-91d8-363851f5c3ea@gmail.com>
 <733527d5-c10d-4f3c-b022-78cc3c21c4d6@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <733527d5-c10d-4f3c-b022-78cc3c21c4d6@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/05/2025 19:40, Lorenzo Stoakes wrote:
> I feel this will get circular. So let's not get lost in the weeds here.
> 
> Let's see what others think, and if not too much push-back I'll put out
> another RFC for the mcontrol() concept and we can compare to your RFC and
> use that to reach consensus if that works for you?
> 
> Thanks, Lorenzo

Sure sounds good, Thanks.

