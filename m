Return-Path: <linux-arch+bounces-2155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4384F52B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A5F1C21023
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08336B1C;
	Fri,  9 Feb 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIwZgUUZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435C1E503;
	Fri,  9 Feb 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481844; cv=none; b=ZsOUFhzWF5QLVpdrTEfdOObaCYlyJWVL/F1Gdp5jVtBqjJ2PSYrDXQBZ4h/kju/s3pgHW5j5xenYUoZhi3DVJNDTcDoMgXRsWXkYnzBMLfmilDoZrtv0Dck3OmpRpx0NXNU50PrAaWXdaHobRjqfwrb/X40AsGraYzm2TYaagGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481844; c=relaxed/simple;
	bh=uv5tY3bK883yOLeFdrV05/wqX5qFWeLR+48lvLQm/dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGcApFgu2vcgXATn9nEl+7aSU7j8ANdWIIULHV5HNB8e+eNiwGl7uwWQQcO5MfXrzFxt+guPHzEVfVYGRgxHd5wI8WBnSHFGZA8tEAkIKr/THkNwo72if8BiovGozBg9M6WQzofuh6E5BpD6Cq8IHOHOjOk9f/MJ2+B3Nnj/tMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIwZgUUZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51168572090so1532277e87.0;
        Fri, 09 Feb 2024 04:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707481840; x=1708086640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj53K0srSTgaE2lo+BGlpZ9XqSxQFcHLvaITEUOH728=;
        b=MIwZgUUZawE3B8ttVCg2ssn8Dj9fS9r1E4drUZ/T/P/cHJcEeTIza8cwU3nC8eV90Z
         SFKyK6uF1vGT1GPiD+/RCeF+p8lQapp5X/MV0kKJmcAnpnKdAPEhmci/Aq24n9OOxm26
         cqapuyj+EsOBEFAuni0EmRE8quN94z1E8+czQkykybvI1XRzUukRTMIQVrxoQ6EOvtzH
         zL2PHcOiE0uNmVT+y4RPTW52jywxDh19iHzVrcQltnMOFx80LVjpS5Eic02pkAGV71XP
         7rx4BNlQCz6+xUjtHmXn/3RcAQVUPFUTGsukfrTYrgH/BDzyBBXhtMSJZR9Ko2wriRx8
         Aduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707481840; x=1708086640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj53K0srSTgaE2lo+BGlpZ9XqSxQFcHLvaITEUOH728=;
        b=IE6LeCMFP5YkO45QO5nYFeC5I6nSD3ldsRJVi11apot884UDzreIMyBITrhFt7Nzd4
         aP1pAO0S1v8/CfT9TAhmtB4YOQWVoKpgMA8/NoRoc2cIE3cjEp15MUjQM6ivyGXfjFwW
         E2Z6WWs5Cl5KqONrak3fEiV9Ry4DenEpK8H8aGT4Dy+aOZDfqL6ZSTfMOb0bc8pbcMzR
         O+NgU9Ehlk8tih5JcNEhNF6zXY8OmT/I3YpVd9KWRmnVhVVC6e9OGolAzCyXwV5R3ojP
         zhRSFnywb8uENezYyl4lY6ONuwWh1KpxoQxLoYnuS7ejHX3pA5UpLCGpd8t3hQapnvXB
         n0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgHaD6r4C+0l3NvFSsW3YiLb6wLTQJ6yuFuXhojcQ5wKX+GITfWbRBMICtG/Adg4iREICDoN3IwWB74Y1Pit1+I8ArZxOz+c1L4CT7wWV110h5DCcAEM7CIlhhPzFJGhVXhN5Hhue3E287LxUKm2OtDH/xTOixRwlORgbv65u9wqc66Q==
X-Gm-Message-State: AOJu0YyZDaFvEjDSz4VcuY08GEFgcxPIlsJGA17rFFPBIsFLF8M65A7T
	XMlZDyUkeS9u+XrkQyNJMqtOtxNIDkKkGUcX3IvalTBHAL8jMHA=
X-Google-Smtp-Source: AGHT+IE0JGLdElzMLusS908kDQz2q4c097RomGl8DCTI3zHrLOkKj8VzGPXp8eEsk9o5kuAHNwATqA==
X-Received: by 2002:ac2:484a:0:b0:511:722a:31b8 with SMTP id 10-20020ac2484a000000b00511722a31b8mr970340lfy.1.1707481840235;
        Fri, 09 Feb 2024 04:30:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC7aVbUgyYUFqe4BOWij8oOhFJX8hexIUGnct5ga5313HbMHAvP3Cs92Baul/FbBOgNDFd2NvFoKTtR6kkGhB+NrAu1MY1ipTYcNGm3U7NDBy+x9aQ0VYAoE+LsXZ8YE/rNriusgogeB9hnUidNP/6qIR4GfvBhcZkwKg/HAZnbBc5gU20dlUA1Gngf1WK1JwPFmy+UnWl3UO/cP0kj6NQBvzXxovEj1pM4e/D0QBot0IIx3lYapYAb7WuzkJ3aKGysPbnZjWGn3mCcMOa6MVPbzigA+sZLWLytRz8pq0gvM3me69ChBMNIJGNpUthAhozSaglc/m580qhYqAVTWUkq6PbgxtOKPCyUNJWAZejFgPrnkBnGkgjsqj9V8+TI1r3Lgw=
Received: from p183 ([46.53.249.38])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c230a00b0040fdf204fe7sm488009wmo.38.2024.02.09.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:30:39 -0800 (PST)
Date: Fri, 9 Feb 2024 15:30:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <acd02481-ca2e-412a-8c6b-d9dff1345139@p183>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
 <202402050445.0331B94A73@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402050445.0331B94A73@keescook>

On Mon, Feb 05, 2024 at 04:48:08AM -0800, Kees Cook wrote:
> On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> > +#define ARCH_AT_PAGE_SHIFT_MASK					\
> > +	do {							\
> > +		u32 val = 1 << 12;				\
> > +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> > +			val |= 1 << 21;				\
> > +		}						\
> > +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> > +			val |= 1 << 30;				\
> > +		}						\
> 
> Can we use something besides literal "12", "21", and "30" values here?

Ehh, no, why? Inside x86_64 the page shifts are very specific numbers,
they won't change.

