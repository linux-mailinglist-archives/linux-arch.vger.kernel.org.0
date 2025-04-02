Return-Path: <linux-arch+bounces-11216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF82A787AD
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 07:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FDD3B0E7A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CD20C02A;
	Wed,  2 Apr 2025 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5/Duyyk"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F39524C;
	Wed,  2 Apr 2025 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743573399; cv=none; b=iD0V32c2aEir6Ncdxp8lhdXsgWcX3tR45E3MV5YIBoo9QDeE6zGvxj74c7i8fCnxc0/uL/ZJK+rmc9iYxXd3x0F43mFIYa72er0MzcZwuAv9dwbQ2FTiMFfJbH+kUXH+h+SyztqOvwyi1EdCFQ+DvwZRwBMsL1bJp7dDpIDjfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743573399; c=relaxed/simple;
	bh=idNX+svvEWLKtNy71wkE47NdHgMMCp/086kEVWpDgJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTUdWtV6SRMWUcSJ2MitlMAhslTEWZt+4BgNjT3AJvYwOJAAvV8iVDlRui7EpX2Y2vz4Z4AYutOxDMJ0yioOzXq1t2qm/U8v7hav6qWn0BDZVf5kjGc9C3TKs4MA1iB5MzmtLhVEVa+ZfVKvOlBjJqupRqtrJTG3VN6MkJkC558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b5/Duyyk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b75+Ht5Hyq1P528GzwL4WQIDfaLlTiDS1piLjtDr6oY=; b=b5/DuyykqDpZGV5cYCxB3ptdbL
	kFxw+AULnogOBOaIYBVtSPJoF5wVmts9Xh6yMsEoRpVZ4oT88mer0yJZLIvwfMOUl/FeREJfUNp0p
	2JgSIbqdwKuMRcm+5BmIQ08tJtGeDBJkdmRlA+vGLI8sY/7j5ZZFBevuYPfhr5GLcTXrNWkKLR7CE
	yQMNdoabWhI+fIz0Lw3za5az21nq4qb+A1XfPeKEq6ggpXkMYALO5wNtyU67NqsvWiahb79wUYogO
	rY/ntXNvQkPEw0gA43/iV9rLyMJ+BhOIlrQHOSuvrIPTf6wjAXtx6CYrAFWnB6Dd/0hjfPyR6/c4S
	/oBOnTlQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzr5X-00000006yR0-0vUZ;
	Wed, 02 Apr 2025 05:56:36 +0000
Message-ID: <b5589b7d-d4a1-4b12-a845-afdbb26ed845@infradead.org>
Date: Tue, 1 Apr 2025 22:56:32 -0700
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
 <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>
 <20250402050234.GB317606@sol.localdomain>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250402050234.GB317606@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/25 10:02 PM, Eric Biggers wrote:
> On Tue, Apr 01, 2025 at 09:50:57PM -0700, Randy Dunlap wrote:
>>
>>
>> On 4/1/25 8:51 PM, Eric Biggers wrote:
>>> On Tue, Apr 01, 2025 at 08:42:41PM -0700, Randy Dunlap wrote:
>>>> Hi 
>>>>
>>>> On 4/1/25 3:15 PM, Eric Biggers wrote:
>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>>
>>>>> All modules that need CONFIG_CRC32 already select it, so there is no
>>>>> need to bother users about the option, nor to default it to y.
>>>>>
>>>>
>>>> My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
>>>> CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
>>>> FWIW.
>>>> But they would not need to be default y.
>>>
>>> That's not supported by upstream, though.
>>
>> Which part is not supported by upstream?
> 
> Having prompts for library kconfig options solely because out-of-tree modules
> might need them.

Well, I think that is was supported for many years. I don't see how it would become
unsupported all of a sudden. IMHO.

-- 
~Randy


