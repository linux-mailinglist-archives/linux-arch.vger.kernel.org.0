Return-Path: <linux-arch+bounces-15601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04ECE8377
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 22:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 596103010CF4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100E2E7657;
	Mon, 29 Dec 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHPY0Zio"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA1E1C02;
	Mon, 29 Dec 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767043719; cv=none; b=Km6ZK8rSZBOG8FE7oTZ//JnaM3Ij8hgBQi//dVLVAv6lhEOFIdCwNFnVRYvDYP3/U3F+QhEV+RkyHsGL90ri1Ehnz4x1MSsZvsT5GqjUzANnSAg9eTvbB/8LvHfEbW4SJWlCElzLurAd7CrX9Zf4BnRXFJiKTmJzJ98fgCpD5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767043719; c=relaxed/simple;
	bh=SVRqYR0GXBh37EIJDTe7QP6vSom4boVYlTrlJiH7Y3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=siZ4bZyg01StmCtb1CbVL65SE0TVLevdNN+RrMk1J5QXAc0ErXVJ2GHIU19NT6xN5zVm9pW7HnfxB8VubG/lEvf20Uq6aF7yF7jv/GFF01eg2TuK4NgNmFRwb5rnpUZJ+X7z5/+1VxY6Pa0V7wenaX5bYcHyMcjU503ZMvnUqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHPY0Zio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F370C4CEF7;
	Mon, 29 Dec 2025 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767043719;
	bh=SVRqYR0GXBh37EIJDTe7QP6vSom4boVYlTrlJiH7Y3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jHPY0Zio4UWt0Jmie7XDhylPHKe4oeCNafzP75gZq+v2MHP/cHARsw1IvKXp6pZs3
	 VTYUGouFCZwVkUTMADLvPuHp22ZPOzpY/hEBy61azE/0jQl33SnjvIZ/fAXdRKZyUS
	 C0fVsk8KmYItSJo8KycqEcqD1J5WeUUu22DFatpuQ0Zvxg7yOCosB/EBu3u3jZAfjO
	 jrUdmThHREyv8RBcILupv7zDt03yOYEnTav0jTYjUsvYfBCxQI+Iw3RHvYXusasxGy
	 qgm20EGBgpnFZHnEdqjZNnQ2cPSrWDLkAPsn+PUi80K0IDOhqeoPic9S0U22uMTwNc
	 hY4CnEv0Ihteg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  "Pasha Tatashin" <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  "Andrew Morton" <akpm@linux-foundation.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason Miu
 <jasonmiu@google.com>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
In-Reply-To: <e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com> (Alexander
	Graf's message of "Sat, 13 Dec 2025 16:10:22 +0900")
References: <20251211042624.175517-1-pratyush@kernel.org>
	<e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com>
Date: Mon, 29 Dec 2025 22:28:32 +0100
Message-ID: <86ecod7zb3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Dec 13 2025, Alexander Graf wrote:

> Hi Pratyush,
>
> On 10.12.25 20:26, Pratyush Yadav wrote:
>> As live update evolves, there will be a need to update the serialization
>> formats for the different file types. This could be for adding new
>> features, for supporting a change in behaviour, or to fix bugs.
>>
>> If the current kernel does not understand the same set of versions as
>> the next kernel, live update will inevitably fail. The next kernel will
>> be unable to understand the handed over data and will be unable to
>> restore memory, devices, IOMMU page tables, etc.
>>
>> List the set of versions the kernel understands in a section in vmlinux.
>> This can then be used by userspace tooling to make sure the set of file
>> descriptors it uses have the same version between both kernels. If there
>> is a mismatch, the tooling can catch this early and abort live update
>> before it is too late.
>>
>> The versions are listed in a section called ".liveupdate_versions". The
>> section has a header that contains a magic number and the version of the
>> data format. The list of version strings directly follow this header.
>> Only the version strings are listed, and it is up to userspace to map
>> them to file descriptor types.
>>
>> The format of the section has the same ABI rules as the rest of LUO ABI.
>>
>> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
>> file handler while also adding its version string to the right section.
>>
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>
> To support multi-version preservation and resume, how about you add a "profile"
> hint to the handlers? Then you can tag the handlers with "current" and a
> "previous". You then expose one section table with supported versions per
> profile. And that means you can from user space select the local profile to
> serialize and match that against the target profile of the target system.
>
> It also allows you to support more "profiles", such as elaborate downstream
> version combinations, that upstream will not have to care about.

So in essence you want to tie the versions into a "version set"? If you
want to use a new version even for one component, you would create a new
version set.

Interesting idea, but I am curious. Do you see a reason for grouping
versions together in this fashion? Why not let each version be changed
independently?

-- 
Regards,
Pratyush Yadav

