Return-Path: <linux-arch+bounces-600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D0800E8C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 16:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1670B212A1
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414054A9BF;
	Fri,  1 Dec 2023 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tSSvQ/XN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LR7YgG92"
X-Original-To: linux-arch@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD311A6;
	Fri,  1 Dec 2023 07:26:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 2FCE2580B7E;
	Fri,  1 Dec 2023 10:26:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 10:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701444409; x=1701451609; bh=kz
	ZQHdKoAAB6+QfS9nk3zfKOvPAc1RPjvivwc2Gzfyk=; b=tSSvQ/XNZ3ynaWywM6
	O2qOAAwm6/yH9PjS77M2/Q9aKwXZek8fBS0aSD2KECe1D8Dx/NwERvitb3hqsB6E
	bwBjdi61UDIa7VUnAcycsP5NqfS4a39CV1wO/UzplGjXgjWrKc8zkBlZ6aQ2i07A
	aNSwORpTAVmQDEV80XNIAbPnvteoB/F1pY4TZ/CXaY+eqK+Wu0VuG5zHbK8uXwqc
	nZGJAUlddmzXCu3xEvO5rSiqiOeOAKKnOdtQu4wH0OJhCpouv4xXw9avkArEAgJF
	KnBo+jRgQO9FqKszPRUTU+RZQR81aPJEBMxqkojgxyLt0zGBl8Gv9oyZKKyXIOqI
	YQZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701444409; x=1701451609; bh=kzZQHdKoAAB6+
	QfS9nk3zfKOvPAc1RPjvivwc2Gzfyk=; b=LR7YgG92SvMJUcrWxR02LU+JCYKuS
	X9GrH0wt+Ns6is1sMWzBiI4296x+7LNvpS3NRjLVl8R5XvPRVJXavrc7smV2q4H+
	Jwhdk3u+MJrK1W+G3MYKPc7HSu/VpcxdPfKjd+EX013OdaFKsj1J7eSYjVHGhQ5t
	i2E3WRlZ5nFK/fnUvA2dpcGBVnUTfTPhjkF51gLu4gbd4bDy0lEFrwOb2M5Yq9Gh
	3584dzcqvpyfRfRK+g7hwq3h35NXlfGyDOY9VYMEO4jx+lfLAfxD9+4HbQ7Q+ZUM
	ZvdR9hrAwqUqdVqiZBH5p5aaxb4ZCe+/PXJRT3WlWYaCafc6Y7eaWBf3Q==
X-ME-Sender: <xms:N_tpZdc2iDyIULkyu78iP-8qvlVtSTEExG7xaQGeygmCEuHpSwMgtg>
    <xme:N_tpZbOfbm_2vo0beWL8uSogQtGDNpg6i6r8GtA5IlvdGC2L_BsjnWEnWIsEA_J63
    L6V04OzMRtikUO5gnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OPtpZWgp-T_dWsVgn7yC5TiiAZYL2j-CEi2qJJq45jBWMPcY1jnWLA>
    <xmx:OPtpZW99Dblp5rnQ9Ltr9-pcMMSPDOt_Csdui7-h-avKqpmP0lUQTg>
    <xmx:OPtpZZvmBwqQAEMyRuzM5ZgAXDTzVgF05-zYgladKDIUbhC2lUyfCg>
    <xmx:OftpZZeI7Btyq6g_HlGQgiGKPT8NE7ZzIsrQNdjdYfLs5A108twiew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E5FD2B6008D; Fri,  1 Dec 2023 10:26:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
In-Reply-To: <20231201121622.16343-5-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-5-pstanner@redhat.com>
Date: Fri, 01 Dec 2023 16:26:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>, "Neil Brown" <neilb@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "John Sanpe" <sanpeqf@gmail.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain

On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> The implementation of pci_iounmap() is currently scattered over two
> files, drivers/pci/iounmap.c and lib/iomap.c. Additionally,
> architectures can define their own version.
>
> Besides one unified version being desirable in the first place, the old
> version in drivers/pci/iounmap.c contained a bug and could leak memory
> mappings. The bug was that #ifdef ARCH_HAS_GENERIC_IOPORT_MAP should not
> have guarded iounmap(p); in addition to the preceding code.
>
> To have only one version, it's necessary to create a helper function,
> iomem_is_ioport(), that tells pci_iounmap() whether the passed address
> points to an ioport or normal memory.
>
> iomem_is_ioport() can be provided through three different ways:
>   1. The architecture itself provides it.
>   2. As a default version in include/asm-generic/io.h for those
>      architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
>      provide their own version of iomem_is_ioport().
>   3. As a default version in lib/iomap.c for those architectures that
>      define and use CONFIG_GENERIC_IOMAP (currently, only x86 really
>      uses the functions in lib/iomap.c)

I would count 3 as a special case of 1 here.

> Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> Provide the function iomem_is_ioport() in include/asm-generic/io.h and
> lib/iomap.c.
>
> Remove the CONFIG_GENERIC_IOMAP guard around
> ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> function.
>
> Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make 
> sense of it all")
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Looks good overall. It would be nice to go further than this
and replace all the custom pci_iounmap() variants with custom
iomem_is_ioport() implementations, but that can be a follow-up
along with removing the incorrect or useless 'select GENERIC_IOMAP'
parts.

>  		return;
> -	iounmap(p);
> +	}
>  #endif
> +	iounmap(addr);
>  }

I think the bugfix should be a separate patch so we can backport
it to stable kernels.

> +#ifndef CONFIG_GENERIC_IOMAP
> +static inline bool iomem_is_ioport(void __iomem *addr)
> +{
> +	unsigned long port = (unsigned long __force)addr;
> +
> +	// TODO: do we have to take IO_SPACE_LIMIT and PCI_IOBASE into account
> +	// similar as in ioport_map() ?
> +
> +	if (port > MMIO_UPPER_LIMIT)
> +		return false;
> +
> +	return true;
> +}

This has to have the exact logic that was present in the
old pci_iounmap(). For the default version that is currently
in lib/pci_iomap.c, this means something along the linens of

static inline bool struct iomem_is_ioport(void __iomem *p)
{
#ifdef CONFIG_HAS_IOPORT
        uintptr_t start = (uintptr_t) PCI_IOBASE;
        uintptr_t addr = (uintptr_t) p;

        if (addr >= start && addr < start + IO_SPACE_LIMIT)
                return true;
#endif
        return false;
}

> +#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will be used. 
> */
> +bool iomem_is_ioport(void __iomem *addr);
> +#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT

I'm not sure what this macro is for, since it appears to
do the opposite of what its name suggests: rather than
provide the generic version of iomem_is_ioport(), it
skips that and provides a custom one to go with lib/iomap.c

     Arnd

