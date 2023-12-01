Return-Path: <linux-arch+bounces-604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDB801341
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 20:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768F0280FD1
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C4121A0E;
	Fri,  1 Dec 2023 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQjJX6yb"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FBA10DE
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701457209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m41LLKgfTnOgM1rZWGXKDoV2xNtfCXmSDGiVFJ2E2HI=;
	b=EQjJX6ybLzUJQmjlIXpoT7jlq6QiXYpw44v525CmMEHrUpx413tgp+62GcGbaHJ/6nAyQC
	aaqHlPiDIZpa8+CZyigiy5mrjra7co/BXBO10mcYtkKVvoQC+LNLfnvxmbXgx68VkKBI4j
	9Y83LzXlD+3PHqVxkIoM/HC6nfK7ST8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Azyh93_6Pma9sUBX3FQ5bA-1; Fri, 01 Dec 2023 14:00:07 -0500
X-MC-Unique: Azyh93_6Pma9sUBX3FQ5bA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b371a69f9so3964185e9.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 11:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457206; x=1702062006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m41LLKgfTnOgM1rZWGXKDoV2xNtfCXmSDGiVFJ2E2HI=;
        b=LjSFxWWTYUhZEq3Fdn3XLlA/rZQqpKoPjN4nb+qte1l2l3WbNney1Zgu0hrnhuKLJU
         kbRz2Y/g4THn18GwVEnloIJ1PlQ4aGDUT5ZqonrSAc1fdPF8udHxH7Go+VU0+N6lnmYb
         KUrDlM0ffnt5Suz1XLlEDqhtG0F/SaL9U1QBZWByw8I1lPamgXmuf32fEv2Fku3We+1e
         +XXQsFkcxG8qF8RohAiJwp37Fvsdwkkdd9nRfjiGHLgSPSWHiAOlAejApEwcBzUyl6D0
         e0oz4rhaU/nS9kh7M/Pn3KCbDB3CmPv9W4L7+2lhNpOswfnY7/TvmaGq1lHOwh6HHtg3
         Y4Ww==
X-Gm-Message-State: AOJu0YzdlQrVSj7TvVeSB6ZUykoGVA44WJoBcHWTv96h+IsAW4sGH3F4
	moiHzpeqUIarwN6d6g1IeGUjwXJ63ctIkrmw7B8v2Y6iWp22anF0hcHPrfnFc6+08dWvq57cD2k
	OFwnYwOssNvVWZpgi/nzzmw==
X-Received: by 2002:a5d:5889:0:b0:333:362e:8416 with SMTP id n9-20020a5d5889000000b00333362e8416mr330987wrf.0.1701457206636;
        Fri, 01 Dec 2023 11:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb31Qn5jnGDryDULukDS8yw9/j8mm87Arm4MPjyniF6L5X3AMBJABucr2yZHjHSgyTVs+IlA==
X-Received: by 2002:a5d:5889:0:b0:333:362e:8416 with SMTP id n9-20020a5d5889000000b00333362e8416mr330966wrf.0.1701457206306;
        Fri, 01 Dec 2023 11:00:06 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4686000000b0033315876d3esm4877262wrq.12.2023.12.01.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:00:05 -0800 (PST)
Message-ID: <90423946a0dbdcdb7cb3c93b3897683ce07c5e69.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] lib: move pci-specific devres code to
 drivers/pci/
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, Neil Brown <neilb@suse.de>,
 Niklas Schnelle <schnelle@linux.ibm.com>, John Sanpe <sanpeqf@gmail.com>, 
 Kent Overstreet <kent.overstreet@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, David Gow
 <davidgow@google.com>, Yury Norov <yury.norov@gmail.com>, "wuqiang.matt"
 <wuqiang.matt@bytedance.com>, Jason Baron <jbaron@akamai.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Linux-Arch
	 <linux-arch@vger.kernel.org>
Date: Fri, 01 Dec 2023 20:00:03 +0100
In-Reply-To: <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
	 <20231201121622.16343-3-pstanner@redhat.com>
	 <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 15:44 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> > The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> > CONFIG_PCI and, thus, don't belong to this file. They are only ever
> > used
> > for pci and are not generic infrastructure.
> >=20
> > Move all pcim_*() functions in lib/devres.c to
> > drivers/pci/devres.c.
> > Adjust the Makefile.
> >=20
> > Suggested-by: Danilo Krummrich <dakr@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/Makefile |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/pci/devres.c | 207
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0lib/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
8 +--------------------------------------
> > ----
>=20
> I still think this should go into drivers/pci/pci_iomap.c along
> with the other functions.

I understand where you're coming from, but the technical reason I'm
doing it this way is the same topic as in patch =E2=84=961:

@@ -14,6 +14,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o
 endif


As you pointed out very correctly, I removed the #ifdef PCI in the
iomap.c functions, which would result in build failure, because the
file has to be made empty if GENERIC_PCI_IOMAP is selected and PCI is
not

The devres functions have different compile rules than the iomap
functions have.

I would dislike it very much to need yet another preprocessor
instruction, especially if we're talking about #ifdef PCI within the
very PCI driver.

P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20


