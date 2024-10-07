Return-Path: <linux-arch+bounces-7747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDC99275D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2B1C20BC0
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF118C021;
	Mon,  7 Oct 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXT/EznR"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149518C003
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290662; cv=none; b=cZGfJN1gMhPzFwvsILnF2ls2RW9Acl7cMIcTtyUxSPvFshi+uU5qTs/omtkEA7SFZQFYTCn4V0gGZiuuUD85JZTB1TJ+oh7bimtvycToE2g55+Wx5PH9EtB91wUBZScIclNZlubZ1xFOEPhblYlqIl/tn7DModz/JdTXNpyNJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290662; c=relaxed/simple;
	bh=tAClxRaBJPv5eyWcIfMg9YB2BkxVVz3tgyeIh/4fQlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8Y7eLECbkseP7YApE/n0BbP7stWt96BeFHN/Lfy80OMUQ1lCTWKeYYefts9irCxw8ZdNcGnHP26SL80xsP2Z+OQF9bD8guZgclEadM5JhnXTE+A4BvJL6MX0tstJF0cEAXs6uLFfeM91kJEIi8lYwrjwnABGUksqBw6JoZENQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXT/EznR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728290659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ISoSaol0yhnJNCBfnz14JQTrUy040gnzhzeH5X60flo=;
	b=dXT/EznRpHPRmMZVgStD/+l3/QknEB+gjyYQvm28kwhoAfeRbu83eC20Rwl45RISJ+3wQK
	HwgeLxm8N2e1+Oouwmn+vBwimNe+jfQcpW/li4VKsT5ydtsYRUIPmKvqdTUtOzD9UBXRZL
	8qJ6v01DvbXgpxP6OcKlCY1p/oeB3N8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-TWcMRAJQPpKefwIq8UBdgw-1; Mon, 07 Oct 2024 04:44:17 -0400
X-MC-Unique: TWcMRAJQPpKefwIq8UBdgw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cd282fb39so2670476f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290656; x=1728895456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISoSaol0yhnJNCBfnz14JQTrUy040gnzhzeH5X60flo=;
        b=psNsd6RX5AT+9mtBuoOySKozTSE87kJAkpAHE72Br5t/morIBUxBgcIYc+7FBMiTDx
         LFWIJisL/5xPPT+KmlGXotvtvvVBiRTOJ98aX2vqdNx5qP506yeQNF7t/+axenJ2W13A
         xJqNaSUOSasqxICM/SZyRhSPH+OMaauFp1jlKZCjBuPBl9snb2UQ7nlMGOHTV6DVNKRd
         nq6VIW57/lfQt0Ma4jkXYz5HP9Jp28HVPi47psBquBu7mA5NbP0NAu2RRCt4Nv9rgN61
         LB3P+/iK8b8EZHC/0Eprkr+Cg5AQnW4yA7q2c0AIDjkV3arMbnIy3tcVff6/4CDiKx17
         cRZw==
X-Forwarded-Encrypted: i=1; AJvYcCWWYXsmnH3YONwVGiUAB8lexf405+KGfKL7yoW6CRnW8tdNjsX5ZVUrwAoVxLDFKGuUl20JVLbWKGMe@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkCEGKzRZu0OOHo1SF/B0YfoYe2lpDZtkhRGFGXGk7j+NNsti
	BpcrOINwk8DMLSRKMx9Y3mxFcksZeluFOiGGtxupoFI7ZLodQoKPFSROfyfbuUyN/zj+Yk6B2ez
	2glXXWuqLIW/EbiZrWvxNVF9B47xWw/MNU6pRZ+7056qE4c0RU32/3FvNvb0=
X-Received: by 2002:a5d:6d8a:0:b0:37c:cc96:d1ce with SMTP id ffacd0b85a97d-37d0e76692bmr8296048f8f.24.1728290656094;
        Mon, 07 Oct 2024 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9n9/Tce+6YujBOglRtvpsa302FQJRjjqFUgcCMnVpyDNnDXLmdOaMtm35K34jGrYxc8KM9Q==
X-Received: by 2002:a5d:6d8a:0:b0:37c:cc96:d1ce with SMTP id ffacd0b85a97d-37d0e76692bmr8296017f8f.24.1728290655725;
        Mon, 07 Oct 2024 01:44:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34? (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de. [2003:cb:c725:8700:77c7:bde:9446:8d34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f0b2sm5213418f8f.9.2024.10.07.01.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:44:15 -0700 (PDT)
Message-ID: <8c7fbaf1-61a0-4f55-8466-1ab40464d9db@redhat.com>
Date: Mon, 7 Oct 2024 10:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Dave Hansen <dave.hansen@intel.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
 willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 khalid@kernel.org
Cc: andreyknvl@gmail.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org,
 David Rientjes <rientjes@google.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.24 19:35, Dave Hansen wrote:
> We were just chatting about this on David Rientjes's MM alignment call.

Unfortunately I was not able to attend this time, my body decided it's a 
good idea to stay in bed for a couple of days.

> I thought I'd try to give a little brain
> 
> Let's start by thinking about KVM and secondary MMUs.  KVM has a primary
> mm: the QEMU (or whatever) process mm.  The virtualization (EPT/NPT)
> tables get entries that effectively mirror the primary mm page tables
> and constitute a secondary MMU.  If the primary page tables change,
> mmu_notifiers ensure that the changes get reflected into the
> virtualization tables and also that the virtualization paging structure
> caches are flushed.
> 
> msharefs is doing something very similar.  But, in the msharefs case,
> the secondary MMUs are actually normal CPU MMUs.  The page tables are
> normal old page tables and the caches are the normal old TLB.  That's
> what makes it so confusing: we have lots of infrastructure for dealing
> with that "stuff" (CPU page tables and TLB), but msharefs has
> short-circuited the infrastructure and it doesn't work any more.

It's quite different IMHO, to a degree that I believe they are different 
beasts:

Secondary MMUs:
* "Belongs" to same MM context and the primary MMU (process page tables)
* Maintains separate tables/PTEs, in completely separate page table
   hierarchy
* Notifiers make sure the secondary structure stays in sync (update
   PTEs, flush TLB)

mshare:
* Possibly mapped by many different MMs. Likely nothing stops us from
   having on MM map multiple different mshare fds/
* Updating the PTEs directly affects all other MM page table structures
   (and possibly any secondary MMUs! scary)


I better not think about the complexity of seconary MMUs + mshare (e.g., 
KVM with mshare in guest memory): MMU notifiers for all MMs must be 
called ...


> 
> Basically, I think it makes a lot of sense to check what KVM (or another
> mmu_notifier user) is doing and make sure that msharefs is following its
> lead.  For instance, KVM _should_ have the exact same "page free"
> flushing issue where it gets the MMU notifier call but the page may
> still be in the secondary MMU.  I _think_ KVM fixes it with an extra
> page refcount that it takes when it first walks the primary page tables.
> 
> But the short of it is that the msharefs host mm represents a "secondary
> MMU".  I don't think it is really that special of an MMU other than the
> fact that it has an mm_struct.

Not sure I agree ... IMHO these are two orthogonal things. Unless we 
want MMU notifiers to "update" MM primary MMUs (there is not really 
anything to update ...), but not sure if that is what we are looking for.

What you note about TLB flushing in the other mail makes sense, not sure 
how this interacts with any secondary MMUs ....

-- 
Cheers,

David / dhildenb


