Return-Path: <linux-arch+bounces-2097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D484B172
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 10:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EF6280CBF
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789412D16D;
	Tue,  6 Feb 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g05AKgIC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F512D165
	for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212276; cv=none; b=BckYJSWZRR5S+1Ek+ooMtgVS4gN9bJv4HlGK7ibx5RTGtYmG1zAxir71aDxNAx9Khv6o9O5NBME3z/jwoCWLJj2ARkpkQ1447bPBybUsaQz93sygWuXFIne6rIc0K9ZUQ8jaIII6W4JTAdqlrhX/T4C1oXwv+WZ3BB3UbCvLvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212276; c=relaxed/simple;
	bh=UFw0/tki7MzcuGpQDjCWPan97sbo8eZxmh34JYGWwvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEzy7oH31jOyzca6E2LFGcNswCSwcfDKG1KUc1s6aSoM0/KFgt2kFwpKKxM31kUHSmEJ3ftcfGQbGx+wcH4eVpzuYKwKdWtq2bYLfEyb2JIR4QGan5Rgs+kEuMG531MZOkdXDxE8Dx8YyKVX1p/V9dWdq6kZh7aM+AGP3iNYRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g05AKgIC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFw0/tki7MzcuGpQDjCWPan97sbo8eZxmh34JYGWwvw=;
	b=g05AKgICNqTkFjgWbcfI1jPw3/I4Hqw7d4kwgTCI433HoChVEnnjln+IyFTD+wr/VTh1FP
	5OCDSQPZiwwdIy19ls7IIW4tsT242vHPCqDPyEjjX0TBDt7x8atUGtKNNGkK8TaVCSRe4q
	JBXlNORQe/J8FfrPv3NPtfQxPUTo5w8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-5LsNYbVaPCuMF629lewgPQ-1; Tue, 06 Feb 2024 04:37:52 -0500
X-MC-Unique: 5LsNYbVaPCuMF629lewgPQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c7b8c18f2so10245456d6.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Feb 2024 01:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212272; x=1707817072;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFw0/tki7MzcuGpQDjCWPan97sbo8eZxmh34JYGWwvw=;
        b=qefQqLFEy6JjaM7kxwNTO4jydxxwEFvhNAJ/Hz1tA12OUN4Lx7FjhMrxDSCPgRcUQ0
         c1u4LFd1dq4S88/hgP/eG2z3Fc2cmvz8OLrt03rrFRFvvP1pBC9RAx6KlbDL80FYPxvz
         /AJzAQsuk5q5uy1SeVeEAoKdfttZfFDl8IpmoNniuwodhf5dh+DpeNy0JVYgGXtCNdfN
         ZWyhNbOmTTvnZo3hJrxWkWM37kstvaw0LDoCpoELM+dO8SEHH6OKM3Elf2lSuO5CpsJl
         yMAG1huNisZQlm4t07ofYi/9eAmsPyvYnS5oUnXqe6QLB0NawqLbE5fRi5KxP86kb+aj
         NymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP9Ewt1L5tywpqEGLAVc6Rp/zNkhOPrwfhF31xhZucx0tJ9V4qVVQ+GL7GKBlmKC65pKnASHJaGpHwmn+aVojqY29cY95qxGaSEw==
X-Gm-Message-State: AOJu0YyxC0FA5A7eyc0ccOupjbILcmqJW0XoUrDIzniwFz3i78bxGWzG
	ZG/uZX2nkaZkNCgE6kw/0U1hyGObiMjfTDERtZ+Bqd6PSUDxo/2qDMG+gyQ59KLYVXaQKiYalWV
	HYYVueAQ1ytfKTnTkgC5x8onl8IIbs3ZzSOR+AiUIQMIyNi/31SepI4MQHhQ=
X-Received: by 2002:a0c:fd81:0:b0:68c:892d:3580 with SMTP id p1-20020a0cfd81000000b0068c892d3580mr1906095qvr.2.1707212272248;
        Tue, 06 Feb 2024 01:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf8jMGPfr9HK+wkVYLwf6cn8LeUVvvC77sfjQ9swGgq33sBn/RFP3wypkxfuqD7DIvGYoWnw==
X-Received: by 2002:a0c:fd81:0:b0:68c:892d:3580 with SMTP id p1-20020a0cfd81000000b0068c892d3580mr1906059qvr.2.1707212271977;
        Tue, 06 Feb 2024 01:37:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfUoaFEr7eaRe5ycg1DbG6mUeacI7DqXnDEQAqR/uOtVZi5iFHBIfAHWtmdID07LMES9Vqtbf3/fDfcaZBNv9q/LKcJCvpZ+uQgCEVeMTU7NVUBYA6uY3aLynfiw2uUhE6tdAOuqYInOKJAQMomBkV5l/VJHC3+6tIX1TH85D9DfaFx4gpu4oHJ9rLu6wOO0BQ0v7WkpB66r/8MT495M3IZvXMbKXAho54eYMqxSohWmzS4Zd18vYFR4tA84odtM96MQSFKSOl66yhSwJICX8VzbMZ86CzFpYkQOtXuq4de74sUrDbH2gwURZHiKSoRT+JAmDyPQmqGzsTWGvejl0gWUwHvuLSpEMqIhBpD0ajsqFXhituE+IuAVn9KzdCPnsmVJsflajKjmzFfzx68lxghXJEfEVQcBMshWKP+AkEELVUdAv396VdpP5cA1WWIjG78Eo70CI60B+/VpjL+S7Gd66bOCtvZNl1TF8bp6nsW/g7ptgrScj9NXW78jFSRoABrhjp6hePZSYF5zjuX/QCUCpgLIh/t/9sqHaAjQ3eLvBVeYWIl6Q3glSL6Z2/hF7z65mnsPfgT0Q1j2b/ZRVPyzV0wIt+YyUirpjo5VPamlgylLEZoE52w/gYK37P7Tz/dx3lm+IGXJl/voSUee/Jo89OYHX2E9Tg2064/fHk9rU2p93kU70XkZ0op6YcaD5MRTq8NgaDFjOfnUEOGsKHwv0WaugrX0/jDwkA8bmBGJuaYo+1TM+wHVksIRvhJJ+G+MLpXKZOgqyPD16p8gvlfK2Lc81+EI4sm4Ef2kz7Oz2nXhnO3UB1jo36t2eCbozlgmx4xz7ijA==
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bo14-20020a05621414ae00b0068c67a3647dsm846048qvb.76.2024.02.06.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:37:51 -0800 (PST)
Message-ID: <20c967ffac2cec6c9d89017d606967551b30d20d.camel@redhat.com>
Subject: Re: [PATCH v6 4/4] PCI: Move devres code from pci.c to devres.c
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 06 Feb 2024 10:37:47 +0100
In-Reply-To: <20240131211235.GA599807@bhelgaas>
References: <20240131211235.GA599807@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 15:12 -0600, Bjorn Helgaas wrote:
> On Wed, Jan 31, 2024 at 10:00:23AM +0100, Philipp Stanner wrote:
> > The file pci.c is very large and contains a number of devres-
> > functions.
> > These functions should now reside in devres.c
> > ...
>=20
> > +struct pci_devres *find_pci_dr(struct pci_dev *pdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pci_is_managed(pdev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return devres_find(&pdev->dev, pcim_release, NULL,
> > NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > +}
> > +EXPORT_SYMBOL(find_pci_dr);
>=20
> find_pci_dr() was not previously exported, and I don't think it needs
> to be exported now, so I dropped the EXPORT_SYMBOL.=C2=A0 It's still
> usable
> inside drivers/pci since it's declared in drivers/pci/pci.h; it's
> just
> not usable from modules.=C2=A0 Let me know if I missed something.

No, ACK, you are right.
I forgot this since find_pci_dr() is removed later anyways.


P.


>=20
> > -static struct pci_devres *find_pci_dr(struct pci_dev *pdev)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pci_is_managed(pdev))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return devres_find(&pdev->dev, pcim_release, NULL,
> > NULL);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > -}
>=20


