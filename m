Return-Path: <linux-arch+bounces-7748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B015992776
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A96A1C229C1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7903187353;
	Mon,  7 Oct 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDEX098M"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DE13C9B3
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290891; cv=none; b=gvZMR4JmU4469ehx14T2jDJEGxBT0OcrT+kWn5GOV0qGVTqca8oK1qjPi+ok77sPA/oOTRSyj13D+25+T3+BSTJkLcNGG4Yzrt07L4n5+rSInT7maVT9evNmAQ83bwfQS5xiJlyT5KTQoc7II783SWdk4vOsVY7VfcIKfZaUiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290891; c=relaxed/simple;
	bh=6Ryk55P/ZxwhvTmz2rvcNGmMVLmsXPwyEfGUDmZigHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E56ENveVEEwvyrD43R8PM44IPdacZIg2dbngjjwL4tVa1O0Xi/SAqJCw6Wf8kZUrfN8Mbu9+DuDt6aFq4QtCzC+PgPpVW6irwRhs513uDoFCQ/3dayhNleM+e2j46UORUrU8tlKAd/VSojXr/WFeRKSsjuvfGm8DgZsLXWHqHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDEX098M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728290889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ye3b3jDj+gVu6tf7ycFgsi/ORu7X0wqxMcaQMdkv+o4=;
	b=WDEX098M6CSQKh/XO3NjyKACoy26JyzNDjhbPKfX1R2gs47jOcV0YYD6bzqCDmCmoWPbG1
	9QYeY5coxn0UQEOrMrsa743MxNMAF4xywn5/CJEyVjAQ1pbhs+eSuIG02KmOqKkuAhazMq
	mlwjvzxfyqw/82xYJU2hVNDnaVSx0lQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-_MjYLJmaNKSgBXmTnLkksA-1; Mon, 07 Oct 2024 04:48:08 -0400
X-MC-Unique: _MjYLJmaNKSgBXmTnLkksA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37ccc96d3e6so1530146f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 01:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290887; x=1728895687;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ye3b3jDj+gVu6tf7ycFgsi/ORu7X0wqxMcaQMdkv+o4=;
        b=NJOT9Pp3SVxcGMfd3xc9Uffr5mrPKb9P4qhCCjtQIs13zKiY1CpoGmjPyoN9K2t91g
         hDBugRlRhc6bvHbZeeSfd1qJipOCO/Ilewn64Snd/NkMVOxz/LQw291zYLg5JTJjKrgK
         5EGtHnR1kfd+vOoJi8vNhEiKgfae/TBvOXVKjjjrKQYoEoQn+lKBBCHjJvF2IYYgYr6A
         Vcisa7a7QMrrgJlYcNHfq+aMK7zjTG+VUfVn6cDeCB4N7fiLH3Mr7J+HayxJJnGjPEEM
         gK07DWu/uSm8uu0fVA4WTk0Z6ktdr+8segTB73OOfeANqyLjH2uc6qvH/O3VscxrOYnQ
         ekiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUppJMEFdpQHSQQa5gIpzAjnLb9Md19RM9GgmXPUwoz04BKhkFQC1ao1yfcQflyCHdVAKGpFqgAEUEw@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFXoW7/J2i6Gnta3oMqZTodxqWTGZixntrbACW4JdSIZnhMCi
	obNWPi0c1IWV8vYhyORzKqAYgOhBd51uJq0ONXXWiKnu+je2SBrBDal/oGueH0rio0pXBrXnhra
	+LrQ1S/bixiT1M/MUiZU9aOaqgdfFGA51JM+aaMuDMhH8v8vdTTLUA/Rt0Rk=
X-Received: by 2002:a5d:6d4f:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-37d0e79149fmr4991489f8f.34.1728290886804;
        Mon, 07 Oct 2024 01:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZ/w3D+q+nMdjdIGuUJr/i0qPxXp9GNxuINQsc/xoiQ71kZjMwPf5lmhFEeKdWC8FO8B6XA==
X-Received: by 2002:a5d:6d4f:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-37d0e79149fmr4991478f8f.34.1728290886425;
        Mon, 07 Oct 2024 01:48:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34? (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de. [2003:cb:c725:8700:77c7:bde:9446:8d34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5190945f8f.96.2024.10.07.01.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:48:05 -0700 (PDT)
Message-ID: <2c392f07-1363-4306-a1cc-ac89decdd7bc@redhat.com>
Date: Mon, 7 Oct 2024 10:48:04 +0200
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
> 
> Basically, I think it makes a lot of sense to check what KVM (or another
> mmu_notifier user) is doing and make sure that msharefs is following its
> lead.  For instance, KVM _should_ have the exact same "page free"
> flushing issue where it gets the MMU notifier call but the page may
> still be in the secondary MMU.  I _think_ KVM fixes it with an extra
> page refcount that it takes when it first walks the primary page tables.

Forgot to comment on this (brain still recovering ...).

KVM only grabs a temporary reference, and drops that reference once the 
secondary MMU PTE was updated (present PTE installed). The notifiers on 
primary MMU changes (e.g., unmap) take care of any TLB invalidation 
before the primary MMU let's go of the page and the refcount is dropped.

-- 
Cheers,

David / dhildenb


