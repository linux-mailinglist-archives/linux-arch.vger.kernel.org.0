Return-Path: <linux-arch+bounces-8888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA69C07F2
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736F2287403
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A48212194;
	Thu,  7 Nov 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIEmzkj5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B421218E;
	Thu,  7 Nov 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987249; cv=none; b=o21LvZ9za0qMSHA7ZJTHZVCNZ44fyH0MhIysthCLOzr6cpWA2/tGRBBbi6JRzXQROnhRhiX2Kmsp73vxWAieQwX4n7P8n14uyMx02gS43gGIKTPbL+CtTayWMruI+PEVwfkf4rxxe9HopbrYamFpVx+GmbcSmOwp7Dkju9crtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987249; c=relaxed/simple;
	bh=RFk3924VrW1xb5x1DFkPBcmjcDaZmpuHPPQS5Fg3iuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIaBSSZMc2UGH+wjHPqy8bM6GkQssj4VCFhQ1rMenJO+dZilOeLyfGO+vQZPDhLFNCAVjJExwz0/VXAV1tXdVInW7PFcBRHK7FSSQFjL7Wd5rQKFz5yWb8UyvmfizLik01YM/s0ElAxKLwgDIO1ctZHblBC4YfrFqemCX9vh1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIEmzkj5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5743074bso8436741fa.1;
        Thu, 07 Nov 2024 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987245; x=1731592045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0on35LMoILRFRct1tStDDPXY9cyBuAggEZbNv9uoPFU=;
        b=UIEmzkj5z5E/SHpn4DBVPJiPQVcoxOF84IsetVdqwV1AKgfJg43bahdnb8FxD+6Acu
         ubvWZotNJ4K1BWJltsZNDIHG5kYppeyY+etSR1aW5fSvG1Tg1lDnEWko2075Ukllajw/
         d/OJgpMCaBNUJVWXyeYZIRieswQffL4Uao1ZCASvHo88GV/oP0NAlVkRJv1jHtuxg3xj
         wpeLhQn9dolAEhxpHs0ginnyTAFjE21wsO72IogHaabxbYuEUoPdgDZM21h/OOgk4K+A
         8Oh1fdKnlUdPDs+StIVox6IDs7oSaJz3ggkoZ0JXiAuL3sKrOi3kXWRTyjSyH323RpX9
         ao2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987245; x=1731592045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0on35LMoILRFRct1tStDDPXY9cyBuAggEZbNv9uoPFU=;
        b=CZt1YYfsdqT6K1ZK/s6UwEKy7jWF2XqgEe7xi5BSROTuhxyaBKN0NN9xjpW3NYJ1kD
         4lAbre+vuUr/rZ9y7tyq2PYU1p8r2FOMYN+IgGsEctHfDoSR2YAxgICo1HAuVhaY9fKC
         o6ms4OFo5nOc1f2zy6MT+LjLts/jqcfCIW7aaQVq9IeNDUQ0xmOpLWWkvUsYn0sau3RX
         gCcR+PgtjExSGQ58LdXiW1KvefvNaOHLbPv8KiRWOWvyDDMq3SwEhDZ6jsii5JQoxRBt
         qaXQR+m1dQktZifjjJzEDtE8KSOR7V3ikFoE4XnUN1X7fp8/FSFHJVxYLBCeR0/JC7h8
         VLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoRpcASuoOXnHQo2GQ2TE7SIebwF0DjbKfWfbcDfZuscBnEr1VIjOChG9KgIZY5RAsY4AvfAD9T0rQfetc@vger.kernel.org, AJvYcCXaJ4X8Oyx6dOg8bG+zFccI+NNtyZj4cTC6nwFxdgT6zaJtGI6Bu5Of1m8dap7xsll673TlxVDEOHfu@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAGD9LQ7UVlYbDGIeiY3yDAihsudHbijN0ieSW/Yl8KGj+gS4
	uLoTSi5W+lnwxTK5BeqriqJgBDyFu0YtcVh8FoGGm1/GBGSG/50KVyF32/hxfYHGLGKZmbsoCaS
	ja3Pb9iw05zO6YDgmDF+0ZB/UYnk=
X-Google-Smtp-Source: AGHT+IEFnkyx9mt/m4+C/bADWUR23kL5+W4hrTa+9//vSMQM1VLtLBdN3fRu+hcFzKzPTrZcZ/NxVbPCE/GiT6Q9ONA=
X-Received: by 2002:a05:651c:220a:b0:2fa:ce87:b7da with SMTP id
 38308e7fff4ca-2ff1e980065mr36591fa.18.1730987244974; Thu, 07 Nov 2024
 05:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com> <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com> <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
 <20241106134034.GN458827@nvidia.com> <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
 <20241107133725.GD520535@nvidia.com>
In-Reply-To: <20241107133725.GD520535@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:47:12 +0100
Message-ID: <CAFULd4YDSRzMAvxunw=vfC-jw3xHPRjg=+X6mDONUXSSnU=7Xw@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, santosh.shukla@amd.com, 
	pandoh@google.com, kumaranand@google.com, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:37=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Nov 07, 2024 at 11:01:58AM +0100, Arnd Bergmann wrote:
>
> > >> and later:
> > >>
> > >>  * Yes, this permits 64-bit accesses on 32-bit architectures. These =
will
> > >>  * actually be atomic in some cases (namely Armv7 + LPAE), but for o=
thers we
> > >>  * rely on the access being split into 2x32-bit accesses for a 32-bi=
t quantity
> > >>  * (e.g. a virtual address) and a strong prevailing wind.
> > >>
> > >> This is the "strong prevailing wind", mentioned in the patch review =
at [1].
> > >>
> > >> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com=
/
> >
> > I understand the special case for ARMv7VE. I think the more important
> > comment in that file is
> >
> >   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> >   * atomicity. Note that this may result in tears!
>
> That makes sense, let's just use that and there is no need to change
> anything here?
>
> Uros?

Yes, preloading "old" value for try_cmpxchg loop does not need to be
atomic (cmpxchg will fail in case teared value is preloaded and loop
will be retried). So, __READ_ONCE() is perfectly OK to be used in this
series.

Please note that __READ_ONCE() uses  __unqual_scalar_typeof()
operator, so at least patch at [1] to teach __uqual_scalar_typeof()
about __int128 is needed.

[1] https://lore.kernel.org/lkml/CAFULd4Z86uiH+w+1N36kOuhYZ5_ZkQkaEN6nyPh8V=
NJth3WNhg@mail.gmail.com/

Uros.

