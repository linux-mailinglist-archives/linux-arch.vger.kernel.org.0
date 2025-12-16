Return-Path: <linux-arch+bounces-15464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83722CC3366
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B74633004462
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88532E124;
	Tue, 16 Dec 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="askC+C06"
X-Original-To: linux-arch@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96968328615;
	Tue, 16 Dec 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891512; cv=none; b=kG1B9RROHj17/dGRZdlnS4NBz3mLSI7WObOFeVZPKM/h8+0Ds3Yj9rUkQVWjK5jegyf6FERACiQUjDTzMMgy4N0bKopmfwI0uKUxTmyl4sBROIFesG073tX4bXVWJ7wu9Z9KNgPiZSJFr3V5OBnch0261uA2RyV2zhgC1aD1sDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891512; c=relaxed/simple;
	bh=fNVv/jxi63LEgW66a7xU6SSs62jJHhzSaZRxIYvzraM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6JXIcT1mXFBGi2k06wHfLIemJSiX+8jwt0gMDmCv/9GJ7qkKPT3/LJZAQk+Vgs7QV5/5IZ9ZOABoEAEB3XpGbdoUPDcAZ/JqPlTXBUprL/jNp5u2kVm6wU3cwYYQb8mO6y4SKzgkFnt9Td7aFLhL17l4GCR3vdAnEHK5fr1rQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=askC+C06; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765891510; x=1797427510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Owz+SqmUbMxEza/nbiqSp1ZviUjX8HAPBLSYA5hAFI=;
  b=askC+C06xGwJx66ab2dizxVsHuNZGkt3K3PnO6moPWZVK7BbVWIlg6SK
   dK2kg6wfQcviCG1av0AOoJp4DwY2I6+5+YFyH10kw4M61nLrNLCiCgpaa
   x83n84x8BlPbjsTa9LzfbA5COWaraOlyilTX+dUM7+5n7Rvw4B97ZuM7Z
   za2I2Fu6HD4hvI3pji3l5wNr9q25wITSbO4oMQE7LW+Zrs6XFrI/gTruN
   EwhJCt5i+kRJpAuljuZGa8VqZBm4gnEpIVSExfrOvuSo8CsbHjVFz7CVM
   NAnzjRwwt6T4V1irBru8izTD0RJJ5JlLPiIgIvp2sKz9YeJ6Yda+mQlU4
   A==;
X-CSE-ConnectionGUID: K5ndT0gFQmeqj3A9lSSyfQ==
X-CSE-MsgGUID: 8SweK6QCRJ6oI+XRhjCbsA==
X-IronPort-AV: E=Sophos;i="6.21,153,1763424000"; 
   d="scan'208";a="9177461"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 13:25:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17082]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.145:2525] with esmtp (Farcaster)
 id 8dfd8098-be01-4286-baba-bb6b63f882de; Tue, 16 Dec 2025 13:25:07 +0000 (UTC)
X-Farcaster-Flow-ID: 8dfd8098-be01-4286-baba-bb6b63f882de
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 16 Dec 2025 13:25:00 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 16 Dec 2025
 13:24:58 +0000
Date: Tue, 16 Dec 2025 13:24:55 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Pratyush Yadav <pratyush@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>, Jason Miu <jasonmiu@google.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
Message-ID: <aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20251211042624.175517-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251211042624.175517-1-pratyush@kernel.org>
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Dec 11, 2025 at 01:26:22PM +0900 Pratyush Yadav wrote:
> As live update evolves, there will be a need to update the serialization
> formats for the different file types. This could be for adding new
> features, for supporting a change in behaviour, or to fix bugs.
> 
> If the current kernel does not understand the same set of versions as
> the next kernel, live update will inevitably fail. The next kernel will
> be unable to understand the handed over data and will be unable to
> restore memory, devices, IOMMU page tables, etc.
> 
> List the set of versions the kernel understands in a section in vmlinux.
> This can then be used by userspace tooling to make sure the set of file
> descriptors it uses have the same version between both kernels. If there
> is a mismatch, the tooling can catch this early and abort live update
> before it is too late.
> 
> The versions are listed in a section called ".liveupdate_versions". The
> section has a header that contains a magic number and the version of the
> data format. The list of version strings directly follow this header.
> Only the version strings are listed, and it is up to userspace to map
> them to file descriptor types.
> 
> The format of the section has the same ABI rules as the rest of LUO ABI.
> 
> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
> file handler while also adding its version string to the right section.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e04d56a5332e..a474c9529a5f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -342,6 +342,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define THERMAL_TABLE(name)
>  #endif
>  
> +#ifdef CONFIG_LIVEUPDATE
> +#define LIVEUPDATE_VERSIONS						\
> +	. = ALIGN(8);							\
> +	.liveupdate_versions : AT(ADDR(.liveupdate_versions) - LOAD_OFFSET) {	\
> +		KEEP(*(.liveupdate_sec_hdr))				\
> +		KEEP(*(.liveupdate_versions))				\
> +	}
> +#else
> +#define LIVEUPDATE_VERSIONS
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	__dtb_start = .;						\
> @@ -544,6 +555,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  	RO_EXCEPTION_TABLE						\
>  	NOTES								\
>  	BTF								\
> +	LIVEUPDATE_VERSIONS						\
>  									\
>  	. = ALIGN((align));						\
>  	__end_rodata = .;
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 4a1cc6a5f3f8..57ef75695f62 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -244,4 +244,38 @@ struct luo_flb_ser {
>  #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
>  #endif
>  
> +#define LIVEUPDATE_VER_HDR_MAGIC 0x4c565550 /* 'LVUP' */
> +#define LIVEUPDATE_VER_HDR_VER   1
> +
> +/**
> + * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
> + * @magic:     Magic number.
> + * @version:   Version of the header format.
> + *
> + * This struct is the header for the vmlinux section ".liveupdate_versions". The
> + * section contains the list of file handler versions that the kernel can
> + * support.
> + */
> +struct liveupdate_ver_hdr {
> +	u32 magic;
> +	u32 version;
> +};

I believe we are going to have two main classes of LUO objects that are
going to participate in Liveupdates, when it comes to their criticality

- Core/Mandatory components. Theese components are necessary for the
kexec to be succesfull. Think components like IOMMU page tables, as
you have mentioned.

- Acceleration/Optional Components. As we strive to minimise the blackout
time, we will trying to persist more and more state across kexec, that
are currently being initialised from scratch during boot. Thing of
certain optimisation like PCI onboarding (at least parts of it)
and the PCI Config Space Cache. If theese components are incompatible
between versions, we might still want to proceed, with the LU, at the
cost of increased blackout time.

I believe it will be quite usefull to be able to have the ability
to differentiate between the two.

> +
> +/**
> + * struct liveupdate_ver_table - Table of file handler versions that the kernel
> + * can support.
> + *
> + * @hdr:        Table header.
> + * @versions:   List of versions the kernel supports. The strings ate
> + *              NUL-terminated, but to keep the format simpler always take up
> + *              LIVEUPDATE_HNDL_COMPAT_LENGTH bytes.
> + *
> + * The list of versions immediately follows the header. The number of versions
> + * are determined by section length.
> + */
> +struct liveupdate_ver_table {
> +	struct liveupdate_ver_hdr hdr;
> +	char versions[][LIVEUPDATE_HNDL_COMPAT_LENGTH];
> +};
> +
> -- 
> 2.43.0
>

Kind Regards,
Evangelos



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


