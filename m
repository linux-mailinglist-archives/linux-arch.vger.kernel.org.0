Return-Path: <linux-arch+bounces-11893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA9AB35C1
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 13:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7CE1776CC
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638428E56C;
	Mon, 12 May 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+oG+GST"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E828DF0F;
	Mon, 12 May 2025 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048548; cv=none; b=gT1ZTziiH14s51ZXjRx8/Vl0odwUFy04JMODCkLtiTfl+b+rFZYwDCRSInagpHNnKN7nnHC1c0rsOKloAVuERsgczVZKXMB6gkNOcMqlTtS9amguUhpAoKWjC9D914pakX6cKFqg9H89Swl+k7x8eYyb0ty4/OFSXDNPASUqZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048548; c=relaxed/simple;
	bh=oT8B8PuPRmFZoKB8QPD4DQ56LMUoF01HMVZAtrTjxkk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkjrh+CzL7T2jxut2RqSEwm16Fsy9iz1tbWgKm9VjxISBQ3OLJR0JRhFfC/L3VzPcFmQZp86YnCIAD7cUTMqV6tEYvznRCq9CAmFgn/4jHu3AWOzsO3X01tWIN0iw1IuHR532iUdBapC8u8WCnaEA/F90zX3HIkz3HB3MoY5V5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+oG+GST; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso2942681a12.2;
        Mon, 12 May 2025 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747048546; x=1747653346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIKni9pPLOHu4o+QrtpE1+aCnaxZVOBceumrlQ5KJ4s=;
        b=B+oG+GSTDqyR61M6jx4xHYpmTTYsQn99iw6i3h1DjlkCyHxvKCMtV11goAyQpJ8tW7
         ySOv1jiAMOOVQo/06oR7Q0+Nl9k22HzNNxGsaerTL+ztwiI88oZrYoqTGJFOJhO3mDdR
         uzM3aIol4c/oM59YIc+q6FbpCa0Af8PVnvBedbnlXqyGTxbQ7asDUrsjwx24Xd8MEF/q
         a87xuPrKnVjOMuXoct2QqN1kFWOGE1G4QhgHnfIXuCLdnc2ADAfCVx4OpaayEQuAhBq/
         AaIzkt9nXVHhBQbbbLuVepxCDlwv91T0L/cmigFGxpImh7C+oJfaXDB/zx9HK5AggjwE
         eLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747048546; x=1747653346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIKni9pPLOHu4o+QrtpE1+aCnaxZVOBceumrlQ5KJ4s=;
        b=qNgGfpNT3hEtV+gat9qxVgoOtQr49aUsOxu0MmyuVsHt13py2gT0ePeyRvDgj3bgi/
         Rv+ikf1PwPypRMZc9Amp2P3whxmr1VsMtecGQJqDg88qrI2IFwdjwusSZv0hZW9koQGG
         8j7x7J1wMIiObQY0mgcK9jH4XEw1oUTNxQgswau/7WBU5cDaiYOwl2JqHOR79T8EW5de
         kkTRPlI4+NJ3wceLUxZbP8JJ2GIeuDcjmhqmsRTYrXkN/x3xPdA/3ZQFcDQL1dVgWAvg
         Sen0K9WusMBllBdd6duZVeJEVMAkZWRZMAIHCSlsSBV1QB4kHxTm0mTtVFmRdSyGKNTT
         ut5g==
X-Forwarded-Encrypted: i=1; AJvYcCU2uQowPZX624VF2GUr75EIfx7rTjdfEQvE05YB/fc9wW8f3DtjQmWwuW1pSizwLeScfm8=@vger.kernel.org, AJvYcCURz1RWQvtQBE/ewxGxFGXDTC1A8ha2CVrX56aOfgZIlDpk1KENb5v8kJ1pu/qMymCiEviquYmovGRPOJH6@vger.kernel.org, AJvYcCUxapXB5ohVH6fsnlRss1GaLrfN1m0iDzzIfpBBq0vdBX7e4SfkB6Kxwt1iJe1aZ7wJDfDXHeHDL4hmLBm7b9v1@vger.kernel.org, AJvYcCUzIbCF0iMTbyJrw7Qw9hbWFEiEZO5O9pPVWASnIidei+nxoSHhVsO5Hrp4S4MJlBQ8MgZU1MB/r7PpVQ==@vger.kernel.org, AJvYcCWTedt14Ggle3J82NASJ82u9oPmGdT27kjotoiUAxDYiWvlW11omBi/0mBiEJXbaWoVfNuyavLYNG2oGfSS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60UDO3YXY6fCkWr8t9RIRl3Qo/5gL2f1xifti3sCUVXliPwM7
	DayurJwj+YpG1xz5rpoFWvDCmx+EVm9ziCtAaoPr6iEhHPedxPo1
X-Gm-Gg: ASbGncsCxq8+AbIdmJAhDSmZSAaEtmhLusFtlzJJnkkKDt50QJnqQKgON8AsfMmDGxr
	RRmaCauiXXQfD0q1vJfEEtsFh6WM1NVcfZnNYVBUSjrj9DeLVY4uzXegGGW48+SwSO9lT7GtOAy
	tGRgtTK/6G5cm5PL5P7pGIclF85dyGtG2Q16GmfCfP+4Or9xBea2SYF+4kfipcBi5wB/rq5CWaj
	wpzB05zWuAtR96tjwFzS0EGrw0Zxh+Iru97lbYAxFG6MY2K6IRKtiYLDBktayadl3BRbxPT75JF
	XhBL5jurHpDM3hHol6+Q41BeTJ+ImvUWormi5JcBBDfUCGZvX2ukRKsLft97/hJFDPiq7pZab4L
	/Wi5XrwAZVypSCBgNcA==
X-Google-Smtp-Source: AGHT+IGdhYPbJPcGMDw80qXe6ASIagaqClZ9iXMY9/sIldXOZU7oATP4AwtW7JWEzAYHF6iI2UMfDA==
X-Received: by 2002:a17:902:dac6:b0:21f:768:cced with SMTP id d9443c01a7336-22fc8aff07cmr157726675ad.8.1747048545743;
        Mon, 12 May 2025 04:15:45 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc774134fsm60669495ad.56.2025.05.12.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 04:15:45 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 12 May 2025 04:15:40 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Sami Tolvanen <samitolvanen@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hao Luo <haoluo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-debuggers@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
Message-ID: <aCHYXFXOA74TkU5S@kodidev-ubuntu>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
 <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83a42276-22cc-4642-8ce6-7ef16fa93d9c@oracle.com>

On Tue, Feb 25, 2025 at 10:01:27AM +0000, Alan Maguire wrote:
> On 07/02/2025 23:50, Alexei Starovoitov wrote:
> > On Thu, Feb 6, 2025 at 5:21 PM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >> When the feature was implemented in pahole, my measurements indicated
> >> that vmlinux BTF size increased by about 25.8%, and module BTF size
> >> increased by 53.2%. Due to these increases, the feature is implemented
> >> behind a new config option, allowing users sensitive to increased memory
> >> usage to disable it.
> >>
> > 
> > ...
> >> +config DEBUG_INFO_BTF_GLOBAL_VARS
> >> +       bool "Generate BTF type information for all global variables"
> >> +       default y
> >> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >= 128
> >> +       help
> >> +         Include type information for all global variables in the BTF. This
> >> +         increases the size of the BTF information, which increases memory
> >> +         usage at runtime. With global variable types available, runtime
> >> +         debugging and tracers may be able to provide more detail.
> > 
> > This is not a solution.
> > Even if it's changed to 'default n' distros will enable it
> > like they enable everything and will suffer a regression.
> > 
> > We need to add a new module like vmlinux_btf.ko that will contain
> > this additional BTF data. For global vars and everything else we might need.
> > 
>

Hi Alan,

> In this area, I've been exploring adding support for
> CONFIG_DEBUG_INFO_BTF=m , so that the BTF info for vmlinux is delivered
> via a module. From the consumer side, everything looks identical
> (/sys/kernel/btf/vmlinux is there etc), it is just that the .BTF section
> is delivered via btf_vmlinux.ko instead. The original need for this was
> that embedded folks noted that because in the current situation BTF data
> is in vmlinux, they cannot enable BTF because such small-footprint
> systems do not support a large vmlinux binary. However they could
> potentially use kernel BTF if it was delivered via a module. The other
> nice thing about module delivery in the general case is we can make use
> of module compression. In experiments I see a 5.8Mb vmlinux BTF reduce
> to a 1.8Mb btf_vmlinux.ko.gz module on-disk.
> 

Thank you very much for working on this. I was keen to see this since you
first mentioned it a few years back [1], and have been meaning to ping
you on where things stand. Your summary of motivations above is spot on,
and I can add some context w.r.t. OpenWrt, often used on small consumer
Linux routers to: improve security after support ends, expand
functionality, and increase lifetime/reduce e-waste.

This lifetime is already constrained by the limited kernel binary storage
of some devices and ever increasing kernel sizes. The biggest mitigation
is heavy use of loadable modules to avoid using kernel storage and also
reduce the kernel BTF.  Even so, the (compressed) kernel BTF is ~400 KB,
and over the years I've seen kernel sizes grow by ~200 KB per annual LTS
release.

These rates can amount to penalizing BTF usage with _two years of reduced
lifetime_, which is a key obstacle to enabling BTF by default on such
small systems IMO. Having a module-based kernel BTF would be a huge
improvement!

> The challenge in delivering vmlinux BTF in a module is that on module
> load during boot other modules expect vmlinux BTF to be there when
> adding their own BTF to /sys/kernel/btf. And kfunc registration from
> kernel and modules expects this also. So support for deferred BTF module
> load/kfunc registration is required too. I've implemented the former and
> now am working on the latter. Hope to have some RFC patches ready soon,
> but it looks feasible at this point.
> 

That sounds great. I'm looking forward to seeing and trying this out. If
there's anything you can share at this time please let me know.

Thanks,
Tony
 
1: https://lore.kernel.org/bpf/43fd3775-e796-6802-17f0-5c9fdbf368f5@oracle.com/ 

> Assuming such an option was available to small-footprint systems, should
> we consider adding global variables to core vmlinux BTF along with
> per-cpu variables? Then vmlinux BTF extras could be used for some of the
> additional optional representations like function site-specific data
> (inlines etc)? Or are there other factors other than on-disk footprint
> that we need to consider? Thanks!
> 
> Alan
> 
> > pw-bot: cr
> > 
> 

