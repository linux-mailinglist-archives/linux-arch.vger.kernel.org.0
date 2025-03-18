Return-Path: <linux-arch+bounces-10934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F06A67DB7
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20CC19C6BB6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDFE1F4CB4;
	Tue, 18 Mar 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pueGFkic"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA21DC9BA;
	Tue, 18 Mar 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328428; cv=none; b=OmvJ76V5USmIZibBajibVF66Qksq/YIp7t1hb+retFSd8NnSK9xgr+lzCWR/heiYoGcsXkz2dcOtl7zl3BecLKxbY9jTQkzAyBKsM+cxfypPISOdG8XkPLDVJ3DjfioVXcalVzu3jXJrg4r2aj6YFORXKVUowYmySM2xx/0H89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328428; c=relaxed/simple;
	bh=cBVXeJOtqBDx4LrWM3O+qh9nlS4Cj6NRmbqTyPvz/Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCfxNLVg5EdOx8lT/lG+F6VB/yfjMOSuun4vo+UDg20W+7NttmVZxh2jcA4Zzc2hIQ8r1VpzmuNKFkhxwQO/Jp+LpxyMf2nwdCdGh4O57mp9+JwGRJe3KgTZy75PGo0PQYpB0C3LYC1l2PbO3q0QwLT3JBeCmpBi/SYA8t9O1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pueGFkic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD2C4CEDD;
	Tue, 18 Mar 2025 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328428;
	bh=cBVXeJOtqBDx4LrWM3O+qh9nlS4Cj6NRmbqTyPvz/Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pueGFkictX5+wAr/XnyzgSHeqVQNj2ucVtP/gfHDnpkXe8FbAZhnFJagNI9lwwW8X
	 Qh3Xe715ie2yPUUc0Az+3cHKHe/zwkgZa3x0m1qz80FvQ5jNqZMxs2+j6yjNZ5FAaM
	 Ow70S6P1JPCNu6UFTuw7s6w2r9ZL8veBoMkmzMp24kZupyBMsud9HnFQiIBtsboT2v
	 bT3K+RyEON+vsh5cBZzECQ/OQyxuFD2pksqdCYximtqTKzC64CGBfztvWXBUEvpnep
	 XcQvI1WGRpDucf3BYKnYHO015wVArj86L3J3L1H/SkGmUiCGzZICqzhaJVkQrvvcVy
	 r9dSNaEsUwTLg==
Date: Tue, 18 Mar 2025 20:07:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"muislam@microsoft.com" <muislam@microsoft.com>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Message-ID: <Z9nSav5QX-Vf0Eae@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z9msXAClr-vGn3GR@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <SN6PR02MB415725C0B70BBBE541D6F87DD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415725C0B70BBBE541D6F87DD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Mar 18, 2025 at 05:45:46PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, March 18, 2025 10:25 AM
> > 
> > On Mon, Mar 17, 2025 at 11:51:52PM +0000, Michael Kelley wrote:
> > > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday,
> > February 26, 2025 3:08 PM
> > [...]
> > > > +static long
> > > > +mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
> > > > +			    struct mshv_get_set_vp_state __user *user_args,
> > > > +			    bool is_set)
> > > > +{
> > > > +	struct mshv_get_set_vp_state args;
> > > > +	long ret = 0;
> > > > +	union hv_output_get_vp_state vp_state;
> > > > +	u32 data_sz;
> > > > +	struct hv_vp_state_data state_data = {};
> > > > +
> > > > +	if (copy_from_user(&args, user_args, sizeof(args)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	if (args.type >= MSHV_VP_STATE_COUNT || mshv_field_nonzero(args, rsvd) ||
> > > > +	    !args.buf_sz || !PAGE_ALIGNED(args.buf_sz) ||
> > > > +	    !PAGE_ALIGNED(args.buf_ptr))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!access_ok((void __user *)args.buf_ptr, args.buf_sz))
> > > > +		return -EFAULT;
> > > > +
> > > > +	switch (args.type) {
> > > > +	case MSHV_VP_STATE_LAPIC:
> > > > +		state_data.type = HV_GET_SET_VP_STATE_LAPIC_STATE;
> > > > +		data_sz = HV_HYP_PAGE_SIZE;
> > > > +		break;
> > > > +	case MSHV_VP_STATE_XSAVE:
> > >
> > > Just FYI, you can put a semicolon after the colon on the above line, which
> > > adds a null statement, and then the C compiler will accept the definition
> > > of local variable data_sz_64 without needing the odd-looking braces.
> > >
> > > See https://stackoverflow.com/questions/92396/why-cant-variables-be-declared-in-a-switch-statement/19830820
> > >
> > 
> > This is a rarely seen pattern in the kernel, so I would prefer to keep
> > the braces for clarity.
> > 
> >  $ git grep -A5 -P 'case\s+\w+:;$'
> > 
> > This shows a few places are using this pattern. But they are not
> > declaring variables afterwards.
> > 
> 
> The braces just looked a little odd, particularly the way they are indented. Another
> alternative is to move the variable to function scope, and avoid the issue altogether.
> But I'm fine regardless of which approach you take, including keeping it like it is.
> 
> > > I learn something new every day! :-)
> > >
> > 
> > Yep, me too.
> > 
> > Thanks for reviewing the code. Nuno will address the comments. I can fix
> > them up.
> 
> FYI, I may submit a few more comments on the v6 version of the patches.
> If there are changes you want to make based on my comments, I don't care
> if you fix up the existing patches, or take them later as follow up patches.
> And of course, you may choose to not make changes.

We will aim to  address as many comments as possible in the first
submission to reduce the number of follow-up patches. This driver will
be backported to replace the one running internally in Microsoft, so the
fewer patches we need to backport the better.

Wei.

> 
> Michael

