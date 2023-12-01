Return-Path: <linux-arch+bounces-602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C9801017
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 17:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0862816B0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F44CDEF;
	Fri,  1 Dec 2023 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FewMsGRG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6OuCdxi"
X-Original-To: linux-arch@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BBA83;
	Fri,  1 Dec 2023 08:28:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id AAE28580A4F;
	Fri,  1 Dec 2023 11:28:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 11:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701448083; x=1701455283; bh=eY
	YJBcIdkLd72F1/I/hnCobiC3d8I4lgiTDbsW05Rfk=; b=FewMsGRG2mUxUBSpWO
	M/0S1myc7hSRL3FvSrwVGHeQGumuLJ4RvB4EGSTNC83CaKyGC1+bFU5Hb33Yf1tY
	VO4XFT8d/i/Y+dJYjdSDrW/8zqFVcu/2daQX8puPuiveYcVXPGRJH+KQsmRUMjPR
	NwFZMOCSRsa8S1Ey4IpHbePMk5LTSf60L1Ofqcd9VJQkd/WyYvCNWDGa1gDReibG
	b/T0TFNxpueSxIzhQhxPzzflpDZv/CtDYmCMGC+o+tsi6PNHCikhWOUPSeIqtY2q
	iaIMCgLJunahTFwQ7hNYdKEfmK8wz/WAyfaafbTVANnSiri5Qz+V/3uRN2DIrKWG
	z+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701448083; x=1701455283; bh=eYYJBcIdkLd72
	F1/I/hnCobiC3d8I4lgiTDbsW05Rfk=; b=A6OuCdxivjbAP5VbfQsErA89IkZzt
	z5fbjEpYzWg/ItEGqilefFlgi4GX08/yh9jdVCf/SREg/aq70rvhcSq44BckYCkc
	DSjl9E1eTCLZ5N/sJ1CvoNy1LS6yN1B7ILVTMABRc31B1yU4IzRVNVxs82czDOdk
	nC/H7Ks4QsPk67HzdQAnS7GpYqCXEuCQ8LXJFYe3/NChoyv8FkMjdScJVEn0TWe8
	OzHIkGVmihZaABAzrdsxutC3XIc7748UcqyQpX4Js56w1k0caCPxH+6Lxf99GoJI
	m8P8YdvI+1xJS1J6AM3J94+0H0erqV0jmx+Oxt+OQchX9BLoDLmfMhVyQ==
X-ME-Sender: <xms:kglqZf_CEBYJvjsczzeens3_fwY4UOf70OKzoSAEwa7BapVJglFI9g>
    <xme:kglqZbs8XqF0Dc2wngbqmcylIMG9wIWpq6u5yxSmo9EEO77FXCcWwKEyamAjqvTFp
    0a_wj0rA2xPgpgeRPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kglqZdA1dH1Ijr6lBN34WvsZKLb0mzMG6v_GRemXoo-tr1a7NNY07g>
    <xmx:kglqZbc1dxMUS-Une1a8_DLny0TVaaQ8FH7yEcvDf0aJzBSUrB7SSA>
    <xmx:kglqZUMN_NYtIoLmbna_zQ5GJYdjeAHV9yprhR5PTCxb9ecEL8MfjA>
    <xmx:kwlqZS3F_5Pk_UhB-2fGmXuWnF6ffq_QrHfqPU2X-VYrH8gd376azQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1E96DB60089; Fri,  1 Dec 2023 11:28:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3871b83a-0e80-402e-bbe6-359c17127842@app.fastmail.com>
In-Reply-To: <20231201121622.16343-1-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
Date: Fri, 01 Dec 2023 17:27:40 +0100
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
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Regather scattered PCI-Code
Content-Type: text/plain

On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
>
> Arnd has suggested that architectures defining a custom inb() need their
> own iomem_is_ioport(), as well. I've grepped for inb() and found the
> following list of archs that define their own:
>   - alpha
>   - arm
>   - m68k <--
>   - parisc
>   - powerpc
>   - sh
>   - sparc
>   - x86 <--
>
> All of those have their own definitons of pci_iounmap(). Therefore, they
> don't need our generic version in the first place and, thus, also need
> no iomem_is_ioport().

What I meant of course is that they should define iomem_is_ioport()
in order to drop the custom pci_iounmap() and have only one remaining
definition of that function left.

The one special case that I missed the last time is s390, which
does not use GENERIC_PCI_IOMAP and will just require a separate
copy of pci_iounmap() to go along with the is custom pci_iomap().

> The two exceptions are x86 and m68k. The former uses lib/iomap.c through
> CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous discussion
> (thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).
>
> So as I see it, only m68k WOULD need its own custom definition of
> iomem_is_ioport(). But as I understand it it doesn't because it uses the
> one from asm-generic/pci_iomap.h ??

At the moment, m68k gets the pci_iounmap() from lib/iomap.c
if PCI is enabled for coldfire, but that incorrectly calls
iounmap() on PCI_IO_PA if it gets passed a PIO address.

The version from asm-generic/io.h should fix this.

For classic m68k, there is no PCI, so nothing calls pci_iounmap().

> I wasn't entirely sure how to deal with the address ranges for the
> generic implementation in asm-generic/io.h. It's marked with a TODO.
> Input appreciated.

I commented on the function directly. To clarify, I think we should
be able to directly turn each pci_iounmap() definition into
a iomem_is_ioport() definition by keeping the logic unchanged
and just return 'true' for the PIO variant or 'false' for the MMIO
version.

> I removed the guard around define pci_iounmap in asm-generic/io.h. An
> alternative would be to have it be guarded by CONFIG_GENERIC_IOMAP and
> CONFIG_GENERIC_PCI_IOMAP, both. Without such a guard, there is no
> collision however, because generic pci_iounmap() from
> drivers/pci/iomap.c will only get pulled in when
> CONFIG_GENERIC_PCI_IOMAP is actually set.

The "#define pci_iomap" can be removed entirely I think.

     Arnd

