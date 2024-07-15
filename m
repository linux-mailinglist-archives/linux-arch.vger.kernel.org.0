Return-Path: <linux-arch+bounces-5397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD5931B07
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCB8281D7B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF3F9EC;
	Mon, 15 Jul 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK7YpiRe"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3F71B52
	for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071841; cv=none; b=fd6fGhj9R/NZzWOZWCeX8Nr0pnX3hiSzjYdCv2mvjS0Sqlgcr0RfOSa9vJ+/GxM03u8B2b541QmJBkbF3Qox9Xwo+yv9dmh7F6civui3QC82geIsRhK7jhPqQiguf2DeCU4s9OIPmj8eDgsw1qPcb4b3bAxVIJgaEnswMC9WxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071841; c=relaxed/simple;
	bh=lgxQTsjT/Zs3WcDsQRcmnmx5cmihBb5Fc0pIMC0leDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nou8cfSJeZsFMdlQIRwisn5z7DG4f3Zt40DhAPU0NfSsiEmH0661Dt8Di8/y/8MwnV55FY2Uot6CsrLcQSpG44X9e97s/yfxq42qOmlIVxMkiodZWMb3RvV+qiWKhkm5kmhNAX1hYC+yBs3NHEU7xFYXxQ14/u35OVlfq2vHhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gK7YpiRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Zo9CyMJSxsrZ+IkEYrIUXBuAiAj8cTbqlht6M8S8U=;
	b=gK7YpiReSl0saauiQMT3AuK6vStK/4a3M9Y5xvVqakvETj3ploNfMDRQImUU1YDVDWHHNL
	9AOju+vyhHWLIjTRmHLLlulLeo7y6S6sc0SItmc6Yr4ey+dRVXFzqFpimhEILPOHXg5X2p
	hqRpPO9JYfmBgj2YXlfTeXiD/KNcbh0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ai8VoDUqNFqiyVr_TYnlpA-1; Mon,
 15 Jul 2024 15:30:35 -0400
X-MC-Unique: ai8VoDUqNFqiyVr_TYnlpA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 257771955D4D;
	Mon, 15 Jul 2024 19:30:32 +0000 (UTC)
Received: from [10.22.9.29] (unknown [10.22.9.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88CCE1955F40;
	Mon, 15 Jul 2024 19:30:27 +0000 (UTC)
Message-ID: <a096151c-c349-455f-8939-3b739d73f016@redhat.com>
Date: Mon, 15 Jul 2024 15:30:25 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha
 extension
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com>
 <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
 <CAHVXubizLq=qZgVQ2vBFe5zVuLRP0DGw=UN4U_Wkx2P2xsP3Mw@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAHVXubizLq=qZgVQ2vBFe5zVuLRP0DGw=UN4U_Wkx2P2xsP3Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/15/24 03:27, Alexandre Ghiti wrote:
> Hi Guo,
>
> On Sun, Jul 7, 2024 at 4:20 AM Guo Ren <guoren@kernel.org> wrote:
>> On Wed, Jun 26, 2024 at 9:14 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>> In order to produce a generic kernel, a user can select
>>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
>>> spinlock implementation if Zabha is not present.
>>>
>>> Note that we can't use alternatives here because the discovery of
>>> extensions is done too late and we need to start with the qspinlock
>> That's not true; we treat spinlock as qspinlock at first.
> That's what I said: we have to use the qspinlock implementation at
> first *because* we can't discover the extensions soon enough to use
> the right spinlock implementation before the kernel uses a spinlock.
> And since the spinlocks are used *before* the discovery of the
> extensions, we cannot use the current alternative mechanism or we'd
> need to extend it to add an "initial" value which does not depend on
> the available extensions.

With qspinlock, the lock remains zero after a lock/unlock sequence. That 
is not the case with ticket lock. Assuming that all the discovery will 
be done before SMP boot, the qspinlock slowpath won't be activated and 
so we don't need the presence of any extension. I believe that is the 
main reason why qspinlock is used as the initial default and not ticket 
lock.

Cheers,
Longman


