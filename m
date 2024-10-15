Return-Path: <linux-arch+bounces-8162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E899E4A1
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01EF1F21D8A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919171E490B;
	Tue, 15 Oct 2024 10:53:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AF1DD86F;
	Tue, 15 Oct 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989619; cv=none; b=CRlNA99LeQi1IzzPtW7QVE+AAX0/0COWmHCi0VVOSRzw4fMo5at+ZVWU4NbxvqW6PfQaY1Ipu//gRGz7vu08kagT454+qH4tQoSyd6PgeV3PsbEdmnehZC8r49+OC2bo4fVsrM5n9EcvWL85RafJ4dqs4HWxaDLsL2BLedQuoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989619; c=relaxed/simple;
	bh=4jtZFTSBUymdmYewGD8xEwu2w7gp3pptXGUdc8PtQPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3ih0TCto8CfVW0VLoTgd19Q4+3lg3W6s76sjOG21A0Htc77Kv/ryAWAE0vXQUu1wPx9fv0sK6qsbBYXmnaZCvPJdpNjWSLHuaIfejSYL2pMOkGyt9p2vCkOqNkVP4s6jQsXAOLbcmzuLqzav+9zQ9kQJngJ7qbaWktFnF/20rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333991007;
	Tue, 15 Oct 2024 03:54:06 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47463F51B;
	Tue, 15 Oct 2024 03:53:32 -0700 (PDT)
Message-ID: <aa1a1ee9-bddf-4b14-a3ca-f0e2c34a22ad@arm.com>
Date: Tue, 15 Oct 2024 11:53:31 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 02/57] vmlinux: Align to PAGE_SIZE_MAX
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Tejun Heo <tj@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-2-ryan.roberts@arm.com>
 <0e7c6bd0-b4a0-4afe-22ff-73239bd86943@gentwo.org>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0e7c6bd0-b4a0-4afe-22ff-73239bd86943@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 17:50, Christoph Lameter (Ampere) wrote:
> On Mon, 14 Oct 2024, Ryan Roberts wrote:
> 
>> Increase alignment of structures requiring at least PAGE_SIZE alignment
>> to PAGE_SIZE_MAX. For compile-time PAGE_SIZE, PAGE_SIZE_MAX == PAGE_SIZE
>> so there is no change. For boot-time PAGE_SIZE, PAGE_SIZE_MAX is the
>> largest selectable page size.
> 
> Can you verify that this works with the arch specific portions? This may
> also allow to to reduce some of the arch dependent stuff.

Sorry, Chistoph, I'm not exactly sure what you mean here by "arch specific
portions" and "reduce some of the arch dependent stuff"? Could you elaborate?

I can certainly verify that this change works for all the test scenarios I've
listed on the cover letter.

Thanks,
Ryan


