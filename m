Return-Path: <linux-arch+bounces-858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B080B376
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDDE1F21133
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806C111BF;
	Sat,  9 Dec 2023 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROQw2ngJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB5910C9;
	Sat,  9 Dec 2023 01:44:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso30547565e9.2;
        Sat, 09 Dec 2023 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702115096; x=1702719896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L11kNgG7F7jZItjchNT9t/Go/mxOmM6TSGE5IwyttvY=;
        b=ROQw2ngJaKnunF7hSSO0l+XG6+NnPJ1Eo/+8qgHEbTEl4GJx4mPXtNinN2fQ+inDyd
         C++tnCbcuHxs06LuztoUT2RadmgtzlZT/1vsZh/kVObk1i0PjY532byz6si/FaSqACq4
         AI8oM83ptQjIGL1RYpw9AwuNHtrHd03WfsYKQpua3OeEyEKIVL2erxbWkocStfZl+UB8
         YfoDHDyZK9KH3cjQSsTaNg1HXtvY6nMr15LKyxQCVcuT5LbYG4xGxC7Sjg/z+ASMy39Z
         D7TF0h0JIKNqXm3Hl0hx9oB0g4a/Vm8EITvka6/F1+Dg9U3b3RLqftIhe+cP/fP5tC4T
         RS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702115096; x=1702719896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L11kNgG7F7jZItjchNT9t/Go/mxOmM6TSGE5IwyttvY=;
        b=wy+TlioELPjBPIBjqSsXTZ0nN/bhFA35AoSMr65zMrsA09fL1fO3z9KnHxtM8veJCj
         A45CJ6tcqMMSsJIFcT7u6ywqZoXmrFjQE5SzJEG0GzddJ6D5SeJlAWw/f8IrXgE2CZx9
         puiBXbBZUIyrr0Kl3rkdVtg+i1fOVRucLWCJAF/i7fhBlBpXAA93mOfo3yMJoH7AB6h8
         1DpJ/7sYaQBmIOqkjkvhEg+mWl16kS3O5QqlFZmjmH3bImWO/AOx5ypDgnUv4nyNAtOh
         wT+Q9xDMb2cWiYd63slE6ZjL2rRsvt5lWtiZIdpJl9E4rq7MCdhvhxCHnCB0986PWbPe
         zyHQ==
X-Gm-Message-State: AOJu0YzDdt9LAPBdpNbqQ+NQ/wpcOZomwxjFFBED9Gk6SnKE2rFjLLT8
	mz6LhI13ha3a/LzyLJkjE03uDjHCcQ==
X-Google-Smtp-Source: AGHT+IEMsyKeoonkfljSC93eIp/Zwq8nGvzGBX7+ChmGLDJ3pxuZn95Y464CdXx0mGVSJ0VMnI7esQ==
X-Received: by 2002:a7b:cd12:0:b0:40b:5e59:c570 with SMTP id f18-20020a7bcd12000000b0040b5e59c570mr665346wmj.154.1702115096070;
        Sat, 09 Dec 2023 01:44:56 -0800 (PST)
Received: from p183 ([46.53.250.155])
        by smtp.gmail.com with ESMTPSA id tk3-20020a170907c28300b00a1cd54ec021sm2023235ejc.57.2023.12.09.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 01:44:55 -0800 (PST)
Date: Sat, 9 Dec 2023 12:44:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <a46e0141-98c3-4a09-bb74-578d2429c35a@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
 <202312081027.BA44B7B3@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312081027.BA44B7B3@keescook>

On Fri, Dec 08, 2023 at 10:29:25AM -0800, Kees Cook wrote:
> On Thu, Dec 07, 2023 at 05:57:05PM +0300, Alexey Dobriyan wrote:
> > On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
> > > Can't we have a generic ARCH_AT_PAGE_SHIFT_MASK too? Something like:
> > > 
> > > #ifndef ARCH_AT_PAGE_SHIFT_MASK
> > > #define ARCH_AT_PAGE_SHIFT_MASK
> > > 	NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, 1 << PAGE_SHIFT)
> > > #endif
> > > 
> > > Or am I misunderstanding something here?
> > 
> > 1) Arch maintainers can opt into this new way to report information at
> >    their own pace.
> > 
> > 2) AT_PAGE_SHIFT_MASK is about _all_ pagesizes supported by CPU.
> >    Reporting just one is missing the point.
> > 
> >    I'll clarify comment: mmap() support require many things including
> >    tests for hugetlbfs being mounted, this is about CPU support.
> 
> I significantly prefer APIs not being arch-specific,

It will become arch-independent once all relevant archs opt-in.

I doubt anyone is writing new software for sparc or alpha.

> so I'd prefer we
> always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
> define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
> 1 << PAGE_SHIFT, but it might be incomplete.

It is inaccurate if ARCH_AT_PAGE_SHIFT_MASK is defined as "_all_ page
shift CPU supports". Inaccurate version is called AT_PAGESZ which lists
just 1 page size, there is no need for 2 inaccurate APIs.

