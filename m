Return-Path: <linux-arch+bounces-11214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73AA7876A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 06:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5022516C94D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 04:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A81EA90;
	Wed,  2 Apr 2025 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/spYfaR"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177DAD27;
	Wed,  2 Apr 2025 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569464; cv=none; b=rNnpIgAdTmDkg4S/ONawV2T0r9lVksrTItjBZAP288RdPKQvj69l4rLTw00hPQVguLBmck1EbwAhF/uomCmUDo5+idE3wHx8W/wGsvvNcKSN0ckqm1diJNOlxGHYDg0FR7MKhCC0qjruTqw8LWhdyr3ypABRUBb7uxBUKt3bVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569464; c=relaxed/simple;
	bh=5k0lhMFDuMGUXvZLxsi8dU5uY98pe4x9nV0Dj+9z75Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTxQLQZjG+CBQil8p/bMaf1mZDVfd0TfL3V6+VKUkKElwG6/+DVpi8g3Yc22RX/mzD2CzvwotihornNzaDs0KkqA9BPrQe/u33EgR0dosNC32fymPgINYNlsjBeRg0XNYRcGmQ4BwnovXGbyJKetsiY4KB4b7/13mMxL3/40eTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S/spYfaR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=l2KeQ2qhb75h9nTDFAqvdWhepXqH0Xenyjr5YQLAlP4=; b=S/spYfaRBicnn9S4wDLy8px+zX
	FA8NQuAm6xdKsC7vl0yOoXHGUAxABejLuMcYSXkdUihKOxToPK2lqjnw0FKKMOd80Z53deLjryfnL
	Zaqor9EeV+E8/qOU/z+eIDDTU2CnsX2s911TvozTAG5co9KqZUNx9MxPBOhsHMX17KmNJ6HDuHr+H
	U78OC7QLL1Bw+WVCjFEEc7cxXuIDBDtpat7sbT1xxjdWA3DlgDxcXkU6ujcTwUpSCMhb0tMoVH/tt
	jG719SpsCq8KRLf9bQtVc0S22CIZQWAN3XsMKiPO1BugGHNXDYid100LjN38MyOmdnnZvivzGpOZN
	FtB49WZw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzq44-00000006xwk-0uth;
	Wed, 02 Apr 2025 04:51:00 +0000
Message-ID: <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>
Date: Tue, 1 Apr 2025 21:50:57 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
 <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
 <20250402035107.GA317606@sol.localdomain>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250402035107.GA317606@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/25 8:51 PM, Eric Biggers wrote:
> On Tue, Apr 01, 2025 at 08:42:41PM -0700, Randy Dunlap wrote:
>> Hi 
>>
>> On 4/1/25 3:15 PM, Eric Biggers wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> All modules that need CONFIG_CRC32 already select it, so there is no
>>> need to bother users about the option, nor to default it to y.
>>>
>>
>> My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
>> CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
>> FWIW.
>> But they would not need to be default y.
> 
> That's not supported by upstream, though.

Which part is not supported by upstream?

-- 
~Randy


