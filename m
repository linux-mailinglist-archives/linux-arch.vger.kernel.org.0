Return-Path: <linux-arch+bounces-1384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62982FEC1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 03:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DA1C23BE1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 02:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F11864;
	Wed, 17 Jan 2024 02:22:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F217E9;
	Wed, 17 Jan 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458166; cv=none; b=ddNM45kuj7D1rP/lTpOYM9rVZCjVqlUrTmFOsR5r1ALeOL8TtAEyeGtGUrGTO9e8pVKiX+FQHxqYpDRCaXe4DYrW/WvbY7ZFYGfMxn/xJOTh+cZ1MMa9iL+JljOhEFHUTUP8VHt+vtHerHoj2fIJ8kmonAG9/rSjC4IIUg+zGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458166; c=relaxed/simple;
	bh=tjALmxBXd+DQQfMR8Vt2M3FgcBoGxOGfirrdXlPsCzE=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fpsC/x51VsnfqbUDM0p2RJUgYn8z6680ZwryEosA1Tv0fSWGNpa4Spgnn2ljLAKrd0BSBZUhbbtB5EjG/f884R4rtFVfUDFahVQ7kSM6g2d+AwFEnd5tcbVs9Gr8jeV60wyBnnOpLiRkxgqthVka3Blu3yZo3QTbOSlyuE8PD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0af93fdaaso2743778a34.3;
        Tue, 16 Jan 2024 18:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705458163; x=1706062963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvCzHdCCoUAYXVnW660xRj2+vdtdV/6HpzjQHQyUWDg=;
        b=Tf1BAQ1F1E1AB3kfFhoUA9iitz+MtlUAbNil35kah3J1p7rz7DcThbb7pRfRujZiCl
         4S/8wKIg1fpIVNd2UWD2xVPRyaPLUDzxyWui8cBu5augkR+k/WX5Yn2yKBksPzJf+Q8Y
         x7yqT2X2uW3XGw83K08IFXXRNh0xePF7vyi7UCJCFivxTljbsAQ4s0M0VlEf4WeKK1uu
         +c/WTdk27J46r3bZVaVglr6rhIuCGsbdKVOTScr1FKG940eYPQreV+4F9BU9Gb+STwmZ
         kgqBzLaYw+KJh9T/LhTh82FxFwTVFhFR9i6OIT/A4vb3fG6aByljVAeeynNrEkGVgTtP
         PjMw==
X-Gm-Message-State: AOJu0YzzAD0Ds9i/1xSg4eeCulho8/7PbFY5ndsVoXOmdSzJVlss44Tr
	+EMjJqWfs7WzBW4qagBEEkI=
X-Google-Smtp-Source: AGHT+IG7lJq8taiu2dFLP1BoUfxhekVtzTOyRXf1mavjJxh6yyLEVNpTV0pczEs0cRrNHW+EnYQYNg==
X-Received: by 2002:a9d:6488:0:b0:6e0:16cb:4b4d with SMTP id g8-20020a9d6488000000b006e016cb4b4dmr9345003otl.29.1705458163117;
        Tue, 16 Jan 2024 18:22:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y27-20020aa79e1b000000b006d9ac481eccsm258477pfq.220.2024.01.16.18.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:22:42 -0800 (PST)
Date: Wed, 17 Jan 2024 02:22:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com, arnd@arndb.de,
	bp@alien8.de, brijesh.singh@amd.com, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
	jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
	kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
	Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
	rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
	vkuznets@redhat.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v3 08/10] x86/hyperv: Use TDX GHCI to access some MSRs in
 a TDX VM with the paravisor
Message-ID: <Zac58P0MgEQ_ITOf@liuwe-devbox-debian-v2>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-9-decui@microsoft.com>
 <f488fede-5c28-4840-af3c-3faa9a31caa0@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f488fede-5c28-4840-af3c-3faa9a31caa0@intel.com>

Hi Dave

I was away and only saw your email now. Sorry for the late reply.

On Mon, Dec 04, 2023 at 07:10:29AM -0800, Dave Hansen wrote:
> On 8/24/23 01:07, Dexuan Cui wrote:
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +static void hv_tdx_msr_write(u64 msr, u64 val)
> > +{
> > +	struct tdx_hypercall_args args = {
> > +		.r10 = TDX_HYPERCALL_STANDARD,
> > +		.r11 = EXIT_REASON_MSR_WRITE,
> > +		.r12 = msr,
> > +		.r13 = val,
> > +	};
> > +
> > +	u64 ret = __tdx_hypercall(&args);
> > +
> > +	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
> > +}
> 
> First of all, I'd really appreciate if you could seek out explicit acks
> for this kind of stuff before merging it.  This surprised me.
> 

I eyeballed the code and thought it only touched only the Hyper-V files,
so I merged this series without waiting.

> Can you please merge these generic things back into the main TDX code?
> There's nothing Hyper-V specific about any of this code.  Basically, you
> can make a hv_tdx_whatever() variant, but make _that_ in the generic TDX
> code and then export only _that_.

The code is still there. Dexuan, can you send a patch to do the
refactoring?

Wei.

