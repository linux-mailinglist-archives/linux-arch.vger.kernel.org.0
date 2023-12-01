Return-Path: <linux-arch+bounces-603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B92801334
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB16C1F20FD0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83B48CF1;
	Fri,  1 Dec 2023 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrTTrJm3"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0910DA
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701457002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
	b=WrTTrJm3CVxYgsLbSYHLCs1e8p2ZE89pQc2i4AYrwTGA0Gg8LeVLAD2cpHBu9qJZZahtKG
	sC0xAIEPC4dURaXiZPk4IqSPvQLK5IXeuSDvjnjVe5Vw6+/se6l/s+Anw83tZ7qGn7cXFu
	kwT+n9bG2CUysYXCOiCe/PAQtQOle3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-hnfRMzJJN8ai5z5PvqknlQ-1; Fri, 01 Dec 2023 13:56:41 -0500
X-MC-Unique: hnfRMzJJN8ai5z5PvqknlQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3333298eaabso128327f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 10:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457000; x=1702061800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
        b=KPW/AFLnjFkmKrDTmyAcxmGNPdP85gJbh+xQSLZgYWLaOAXB1WAGeQfoY+tN6vjpOv
         XQk8ZDAk02W9IqqVWby+SoPVT8AVQfuVu31mH8BDllQg0+81w3q7+fAE0uub+ikB0yh5
         qWddk0HWZWdpR9J6Fg8WJmMdcdr2x9jH/j2pel5aqbAhLPewgPggbjqt0c7Uzstjtlzb
         LEGLKxUvkLbTGFPH915Q48jMm9eGJSUAacW+v2vQPoOcLtTOr8tSi99UWjas1QGGymsK
         NygQAR5dwhZiUuDUNlWBhmghH/AJOvPRkazN4pdcIE8DCRHHLTXUNNQYlHmPTJvzv514
         dvCA==
X-Gm-Message-State: AOJu0Yyc8ufV3LoflhClTS2+l73AbeHyhGXnHtiB65HDIfEl4mr2Brbg
	Cw461pENhIVmN3N2ZMAYLWxffX990aPbIZANtcT7ZmWyaQ3MyurVXuR0/2wzfRkPaCTMzGpqez1
	Vl/xZcK+a0U5/nNfIg7D9Yg==
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267057wrz.2.1701456999967;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYgHWBQ7ogcvjbLFWn2No+e3cu9LEahop+KqhFPcJLWwUOIMB6Bc+JurOdJinf9T84hx/+XQ==
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267048wrz.2.1701456999652;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003296b488961sm4857046wru.31.2023.12.01.10.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Message-ID: <4bf46893a583551c71bdfbf91df9ccc4b51556b1.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
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
Date: Fri, 01 Dec 2023 19:56:36 +0100
In-Reply-To: <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
	 <20231201121622.16343-2-pstanner@redhat.com>
	 <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 15:43 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> >=20
> > -#ifdef CONFIG_PCI
> > =C2=A0/**
>=20
> You should not remove the #ifdef here, it probably results in
> a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
> GENERIC_PCI is not.

CONFIG_PCI you mean.
Yes, that results in a build failure. That's what the Intel bots have
reminded me of subtly before, which is why I:

>=20
> Alternatively you could use Kconfig or Makefile logic to
> prevent the file from being built without CONFIG_PCI.

did exactly that in this very patch:

@@ -14,6 +14,7 @@ ifdef CONFIG_PCI             <------------
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o     <-----------
 endif


P.

>=20
> =C2=A0=C2=A0 Arnd
>=20


