Return-Path: <linux-arch+bounces-15522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F43CD2634
	for <lists+linux-arch@lfdr.de>; Sat, 20 Dec 2025 04:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB00E3019B8E
	for <lists+linux-arch@lfdr.de>; Sat, 20 Dec 2025 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D1242D6C;
	Sat, 20 Dec 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcsrlEDN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DF22AE45;
	Sat, 20 Dec 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201447; cv=none; b=TQmsbeTC31R/wIciau2B8OSLqfmRyrYvF3FPvLEWUR4sMRA0T+iH7V7hsVQC7FjmrD6HMqYhDTL5FFKTaOAjbcBi7+gt50izxTTC8V2Plmu6rymodxqbsYeqKGIIQrePV/diXVNAjCyFulUYtrPFoj13d+YsksquZUwZaziszw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201447; c=relaxed/simple;
	bh=iUdJa3ZP1iU0bgE8m+U5BrelPEBq+tJ2Onv6xomprvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N0pogzUwkveJdYE8wuUg0L0KBalevpxBSynh3T96iwu8GJr0QgDg3sCSugEySY0yY9eW2geYZnrY1hcfhWrGXGt8vCGQdgrbXtTmiTHe4R0252tgfkXkCQ1RdweCbTfzKiGiNyp1o12IjhpOjfI7Cg1RBzuDCTqFfJMXAa172B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcsrlEDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F37DC4CEF5;
	Sat, 20 Dec 2025 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766201447;
	bh=iUdJa3ZP1iU0bgE8m+U5BrelPEBq+tJ2Onv6xomprvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gcsrlEDN3DXmkvFdNY57ugc+QQe96QWVElttk9jICytrE5OUc2pgeqZlEes1FtmQS
	 Wq1OdG/EGBrFKpN2szp8TuYPDcvOgRWbL6jYBT0vfF7bKCNjmOaRSgzo2S+rBeJJs1
	 ppYT2+yZdSm0xlqRoXPtLmOVXhrqiGHvIM3ubwvFEVnHLzIyPcqqQ/whTHpGS7KmPV
	 tvvFdvUm6WFf9IqgVnfxxt3kVugGfrcHhfvQ+YB0qY8ZJjIhfsCk0He+SyfvqyhJeh
	 VQXRkZwqG/TFzY1PgHimR1e+wz3BP7JHjM4C1pFfgoIO/1tsW1vEzl8cuExCGIbWh3
	 Go+hvM1CBi66g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason Miu
 <jasonmiu@google.com>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
In-Reply-To: <aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
	(Evangelos Petrongonas's message of "Tue, 16 Dec 2025 13:24:55 +0000")
References: <20251211042624.175517-1-pratyush@kernel.org>
	<aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
Date: Sat, 20 Dec 2025 12:30:40 +0900
Message-ID: <86sed5j0db.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 16 2025, Evangelos Petrongonas wrote:

> On Thu, Dec 11, 2025 at 01:26:22PM +0900 Pratyush Yadav wrote:
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
>> ---
>> 
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index e04d56a5332e..a474c9529a5f 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -342,6 +342,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>>  #define THERMAL_TABLE(name)
>>  #endif
>>  
>> +#ifdef CONFIG_LIVEUPDATE
>> +#define LIVEUPDATE_VERSIONS						\
>> +	. = ALIGN(8);							\
>> +	.liveupdate_versions : AT(ADDR(.liveupdate_versions) - LOAD_OFFSET) {	\
>> +		KEEP(*(.liveupdate_sec_hdr))				\
>> +		KEEP(*(.liveupdate_versions))				\
>> +	}
>> +#else
>> +#define LIVEUPDATE_VERSIONS
>> +#endif
>> +
>>  #define KERNEL_DTB()							\
>>  	STRUCT_ALIGN();							\
>>  	__dtb_start = .;						\
>> @@ -544,6 +555,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>>  	RO_EXCEPTION_TABLE						\
>>  	NOTES								\
>>  	BTF								\
>> +	LIVEUPDATE_VERSIONS						\
>>  									\
>>  	. = ALIGN((align));						\
>>  	__end_rodata = .;
>> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
>> index 4a1cc6a5f3f8..57ef75695f62 100644
>> --- a/include/linux/kho/abi/luo.h
>> +++ b/include/linux/kho/abi/luo.h
>> @@ -244,4 +244,38 @@ struct luo_flb_ser {
>>  #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
>>  #endif
>>  
>> +#define LIVEUPDATE_VER_HDR_MAGIC 0x4c565550 /* 'LVUP' */
>> +#define LIVEUPDATE_VER_HDR_VER   1
>> +
>> +/**
>> + * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
>> + * @magic:     Magic number.
>> + * @version:   Version of the header format.
>> + *
>> + * This struct is the header for the vmlinux section ".liveupdate_versions". The
>> + * section contains the list of file handler versions that the kernel can
>> + * support.
>> + */
>> +struct liveupdate_ver_hdr {
>> +	u32 magic;
>> +	u32 version;
>> +};
>
> I believe we are going to have two main classes of LUO objects that are
> going to participate in Liveupdates, when it comes to their criticality
>
> - Core/Mandatory components. Theese components are necessary for the
> kexec to be succesfull. Think components like IOMMU page tables, as
> you have mentioned.
>
> - Acceleration/Optional Components. As we strive to minimise the blackout
> time, we will trying to persist more and more state across kexec, that
> are currently being initialised from scratch during boot. Thing of
> certain optimisation like PCI onboarding (at least parts of it)
> and the PCI Config Space Cache. If theese components are incompatible
> between versions, we might still want to proceed, with the LU, at the
> cost of increased blackout time.
>
> I believe it will be quite usefull to be able to have the ability
> to differentiate between the two.

I agree that it would be useful. But I've been thinking about this for a
bit. I think it will be hard for the kernel to judge what is a mandatory
component and what is an optional one. There might be some setups where
you would deem some PCI devices as mandatory and some as optional. I
don't think we should even try to encode that kind of policy in the
kernel.

So I think we need a UAPI for userspace to tell us what is mandatory.
That is more UAPI exposure. Dunno if now is the right time to take
that, before we know more how this works out in practice...

[...]

-- 
Regards,
Pratyush Yadav

